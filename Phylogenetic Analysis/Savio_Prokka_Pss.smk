# Mass Genomic Anotation of Pseudomonas Syringae pv. Syringae Bacterial Genomes
# Author: George Rickus

import os
import glob
# Current directory paths.
output_dir = "/my/path/result"
input_dir = "/my/path/data"

# This rule annotates all of the fasta(.fna) files within the input_dir path
# The dataset of fasta files was manually created and downloaded by me from the NCBI database on all known PSS organisms
rule main:
    params:
    run:
        for file in glob.glob(input_dir+'/*.fna'):
            input_file = os.path.join(input_dir, file)
            modified_file = file[:len(file)-4]
            curr_OutDir = os.path.join(output_dir, modified_file)
            shell("bash /my/path/Prokka_Delegated_Savio.sh {input_file} {curr_OutDir}")
