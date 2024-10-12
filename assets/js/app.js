// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//
import { createPopper } from "@popperjs/core";
// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";

import tippy from "tippy.js";
import "tippy.js/dist/tippy.css";
import "tippy.js/dist/svg-arrow.css";

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");

Hooks = {};
Hooks.Dropdown = {
  mounted() {
    this.toggle = this.el.querySelector("button");
    this.menu = this.el.querySelector("div");
    this.icon = this.el.querySelector("svg");
    this.isOpen = false;

    this.initializePopper();
    this.addEventListeners();
  },

  initializePopper() {
    this.popperInstance = createPopper(this.toggle, this.menu, {
      placement: "auto-start",
      strategy: "fixed",
      modifiers: [
        {
          name: "preventOverflow",
          options: {
            // boundary: "",
          },
        },
        {
          name: "offset",
          options: {
            offset: [0, 0],
          },
        },
        {
          name: "flip",
          options: {
            fallbackPlacements: ["top", "left", "right"],
          },
        },
      ],
    });
  },

  addEventListeners() {
    this.toggle.addEventListener("click", this.toggleDropdown.bind(this));
    document.addEventListener("click", this.handleOutsideClick.bind(this));
  },

  handleOutsideClick(e) {
    if (this.isOpen && !this.el.contains(e.target)) {
      this.closeDropdown();
    }
  },

  toggleDropdown() {
    this.isOpen ? this.closeDropdown() : this.openDropdown();
  },

  openDropdown() {
    this.menu.classList.remove("hidden");
    this.toggle.setAttribute("aria-expanded", "true");
    this.icon?.classList.add("rotate-180");
    this.popperInstance.update();
    this.isOpen = true;
  },

  closeDropdown() {
    this.menu.classList.add("hidden");
    this.toggle.setAttribute("aria-expanded", "false");
    this.icon?.classList.remove("rotate-180");
    this.isOpen = false;
  },
};

Hooks.Tooltip = {
  mounted() {
    tippy(this.el.id ? `#${this.el.id}` : this.el.id, {
      arrow: true,
      placement: "auto",
      // duration: 0,
      allowHTML: true,
      onCreate: (instance) => {
        if (this.el.dataset.tippyClass) {
          instance.popper.classList.add(
            ...this.el.dataset.tippyClass.split(" "),
          );
        }
      },
    });
  },
};

Hooks.Tabs = {
  mounted() {
    // console.log(this.el);
  },
};

let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks,
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (_info) => topbar.show(300));
window.addEventListener("phx:page-loading-stop", (_info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
