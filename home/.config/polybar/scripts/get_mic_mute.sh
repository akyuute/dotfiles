#!/bin/bash

# Use pactl to get the current microphone state.
# Echo a muted or unmuted icon, which can be set manually.
# The name of a source device is required as a positional argument.

# Syntax:
# -h (Print a help message)
# -m MUTED_ICON
# -u UNMUTED_ICON

Help()
{
    echo "Syntax: $0 SOURCE -[h|m|u] [...]"
    echo "        SOURCE - Audio source device name"
    echo "        (Usually something crazy like 'alsa_input.pci-0000_00_1f.3- ...')"
    echo ""
    echo "Options:"
    echo "-h  (Print this help message and exit)"
    echo "-m  MUTED_ICON"
    echo "-u  UNMUTED_ICON"
}

if [ $# == 0 ];
then
    echo "Error: Invalid syntax" 2>&1
    Help
    exit 1
fi

src=$1
icon_muted=''
icon_unmuted=''


while getopts "h:m:u:" opt;
do
    case $opt in
        h)
            Help
            exit 0
            ;;

        m)
            icon_muted=$OPTARG
            ;;
        u)
            icon_unmuted=$OPTARG
            ;;
        \?)
            echo "Invalid syntax"
            Help
            exit 1 ;;

    esac
done

muted=`pactl get-source-mute "$src" | sed -n 's/Mute: //p'`
[[ "$muted" =~ "yes" ]] && echo $icon_muted || echo $icon_unmuted
