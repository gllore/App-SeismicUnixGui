 package entropy;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  ENTROPY - compute the ENTROPY of a signal			
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 ENTROPY - compute the ENTROPY of a signal			

  entropy < stdin n= > stdout					

 Required Parameter:						
  n		number of values in data set			

 Optional Parameters:						
  none								



 Author: CWP: Tong Chen, 1995.
 

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $entropy		= {
		_n					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$entropy->{_Step}     = 'entropy'.$entropy->{_Step};
	return ( $entropy->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$entropy->{_note}     = 'entropy'.$entropy->{_note};
	return ( $entropy->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$entropy->{_n}			= '';
		$entropy->{_Step}			= '';
		$entropy->{_note}			= '';
 }


=head2 sub n 


=cut

 sub n {

	my ( $self,$n )		= @_;
	if ( $n ne $empty_string ) {

		$entropy->{_n}		= $n;
		$entropy->{_note}		= $entropy->{_note}.' n='.$entropy->{_n};
		$entropy->{_Step}		= $entropy->{_Step}.' n='.$entropy->{_n};

	} else { 
		print("entropy, n, missing n,\n");
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