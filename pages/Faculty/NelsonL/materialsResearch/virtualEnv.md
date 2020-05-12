---
title: Virtual Environments
sidebar: sidebarNelson
permalink: virtualEnv.html
toc: true
---

Make a directory called environments and go into that directory:  
``` bash
mkdir ~/environments
cd ~/environments
```
Create the virtual environment  
``` bash
virtualenv alloys 
```

Enter the virtual environment:  
``` bash
workon alloys 
```

You can exit the environment like this:  
``` bash
deactivate alloys 
```
