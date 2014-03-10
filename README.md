Debian backup scripts
=====================

These are some scripts I wrote for keeping rotating backups of a debian server. They mirror a set of files under a source directory to a local usb disk every night, using rsync with its --link-dest option, which creates a series of daily backups in separate directories, where duplicate files between days are stored as hard links to the same inode. 

This means that each day's backup appears as a complete archive of that day's data, but disk space is only used for unique revisions of a given file. Unlike a normal master / incremental backup system, there is no need to re-do the master backup regularly - the current day's backups are always a full copy. See: (http://www.mikerubel.org/computers/rsync_snapshots/) for more information.

The other part of the system allows you to rotate the backup disk media at intervals, so that one copy can be kept off site. The way this works is that when you plug in a new usbdisk whose volume label begins with 'USBBACKUP', this is automatically mounted and the files from the current disk transferred to it. Once this is finished, the admin(s) get an email and the current disk can be unplugged.

Configuration
-------------


