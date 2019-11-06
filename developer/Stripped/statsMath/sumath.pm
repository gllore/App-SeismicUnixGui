 package sumath;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUMATH - do math operation on su data 		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUMATH - do math operation on su data 		

 suop <stdin >stdout op=mult					

 Required parameters:						
	none							

 Optional parameter:						
	op=mult		operation flag				
			--------- operations -----------------	
			add   : o = i + a    (o=out; i=in)	
			sub   : o = i - a			
			mult  : o = i * a  			
			div   : o = i / a  			
			pow   : o = i ^ a			
			spow  : o = sgn(i) * abs(i) ^ a  	
			--------- operation parameter --------	
	a=1							
	copy=1		n>1 copy each trace n times		

 Note:								
 There is overlap between this program and "sugain" and	
 "suop

 Credits:

	U Arkansas: Chris Liner Jun 2013

 Notes:

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sumath		= {
		_a					=> '',
		_copy					=> '',
		_o					=> '',
		_op					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sumath->{_Step}     = 'sumath'.$sumath->{_Step};
	return ( $sumath->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sumath->{_note}     = 'sumath'.$sumath->{_note};
	return ( $sumath->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sumath->{_a}			= '';
		$sumath->{_copy}			= '';
		$sumath->{_o}			= '';
		$sumath->{_op}			= '';
		$sumath->{_Step}			= '';
		$sumath->{_note}			= '';
 }


=head2 sub a 


=cut

 sub a {

	my ( $self,$a )		= @_;
	if ( $a ne $empty_string ) {

		$sumath->{_a}		= $a;
		$sumath->{_note}		= $sumath->{_note}.' a='.$sumath->{_a};
		$sumath->{_Step}		= $sumath->{_Step}.' a='.$sumath->{_a};

	} else { 
		print("sumath, a, missing a,\n");
	 }
 }


=head2 sub copy 


=cut

 sub copy {

	my ( $self,$copy )		= @_;
	if ( $copy ne $empty_string ) {

		$sumath->{_copy}		= $copy;
		$sumath->{_note}		= $sumath->{_note}.' copy='.$sumath->{_copy};
		$sumath->{_Step}		= $sumath->{_Step}.' copy='.$sumath->{_copy};

	} else { 
		print("sumath, copy, missing copy,\n");
	 }
 }


=head2 sub o 


=cut

 sub o {

	my ( $self,$o )		= @_;
	if ( $o ne $empty_string ) {

		$sumath->{_o}		= $o;
		$sumath->{_note}		= $sumath->{_note}.' o='.$sumath->{_o};
		$sumath->{_Step}		= $sumath->{_Step}.' o='.$sumath->{_o};

	} else { 
		print("sumath, o, missing o,\n");
	 }
 }


=head2 sub op 


=cut

 sub op {

	my ( $self,$op )		= @_;
	if ( $op ne $empty_string ) {

		$sumath->{_op}		= $op;
		$sumath->{_note}		= $sumath->{_note}.' op='.$sumath->{_op};
		$sumath->{_Step}		= $sumath->{_Step}.' op='.$sumath->{_op};

	} else { 
		print("sumath, op, missing op,\n");
	 }
 }


=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut
 
  sub get_max_index {
 	my ($self) = @_;
	# only file_name : index=36
 	my $max_index = 36;
	
 	return($max_index);
 }
 
 
1; 