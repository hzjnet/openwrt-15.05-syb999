#!/bin/sh

xmgetspkdev=$(amixer | grep 'Simple mixer control' | grep -e 'Speaker' -e 'PCM' -e 'Master' | cut -d "'" -f 2)
getcurrentvolume=$(amixer get $xmgetspkdev | tail -n 1 | cut -d ' ' -f 6)
if [ "$xmgetspkdev" == "Speaker" ];then
	getmaxvolume=$(amixer get Speaker | head -n 4 | tail -n 1 | cut -d '-' -f 2 | cut -d ' ' -f 2)
	if [ $getmaxvolume -lt 100 ];then
		volumestep=3
	else
		volumestep=12
	fi
elif [ "$xmgetspkdev" == "PCM" ];then
	volumestep=8
else
	volumestep=5
fi
volume=$getcurrentvolume

if [ "$xmgetspkdev" == "Speaker" ];then
	if [ $volume -gt 0 ];then
		volume=$(echo `expr $volume - $volumestep`)
		volumedown=$volume
		amixer -q set Speaker $volumedown
	fi
elif [ "$xmgetspkdev" == "PCM" ];then
	if [ $volume -gt 0 ];then
		volume=$(echo `expr $volume - $volumestep`)
		volumeup=$volume
		amixer -q set PCM $volumeup
	fi
else
	if [ $volume -gt 0 ];then
		volume=$(echo `expr $volume - $volumestep`)
		volumeup=$volume
		amixer -q set Master $volumeup
	fi
fi

