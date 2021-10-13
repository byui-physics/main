---
title:  Building a Moment Tensor Potential
sidebar: sidebarNelson
permalink: mtp.html
toc: true
topnav: topnav
---

## Building an MTP (Moment Tensor Potential)
Constructing a Moment Tensor potential is an iterative process
wherein the model is repeatedly refined and improved until it predicts
well across the entire search space.  To make this iterative process
easier, a python package called `aBuild`(see [here][aBuildInstall] for
installation instructions) has been built.  `aBuild`
automates file building and information extraction that is constantly
being done during the model-building process.  Below you will find the
steps needed to build an MTP, using aBuild as the automation tool.
Anytime you run aBuild (through the `builder.py` script) you will need
a yaml file to specify run settings.  [Here][YAML] is an example yaml file.
Make sure you modify it for your system. Note: In the instructions
below, the name of my yaml file was AgAu.yml.  You  should modify the
command for your system.

### 1. Enumerate derivative superstructures

In order to build the library of candidate ground states, we need to
enumerate the candidates.  See the derivative superstructures section
[here](researchArticles.html) for more information.  The command to
perform the enumeration is:

```bash
python builder.py AgAu -enum -dataset='gss'
```
 (Note: the "dataset" option to the command specifiies which dataset in the YAML file
 will be used to perform the enumeration)
When this runs it will pull information from the 'gss' section of your
yaml file to determine which parent lattices to enumerate on.  After
this completes, you should have a folder called `Enum` with the
enumeration files in there. (`struct_enum.out.<lattice>`) You should
only have to do this step once per system.  

### 2. Define the search space

Now it's time to build a file that contains all of the crystal
structures that are considered to be candidate ground states.  It's
important that this file be as exhaustive as possible, which means we
should include any crystal structure that we suspect might be low in
energy.(Likely, this means hundreds of thousands or even millions of
crystal structures!)  The code to generate this file is:  
```bash
python builder.py AgAu -setup_relax
```
When this runs, it
will use the information in the 'gss' section of the yaml file to
generate the crystal structures. Due to the large number of crystals
that will be generated, this command may take several hours to
complete.  You can either i) submit a job and let it run overnight or
ii) split up the file generation over many processors and let it
finish in less than half an hour.  ([Here][setupRelaxSubmission] is an
example submission script that will do that for you) When this
finishes, you will have a folder called `fitting/mtp`.  Inside that
folder you will notice the following files:
```bash
to_relax.cfg
relax.ini
pot.mtp
train.cfg
jobscript_relax.sh
```
(If you split up the job over many processors, you'll have to
concatenate all of the files into one, like this:
```bash
cd fitting/mtp
cat to_relax.cfg_* > to_relax.cfg
cd -
```
)

### 3. Relax

Once step 2 finishes, there will be a job script located in `fitting/mtp`
   that you can submit.  This job will use the MTP (we haven't
   generated one yet, but that's OK) to attempt to relax the atoms in all of the
   crystals.  
``` bash
cd fitting/mtp
sbatch jobscript_relax.sh
```

### 4. Select

   As the model relaxes the atoms, it will find that it has to
   extrapolate on some of them. In other words, the model is making
   calculations on a crystal structure that is very different from the
   ones it was trained on. It saves these structures and selects
   a subset of
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
could take several hours to complete and, in later iterations, this job
may need the better part of a day to complete.  

### 5. Augment Training Set

Now we need to build VASP folders for the structures that were requested be added
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

#### Calculations that have errors.
  Sometimes a calculation will not finish correctly for one reason or
  another.  `aBuild` has a mode called `-status` that will check all
  of the calculation folders for errors.   You can run it like this:

```bash
python3 builder.py AgAu -status
```

This will create files entitled `status.<runcode>`, where `<runcode>`
can be one of :  running, done, unconverged, and errors.  If you have
unconverged or erroneous calculations, you must investigate the
problem and restart the calculation before moving on.  See
[this page][vaspdebug] for help finding and fixing vasp errors.

### 6. Build Training Set

Once the calculations are finished, we need to extract the results
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

### 7. Return to step #2

With a trained potential, we can return to step #2 and attempt to
relax again.  Look from step #2 to step #7 until the model successfully
    relaxes all of the crystals in to_relax.cfg.



[aBuildInstall]: /main/neededSoftware.html
[ljnabuild]: https://github.com/lancejnelson/aBuild  
[YAML]:  http://byui-physics.github.io/main/pages/Faculty/NelsonL/materialsResearch/sample.yml
[setupRelaxSubmission]:https://byui-physics.github.io/main/pages/Faculty/NelsonL/materialsResearch/setupRelaxJobscript.sh
[YAML]:  /vaspTroubleshooting.html
