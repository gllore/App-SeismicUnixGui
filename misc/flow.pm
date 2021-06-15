package flow;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PROGRAM NAME: test.pl 
 AUTHOR: 	Juan Lorenzo
 DATE: 		June 15 2021
 (original c. 2018)


DESCRIPTION 
     

 BASED ON:

=cut

=head2 USE

=head3 NOTES

=head4 Examples


=head2 CHANGES and their DATES

=cut 

use Moose;
our $VERSION = '0.0.2';

my $flow = {
	_inbound      => '',
    _instructions => '',
	_outbound     => '',
	_ref_PID      => '',
	_ref_list     => '',
	_this_package =>'',
};


=head2 Defaults

=cut
my $number_of_instructions_start = 2;
my $instruction_start            = 'hi';

sub BUILD {
	my ($this_package_address) = @_;

	$flow->{_this_package} = $this_package_address;

}


=head2 sub default_instruction_aref
Initialize array 

=cut

sub _default_instruction_aref_start {

	my ($self) = @_;

	my @instruction = (
		$instruction_start,
		$instruction_start,
	);

	my $instruction_aref = \@instruction;
	return ($instruction_aref);

}

=head2 Declare attributes

=cut

has 'instruction_aref' => (
	default => \&_default_instruction_aref_start,
	is      => 'rw',
	isa     => 'ArrayRef',
	writer  => 'set_instruction_aref',
	reader  => 'get_instruction_aref',

	#	trigger=> \&_update_instruction_aref,
);

has 'number_of_instructions' => (
	default => $number_of_instructions_start,
	is      => 'rw',
	isa     => 'Int',
	writer  => 'set_number_of_instructions',
	reader  => 'get_number_of_instructions',

	#	trigger=> \&_update_number_of_instructions,
);

=head2 sub _update_instruction_aref

update instruction_aref

=cut

sub _update_instruction_aref {

	my ( $instruction, $new_current_instruction_aref, $new_prior_instruction_aref ) = @_;

	my @ans = @{$new_current_instruction_aref};

	#    my @ans = @{$new_prior_instruction_aref};

	#	print("1. instruction,_update_instruction_aref,instruction_aref= @ans  \n");

	@ans = @{ $instruction->get_instruction_aref() };
	print("2. flow,_update_instruction_aref,instruction_aref= @ans  \n");

	return ();
}

=head2 sub _update_number_of_instructions

update file_name

=cut

sub _update_number_of_instructions {

	my ( $flow, $new_current_number_of_instructions, $new_prior_number_of_instructions ) = @_;

	my $ans = $flow->get_number_of_instructions();

	print("flow,_update_number_of_instructions, number_of_instructions= $ans  \n");

	return ();

}
sub inbound {
	my ( $flow, $inbound ) = @_;
	$flow->{_inbound} = $inbound if defined($inbound);
}

sub outbound {
	my ( $flow, $outbound ) = @_;
	$flow->{_outbound} = $outbound if defined($outbound);
}

=head2 sub modules

   rearrange list of items
   before sending to the
   operating system to run

   Debug using:
    print "list length is $list_length\n\n";
    print("flow so far is $flow->{_ref_list}\n\n");

=cut

sub modules {
	my ( $flow, $ref_list ) = @_;
	my $i;
	
	if ( defined $ref_list
		and ( scalar @$ref_list ) > 0 ) {  # N.B. at least '&' exists

		# print("flow so far is @$ref_list\n\n");
		my $list_length = $#$ref_list;
		my $word        = $$ref_list[0];

		for ( $i = 1; $i <= $list_length; $i++ ) {
			$word = $word . $$ref_list[$i];
		}

		$flow->{_ref_list} = $word;
		return $flow->{_ref_list};
		
		} else {
			print("flow,modules, empty ref_list\n\n");
		}
		return();
	}

=head2 sub flow 

   sending a list of instructions to 
   operating system to run

   Debug using:
    print("ref_instr is $$ref_instructions\n\n");
    print "it's an array reference!";
    print("flows=$flow->{_instructions}\n\n");
			print("flow,flow,$$ref_instructions\n");

			 print("flow,flow,/usr/local/bin/pl $$ref_instructions\n");

=cut

	sub flow {

		my ( $self, $ref_instructions ) = @_;

		if ($ref_instructions) {

			$flow->{_instructions} = $$ref_instructions;

			# print("flow,flow, $flow->{_instructions}\n");
			system("$flow->{_instructions}");
			return ();

		} else {
			print("flow,flow,missing instructions \n");
		}
	}

	1;
