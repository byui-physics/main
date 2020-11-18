---
title:  Installing necessary software
sidebar: sidebarNelson
permalink: neededSoftware.html
toc: true
summary: Instruction for installing important softwares.
---



## AFLOW

AFLOW is a package written by collaborators at Duke University.  It
will help automate the crucial quantum-mechanical calculations that
you will perform.  The instructions for installing aflow can be found
[here][AFLOWInstall].  Follow the instructions on slides 13 and 14 if
installing on MaryLou.  Once you have it installed, you'll need to
modify a file called `aflow.rc` located in your root:

``` bash
emacs ~/.aflow.rc
```

1. Find the tag labeled `DEFAULT_VASP_BIN` and set it equal to
`vasp6_serial`
2. Find the tag labeled `DEFAULT_VASP_MPI_BIN` and set it equal to
`vasp6`
3. Find the tag labeled `DEFAULT_VASP_POTCAR_DIRECTORIES` and replace
   `/somewhere/` with `/fslhome/glh43/src/vasp`. 
4. Save the file and exit.


## aBuild

aBuild is a python package that I built to help automate file
construction and data analysis that will be needed.  When installing
python packages, it is best to do it inside something called a virtual
environment.  You can install python packages inside of your virtual
environment without disturbing the packages installed outside of the
virtual environment.  

### Setting up your virtual environment
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

### Installing aBuild
1.Register for an account on [github][gh].  
2.Navigate to B. Nelson's aBuild repository (found [here][ljnabuild])  
3.Fork B. Nelson's reposity.  This will create a copy of this code
that is yours to edit.  
4.[back on ML] Make a directory called `codes` and go into it:
``` bash
mkdir ~/codes
cd ~/codes
```

5.[Back on ML]  Type the following to clone your aBuild repository to
ML:  
```bash
git clone https://github.com/<username>/aBuild.git .
```  
(make sure you replace my username with yours.)

6.Install aBuild (while in your virtual environment)
```bash
pip install -e ~/codes/aBuild
```

[AFLOWInstall]: http://materials.duke.edu/AFLOW/AFLOW_WORKSHOP/1_aflow_school_2019_introduction.pptx
[gh]:https://www.github.com  
[ljnabuild]: https://github.com/lancejnelson/aBuild
