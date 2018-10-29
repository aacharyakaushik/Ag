#!/bin/bash
#v#!/usr/bin/env Rscript

#PBS -N GG_45_S4
#PBS -l nodes=1:ppn=1,walltime=12:00:00
#PBS -l mem=5gb
#PBS -q hydro
#PBS -e GG_45_S4_error.txt
#PBS -o GG_45_S4_output.txt
#PBS -M h.noorazar@yahoo.com
#PBS -m abe
cd $PBS_O_WORKDIR

# Ensure a clean running environment:
module purge

# Load modules (if needed)
module load R/R-3.2.2_gcc

/home/hnoorazar/cleaner_codes/drivers/local_future/LF_CM_45_S4.R GFDL-ESM2G

exit 0