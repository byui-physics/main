---
title:  Building a Moment Tensor Potential
sidebar: mydoc_sidebar
permalink: mtp.html
toc: true
---

### Building a MTP (Moment Tensor Potential)
Constructing a Moment Tensor potential is an iterative process
wherein the model is repeatedly refined and improved until it predicts
well across the entire search space.  To make this iterative process
easier, a python package called `aBuild`(link [here][ljnabuild]) has been built.  `aBuild`
automates file building and information extraction that is constantly
being done during the model-building process.  Below you will find the
steps needed to build an MTP, using aBuild as the automation tool.
Anytime you run aBuild (through the `builder.py` script) you will need
a yaml file to specify run settings.  [Here][YAML] is an example yaml file.
Make sure you modify it for your system. Note: In the instructions
below, the name of my yaml file was AgAu.yml.  You  should modify the
command for your system.

1. Enumerate derivative superstructures: (This is only done once per
system)  
```bash
python builder.py AgAu -enum
```
After this completes, you should have a folder called `Enum` with the
enumeration files in there. (`struct_enum.out.<lattice>`)  You should
only have to do this step once per system.  

2. Now it's time to build a file that contains all possible
groundstate crystal structures.  In other words, this file will
define our search space:  
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
`jobscript_select.sh`. Submit it:
``` bash
cd fitting/mtp
sbatch jobscript_select.sh
```
and wait for it to complete.  This
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
`jobscript_vasp.sh`. Submit the job:
``` bash
cd training_set
sbatch jobscript_vasp.sh
```
and let the calculations run.
Each job will need anywhere from a couple of hours to days to run.  

6. Once the calculations are finished, we need to extract the results
and compile the data into the training set file so we can train
the model:
```bash
python builder.py AgAu -setup_train
```
This will generate the following files in `fitting/mtp`:
```bash
train.cfg
relax.ini
state.mvs
jobscript_train.sh
```
Submit the job submission script:
``` bash
cd fitting/mtp
sbatch jobscript_train.sh
```
and wait for it to finish.  Once finished you will notice the file:
```bash
Trained.mtp_
```
located in `fitting/mtp`.  This file contains values for the model
parameters.  

7. Return to step #2 and iterate.



[ljnabuild]: https://github.com/lancejnelson/aBuild  
[YAML]:  http://lancejnelson.github.io/materialsResearch/pages/sample.yml
