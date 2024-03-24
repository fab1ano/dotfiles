Notes
=====

Useful packages are: 
* cheese
* keepassxc
* pdf-presenter-console
* pmount
* virt-manager
* arandr

Fonts are installed to `~/.fonts`.


### PCIe Tunneling, Thunderbolt & Dock
Read about thunderbolt security levels [here](https://www.kernel.org/doc/html/latest/admin-guide/thunderbolt.html).

### Optional configuration for autorandr
Config in file `~/.config/autorandr/settings.ini`:
```
[config]
skip-options=gamma
ignore-lid=true
```

### How to set default programs
Set default programs:
```bash
$ xdg-settings set default-web-browser qutebrowser.desktop
$ xdg-mime default zathura.desktop application/pdf
```
If this is not sufficient, have a look at `~/.local/share/applications/defaults.list` and add qutebrowser.desktop to `/usr/share/applications`.

### USB passthrough for VirtualBox
Add yourself to the `vboxusers` group (necessary for USB passthrough without root):
```bash
$ sudo adduser $USER vboxusers
```

### Screen brightness issues
Use `brightnessctl` for the setup. You might need to add your user to the `video` group.

Or, refer to [this](https://askubuntu.com/questions/715306/xbacklight-no-outputs-have-backlight-property-no-sys-class-backlight-folder) guide.

### Sudo preserve environment
You can add `Defaults env_keep += "HOME"` to `visudo`.
This enables `sudo -s` to preserve `$HOME`, such that you don't have to add config files to `/root`.

### Slow boot
If startup takes very long, you might want to disable the service for waiting for network connection:
```bash
$ sudo systemctl disable NetworkManager-wait-online.service
```

### Lid Close Action
Actions for lid close and suspend are defined in `/etc/systemd/logind.conf`.

### Cursor Theme
You might want to use "Adwaita" (`sudo apt install adwaita-icon-theme`) as [cursor] theme and `lxappearance` for configuring it.
It might be necessary to also update `sudo update-alternatives --config x-cursor-theme`.

### High CPU Usage
If your cpu usage is high in idle see [this thread](https://askubuntu.com/questions/176565/why-does-kworker-cpu-usage-get-so-high).

### Virtual Machines

Use `libvirt-daemon` for VMs.

#### Windows

Install [`spice-guest-tools`](https://www.spice-space.org/download.html).

Add a samba share to `/etc/samba/smb.conf`:
```
[qemu]
   comment = Windows file space
   path = /path/to/shared/folder
   read only = no
   public = yes
```

And add the share as new network location: `\\192.168.122.1\qemu` (adjust the ip address).

You may want to install `x64dbg`, `neo`, ...
