---
title:  Submitting a batch job
sidebar: sidebarMaterials
permalink: submittingJobs.html
toc: true
---


If your code will take longer than an hour to run, you'll want to submit
a batch job and let the scheduler run it.  To do this you first need
to generate a file that

1. Requests resources
2. Provides the commands to be executed

Click [here][sampleJobScript] to see a sample job script. Notice the
lines that start with the characters `#SBATCH`.  These lines are where
you request the computing resources that you need.  The last two lines
in the file are the commands that you want to be executed when the job
runs.  The [marylou website][jobscriptgenerator] has a great tool that will help you
generate job scripts if you're having trouble.


[sampleJobScript]: https://byui-physics.github.io/main/pages/Faculty/NelsonL/materialsResearch/sampleJobScript.sh
[jobscriptgenerator]: https://rc.byu.edu/documentation/slurm/script-generator
