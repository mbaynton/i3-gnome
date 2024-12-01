#!/bin/bash

set -euo pipefail

mkdir -p /usr/lib/systemd/user/gnome-session@i3-gnome.target.d
chmod 0755 /usr/lib/systemd/user/gnome-session@i3-gnome.target.d
cp -a /usr/lib/systemd/user/gnome-session@ubuntu.target.d/* /usr/lib/systemd/user/gnome-session@i3-gnome.target.d/
# The ubuntu one Requires gnome shell, we obviously do not.
sed s/Requires=org.gnome.Shell.target// < /usr/lib/systemd/user/gnome-session@i3-gnome.target.d/ubuntu.session.conf > /usr/lib/systemd/user/gnome-session@i3-gnome.target.d/i3-gnome.session.conf
rm /usr/lib/systemd/user/gnome-session@i3-gnome.target.d/ubuntu.session.conf

# Instead, we Want gnome-fallback. Its .target/.service files are provided by the apt package in universe.
grep -qF 'Wants=gnome-flashback.target' < /usr/lib/systemd/user/gnome-session@i3-gnome.target.d/i3-gnome.session.conf || echo Wants=gnome-flashback.target >> /usr/lib/systemd/user/gnome-session@i3-gnome.target.d/i3-gnome.session.conf
