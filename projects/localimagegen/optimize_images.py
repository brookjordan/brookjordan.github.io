#!/usr/bin/env python3
"""Compress the PNG masters (one level up) into the smallest near-lossless web format
and stage them here in fixed/ for the static gallery.

For each master PNG it encodes both AVIF and WebP, binary-searching the quality down
to the lowest setting that still clears a perceptual SSIM gate (~1% / visually
lossless), then keeps whichever passing file is smaller. PNG masters are never
touched. Incremental: an image is skipped if its compressed output already exists
and is newer than the source.

Writes a _manifest.json mapping {master.png: chosen_compressed_name} which
build_static.py bakes into the static index.html.

Run with the ComfyUI venv python (needs numpy + Pillow + scikit-image):
    /Users/brook.jordan/Documents/ComfyUI/.venv/bin/python optimize_images.py
"""
import glob
import json
import os
import re
import subprocess
import tempfile
from concurrent.futures import ProcessPoolExecutor

import numpy as np
from PIL import Image
from skimage.metrics import structural_similarity as ssim

HERE = os.path.dirname(os.path.abspath(__file__))   # .../fixed
SRC = os.path.dirname(HERE)                          # .../_stage2_single3 (masters)
MANIFEST = os.path.join(HERE, "_manifest.json")

SSIM_TARGET = 0.992          # ~1% perceptual budget; visually lossless
Q_LO, Q_HI = 60, 98          # quality search bounds (avifenc/cwebp 0..100)
FILE_RE = re.compile(r"^(.+?)_(?:dragon|van|[a-z0-9]+)_s\d+(?:_t\d+s)?_\d+_?\.png$", re.I)


def _run(cmd):
    subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)


def _ssim(ref_rgb, cand_png):
    b = np.asarray(Image.open(cand_png).convert("RGB"))
    return float(ssim(ref_rgb, b, channel_axis=2, data_range=255))


def _encode(fmt, src, q, dst):
    if fmt == "avif":
        _run(["avifenc", "-q", str(q), "-s", "6", "-j", "2", src, dst])
    else:
        _run(["cwebp", "-quiet", "-q", str(q), src, "-o", dst])


def _decode(fmt, src, dst_png):
    if fmt == "avif":
        _run(["avifdec", src, dst_png])
    else:
        _run(["dwebp", "-quiet", src, "-o", dst_png])


def _best_for_format(fmt, src_png, ref_rgb, tmpdir):
    """Binary-search the lowest quality that clears SSIM_TARGET; return (size, bytes)."""
    enc = os.path.join(tmpdir, f"c.{fmt}")
    dec = os.path.join(tmpdir, "c.png")
    lo, hi, best_q = Q_LO, Q_HI, Q_HI
    while lo <= hi:
        mid = (lo + hi) // 2
        _encode(fmt, src_png, mid, enc)
        _decode(fmt, enc, dec)
        if _ssim(ref_rgb, dec) >= SSIM_TARGET:
            best_q = mid
            hi = mid - 1
        else:
            lo = mid + 1
    _encode(fmt, src_png, best_q, enc)
    with open(enc, "rb") as fh:
        return os.path.getsize(enc), fh.read(), best_q


def optimize_one(png_name):
    src = os.path.join(SRC, png_name)
    stem = os.path.splitext(png_name)[0]
    ref = np.asarray(Image.open(src).convert("RGB"))
    png_size = os.path.getsize(src)
    with tempfile.TemporaryDirectory() as td:
        candidates = []
        for fmt in ("avif", "webp"):
            try:
                size, data, q = _best_for_format(fmt, src, ref, td)
                candidates.append((size, fmt, data, q))
            except Exception:
                continue
    if not candidates:
        return png_name, png_name, png_size, png_size  # fallback: keep PNG
    size, fmt, data, q = min(candidates, key=lambda c: c[0])
    if size >= png_size:  # compression didn't help (rare) — keep PNG
        return png_name, png_name, png_size, png_size
    out_name = f"{stem}.{fmt}"
    with open(os.path.join(HERE, out_name), "wb") as fh:
        fh.write(data)
    return png_name, out_name, png_size, size


def main():
    masters = sorted(f for f in os.listdir(SRC) if FILE_RE.match(f))
    manifest = {}
    if os.path.exists(MANIFEST):
        manifest = json.load(open(MANIFEST))

    todo = []
    for png in masters:
        out = manifest.get(png)
        if out and os.path.exists(os.path.join(HERE, out)) and \
           os.path.getmtime(os.path.join(HERE, out)) >= os.path.getmtime(os.path.join(SRC, png)):
            continue  # up to date
        todo.append(png)

    print(f"{len(masters)} masters, {len(todo)} to (re)compress, {len(masters)-len(todo)} cached", flush=True)
    before = after = 0
    done = 0
    workers = max(1, (os.cpu_count() or 4) // 2)
    with ProcessPoolExecutor(max_workers=workers) as ex:
        for png, out_name, bsz, asz in ex.map(optimize_one, todo):
            manifest[png] = out_name
            before += bsz
            after += asz
            done += 1
            if done % 25 == 0:
                print(f"  {done}/{len(todo)}…", flush=True)

    # prune manifest entries whose master no longer exists
    manifest = {k: v for k, v in manifest.items() if k in set(masters)}
    json.dump(manifest, open(MANIFEST, "w"), indent=1)

    if before:
        print(f"recompressed {done} images: {before/1e6:.0f}MB -> {after/1e6:.0f}MB "
              f"({100*(before-after)/before:.0f}% smaller)", flush=True)
    print(f"manifest: {len(manifest)} entries -> {MANIFEST}", flush=True)


if __name__ == "__main__":
    main()
