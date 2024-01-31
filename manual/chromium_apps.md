

Some helpful details are described [here](https://askubuntu.com/questions/961745/unable-to-create-custom-uri-scheme-on-ubuntu).

1. Create desktop file in `~/.local/share/applications` (make executable):
```
[Desktop Entry]
Name=LinkHandler
Exec=linkhandler %u
Type=Application
MimeType=x-scheme-handler/linkhandler;
NoDisplay=true
```

2. Update cache: `update-desktop-database ~/.local/share/applications/`

3. Create handler in `~/bin/linkhandler` (make executable):
```
#!/bin/bash

link=$1
# If link starts with "linkhandler://" then remove it
if [[ $link == linkhandler://* ]]; then
	link=${link#linkhandler://}
fi

# Open the link
open $link
```

4. Create the extension to modify the link click behavior.
Manifest file `manifest.json`:
```
{
  "name": "Link Forward",
  "version": "1.0",
  "manifest_version": 3,
  "host_permissions": ["<all_urls>"],
  "content_scripts": [
    {
      "matches": ["<all_urls>"],
      "js": ["linkforward.js"]
    }
  ]
}
```

And the javascript `linkforward.js`:
```
app_url = "notion.so"

function onClick(ev) {
  let a = ev.target.closest('a');

  if (a) {
    const href = a.href;

    if (isExternalHref(href)) {
      // Prevent the default link behavior
      ev.preventDefault();

      // Open the link
      window.location.href = "linkhandler://" + href;
    }
  }
}

function isExternalHref(href) {
  // Check if the link is external
  return href.startsWith("http") && !href.includes(app_url);
}

document.addEventListener("click", onClick, false)
```

5. Profit!
```
chromium --app=https://www.notion.so/ --load-extension=/home/$(whoami)/.chromium_extensions/notion --user-data-dir=/home/$(whoami)/.config/chromium-notion
```
