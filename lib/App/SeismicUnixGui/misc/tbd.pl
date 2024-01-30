#!/usr/bin/perl
use warnings;
use strict;

my @a = (1..9);
my $i = 20;

for $i (@a){
	print("$i","\n");
}

print('iterator $i is ',"$i","\n"); # 20