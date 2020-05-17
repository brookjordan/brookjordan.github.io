import path from "path";
import app from "./app.js";
import walk from "./walk.js"

const __dirname = path.resolve();

(async function() {
  const routes = await walk(path.join(__dirname, "routes"));

  routes.forEach(async (path) => {
    let routeName = path.split(".")[0];
    let route = await import(`./routes/${path}`);
    app.get(routeName === "index" ? "/" : `/${routeName}`, route.default);
  });
}());
