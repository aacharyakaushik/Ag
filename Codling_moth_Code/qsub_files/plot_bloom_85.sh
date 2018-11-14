#!/bin/bash
#v#!/usr/bin/env Rscript

#PBS -N plot_bloom_85
#PBS -l nodes=1:ppn=1,walltime=99:00:00
#PBS -l mem=20gb
#PBS -q hydro
#PBS -e plot_bloom_85_e.txt
#PBS -o plot_bloom_85_o.txt
#PBS -m abe
cd $PBS_O_WORKDIR

# Ensure a clean running environment:
module purge

# Load modules (if needed)
module load R/R-3.2.2_gcc

/home/hnoorazar/cleaner_codes/drivers/plot_bloom_driver.R rcp85

exit 0