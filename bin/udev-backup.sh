#!/bin/bash

# this is invoked by a udev rule: /usr/local/etc/80-usb-backup.rules

. /usr/local/etc/backup.conf

# following lines are for testing the udev rule.
#echo "---------------------" >> /tmp/udev-backup
#env >> /tmp/udev-backup
#echo $ACTION >> /tmp/udev-backup

if [ "$ACTION" == "add" ] ; then
  # kick off the disk-change script
#  echo "run" >> /tmp/udev-backup
  /usr/local/bin/run-disk-change &
  disown -ha # disown that job before exiting
else
  # unmount the device
#  echo "unmount" >> /tmp/udev-backup
  umount $DEVNAME
fi
