# Pipeline for Phage Genomic Analysis
# Author: George Rickus

# Each rule was consecutively in the order they are introduced in this python script.
# This pipeline takes in raw Illumina reads, pre-processes them using Trimmomatic, assesses their quality using FastQC, and assembles them into a genome by using shovill

# The format that will be used in trimmomatic and then will be slightly modified in other programs to get the correct files.
trimmomatic_output_format = "./my/path/currPhageName"

# This rule trims and filters our raw reads by removing the necessary adapters and attempting to ensuring adequate read quality
rule trimmomatic:
    conda: "./my/path/anaconda3/envs/trimmomatic"
    params: 
        forward_reads = "./my/path/currPhageName_R1_001.fastq.gz", 
        reverse_reads = "./my/path/currPhageName_R2_001.fastq.gz",
        adapter_fasta = "./my/path/adapter_seq.fasta"
    output: trimmomatic_output_format
    shell: 
        """
        source activate trimmomatic
        trimmomatic PE {params.forward_reads} {params.reverse_reads} -baseout {trimmomatic_output_format}.fastq.gz ILLUMINACLIP:{input.adapter_fasta}:2:30:10:2:True LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:36
        """
# output stored in: ./my/path

# Assess the quality of the reads created after being filtered by trimmomatic
rule fastqc:
    conda: "./my/path/anaconda3/envs/fastqc"
    params: 
        paired_forward1 = trimmomatic_output_format + "_1P.fastq.gz",
        paired_reverse1 = trimmomatic_output_format + "_2P.fastq.gz",
        output_dir1 = "./my/path/FastQC_result"
    shell: 
        """
        source activate fastqc
        fastqc {params.paired_forward1} {params.paired_reverse1} -o {params.output_dir1}
        """

# output stored in: "./my/path/FastQC_result"


# Assembles our trimmed reads using SPAdes and other bioinformatic tools
rule shovill:
    conda: "./my/path/anaconda3/envs/shovill"
    params: 
        paired_forward2 = trimmomatic_output_format + "_1P.fastq.gz",
        paired_reverse2 = trimmomatic_output_format + "_2P.fastq.gz",
        ram = 8,
        output_dir2 = "./my/path/Shovill_result"
    shell: 
        """
        source activate shovill
        shovill --force --R1 {params.paired_forward2} --R2 {params.paired_reverse2} --outdir {params.output_dir2}
        """

# output stored in: "./my/path/Shovill_result"