#!/bin/bash

source ./.temp
echo 'source .temp'

# see if global variable is set
# global variable L_SU locates main folder

 if [ -z "${LSeismicUnix}" ]; then

 	echo "global variable L_SU must first be set"
 	echo "e.g. in .bashrc: "
 	echo " export LSeismicUnix_script=/Location/of/script/folder "

 else
	echo "L_SU =" ${LSeismicUnix}
 fi
