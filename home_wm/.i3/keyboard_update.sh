#!/bin/bash
# Stub for inputplug

# Swap Alt and Super
if [ "$1 $3" == "XIDeviceEnabled XISlaveKeyboard"  ]
then
	setxkbmap -option altwin:swap_lalt_lwin
fi

# Touchpad
if [ "$1 $3 $4" == "XIDeviceEnabled XISlavePointer HTX USB HID Device HTX HID Device Touchpad"  ]
then
	xinput --set-prop $2 'libinput Tapping Enabled' 1
	xinput --set-prop $2 'libinput Accel Speed' 0.7
#	xinput --set-prop $2 --type=float "Coordinate Transformation Matrix" 0.7071 -0.7071 0 0.7071 0.7071 0 0 0 1
fi

# Ball Mouse
if [ "$1 $3 $4" == "XIDeviceEnabled XISlavePointer Kensington Expert Wireless TB Mouse"  ]
then
	xinput --set-button-map $2 8 1 3 4 5 6 7 2 9
	xinput --set-prop $2 'libinput Accel Speed' 1.0
	xinput --set-prop $2 'libinput Scrolling Pixel Distance' 50
fi
