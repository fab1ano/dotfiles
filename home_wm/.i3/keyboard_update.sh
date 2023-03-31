#!/bin/bash
# Stub for inputplug

if [ "$1 $3" == "XIDeviceEnabled XISlaveKeyboard"  ]
then
	setxkbmap -option altwin:swap_lalt_lwin
fi

if [ "$1 $3 $4" == "XIDeviceEnabled XISlavePointer HTX USB HID Device HTX HID Device Touchpad"  ]
then
	xinput --set-prop $2 'libinput Tapping Enabled' 1
	xinput --set-prop $2 'libinput Accel Speed' 0.5
fi
