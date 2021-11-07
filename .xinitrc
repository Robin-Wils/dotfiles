xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi=96 # Optional, if the text is too large or small by default when started

xfdesktop &
xfsettingsd &
stalonetray &
nextcloud &
exec dbus-run-session xfwm4
