import fs from "fs";
import path from "path";
import { promisify } from "util";

const readdir = promisify(fs.readdir);
const stat = promisify(fs.stat);

async function walk(dir) {
  let files = await readdir(dir);
  return await Promise.all(files.map(async _file => {
    let file = path.join(dir, _file);
    let stats = await stat(file);
    if (stats?.isDirectory()) {
      return [
        path.parse(file).base,
        await walk(file),
      ];
    } else {
      return path.parse(file).base;
    }
  }));
}

export default walk;
