#!/bin/bash
#v#!/usr/bin/env Rscript

#PBS -N GFDL_G_85
#PBS -l nodes=1:ppn=1,walltime=40:00:00
#PBS -l mem=20gb
#PBS -q hydro
#PBS -e GFDL_G_85_error.txt
#PBS -o GFDL_G_85_output.txt
#PBS -M h.noorazar@yahoo.com
#PBS -m abe
cd $PBS_O_WORKDIR

# Ensure a clean running environment:
module purge

# Load modules (if needed)
module load R/R-3.2.2_gcc

/home/hnoorazar/cleaner_codes/drivers/local_future/LF_CM_85_scenario_driver.R GFDL-ESM2G

exit 0
