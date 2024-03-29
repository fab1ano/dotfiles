# Autogenerated config.py
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

# Uncomment this to still load settings configured via autoconfig.yml
config.load_autoconfig()

config.bind('<Ctrl-k>', 'spawn --userscript qute-keepass -p ~/.db.kdbx')
config.bind('<Ctrl-s>', 'spawn --userscript qute-keepass -p ~/.db.kdbx --username-fill-only')
config.bind('<Ctrl-b>', 'spawn --userscript qute-keepass -p ~/.db.kdbx --password-fill-only')


#c.content.private_browsing = True
c.content.cookies.accept = 'no-3rdparty'
c.auto_save.session = True

c.url.default_page = 'about:blank'
c.url.start_pages = 'about:blank'

c.completion.cmd_history_max_items = 10000

c.downloads.location.directory = '~/downloads'

# Colors
bgColor        = '#2f343f'
bgColor2       = '#444953'
bgColorStatus  = bgColor
textColor      = 'grey'
textColorSel   = 'white'

# Another good set of colors would be
#bgColor        = '#ffffff'
#bgColor2       = '#f0f0f0'
#bgColorStatus  = '#2f343f'
#textColor      = 'grey'
#textColorSel   = 'black'
# Or
#bgColor        = '#29487d'
#bgColor2       = '#4267b2'
#bgColorStatus  = '#2f343f'
#textColor      = 'grey'
#textColorSel   = 'white'

c.colors.tabs.bar.bg = bgColor

c.colors.tabs.odd.fg = textColor
c.colors.tabs.odd.bg = bgColor
c.colors.tabs.even.fg = textColor
c.colors.tabs.even.bg = bgColor2

c.colors.tabs.selected.odd.fg = textColorSel
c.colors.tabs.selected.odd.bg = bgColor
c.colors.tabs.selected.even.fg = textColorSel
c.colors.tabs.selected.even.bg = bgColor2

c.colors.statusbar.normal.bg = bgColorStatus
c.colors.statusbar.command.bg = bgColorStatus
c.colors.statusbar.command.private.bg = bgColorStatus
c.colors.statusbar.private.bg = bgColorStatus

c.colors.downloads.bar.bg = bgColor

c.tabs.last_close = 'blank'
