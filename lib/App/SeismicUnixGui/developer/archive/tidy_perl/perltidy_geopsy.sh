#!/bin/sh
# will make all perl programs
# fit the Perl Best Practices of 2005

cd ../../geopsy
perltidy -nst *.pm
mkdir bck
mv *.pm bck
rename .pm.tdy .pm *.pm.tdy
