#!/bin/bash

PATH=/my/path/anaconda3/bin:$PATH
source activate prokka
prokka $1 --outdir $2 --genus 'Pseudomonas' --species 'syringae' --force