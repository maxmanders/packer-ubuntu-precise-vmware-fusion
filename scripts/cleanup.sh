# And reboot 
if [ -f /var/run/reboot-required ]; then
  /sbin/reboot
fi
exit 0
