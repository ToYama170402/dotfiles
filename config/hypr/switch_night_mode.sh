#!/bin/sh

if [ $(ps aux | grep hyprsunse | wc -l) = 1 ]; then
	hyprsunset --temperature 2000 > /dev/null & disown
else
	killall hyprsunset
fi
