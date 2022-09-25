#!/bin/bash
# Stub for inputplug

if [ "$1 $3" == "XIDeviceEnabled XISlaveKeyboard"  ]
then
	setxkbmap -option altwin:swap_lalt_lwin
fi
