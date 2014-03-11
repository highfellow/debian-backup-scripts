Debian backup scripts
=====================

These are some scripts I wrote for keeping rotating backups of a debian server. I am keeping them here mainly for my own reference, but you're welcome to use them if you wish. Raise an issue if you need help or more information.

The scripts mirror a set of files under a source directory to a local usb disk every night, using rsync with its --link-dest option, which creates a series of daily backups in separate directories, where duplicate files between days are stored as hard links to the same inode. 

This means that each day's backup appears as a complete archive of that day's data, but disk space is only used for unique revisions of a given file. Unlike a normal master plus incremental backup system, there is no need to re-do the master backup regularly - the current day's backups are always a full copy. See: (http://www.mikerubel.org/computers/rsync_snapshots/) for more information.

The other part of the system allows you to rotate the backup disk media at intervals, so that one copy can be kept off site. The way this works is that when you plug in a new usbdisk whose volume label is with 'USBBACKUP' plus a disk number, this is automatically mounted and the files from the current disk transferred to it. Once this is finished, the admin(s) get an email and the current disk can be unplugged.

Configuration
-------------
The main things you need to do to set this up are:

  - make sure all the files you want to archive as daily snapshots are kept under a single directory. You can use symlinks to do this if they aren't arranged that way already.
  - you can also have another directory for files which only need to be archived once (no snapshots). E.g. a git repository.
  - create a top level directory to be the mount point for the backup disks. E.g. '/backup'.
  - get two or more usb hard drives to use as backup drives, and label these with the volume label 'USBBACKUPx' where x is the number of the drive in the sequence. It's a good idea to put sticky labels on the drives with the drive number.
  - copy or symlink all the files from bin/ and etc/ to /usr/local/(bin|etc).
  - symlink /usr/local/etc/80-usb-backup.rules to be in /etc/udev/rules.d, and do 'service udev restart' to add this rule to the udev database.
  - symlink /usr/local/bin/check-backup-swap to be in /etc/cron.daily. (This will email you when the disks need rotating).
  - symlink /usr/local/bin/backup-cron to be in /etc/cron.d. (This will run the main backup script every day). Do 'service cron restart' to read the new cron rule in.
  - go through /usr/local/etc/backup.conf, configuring the settings to suit your installation. The inline comments should be enough to tell you what the options mean.

Usage
-----

To begin using the system, plug one of the backup disks into a usb port. The disk should be recognised and mount itself at the appropriate mount point to store the backups. The backups will be in directories numbered from 0 to the number of days you are keeping snapshots. 0 is the youngest. Each day's snapshot will be a complete mirror of the state of the backed up directory at that point.

You should get a daily log from the backup script to the mail address(es) you configured in backup.conf.

After the number of days you've configured in backup.conf, you should get an email warning you the disks need changing. Plug the next disk in the sequence into a free usb port. The disk should be recognised, and be mounted. The files from the current disk will be copied to it and then it will be set as the new current disk.

You will then get an email telling you it's ok to remove the previous disk. (Or an error message). This disk can then be unplugged and stored or taken off site.

If you need to recover a file from a particular day, just work out how many days ago it was, and look for the directory under /backup/current/backups with that number. (Or see the creation dates for the numbered directories). The file should be in the relevant branch of the directory tree under there.
