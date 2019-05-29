#!/bin/bash

#PBS -l nodes=1:ppn=1,walltime=00:05:00
#PBS -l mem=1gb
#PBS -q fast

#bcc BNU Can CNRM GFDLG GFDLM
for runname in GFDLM
do
cd /home/hnoorazar/analog_codes/00_post_biofix/02_find_analogs/rcp85_qsubs/$runname
cat /home/hnoorazar/analog_codes/parameters/post_biofix/q_rcp85_no_precip | while read LINE ; do
qsub $LINE
done
done
