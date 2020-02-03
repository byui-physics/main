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
account before you are ready to get to work.

1. Create a `bin` folder  
``` bash  
mkdir ~/bin
```  


2. Create and modify a `.bash_profile`  
``` bash  
emacs ~/.bash_profile
```

3. Add the following lines to this file  
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

4. Save the file:  
``` bash  
ctrl-x ctrl-c y
```  

5. and source the file:  
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
~/fsl_groups/fslg_byuimaterials/vasp6_serial
~/fsl_groups/fslg_byuimaterials/mlp
~/fsl_groups/fslg_byuimaterials/enum.x
~/fsl_groups/fslg_byuimaterials/makestr.x
```

### Building an MTP (Moment Tensor Potential)
Constructing a Moment Tensor potential is an iterative process
wherein the model is repeatedly refined and improved until it predicts
well across the entire search space.  To make this iterative process
easier, a python package called `aBuild` has been built.  aBuild
automates file building and information extraction that is constantly
being done during the model-building process.  Below you will find the
steps needed to build an MTP, using aBuild as the automation tool.
Anytime you run aBuild (through the `builder.py` script) you will need
a yaml file to specify run settings.  [Here] is an example yaml file.
Make sure you modify it for your system.

1. Enumerate derivative superstructures: (This is only done once per
system)  
```bash
python builder.py AgAu -enum
```
After this completes, you should have a folder called `Enum` with the
enumeration files in there. (`struct_enum.out.<lattice>`)  You should
only have to do this step once per system.  

2. Build set of structures that defines the search space:  
```bash
python builder.py AgAu -setup_relax
```
When this finishes, you will have a folder called `fitting/mtp`.  Inside
that folder you will notice the following files:
```bash
to_relax.cfg
relax.ini
pot.mtp
train.cfg
jobscript_relax.sh
```
You are now ready to relax.  
  
3. Once step 2 finishes, there will be a job script located in `fitting/mtp`
   that you can submit.  This job will attempt to relax the atoms in all of the
   crystals.  (For the first iteration, this step will fail because we
   haven't yet built a model.  That's ok)  
``` bash
cd fitting/mtp
sbatch jobscript_relax.sh
```

4. Select new structures to be added to the training set:  As the
   model relaxes the atoms, it will find that it has to extrapolate on
   some of them.  It saves these structures and selects a subset of
   them to be added to the training set:  
```bash
python builder.py AgAu -setup_select_add
```
This will only take a few seconds to run and when it's finished there
will be a new job submission file located in `fitting/mtp` called:
`jobscript_select.sh`. Submit it and wait for it to complete.  This
could take several hours to complete and in later iterations, this job
may need the better part of a day to complete.

5. Setup the requested calculations: Now we need to build VASP folders for the structures that were requested be added
into the training set:
```bash
python builder.py AgAu -add
```
This will generate several hundred folders inside of the folder
`training_set`.  Each folder has the needed files to perform a
quantum-mechanical calculation for a different crystal.  There will
also be a job submission file located in `training_set` called
`jobscript_vasp.sh`. Submit the job and let the calculations run.
Each job will need anywhere from a couple of hours to days to run.  

6. Once the calculations are finished, we need to extract the results
and compile the data into the training set file so we can train
the model:
```bash
python builder.py AgAu -setup_train
```
Once this is finished you will find a job submission script in
`fitting/mtp` called `jobscript_train.sh`.  Submit this job (it will
run in parallel) to train
the model to the data.

7. Return to step #2 and iterate.

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

## Installing AFLOW

The instructions for installing aflow can be found
[here][AFLOWInstall].  Follow the instructions on slides 13 and 14 if
installing on MaryLou.


## Reading
This paper explains the algorithm used to generate derivative structures
[Algorithm for Generating Derivative Structures][derivStr]
## Projects

### High Entropy Alloys (HEA)

[Best Candidates Paper][criteria2015]


### Moment Tensor Potentials Reading Material

[MTP Paper][MTP]
### VASP stuff

[AFLOW Pseudopotential][AFLOWpaper]


[criteria2015]: https://journals.aps.org/prx/abstract/10.1103/PhysRevX.5.011041  
[mlunixtutorial]: https://rc.byu.edu/documentation/unix-tutorial/  
[gh]:https://www.github.com  
[ljnabuild]: https://github.com/lancejnelson/aBuild  
[derivStr]: https://msg.byu.edu/papers/GLWHart_enumeration.pdf  
[AFLOWpaper]: http://materials.duke.edu/auro/AUROARTICULA/j.commatsci.2015.07.019.pdf  
[MTP]: https://www.sciencedirect.com/science/article/pii/S0927025618306372  
[AFLOWInstall]: http://materials.duke.edu/AFLOW/AFLOW_WORKSHOP/1_aflow_school_2019_introduction.pptx
[YAML]:  http://byuiphysics.github.io/main/pages/researchAreas/sample.yml
