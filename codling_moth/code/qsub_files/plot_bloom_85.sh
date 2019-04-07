#!/bin/bash
#v#!/usr/bin/env Rscript

#PBS -N plot_bloom_85
#PBS -l nodes=1:ppn=1,walltime=99:00:00
#PBS -l mem=40gb
#PBS -q hydro
#PBS -e /home/hnoorazar/cleaner_codes/qsub_files/error/E_plot_bloom_85.txt
#PBS -o /home/hnoorazar/cleaner_codes/qsub_files/error/plot_bloom_85.txt
#PBS -m abe
cd $PBS_O_WORKDIR

# Ensure a clean running environment:
module purge

# Load modules (if needed)
module load R/R-3.2.2_gcc

/home/hnoorazar/cleaner_codes/drivers/plot_bloom_driver.R rcp85

exit 0
