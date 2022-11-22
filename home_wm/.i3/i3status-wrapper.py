#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# This script is a simple wrapper which prefixes each i3status line with custom
# information. It is a python reimplementation of:
# http://code.stapelberg.de/git/i3status/tree/contrib/wrapper.pl
#
# To use it, ensure your ~/.i3status.conf contains this line:
#     output_format = "i3bar"
# in the 'general' section.
# Then, in your ~/.i3/config, use:
#     status_command i3status | ~/i3status/contrib/wrapper.py
# In the 'bar' section.
#
# In its current version it will display the cpu frequency governor, but you
# are free to change it to display whatever you like, see the comment in the
# source code below.
#
# © 2012 Valentin Haenel <valentin.haenel@gmx.de>
#
# This program is free software. It comes without any warranty, to the extent
# permitted by applicable law. You can redistribute it and/or modify it under
# the terms of the Do What The Fuck You Want To Public License (WTFPL), Version
# 2, as published by Sam Hocevar. See http://sam.zoy.org/wtfpl/COPYING for more
# details.

import sys
import json
import psutil
import subprocess


def get_cpu_usage():
    """Get current cpu usage per core."""
    cpu_usage = psutil.cpu_percent(percpu=True)
    num_cpu = len(cpu_usage)
    cpu_usage = list(map(lambda x: int(max(1, min(8, x/12.5 + 1))), cpu_usage))
    avg = sum(cpu_usage)
    cpu_usage = map(lambda x: chr(0x2580+x), cpu_usage)

    color = '#FFFFFF'
    if avg >= 4 * num_cpu:
        color = '#FFFF00'  # yellow
    if avg >= 6 * num_cpu:
        color = '#FF0000'  # red

    return '\u200a'.join(cpu_usage), color


def get_vm_status():
    """Get current vm status."""
    status_str = ''
    color = '#FFFFFF'

    try:
        vm_usage = subprocess.check_output(['virsh',
            'list']).decode('utf-8').split('\n')
        for i in range(2, len(vm_usage)-2):
            vm_name = vm_usage[i]
            vm_name = vm_name[6:].split(' ')[0]
            status_str += vm_name + ' '
    except:
        status_str = 'vm error'

    status_str = status_str.strip()

    return status_str, color


def get_clockify_status():
    """Get current clockify status."""
    status_str = ''
    color = '#FFFFFF'

    try:
        time_entry = subprocess.run(['clockify-cli', 'show', 'current'],
                stdout=subprocess.PIPE).stdout.decode('utf-8').split('\n')
        if len(time_entry) >= 5:
            line = time_entry[3].split('|')
            start = line[2].strip().split(' ')[1][:-3]
            project = line[5].strip()

            status_str += f'{project} ({start})'

    except:
        status_str = 'clockify error'

    status_str = status_str.strip()

    return status_str, color


def print_line(message):
    """ Non-buffered printing to stdout. """
    sys.stdout.write(message + '\n')
    sys.stdout.flush()


def read_line():
    """ Interrupted respecting reader for stdin. """
    # try reading a line, removing any extra whitespace
    try:
        line = sys.stdin.readline().strip()
        # i3status sends EOF, or an empty line
        if not line:
            sys.exit(3)
        return line
    # exit on ctrl-c
    except KeyboardInterrupt:
        sys.exit()

if __name__ == '__main__':
    # Skip the first line which contains the version header.
    print_line(read_line())

    # The second line contains the start of the infinite array.
    print_line(read_line())

    while True:
        line, prefix = read_line(), ''
        # ignore comma at start of lines
        if line.startswith(','):
            line, prefix = line[1:], ','

        j = json.loads(line)
        # insert information into the start of the json, but could be anywhere

        cpu_text, cpu_color = get_cpu_usage()
        j.insert(0, {'color' : cpu_color, 'full_text' : cpu_text, 'name' : 'cpu_usage'})
        vm_text, vm_color = get_vm_status()
        j.insert(0, {'color' : vm_color, 'full_text' : vm_text, 'name' : 'vm_status'})
        clockify_text, vm_color = get_clockify_status()
        j.insert(0, {'color' : vm_color, 'full_text' : clockify_text, 'name' : 'clockify_status'})

        # and echo back new encoded json
        print_line(prefix+json.dumps(j))
