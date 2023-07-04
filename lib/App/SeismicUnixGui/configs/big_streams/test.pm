package test2;

use Moose;

sub set {
	my ($self, $program)=@_;

	\&{$program};
}



sub here {
	print("print here \n");
}

1;