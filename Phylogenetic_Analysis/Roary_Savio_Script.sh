#!/bin/bash
# Job name:
#SBATCH --job-name=RoaryJob
#
# Account:
#SBATCH --account=__
#
# Partition:
#SBATCH --partition=savio3
#
# Request one node:
#SBATCH --nodes=1
#
# Number of processors for single task needed for use case:
#SBATCH --cpus-per-task=4
#
# Wall clock limit:
#SBATCH --time=12:00:00
#
## Command(s) to run:
PATH=/my/path/anaconda3/bin:$PATH
source activate roary
export PERL5LIB=$CONDA_PREFIX/lib/perl5/site_perl/5.22.0/
roary /my/path/toAnnotations/*.gff