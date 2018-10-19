#!/bin/bash
#v#!/usr/bin/env Rscript
# job name
PBS -N test-script
# set the requested resources
#PBS -l mem=20gb,nodes=1,walltime=6:00:00
PBS -l nodes=1:dev:ppn=1
PBS -l mem=2gb
PBS -l walltime=12:00:00
#PBS -q hydro
# Request email on (a)bort, (b)eginning, and (e)nd.
#PBS -m abe

# email when finished
#PBS -M h.noorazar@yahoo.com

# First we ensure a clean running environment:
module purge

# Load modules (if needed)
module load R/R-3.2.2_gcc

#./CodlingMoth.R  /home/kiran/histmetdata/vic_inputdata0625_pnw_combined_05142008/ /data/kiran/CodlingMoth/hist/
#./testR.R
cd /home/hnoorazar/clean_codes/
Rscript CodlingMothGenerations.R

exit 0
