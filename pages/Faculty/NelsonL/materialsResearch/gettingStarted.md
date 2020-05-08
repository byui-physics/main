---
title: Getting Started
sidebar: sidebarNelson
permalink: gettingStarted.html
toc: true
---


Before beginning  your research project, you should do the following:

## Unix/Linux skills

You'll be using supercomputing resources which means you need to get
good at using the unix command line.  Here are a few tutorials to help
you get familiar with that:

1. [Tutorial by MaryLou](https://rc.byu.edu/documentation/unix-tutorial/)
2. [Tutorial by Ubuntu](https://ubuntu.com/tutorials/command-line-for-beginners#1-overview)
3. [Tutorial by Linux](http://linuxcommand.org/)



## Get a supercomputing account

Request a supercomputing account at
[BYU's office of research computing][ml].  If you don't have BYU
credentials, you'll be asked to register for them.  During the
application process, you'll be asked some questions about your
research and how you will use their resources.  When asked about your
research project:

> We construct atomic-scale models of alloy systems that are suspected
> to outperform current materials used in our society.  These models
> are then used to simulate the material at finite temperature to
> determine their stability and viability as an improvement over
> current materials


When you are asked to describe the computing resources you will use:

> We use mostly single-processor jobs with 10-20 GB of memory.
> Occasionally we'll use a multi-processor job but that will not be
> the norm.  We like to use job arrays to submit many single-processor
> jobs at once.


## Logging In
Once your account is approved, you can login via the command line:

``` bash
ssh <username>@ssh.fsl.byu.edu
```
(insert your username in place of `<username>`)


You'll then be asked to enter your password and the two-factor
authentication code. (You'll need the Google Authenticator App)

## Setting up your filesystem
The first time you login there are some things you should setup and
that you'll only have to do once.

### Setup your `bin` folder

Traditionally, people create a folder named `bin` and put all of their
   executable files in there.  Then they set the environment variable
   named `PATH` to look in that folder.  This allows you to execute
   anything that is in the `bin` folder from anywhere in your
   filesystem.

1. Make the `bin folder`
``` bash  
mkdir ~/bin
```  
2. Now that you have a `bin` folder, copy some commonly used
executables there.  
``` bash  
cp ~/fsl_groups/fslg_byui_materials/vasp6_serial ~/bin/.
cp ~/fsl_groups/fslg_byui_materials/vasp6 ~/bin/.
cp ~/fsl_groups/fslg_byui_materials/mlp ~/bin/.
cp ~/fsl_groups/fslg_byui_materials/makestr.x ~/bin/.
```  

### Setup important system variables

Now that you have a `bin` folder you need to tell the system to look
there when searching for available executables.  This is done with a
system variable named `PATH`.  We'll assign a value to this variable
in a file name `.bash_profile`, which gets executed every time you
login.

1. Make a file named `.bash_profile`.  
``` bash  
emacs ~/.bash_profile
```
2. Add the following lines to this file  
``` bash
module purge
module load intel-compilers/2019 intel-mpi/2019 intel-mkl/2019
module load makedepf90
module load libfabric
module load python/3.7
export HISTSIZE=100000
export ENUMX=~/bin/enum.x
export PATH=$PATH:~/bin
export MAKESTRX=~/bin/makestr.x
alias workon='workon'
function workon
{
source ~/environments/$1/bin/activate
}
alias workon='workon'
```
(Notice the `PATH` variable in there)
3. Save the file:  
``` bash  
ctrl-x ctrl-c y
```  
4. source the file:  (This is done automatically at login)
``` bash  
source ~/.bash_profile
```  
[ml]:marylou.byu.edu
