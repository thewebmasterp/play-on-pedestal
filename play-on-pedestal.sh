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






#function increase_sound {
#	pactl list short sink-inputs | while read PID PSINKID STH1 STH2 NAME dump
#	do
#                #HAHO=$(/usr/bin/pacmd info | grep -A 5 $PID | grep -o '[^ ]*%')
#                echo 1#"$HAHO"
# 
#                # echo $PID
#                # echo $PSINKID
#                # echo $NAME
#                #VOLUME = pactl get-sink-volume $PID
#                #pactl -- set-sink-input-volume $PID +90%
#	done
#}
#function decrease_sound {
#	pactl list short sink-inputs | while read PID PSINKID dump
#	do
#                #echo $PID
#                HAHO=$(/usr/bin/pacmd info | grep -A 5 $PID | grep -o '[^ ]*%')
#                echo $HAHO                 
#
#                #pactl -- set-sink-input-volume $PID -90%
#	done
#}
#
#update
#
#



# Decrese master sound
#for run in {1..6}; do /usr/bin/amixer set Master 5%-; done
# for run in {1..6}; do /usr/bin/pactl -- set-sink-volume 0 -5%; done

#sleep 0.5
#Play notification

#decrease_sound
#/usr/bin/paplay --volume 65536 ~/.local/share/ringtones/just_a_little_error.wav
#increase_sound

#sleep 0.5

# The sleep 0.01 is to compensate some noticable difference.
# for run in {1..6}; do sleep 0.01; /usr/bin/amixer set Master 5%+; done
