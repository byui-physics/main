---
title: MaryLou setup
sidebar: mydoc_sidebar
permalink: MLSetups.html
toc: true
---

There are a few things you need to do once you get a supercomputing
account before you are ready to get to work.


## Create a `bin` folder

1. Create a `bin` folder  
``` bash  
mkdir ~/bin
```  


## Setup a `.bash_profile` file

1. Create and modify a `.bash_profile`  
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

3. Save the file:  
``` bash  
ctrl-x ctrl-c y
```  

4. and source the file:  
``` bash  
source ~/.bash_profile
```  

## Copy executables to your bin folder

``` bash
cp ~/fsl_groups/fslg_byui_materials/vasp6_serial ~/bin/.
cp ~/fsl_groups/fslg_byui_materials/vasp6 ~/bin/.
cp ~/fsl_groups/fslg_byui_materials/mlp ~/bin/.
cp ~/fsl_groups/fslg_byui_materials/makestr.x ~/bin/.

```
