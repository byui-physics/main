---
title: Virtual Environments
sidebar: sidebarNelson
permalink: virtualEnv.html
toc: true
---

Python applications frequently use packages that are not standard.
Because some applications may require different versions of these
packages, it is convenient to use python in an isolated environment
for each application. For example, maybe you need version 3.0 of
package A for one application but version 4.5 for another application.
 Being able to quickly switch between package installations becomes
 important.  Python virtual environments were designed for
just this purpose.  To install a virtual environment, follow the
instructions below:  
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
