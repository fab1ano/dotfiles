# Stable dbus socket for SSH-forwarded notifications

Forwarding notifications from a remote to local via SSH:

```
RemoteForward /run/user/1004/bus /run/user/1000/bus
```

SSH recreates the remote socket on every login, so its inode changes. Long-running
processes bind-mounting it (e.g. the `yolo` sandbox) end up with a dead fd.

Fix: a user-level socat listens on a stable path and forwards each connection to
the current `bus`. Requires linger so it survives logout:
`sudo loginctl enable-linger "$USER"`.

`~/.config/systemd/user/dbus-forward-proxy.socket`:
```
[Unit]
Description=Stable proxy socket for SSH-forwarded dbus

[Socket]
ListenStream=%t/bus-proxy
SocketMode=0600
Accept=yes

[Install]
WantedBy=sockets.target
```

`~/.config/systemd/user/dbus-forward-proxy@.service`:
```
[Unit]
Description=dbus forward proxy connection

[Service]
ExecStart=/usr/bin/socat - UNIX-CONNECT:%t/bus
StandardInput=socket
StandardOutput=socket
```

Enable and test:
```
systemctl --user daemon-reload
systemctl --user enable --now dbus-forward-proxy.socket
DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus-proxy notify-send hi
```

`bin/yolo` already prefers `bus-proxy` over `bus` when mounting.
