#!/bin/sh
# will make all perl programs
# fit the Perl Best Practices of 2005

cd ../../messages
perltidy -nst *.pm
perltidy -nst *.pl
mkdir bck
mv *.pm bck
mv *.pl bck
rename .pm.tdy .pm *.pm.tdy
rename .pl.tdy .pl *.pl.tdy
