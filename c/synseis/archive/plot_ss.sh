#! /bin/sh
# usage: plot_ss.sh Site number sampling_interval (microsecs)
# filename contains time, amplitude values
path=.

file=./ss
if test $1 = 906
then
tstart=1.21
tend=2.05
fi
set -x
sampling_interval=$1 # microseconds
delay1=`sed 's/	.*//
	     1q' $file` # work out delay from first value in file
#using binary calcualtor did not work on linux
	     delay=`bc -l <<-END
	    $delay1*1000 
END`


#
# awk '{print $2}' $file |
# $bindir/a2b n1=2 outpar=$path/temp >$file.bin # convert ascii to binary

a2b n1=2 outpar=$path/temp < $file >$file.bin # convert ascii to binary

num_samples=`sed 's/n2=//' ./temp` # number of samples in trace
#
#$bindir/suaddhead ns=$num_samples <$file.bin |
#$bindir/sushw key=dt a=$sampling_interval | #put correct sampling interval
#$bindir/sushw key=delrt a=$delay >$file.segy # o/p segy file
#$bindir/suximage wbox=200 xbox=400 <$file.segy &
#$bindir/suxgraph n=$num_samples style=seismic title=wiggle \
#x1beg=$tstart \
#x1end=$tend \
#height=700 width=230 <$file.segy &
# or just suxgraph 
#$bindir/suxgraph <$file.segy

xgraph n=$num_samples style=seismic title=wiggle \
x1beg=$tstart \
x1end=$tend \
nTic2=2 grid2=solid \
height=700 width=230 <$file.bin &




