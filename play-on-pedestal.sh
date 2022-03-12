#!/bin/bash

function increase_volume() {
  pactl list short sink-inputs | while read PID dump
  do
    VolumeForPID="$(/usr/bin/pacmd info | grep -A 5 $PID | grep -o '[^ ]*%' | grep -m 1 -o '[0-9]*')"
    if [ "$VolumeForPID" -lt "70" ]; then
      # echo "increase volume by 30"
      for run in {1..6}; do /usr/bin/pactl -- set-sink-input-volume $PID +5%; sleep 0.01; done
    fi
  done
}

function decrease_volume() {
  pactl list short sink-inputs | while read PID dump
  do
    VolumeForPID="$(/usr/bin/pacmd info | grep -A 5 $PID | grep -o '[^ ]*%' | grep -m 1 -o '[0-9]*')"
    if [ "$VolumeForPID" -gt "30" ]; then
      # echo "decrease volume by 30"
      for run in {1..6}; do /usr/bin/pactl -- set-sink-input-volume $PID -5%; done
    fi
  done
}

decrease_volume
sleep 0.01
/usr/bin/paplay --volume 65536 $1
sleep 0.01
increase_volume

