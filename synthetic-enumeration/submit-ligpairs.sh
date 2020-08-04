#!/bin/bash
#BSUB -P "testing"
##BSUB -J "mpro[1688-4663]" 
##BSUB -J "mpro[1686-1687]" 
##BSUB -J "mpro[4664-7641]" 
##BSUB -J "mpro[7642-7801]" 
##BSUB -J "mpro[7802-8085]" 
#BSUB -J "mpro[8085-8373]" 
#BSUB -n 1
#BSUB -R rusage[mem=3]
#BSUB -R span[hosts=1]
#BSUB -q gpuqueue
#BSUB -sp 1 # low priority. default is 12, max is 25
#BSUB -gpu num=1:j_exclusive=yes:mode=shared
#BSUB -W  02:00
#BSUB -m "ls-gpu lg-gpu lt-gpu lp-gpu lg-gpu lu-gpu ld-gpu"
#BSUB -o output/out_%I.stdout 
#BSUB -eo output/out_%I.stderr
##BSUB -cwd "/scratch/%U/%J"
#BSUB -L /bin/bash

# quit on first error
set -e

source ~/.bashrc
OPENMM_CPU_THREADS=1

cd $LS_SUBCWD
conda activate perses-0.7.1

# Launch my program.
module load cuda/10.1
env | sort | grep 'CUDA'
python run.py $LSB_JOBINDEX 
