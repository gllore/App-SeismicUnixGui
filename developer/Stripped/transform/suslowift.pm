 package suslowift;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUSLOWIFT - Fourier Transforms by (SLOW) DFT algorithm (Not an FFT)
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUSLOWIFT - Fourier Transforms by (SLOW) DFT algorithm (Not an FFT)
             complex frequency to real time domain traces 	

 suslowift <stdin >sdout sign=-1 				

 Required parameters:						
 	none							

 Optional parameters:						
 	sign=-1			sign in exponent of fft		
 	dt=from header		sampling interval		

 Trace header fields accessed: ns, dt				
 Trace header fields modified: ns, dt, trid			

 Notes: To facilitate further processing, the sampling interval
       in frequency and first frequency (0) are set in the	
	output header.						

 Warning: This program is *not* fft based. Use only for demo 	
 	   purposes, *not* for large data processing.		

 	No check is made that the data are real time traces!	


 Credits:

	CWP: John Stockwell c. 1993
       based on suifft:   Shuki Ronen, Chris Liner, Jack K. Cohen

 Note: leave dt set for later inversion


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suslowift		= {
		_dt					=> '',
		_sign					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suslowift->{_Step}     = 'suslowift'.$suslowift->{_Step};
	return ( $suslowift->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suslowift->{_note}     = 'suslowift'.$suslowift->{_note};
	return ( $suslowift->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suslowift->{_dt}			= '';
		$suslowift->{_sign}			= '';
		$suslowift->{_Step}			= '';
		$suslowift->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$suslowift->{_dt}		= $dt;
		$suslowift->{_note}		= $suslowift->{_note}.' dt='.$suslowift->{_dt};
		$suslowift->{_Step}		= $suslowift->{_Step}.' dt='.$suslowift->{_dt};

	} else { 
		print("suslowift, dt, missing dt,\n");
	 }
 }


=head2 sub sign 


=cut

 sub sign {

	my ( $self,$sign )		= @_;
	if ( $sign ne $empty_string ) {

		$suslowift->{_sign}		= $sign;
		$suslowift->{_note}		= $suslowift->{_note}.' sign='.$suslowift->{_sign};
		$suslowift->{_Step}		= $suslowift->{_Step}.' sign='.$suslowift->{_sign};

	} else { 
		print("suslowift, sign, missing sign,\n");
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