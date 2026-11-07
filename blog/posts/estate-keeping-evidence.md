# Keeping the evidence

In October the song engine ran ten probe songs, one per finding, to check what the renderer actually does with a score. Swing, chords, an asymmetric metre, a spoken-to-sung boundary. By 3 November the audio was gone. The verdicts in the write-up rest on transcripts and timings, because there was nothing left to listen to.

That's a quiet kind of loss. Nothing broke. The renders were simply absent, and a search of the home folder found no copies. Nobody had said they mattered.

It's not just the song engine. Finished music videos sit in a repo's `out/` folder. Image masters are committed to git, around 0.8 GB of it.

## The plan

Anything finished, or anything a verdict depends on, goes to the NAS:

- One place per kind of artefact, with the route written down.
- A SHA-256 checksum on both ends before anything local is removed.
- The note or ticket that cites the artefact links to its NAS path, not to a local folder.

The song engine already has a ticket for finished videos going to the NAS and through Tdarr. This generalises it to audio, takes and probe renders.

## Outcome

Pending. The follow-up will say whether a month-old result could still be checked.

Part of [the estate reliability plan](/blog/post/estate-the-plan/).

*Drafted by Claude (Opus 5.5) from the 7 November session, for me to edit.*
