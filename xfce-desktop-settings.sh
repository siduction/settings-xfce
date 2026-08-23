#!/usr/bin/bash
#
# XFCE desktop configurations
#
# Name: xfce-desktop-settings.sh
# Run as user.
#

#------------------
# DESKTOP (xfce4-desktop)
## Find out the interface and the screen size.
## Search for a suitable wallpaper file.
## Set same background for all workspaces.
Monitor=$(xrandr | grep -m1 " connected " | sed 's|+.*$||')
Iface=$(awk '{print $1}' <<< $Monitor)
SizeFile=$(awk '{print $'"$(wc -w <<< "$Monitor")"' ".png"}' <<< $Monitor)
ImagePath="/usr/share/wallpapers/big-crime/contents/images_dark/"
if [ -f "$ImagePath$SizeFile" ]; then
	xfconf-query -c xfce4-desktop -pn /backdrop/screen0/monitor"$Iface"/workspace0/last-image -t string -s "$ImagePath$SizeFile" --create
else
	xfconf-query -c xfce4-desktop -pn /backdrop/screen0/monitor"$Iface"/workspace0/last-image -t string -s /usr/share/wallpapers/big-crime_dark.png --create
	xfconf-query -c xfce4-desktop -pn /backdrop/screen0/monitor"$Iface"/workspace0/image-style -t uint -s 3 --create
fi
xfconf-query -c xfce4-desktop -pn /backdrop/single-workspace-mode -s true --create -t bool
xfconf-query -c xfce4-desktop -pn /backdrop/single-workspace-number -s 0 --create -t int

## Transparent background for labeling the desktop icons
xfconf-query -c xfce4-desktop -p /desktop-icons/label-background-color -t int -s 0 -t int -s 0 -t int -s 0 -t int -s 0 --create
xfconf-query -c xfce4-desktop -p /desktop-icons/use-custom-label-background-color -t bool -s true --create

## Do not display file system folder icons but removable devices
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -s false --create -t bool
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-device-fixed -s false --create -t bool
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -s false --create -t bool
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -s true --create -t bool


# -----------------
# PANEL
## Panel-1, size and automatically adjust icon size
xfconf-query -c xfce4-panel -p /panels/panel-1/size -t uint -s 40 --create
xfconf-query -c xfce4-panel -p /panels/panel-1/icon-size -t uint -s 0 --create

## Display siduction icon but no title in the menu button
xfconf-query -c xfce4-panel -p /plugins/plugin-1/button-icon -s siduction -t string --create
xfconf-query -c xfce4-panel -p /plugins/plugin-1/show-button-title -s false -t bool --create

## Systray plugin: Automatically adjust icon size
xfconf-query -c xfce4-panel -p /plugins/plugin-6/icon-size -t uint -s 0 --create


# -----------------
# METADATA SIDUCTION ICONS
## Setting the metadata::xfce-exe-checksum attribute for the desktop icons
cd /home/${USER}/Desktop/
gio set -t string "siduction-manual.desktop" metadata::xfce-exe-checksum "$(sha256sum "siduction-manual.desktop" | awk '{print $1}')"
gio set -t string "siduction-irc.desktop" metadata::xfce-exe-checksum "$(sha256sum "siduction-irc.desktop" | awk '{print $1}')"
gio set -t string "chroot-helper.desktop" metadata::xfce-exe-checksum "$(sha256sum "chroot-helper.desktop" | awk '{print $1}')" 2>/dev/null
gio set -t string "calamares.desktop" metadata::xfce-exe-checksum "$(sha256sum "calamares.desktop" | awk '{print $1}')" 2>/dev/null


# -----------------
# TERMINAL (xfce4-terminal)
## Setting color palette
xfconf-query -c xfce4-terminal -pn /color-background -s \#000000 --create -t string
xfconf-query -c xfce4-terminal -pn /color-foreground -s \#ffffff --create -t string
xfconf-query -c xfce4-terminal -pn /color-bold-is-bright -s true --create -t bool
xfconf-query -c xfce4-terminal -pn /color-bold-use-default -s true --create -t bool
xfconf-query -c xfce4-terminal -pn /color-cursor-use-default -s true --create -t bool
xfconf-query -c xfce4-terminal -pn /color-selection-use-default -s true --create -t bool
xfconf-query -c xfce4-terminal -pn /color-palette -s \#000000\;\#cc0000\;\#4e9a06\;\#c4a000\;\#3465a4\;\#75507b\;\#06989a\;\#d3d7cf\;\#555753\;\#ef2929\;\#8ae234\;\#fce94f\;\#739fcf\;\#ad7fa8\;\#34e2e2\;\#eeeeec --create -t string
xfconf-query -c xfce4-terminal -pn /tab-activity-color -s \#aa0000 --create -t string

sleep 1

if [ -f /home/"$USER"/.config/autostart/Desktop-settings.desktop ]; then
    rm /home/"$USER"/.config/autostart/Desktop-settings.desktop
fi

exit 0
