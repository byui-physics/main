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

Enter the virtual environment:
``` bash
workon alloys 
```

You can exit the environment like this:
``` bash
deactivate alloys 
```



### Obtaining/Installing a copy of aBuild
Make a directory called codes and go into it:
``` bash
mkdir ~/codes
cd ~/codes
```

1.Register for an account on [github][gh].  
2.Navigate to B. Nelson's aBuild repository (found [here][ljnabuild])  
3.Fork B. Nelson's reposity.  This will create a copy of this code
that is yours to edit.  
4.(Back to ML)  Type the following to clone your aBuild repository to
ML:  
```bash
git clone https://github.com/lancejnelson/aBuild.git .
```  
(make sure you replace my username with yours.)  
5.Install aBuild (while in your virtual environment)
```bash
pip install -e ~/codes/aBuild
```


### Copy executables
You will need to copy the following files to your bin

``` bash
~/fsl\_groups/fslg\_byuimaterials/vasp6\_serial
~/fsl\_groups/fslg\_byuimaterials/mlp
~/fsl\_groups/fslg\_byuimaterials/enum.x
~/fsl\_groups/fslg_byuimaterials/makestr.x


```
## Reading

## Projects

### High Entropy Alloys (HEA)

[criteria2015][hea]



[criteria2015]: https://journals.aps.org/prx/abstract/10.1103/PhysRevX.5.011041  
[mlunixtutorial]: https://rc.byu.edu/documentation/unix-tutorial/  
[gh]:https://www.github.com
[ljnabuild]: https://github.com/lancejnelson/aBuild
