#!/bin/bash

MON_0_CONN=$(xrandr -q | grep "${EXTERNAL_MONITOR_0} connected")
MON_1_CONN=$(xrandr -q | grep "${EXTERNAL_MONITOR_1} connected")

killall -q polybar

while pgrep -u $UID -x polybar > /dev/null; do sleep 2; done
if [ "$MON_0_CONN" ] && [ "$MON_1_CONN" ]; then
  polybar --reload laptop -c ~/.config/polybar/laptop.ini </dev/null >/var/tmp/polybar-laptop.log 2>&1 200>&- &
  polybar --reload ext_mon_1 -c ~/.config/polybar/ext_mon_1.ini </dev/null >/var/tmp/polybar-ext_mon_1.log 2>&1 200>&- &
  polybar --reload ext_mon_2 -c ~/.config/polybar/ext_mon_2.ini </dev/null >/var/tmp/polybar-ext_mon_2.log 2>&1 200>&- &
else
  polybar --reload laptop -c ~/.config/polybar/laptop.ini </dev/null >/var/tmp/polybar-laptop.log 2>&1 200>&- &
fi
