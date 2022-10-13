#!/bin/sh
# will make all perl programs
# fit the Perl Best Practices of 2005

cd ../..
perltidy -nst *.pl
mkdir bck
mv *.pl bck
rename .pl.tdy .pl *.pl.tdy

