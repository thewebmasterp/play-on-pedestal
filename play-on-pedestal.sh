#!/bin/bash

function increase_sound {
  pactl list short sink-inputs | while read PID dump
  do
    VolumeForPID="$(/usr/bin/pacmd info | grep -A 5 $PID | grep -o '[^ ]*%' | grep -m 1 -o '[0-9]*')"
    if [ "$VolumeForPID" -lt "70" ]; then
      # echo "increase volume by 29"
      pactl -- set-sink-input-volume $PID +29%
    fi
  done
}

function decrease_sound {
  pactl list short sink-inputs | while read PID dump
  do
    VolumeForPID="$(/usr/bin/pacmd info | grep -A 5 $PID | grep -o '[^ ]*%' | grep -m 1 -o '[0-9]*')"
    if [ "$VolumeForPID" -gt "30" ]; then
      # echo "decrease volume by 29"
      pactl -- set-sink-input-volume $PID -29%
    fi
  done
}

decrease_sound
sleep 0.1
/usr/bin/paplay --volume 65536 $1
sleep 0.1
increase_sound

