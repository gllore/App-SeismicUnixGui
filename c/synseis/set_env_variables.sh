#!/bin/bash

# see if global variable is set
# global variable L_SU locates main folder

 if [ -z "${LSeismicUnix}" ]; then

 	echo "global variable LSeismicUnix must first be set"
 	echo "e.g. in .bashrc: "
 	echo " export LSeismicUnix_script=/Location/of/script/folder"

 else
	echo "LSeismicUnix =" ${LSeismicUnix}
fi