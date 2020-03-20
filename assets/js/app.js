// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.css";
import "phoenix_html";
import SlimSelect from "slim-select";
import { Socket } from "phoenix";
import LiveSocket from "phoenix_live_view";

// Stimulus
import { definitionsFromContext } from "stimulus/webpack-helpers";
import { Application } from "stimulus";
const application = Application.start();
const context = require.context("./controllers", true, /\.js$/);
application.load(definitionsFromContext(context));

// Turbolinks
var Turbolinks = require("turbolinks");
Turbolinks.start();
document.addEventListener("turbolinks:load", initPage);

function initPage() {
  if (liveSocket) liveSocket.disconnect();

  let csrfToken = document
    .querySelector("meta[name='csrf-token']")
    .getAttribute("content");

  let liveSocket = new LiveSocket("/live", Socket, {
    params: { _csrf_token: csrfToken }
  });

  liveSocket.connect();

  tippy("[data-tippy-content]");

  // Remove flash messages when the X is clicked
  const closeButtons = document.querySelectorAll(".notification .delete");

  closeButtons.forEach(buttonEl => {
    buttonEl.addEventListener("click", e => {
      let notificationEl = e.target.parentNode;
      notificationEl.closest(".notification").remove();
    });
  });

  const multipleChoiceElements = document.querySelectorAll(".slim-select");
  if (multipleChoiceElements.length) {
    for (let i = 0; i < multipleChoiceElements.length; i++) {
      const element = multipleChoiceElements[i];
      new SlimSelect({
        select: element
      });
    }
  }
}
