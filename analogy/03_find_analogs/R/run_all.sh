#!/bin/bash

cd /home/hnoorazar/analog_codes/03_find_analogs/R_codes/Mahoney/rcp45/

cd /home/hnoorazar/analog_codes/03_find_analogs/R_codes/Mahoney/rcp85/

for runname in bcc-csm1-1-m BNU-ESM CanESM2 CNRM-CM5 GFDL-ESM2G GFDL-ESM2M
do
qsub ./q_rcp85_$runname.sh
done

for runname in bcc-csm1-1-m BNU-ESM CanESM2 CNRM-CM5 GFDL-ESM2G GFDL-ESM2M
do
qsub ./q_rcp45_$runname.sh
done