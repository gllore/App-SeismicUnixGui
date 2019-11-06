 package suiclogfft;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUICLOGFFT - fft of complex log frequency traces to real time traces
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUICLOGFFT - fft of complex log frequency traces to real time traces

  suiclogftt <stdin >sdout sign=-1				

 Required parameters:						
 	none							

 Optional parameter:						
 	sign=-1		sign in exponent of inverse fft		
	sym=0		=1 center  output 			
 Output traces are normalized by 1/N where N is the fft size.	

 Note:								
 Nominally this is the inverse to the complex log fft, but	
 suclogfft | suiclogfft is not quite a no-op since the trace	
 	length will usually be longer due to fft padding.	


 Credits:
 
   CWP: John Stockwell, Dec 2010 based on
     suifft.c by:
	CWP: Shuki Ronen, Chris Liner, Jack K. Cohen,  c. 1989

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


	my $suiclogfft		= {
		_sign					=> '',
		_sym					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suiclogfft->{_Step}     = 'suiclogfft'.$suiclogfft->{_Step};
	return ( $suiclogfft->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suiclogfft->{_note}     = 'suiclogfft'.$suiclogfft->{_note};
	return ( $suiclogfft->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suiclogfft->{_sign}			= '';
		$suiclogfft->{_sym}			= '';
		$suiclogfft->{_Step}			= '';
		$suiclogfft->{_note}			= '';
 }


=head2 sub sign 


=cut

 sub sign {

	my ( $self,$sign )		= @_;
	if ( $sign ne $empty_string ) {

		$suiclogfft->{_sign}		= $sign;
		$suiclogfft->{_note}		= $suiclogfft->{_note}.' sign='.$suiclogfft->{_sign};
		$suiclogfft->{_Step}		= $suiclogfft->{_Step}.' sign='.$suiclogfft->{_sign};

	} else { 
		print("suiclogfft, sign, missing sign,\n");
	 }
 }


=head2 sub sym 


=cut

 sub sym {

	my ( $self,$sym )		= @_;
	if ( $sym ne $empty_string ) {

		$suiclogfft->{_sym}		= $sym;
		$suiclogfft->{_note}		= $suiclogfft->{_note}.' sym='.$suiclogfft->{_sym};
		$suiclogfft->{_Step}		= $suiclogfft->{_Step}.' sym='.$suiclogfft->{_sym};

	} else { 
		print("suiclogfft, sym, missing sym,\n");
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