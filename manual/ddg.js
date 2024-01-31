// Copy me to ~/.local/share/qutebrowser/greasemonkey

if (window.location.hostname.includes('duckduckgo.com')) {
  function setPaddingDDG() {
    let width = window.innerWidth;

    if (width == 0) {
      return;
    }

    let pad = "";
    if (width > 2000) {
      pad = "25%";
    } else if (width > 1800) {
      pad = "18%";
    } else if (width > 1700) {
      pad = "10%";
    } else if (width > 1500) {
      pad = "5%";
    }

    document.getElementById("header_wrapper").style.paddingLeft = pad;
    document.getElementById("web_content_wrapper").style.paddingLeft = pad;
  }

  setPaddingDDG();

  window.addEventListener("resize", () => {
    setPaddingDDG();
  });
}

function matches(url, index, array) {
  return window.location.href.startsWith(url);
}

domains = [
    'https://aflplus.plus',
    'https://doc.rust-lang.org/',
    'https://docs.python.org',
    'https://docs.rs/',
    'https://gatech.instructure.com',
    'https://software.intel.com/sites/landingpage/pintool/',
    'https://www.google.com',
];

if (domains.some(matches)) {
  function setPadding() {
    let width = window.innerWidth;

    if (width == 0) {
      return;
    }

    let pad = "";
    if (width > 2000) {
      pad = "25%";
    } else if (width > 1800) {
      pad = "18%";
    } else if (width > 1700) {
      pad = "10%";
    } else if (width > 1500) {
      pad = "5%";
    }

    html_root = document.getElementsByTagName("html")[0];

    html_root.style.paddingLeft = pad;
    html_root.style.paddingRight = pad;
  }

  setPadding();

  window.addEventListener("resize", () => {
    setPadding();
  });
}
