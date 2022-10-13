#!/bin/sh
# will make all perl programs
# fit the Perl Best Practices of 2005

cd ../../configs
perltidy -nst *_config.pm
perltidy -nst *_config.pl
mkdir bck
mv *_config.pm bck
mv *_config.pl bck
rename .pm.tdy .pm *.pm.tdy
rename .pl.tdy .pl *.pl.tdy
