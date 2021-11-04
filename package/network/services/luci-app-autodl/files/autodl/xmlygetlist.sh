#!/bin/sh

paudiopath=$(uci get autodl.@autodl[0].xmlypath)
paudioname=$(uci get autodl.@autodl[0].xmlyname)

testplayer=$(opkg list-installed | grep "gst-play-1.0")

cd $paudiopath/$paudioname

if [ -e /tmp/tmp.Audioxm.list ];then
	rm /tmp/tmp.Audioxm.list
fi

if [ ! "$testplayer" ];then
	find *.mp3 > /tmp/tmp.Audioxm.list
else
	find *.mp3 > /tmp/tmp.Audioxm.list
	find *.m4a >> /tmp/tmp.Audioxm.list
	find *.aac >> /tmp/tmp.Audioxm.list
fi
