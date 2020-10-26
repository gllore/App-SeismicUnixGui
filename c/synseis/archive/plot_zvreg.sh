#!/bin/sh
# usage plot_zvreg.sh
path=.
set -x
file=./zv.reg

a2b n1=2 outpar=./temp_zvreg < $file \
>$file.bin # ascii to binary
num_samples_depth=`sed 's/n2=//' ./temp_zvreg` # numb of samples in trace
xgraph x1beg=0 x2beg=0 x2end=2000 n=$num_samples_depth style=seismic title=m/s \
height=700 nTic2=2 grid2=solid \
<$file.bin &

