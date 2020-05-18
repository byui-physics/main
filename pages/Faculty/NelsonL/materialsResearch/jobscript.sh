#!/bin/bash

#SBATCH --time=1:00:00   # walltime
#SBATCH --ntasks=1   # number of processor cores (i.e. tasks)
#SBATCH --nodes=1   # number of nodes
#SBATCH --mem=12G   # memory per CPU core
#SBATCH -J "Building to_relax.cfg"   # job name
#SBATCH --array=1-200

# Set the max number of threads to use for programs using OpenMP. Should be <= ppn. Does nothing if the program doesn't use OpenMP.
export OMP_NUM_THREADS=$SLURM_CPUS_ON_NODE

cd /fslhome/path/to/your/alloy/folder

# How many crystal structures do you want each process to do.
# Here is wanted 200,000 total crystals spread over 200 processors.
# Feel free to change to suit your needs.
NPCPU=$((200000 / 200))


START=$(( $NPCPU * ($SLURM_ARRAY_TASK_ID - 1) + 1  ))
END=$(($SLURM_ARRAY_TASK_ID*$NPCPU+ 1))


# Get the path to the executable; should be on user's path after the modules have been loaded.
python builder.py CoNbV -setup_relax -start $START -end $END

