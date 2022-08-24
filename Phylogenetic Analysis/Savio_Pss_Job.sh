#!/bin/bash
# Job name:
#SBATCH --job-name=PssJob
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
#SBATCH --time=24:00:00
#
## Command(s) to run:
PATH=/my/path/anaconda3/bin:$PATH
source activate snakemake
snakemake -s Savio_Prokka_Pss.smk -R main