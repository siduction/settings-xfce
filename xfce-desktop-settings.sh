#!/usr/bin/bash
#
# XFCE desktop configurations
#
# Name: xfce-desktop-settings.sh
# Run as user.
#

# DESKTOP (xfce4-desktop)
## Same background for all workspaces
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor$(xrandr | grep -m1 connected | awk '{print $1}')/workspace0/last-image -s /usr/share/wallpapers/big-crime-xmas.png --create -t string
xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-mode -s true --create -t bool
xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-number -s 0 --create -t int

## Transparent background for labeling the desktop icons
xfconf-query -c xfce4-desktop -p /desktop-icons/label-background-color -t int -s 0 -t int -s 0 -t int -s 0 -t int -s 0 --create
xfconf-query -c xfce4-desktop -p /desktop-icons/use-custom-label-background-color -t bool -s true --create

## Do not display file system folder icons but removable devices
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -s false --create -t bool
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-device-fixed -s false --create -t bool
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -s false --create -t bool
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -s true --create -t bool


# Panel
## Panel-1, size and automatically adjust icon size
xfconf-query -c xfce4-panel -p /panels/panel-1/size -t uint -s 40 --create
xfconf-query -c xfce4-panel -p /panels/panel-1/icon-size -t uint -s 0 --create

## Display siduction icon but no title in the menu button
xfconf-query -c xfce4-panel -p /plugins/plugin-1/button-icon -s siduction -t string --create
xfconf-query -c xfce4-panel -p /plugins/plugin-1/show-button-title -s false -t bool --create

## Systray plugin: Automatically adjust icon size
xfconf-query -c xfce4-panel -p /plugins/plugin-6/icon-size -t uint -s 0 --create


# Metadata siduction icons
## Setting the metadata::xfce-exe-checksum attribute for the desktop icons
cd /home/${USER}/Desktop/
gio set -t string "siduction-manual.desktop" metadata::xfce-exe-checksum "$(sha256sum "siduction-manual.desktop" | awk '{print $1}')"
gio set -t string "siduction-irc.desktop" metadata::xfce-exe-checksum "$(sha256sum "siduction-irc.desktop" | awk '{print $1}')"
gio set -t string "chroot-helper.desktop" metadata::xfce-exe-checksum "$(sha256sum "chroot-helper.desktop" | awk '{print $1}')" 2>/dev/null
gio set -t string "calamares.desktop" metadata::xfce-exe-checksum "$(sha256sum "calamares.desktop" | awk '{print $1}')" 2>/dev/null

sleep 1

if [ -f /home/${USER}/.config/autostart/Desktop-settings.desktop ]; then
    rm /home/${USER}/.config/autostart/Desktop-settings.desktop
fi

exit 0
