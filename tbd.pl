use Moose;
my $file = 'App-SeismicUnixGui.0.80_0';
if ($file =~ m/\d\.\d+_\d/) {
	print 'matches';
} else{
	print ' no match';
}