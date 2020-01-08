---
title:  Materials Simulation
sidebar: mydoc_sidebar
permalink: materials.html
toc: true
---


## Overview

In the computational materials reseach group, we perform calculations
and simulations of real materials and search for new, high-performing
candidates.  Below you will find some helpful links and instructions
for getting started.  

## Getting setup on Mary Lou

###  Navigating from the command line
In order to effectively use the supercomputer (or any computer I might
argue) you have to get good working at the command line.  There are
many tutorials out there that will help you get started.  Below I
provide some links to some:

[Mary Lou's Unix Tutorial][mlunixtutorial]

### Setting up your filesystem on Mary Lou
There are a few things you need to do once you get a supercomputing
account before you are ready to get to work  
1- Create a `bin` folder
``` bash
mkdir ~/bin
```
2- Create and modify a `.bash_profile`
``` bash
emacs ~/.bash_profile
```
Add the following lines to this file:
```
module purge
module load intel-compilers/2019 intel-mpi/2019 intel-mkl/2019
module load makedepf90
module load libfabric
module load python/3.7

export HISTSIZE=100000
export ENUMX=~/bin/enum.x
export PATH=$PATH:~/bin
export MAKESTRX=~/bin/makestr.x

function workon {
source ~/environments/$1/bin/activate

}

alias workon='workon'
```

Save the file:
``` bash
ctrl-x ctrl-c y
```
and source the file:
``` bash
source ~/.bash_profile
```

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

## Reading

## Projects

[High-entropy alloys][hea]



[hea]: https://byuiphysics.github.io/main/hea.html  
[mlunixtutorial]: https://rc.byu.edu/documentation/unix-tutorial/  
