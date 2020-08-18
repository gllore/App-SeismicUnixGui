use Moose;
use Test::Simple tests => 235;

my $SPEC_TEST_DIR = '../specs';
my $BIG_STREAMS   = 'big_streams';
my $INBOUND          = $SPEC_TEST_DIR . '/' . $BIG_STREAMS;

opendir( DIR, $INBOUND ) or die $!;
my @directory_list = readdir(DIR);
close(DIR);

my @files;

foreach my $thing (@directory_list) {

	if ( $thing eq '.' or $thing eq '..' ) {
		next;
	} else {
		push @files, $thing;
	}

}

foreach my $prog_spec (@files) {

	$prog_spec =~ s/.pm//g;
	print $prog_spec. "\n";
	eval "use $prog_spec;";
	my $prog           = $prog_spec->new();
	my $variables_href = $prog->variables();
	foreach my $key ( sort keys %$variables_href ) {
		print(" 01_compute.t, key is $key, value is $variables_href->{$key}\n");
		ok( defined $variables_href->{$key} );
	}

}
