#!/bin/bash

mixer='Capture'
icon_muted=''
icon_unmuted=''
state=`amixer get $mixer | sed -En 's/.*\[(.*)\]/\1/p'`
[[ "$state" =~ "on" ]] && echo $icon_unmuted || echo $icon_muted
