Debian backup scripts
=====================

These are some scripts I wrote for keeping rotating backups of a debian server. I am keeping them here mainly for my own reference, but you're welcome to use them if you wish. Raise an issue if you need help or more information.

The scripts mirror a set of files under a source directory to a local usb disk every night, using rsync with its --link-dest option, which creates a series of daily backups in separate directories, where duplicate files between days are stored as hard links to the same inode. 

This means that each day's backup appears as a complete archive of that day's data, but disk space is only used for unique revisions of a given file. Unlike a normal master plus incremental backup system, there is no need to re-do the master backup regularly - the current day's backups are always a full copy. See: (http://www.mikerubel.org/computers/rsync_snapshots/) for more information.

The scripts have been rewritten in a recent commit, and I will add some brief instructions to the new setup later.
