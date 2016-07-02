if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
	[ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -x $HOME/.screenlayout/secondary_display.sh ]; then
    $HOME/.screenlayout/secondary_display.sh
fi

xsetroot -cursor_name left_ptr
setxkbmap pl
xmodmap $HOME/.Xmodmap

systemctl --user start dropbox
systemctl --user start megasync
systemctl --user start pulseaudio
systemctl --user start udiskvm
systemctl --user start trayer
systemctl --user start volwheel
systemctl --user start clipster

export _JAVA_AWT_WM_NONREPARENTING=1

exec xmonad
