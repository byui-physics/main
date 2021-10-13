---
title:  Editing remote files from local machine
sidebar: sidebarNelson
permalink: remoteEdit.html
toc: true
topnav: topnav
---

### Editing ML files remotely
When you are writing code on ML sometimes it's nice to use a local
editor, instead of in-terminal version of emacs, to edit those files.  Here is how you do that.

1.  Create a folder on your local machine.  Call it whatever you want  
```bash
cd ~
mkdir sc
```

2. Run  
```bash
sshfs -o follow_symlinks <your-user-name>@ssh.rc.byu.edu:/fslhome/legoses sc
```
(Make sure you insert the directory that you chose into this command)

This will create a link to your ML filesystem into the folder you
chose.   You can now open and edit these files and the changes you
make will be automatically synced to ML.

Warning: Due to two-factor authentication.  If you let your computer
go to sleep your computer will repeatedly attempt to login to ML
(unsuccessfully) and you will get locked out of your account.  If
you're going to step away from your computer, you should dismount the
drive, like this:
```bash
umount sc
```
