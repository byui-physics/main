---
title:  Installing AFLOW
sidebar: sidebarNelson
permalink: aflow.html
toc: true
---

## Installing AFLOW

The instructions for installing aflow can be found
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

[AFLOWInstall]: http://materials.duke.edu/AFLOW/AFLOW_WORKSHOP/1_aflow_school_2019_introduction.pptx
