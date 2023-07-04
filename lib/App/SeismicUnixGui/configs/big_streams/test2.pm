package test2;

use Moose;

my $dispatch = {
	
	'here' => \&here,
	
};

sub get {
	my ($self, $program)=@_;
	
	my $result = $dispatch->{$program}->();
	
	return($result);
}


sub here {
	
	print("print here \n");
	return("my return from here");
}

1;