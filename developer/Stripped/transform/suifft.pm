 package suifft;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUIFFT - fft complex frequency traces to real time traces	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUIFFT - fft complex frequency traces to real time traces	

 suiftt <stdin >sdout sign=-1					

 Required parameters:						
 	none							

 Optional parameter:						
 	sign=-1		sign in exponent of inverse fft		

 Output traces are normalized by 1/N where N is the fft size.	

 Note: sufft | suifft is not quite a no-op since the trace	
 	length will usually be longer due to fft padding.	


 Credits:

	CWP: Shuki, Chris, Jack

 Trace header fields accessed: ns, trid
 Trace header fields modified: ns, trid

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suifft		= {
		_sign					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suifft->{_Step}     = 'suifft'.$suifft->{_Step};
	return ( $suifft->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suifft->{_note}     = 'suifft'.$suifft->{_note};
	return ( $suifft->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suifft->{_sign}			= '';
		$suifft->{_Step}			= '';
		$suifft->{_note}			= '';
 }


=head2 sub sign 


=cut

 sub sign {

	my ( $self,$sign )		= @_;
	if ( $sign ne $empty_string ) {

		$suifft->{_sign}		= $sign;
		$suifft->{_note}		= $suifft->{_note}.' sign='.$suifft->{_sign};
		$suifft->{_Step}		= $suifft->{_Step}.' sign='.$suifft->{_sign};

	} else { 
		print("suifft, sign, missing sign,\n");
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