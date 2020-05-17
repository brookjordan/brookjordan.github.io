import app from "./app.js";
import "./router.js";

const port = process.env.PORT;

app.listen(port, () => {
  console.log(`Listening on  port ${port}`);
});
