---
title:  Phase Diagrams for Ternary Alloys
sidebar: sidebarNelson
permalink: ternaryAlloyPhaseDiagrams.html
toc: true
---


## Overview Here

A phase diagram summarizes the thermodynamic stability of a
multi-component alloy.  In other words, it tells us how the atoms
inside of an alloy react to changing temperature and/or pressure.
They are of crucial importance to materials discovery and design
because they provide information about the crystal structure stability.

<!--<div style = "text-align:center">
<img src="/images/fcc.png" align="middle" />
</div> -->

Steel is a very well-known material in the construction industry.  It
is an alloy composed of Iron (Fe) and Carbon (C).  (See the
phase diagram for steel [here][steelphasediagram]). If this is the
first time you've seen a diagram like this it's probably hard to
understand.  Notice that the horizontal axis is labeled "Carbon, \%"
and the vertical axis is labeled "T" in Fahrenheit.  This diagram
gives us information about what crystal structure will form at a given
composition (horizontal axis) and temperature (vertical axis).

One way to determine the phase diagram for a system is to construct
the alloy and then use experimental techniques (X-ray diffraction,
electron microscopes, etc.) to figure out where the atoms are.  This
is the work of a metallurgist.

Another way to determine the phase diagram for an alloy is by
simulating the interaction between the atoms on a computer.  These
kinds of studies are a boon to metallugists.  Without the
computational work, they wouldn't even know where to look.


Much experimental information exists for binary (two atom types) alloy
systems.  The same cannot be said for ternary alloys (three atom
types).  [Here][ternary] is a ternary phase diagram for Fe-Cr-Ni so
you can see what they look like. Here's a fun question: How many ways
are there to combine three different atom types among the ~118
elements on the periodic table? Answer: over 260,000 alloy systems.
This research project involves choosing one of those alloy systems and
using computer calculations and simulations to determine it's phase
diagram.  If you choose this project, along the way you will learn:

1. Crystal Structure 
2. Python
3. Unix Command line
4. Thermodynamics of materials.
5. Git
6. Latex
7. Ternary phase diagrams

and more.

## Getting Started
To get started on this project, complete the following:

1. Read Chapters 1 and 2 "Solid State Physics for Advanced
Undergraduates" by Hardold Stokes and **do all of the problems**:
   - [Chapter 1][stokesChap1]
   - [Chapter 2][stokesChap2]
2. Study about phase diagrams:
   - [Short tutorial with graphics](https://textbooks.elsevier.com/manualsprotectedtextbooks/9780750663809/Static/phase/phase1a.htm)
   - [Longer, with more detail][phaseDiagramTutorial]
4. Learn about Git. [Here](https://product.hubspot.com/blog/git-and-github-tutorial-for-beginners)
   is a tutorial.  There are others out there and you are welcome to
   try any of them.

5. Complete the [getting started](gettingStarted.html) page.
6. Setup your filesystem on the HPC.
  - [Install AFLOW and aBuild](neededSoftware.html)





[steeEle][lphasediagram]: https://www.substech.com/dokuwiki/doku.php?id=iron-carbon_phase_diagram
[ternary]: http://sv.rkriz.net/classes/MSE2094_NoteBook/96ClassProj/experimental/ternary2.html
[phaseDiagramTutorial]: https://www.asminternational.org/documents/10192/1849770/06479G_Sample.pdf
[stokesChap1]:https://content.byui.edu/file/ceb83761-b291-4202-94a6-eb42747cfa18/1/Stokes_Chap_1.pdf
[stokesChap2]:https://content.byui.edu/file/ceb83761-b291-4202-94a6-eb42747cfa18/1/Stokes_Chap_2.pdf
[ml]: http://rc.byu.edu
[elsevierPhaseDiagrams]:https://textbooks.elsevier.com/manualsprotectedtextbooks/9780750663809/Static/phase/phase1a.ht
[ubuntuTutorial]:https://ubuntu.com/tutorials/command-line-for-beginners#7-the-command-line-and-the-superuser
[linuxTutorial]:http://linuxcommand.org/
[mlunixTutorial]: https://rc.byu.edu/documentation/unix-tutorial/
[initialSetup]: MLSetup.html


