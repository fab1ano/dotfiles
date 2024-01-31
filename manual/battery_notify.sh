#!/bin/sh
# Place this script in ~ and add the following line to 'crontab -e':
#   */1 * * * * sh -c "${HOME}/.battery_notify.sh"
# 
# It might be necessary to set $HOME/.DBUS/xDBUS (maybe even at every startup):
#   touch $HOME/.dbus/Xdbus
#   chmod 600 $HOME/.dbus/Xdbus
#   env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.dbus/Xdbus
#   echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.dbus/Xdbus


battery_level="$(cat /sys/class/power_supply/BAT0/capacity)"

if [ -z "$battery_level"  ]; then
	notify-send "Charge status unavailable"
	exit 0
fi

if [ "$battery_level" -le "15"  ]; then
	notify-send -t 45000 -u critical "Battery Critical" "Battery level is ${battery_level}%" 
	exit 0
fi
