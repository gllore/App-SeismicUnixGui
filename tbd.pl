use Moose;
my $file = 'App-SeismicUnixGui.0.80_0';
use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';
my $L_SU_global_constants = L_SU_global_constants->new();
my $var                      = $L_SU_global_constants->var();
my $empty_string = $var->{_empty_string};


if ($file eq $empty_string) {
	print ("matches empty string\n");
	print ("---$empty_string---\n");
		
} else{
	print ' no match';
}

