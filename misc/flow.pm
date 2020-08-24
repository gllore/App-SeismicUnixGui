package flow;

use Moose;

my $flow = {
	_inbound      => '',
	_outbound     => '',
	_ref_list     => '',
	_instructions => '',
	_ref_PID      => '',
};

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
