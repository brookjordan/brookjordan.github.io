import { render } from "preact";
import { html } from "./helpers/html.js";
import App from "./components/App.js";

render(html`<${App} />`, document.body);
