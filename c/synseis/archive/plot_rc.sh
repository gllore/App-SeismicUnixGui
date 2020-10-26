#! /bin/sh
# usage plot_rc.sh Site number
# The plotting requires SUnix binaries which are in
# /usr/home/kong/juan/Geol4068/synseis_class/progs/bin
path=.
set -x	
reflection_coef_time=./rc_t
reflection_coef_depth=./rc_z

a2b n1=2 outpar=$path/temp1 < $reflection_coef_depth \
>$reflection_coef_depth.bin # ascii to binary
a2b n1=2 outpar=$path/temp2 < $reflection_coef_time \
>$reflection_coef_time.bin # ascii to binary
num_samples_depth=`sed 's/n2=//' $path/temp1` # number of samples in trace
num_samples_time=`sed 's/n2=//' $path/temp2` # number of samples in trace
#
xgraph n=$num_samples_depth x=0 y=0 style=seismic title=A_ratio_z \
nTic2=2 grid2=solid nTic1=2 grid1=solid \
height=700 width=230 \
<$reflection_coef_depth.bin &
# x2beg=-0.05 \
# x2end=0.05 \
#
# x1beg=1.2 \
# x1end=2.1 \
xgraph n=$num_samples_time style=seismic title=A_ratio_t \
x2beg=-.5 \
x2end=.5 \
nTic2=2 grid2=solid nTic1=2 grid1=solid \
height=700 width=230 x=0 y=0 \
<$reflection_coef_time.bin &
#  x2beg=-0.05 x2end=0.05 nTic2=2 grid2=solid \

