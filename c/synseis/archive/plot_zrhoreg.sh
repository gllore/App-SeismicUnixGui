#! /bin/sh
set -x
# usage: plot_zrhoreg.sh Site number
path=.

zrhoreg=./zrho.reg
a2b n1=2 outpar=$path/temp_zrhoreg < $zrhoreg \
>$zrhoreg.bin # ascii to binary
num_samples_depth=`sed 's/n2=//' ./temp_zrhoreg` # number of samples in trace
#
xgraph x2beg=1 x2end=2.5 linecolor=2 n=$num_samples_depth style=seismic title=g/cc \
height=700 grid2=dash\
<$zrhoreg.bin &
#
