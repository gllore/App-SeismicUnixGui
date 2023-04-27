#!/bin/bash
set -x

local_dir=`pwd`
. $local_dir/.temp
echo "source $local_dir/.temp"
# see if global variable is set
# global variable SeismicUnixGuilocates main folder
a=`env | grep Gui`
echo "env Gui is $a"
 if [ -z "${SeismicUnixGui}" ]; then

 	echo "global variable SeismicUnixGui must first be set"
 	echo "e.g. in .bashrc: "
 	echo " export SeismicUnixGui=/Location/of/folder "

 else
	echo "SeismicUnixGui =" ${SeismicUnixGui}
 fi
