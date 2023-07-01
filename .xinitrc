#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# Set display properties with xrandr
# xrandr --dpi 96
# xrandr --dpi 144
xrandr --output eDP1 --mode 2560x1440 --dpi 144
# xrandr --output eDP1 --off
# xrandr --output HDMI1 --mode 1920x1080 --scale 1.5 --primary

# Set custom screen DPI (helps for HiDPI screens):
# xrdb -merge ~/.Xresources
# xrdb ~/.Xresources


# Load keyboard shortcuts specified in ~/.xbindkeysrc
#xbindkeys

# ./xsetprop.sh
# Set trackpad and scroll behavior using xinput:
#
# MacBook:
#xinput set-prop 'bcm5974' 'libinput Natural Scrolling Enabled' 1
#xinput set-prop 'bcm5974' 'libinput Tapping Enabled' 1
#xinput set-prop 'bcm5974' 'libinput Accel Speed' 0.6
##
# ThinkPad:
xinput set-prop "Synaptics TM3289-021" "libinput Tapping Enabled" 1
xinput set-prop "Synaptics TM3289-021" "libinput Natural Scrolling Enabled" 1
xinput set-prop "Synaptics TM3289-021" "libinput Accel Speed" "0.35"
##
# HP:
##xinput set-prop 'SYNA30D9:00 06CB:CEA4 Touchpad' 'libinput Tapping Enabled Default' 1
##xinput set-prop 'SYNA30D9:00 06CB:CEA4 Touchpad' 'libinput Tapping Enabled' 1;
##xinput set-prop 'SYNA30D9:00 06CB:CEA4 Touchpad' 'libinput Natural Scrolling Enabled' 1;

##Section "InputClass"
##        Identifier "libinput touchpad catchall"
##        MatchIsTouchpad "on"
##        MatchDevicePath "/dev/input/event*"
##        Driver "libinput"
##	Option "Tapping Enabled" "1"
##	Option "Natural Scrolling Enabled" "1"
##	Option "Accel Speed" "0.4"
##EndSection


# Set XKB keymap:
xkbcomp ~/.xkb/vimkeys_LWIN_and_TLDE_to_Super.xkb $DISPLAY
# xkbcomp ~/.xkb/vimkeys-mac-cmd-to-mod3.xkb $DISPLAY
# xkbcomp ~/.xkb/vimkeys-mac-esc-to-mod3.xkb $DISPLAY


# Start window manager
exec i3
#exec openbox

