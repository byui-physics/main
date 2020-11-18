---
title: Calculating Formation Energies
keywords: sample homepage
sidebar: sidebarNelson
permalink: formationEnergies.html
---

<script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.0/MathJax.js?config=TeX-AMS_CHTML"></script>

The formation energy of a crystal structure is an important quantity
for determining whether it's formation is favored over unmixed atoms.
The equation that we will use for calculating formation energies is:

\\[ E_\text{formation} = {E_\text{alloy} \over N_\text{alloy}} - ({E_\text{pure~A} \over N_\text{pure~A}} \times \text{percent A in alloy} + {E_\text{pure~B} \over N_\text{pure~B}}\times \text{percent B in alloy})\\]

where \\(E_\text{alloy} \\) is the total energy of the crystal
structure in questions, \\(E_\text{pure~A} \\) and \\(E_\text{pure~B}
\\) are the total energies of the constituent atoms in their
naturally-forming crystal structures.  The \\( N\\) variables in the
denominators are there so that all of the energies have units of
energy/atom.

To put it more simply, the equation above is finding the difference
between mixing atoms and leaving them unmixed.  A negative formation
energy indicates that mixing is favored over not mixing.  

The calculations for this tutorial will be performed with some
implementation of DFT, which stands for density functional theory.(The
physicists who developed it won the Nobel prize.) It is the main workhorse in
materials modeling.  Density functional theory is used to solve
Schrodinger's equation for the electrons in solids.  These electrons
experience the periodic potential created by a repeating arrangement
of atoms.  Unfortunately, you will mostly use this software as a black
box; you'll use it and extract the results without understanding all
of the details about what's going on.  Here you will find some useful
tips for fixing problems that may arise when performing calculations.


## Copper-Platinum

It is an experimental fact that copper and platinum form the L1\\(_1\\) crystal structure when mixed in
equal parts.  (See [here][l11] for a
picture of the crystal structure.) In other words, we know that the
formation energy of L1\\(_1\\) is negative for Cu-Pt.  


Let's use DFT to calculate the formation energy of Cu-Pt in the L1\\(_1\\)
crystal structure.  Referring to the equation for formation energy,
we'll have to perform three calculations before we can calculate the
formation energy:  pure Copper, pure Platinum, and L1\\(_1\\).  We'll
attack each of them separately.

### Copper Calculation
Every calculation that you perform will require 4 input files. They
must be named: ```POSCAR```, ```INCAR```, ```KPOINTS```,```POTCAR```

We'll go over each one separately:

#### ```POSCAR```

The ```POSCAR``` file contains the crystallographic information about
the material.  It tells the code where the atoms are located.
Copper forms on an fcc lattice, which has lattice vectors:

\\[ \vec{a}_1 = a ( {1\over 2}, {1\over 2},0)\\]
\\[ \vec{a}_2 = a ( 0, {1\over 2}, {1\over 2})\\]
\\[ \vec{a}_3 = a ( {1\over 2}, 0, {1\over 2})\\]

with \\( a = 3.63 \\) Angstroms (a is called the lattice parameter) and basis vector:

\\[ 0 \vec{a}_1 + 0 \vec{a}_2 + 0 \vec{a}_3 = (0,0,0)\\]

You can find crystallographic information about pure substances
[here][periodicTable]

Create a file named ```POSCAR``` and put the following into it:
```bash
Pure Cu	
3.63
0.5 0.5	0
0 0.5 0.5
0.5 0 0.5
1
D
0 0 0 Cu
```


#### INCAR
The ```INCAR``` file contains user-specified settings that allow you
to control what calculation is performed and how it is performed.  A
simple ```INCAR``` looks like this:

```bash
PREC=high
ISIF=3
IBRION=2
NSW=17
SIGMA=0.1
EDIFFG=-.05
```

#### POTCAR
The ```POTCAR``` file specifies the potential produced by the ions in
the crystal and they are different for every atom type.  For this
calculation of pure copper, we just need the ```POTCAR``` file for
copper.  Copy it to your current folder like this

```bash
cp /fslhome/glh43/src/vasp/potpaw_PBE/Cu_pv/POTCAR .
```

#### KPOINTS
The ```KPOINTS``` file is used when performing numerical
integrations.  These files can be generated with a separate program
named ```kpoints.x```.  To use this file, first you need a simple file named
```KPGEN``` that looks like this:

```bash
RMIN=60
EPS=1e-10
```

Once that file is present, you can run ```kpoints.x``` to generate the
```KPOINTS``` file. (If you get an error when you try to run
```kpoints.x```, you should complete
"Setting up your filesystem" section [here](gettingStarted.html) first.)


With these 4 files built: ```POSCAR```, ```INCAR```, ```KPOINTS```,```POTCAR```

you are ready to run the DFT code.  Type ```vasp6_serial``` and watch
it run.  It shouldn't take more than a couple of minutes to finish.
The final energy of the configuration can be extracted like this:

```bash
grep "free  energy" OUTCAR
```
(the last line is the final energy.  You should get a number close to
\\(-3.75604222\\) eV )

### Platinum Calculation
Platinum also forms on an fcc lattice and therefore your platinum
calculation will be nearly identical to your copper calculation.  The
only differences are that \\( a= 3.92\\) Angstroms for platinum and the
```POTCAR``` file is different.

#### ```POSCAR``` file
Your ```POSCAR``` file should look like this:

```bash
Pure Pt
3.92
0.5 0.5	0
0 0.5 0.5
0.5 0 0.5
1
D
0 0 0 Cu
```


#### ```POTCAR``` file

Copy the ```POTCAR``` file for platinum:

```bash
cp /fslhome/glh43/src/vasp/potpaw_PBE/Pt/POTCAR .
```

 Create a new folder for platinum and create all of the necessary
input files.  Then run the calculation just as before. Your final
energy should be close to \\(-6.10085303\\) eV
  
### L1\\(_1\\) Calculation
As before, we need to create four input files: ```POSCAR```, ```INCAR```, ```KPOINTS```,
```POTCAR```.  The ```INCAR``` file is identical to the other ones you
have created, but the other three are different.


#### ```POSCAR``` file

The lattice and
basis vectors for this crystal structure can be found
[here][l11]. You'll need to figure out the lattice parameter (a) by
calculating a weighted average of the lattice parameters for copper and
platinum:

\\[a_\text{alloy} = a_\text{A} \times \text{\% of A} + a_\text{B} \times \text{\% of B} \\]
\\[ = 3.62 \times 0.5 + 3.93 \times 0.5\\]
\\[ = 3.78\\]

Use this along with the information on the website to build your
```POSCAR``` file.  It should look like this:

```bash
L1_1
3.78
1 0.5 0.5
0.5 1 0.5
0.5 0.5 1
1 1
D
0 0 0 Cu
0.5 0.5 0.5 Pt
```


#### ```KPOINTS``` file

The ```KPOINTS``` file can be generated as before: using ```kpoints.x```

#### ```POTCAR``` file

Finally, the ```POTCAR``` file needs to be copied over like this:

``` bash
cat /fslhome/glh43/src/vasp/potpaw_PBE/Cu_pv/POTCAR
/fslhome/glh43/src/vasp/potpaw_PBE/Pt/POTCAR > POTCAR
```

Now you are ready to run this calculation.  Use ```vasp6_serial``` and
watch it run.  It will take a little bit longer, but when it is complete you should find that the total
energy is \\( -10.17153915\\) eV
### Formation Energy

With all three calculations done, we can now calculate the formation energy

\\[ E_\text{formation} = {E_\text{alloy} \over N_\text{alloy}} - ({E_\text{pure~A} \over N_\text{pure~A}} \times \text{percent A in alloy} + {E_\text{pure~B} \over N_\text{pure~B}}\times \text{percent B in alloy})\\]
\\[ = {-10.17153915 \over 2} - ({-6.10085303 \over 1}\times 0.5 - {3.75604222 \over 1} \times 0.5)\\]
\\[ = -0.157322 \text{ eVs}\\]


### Conclusion
Since the formation energy for L1\\(_1\\) is negative, we can conclude
that it's formation is favored over separation of the material into
unmixed copper and platinum atoms.  However, one critical question
remains:  How can we be certain that there isn't a different crystal
structure with a formation energy that is even smaller than for
L1\\(_1\\)?  If we were to find one, it's formation would be favored
over L1\\(_1\\).   Since there are an infinite number of candidate
crystal structures, we can never be 100 % sure that the ground states
have been found.  The best we can do is to search over a very large
set of crystals that are suspected to be groundstates.

### You try

Lookup the crystallographic for L1\\(_0\\) and calculate it's
formation energy in exactly the same way that we did it for L1\\(_1\\)

[l11]:https://homepage.univie.ac.at/michael.leitner/lattice/struk/l1_1.html
[periodicTable]:https://periodictable.com/Properties/A/CrystalStructure.html
