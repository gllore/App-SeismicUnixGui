 package suclogfft;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUCLOGFFT - fft real time traces to complex log frequency domain traces
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUCLOGFFT - fft real time traces to complex log frequency domain traces

 suclogftt <stdin >sdout sign=1 					

 Required parameters:							
 none									

 Optional parameters:							
 sign=1			sign in exponent of fft			
 dt=from header		sampling interval			
 verbose=1		=0 to stop advisory messages			

 .... phase unwrapping options .....				   	
 mode=suphase	simple jump detecting phase unwrapping			
 		=ouphase  Oppenheim's phase unwrapping			
 unwrap=1       |dphase| > pi/unwrap constitutes a phase wrapping	
 	 	=0 no phase unwrapping	(in mode=suphase  only)		
 trend=1	remove linear trend from the unwrapped phase	   	
 zeromean=0     assume phase(0)=0.0, else assume phase is zero mean	

 Notes:								
 clogfft(F(t)) = log(FFT(F(t)) = log|F(omega)| + iphi(omega)		
 where phi(omega) is the unwrapped phase. Note that 0< unwrap<= 1.0 	
 allows phase unwrapping to be tuned, if desired. 			

 To facilitate further processing, the sampling interval		
 in frequency and first frequency (0) are set in the			
 output header.							

 suclogfft unwrap=0 | suiclogfft is not quite a no-op since the trace	
 length will usually be longer due to fft padding.			

 Caveats: 								
 No check is made that the data ARE real time traces!			

 Output is type complex. To view amplitude, phase or real, imaginary	
 parts, use    suamp 							
 PI/unwrap = minimum dphase is assumed to constitute a wrap in phase	
 for suphase unwrapping only 					

 Examples: 								
 suclogfft < stdin | suamp mode=real | .... 				
 suclogfft < stdin | suamp mode=imag | .... 				

 The real and imaginary parts of the complex log spectrum are the	
 respective amplitude and phase (unwrapped) phase spectra of the input	
 signal. 								

 Credits:
      CWP: John Stockwell, Dec 2010 based on
	sufft by:
	CWP: Shuki Ronen, Chris Liner, Jack K. Cohen
	CENPET: Werner M. Heigl - added well log support
	U Montana: Bob Lankston - added m_unwrap_phase feature

 Note: leave dt set for later inversion

 Trace header fields accessed: ns, dt, d1, f1
 Trace header fields modified: ns, d1, f1, trid

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suclogfft		= {
		_dt					=> '',
		_mode					=> '',
		_sign					=> '',
		_trend					=> '',
		_unwrap					=> '',
		_verbose					=> '',
		_zeromean					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suclogfft->{_Step}     = 'suclogfft'.$suclogfft->{_Step};
	return ( $suclogfft->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suclogfft->{_note}     = 'suclogfft'.$suclogfft->{_note};
	return ( $suclogfft->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suclogfft->{_dt}			= '';
		$suclogfft->{_mode}			= '';
		$suclogfft->{_sign}			= '';
		$suclogfft->{_trend}			= '';
		$suclogfft->{_unwrap}			= '';
		$suclogfft->{_verbose}			= '';
		$suclogfft->{_zeromean}			= '';
		$suclogfft->{_Step}			= '';
		$suclogfft->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$suclogfft->{_dt}		= $dt;
		$suclogfft->{_note}		= $suclogfft->{_note}.' dt='.$suclogfft->{_dt};
		$suclogfft->{_Step}		= $suclogfft->{_Step}.' dt='.$suclogfft->{_dt};

	} else { 
		print("suclogfft, dt, missing dt,\n");
	 }
 }


=head2 sub mode 


=cut

 sub mode {

	my ( $self,$mode )		= @_;
	if ( $mode ne $empty_string ) {

		$suclogfft->{_mode}		= $mode;
		$suclogfft->{_note}		= $suclogfft->{_note}.' mode='.$suclogfft->{_mode};
		$suclogfft->{_Step}		= $suclogfft->{_Step}.' mode='.$suclogfft->{_mode};

	} else { 
		print("suclogfft, mode, missing mode,\n");
	 }
 }


=head2 sub sign 


=cut

 sub sign {

	my ( $self,$sign )		= @_;
	if ( $sign ne $empty_string ) {

		$suclogfft->{_sign}		= $sign;
		$suclogfft->{_note}		= $suclogfft->{_note}.' sign='.$suclogfft->{_sign};
		$suclogfft->{_Step}		= $suclogfft->{_Step}.' sign='.$suclogfft->{_sign};

	} else { 
		print("suclogfft, sign, missing sign,\n");
	 }
 }


=head2 sub trend 


=cut

 sub trend {

	my ( $self,$trend )		= @_;
	if ( $trend ne $empty_string ) {

		$suclogfft->{_trend}		= $trend;
		$suclogfft->{_note}		= $suclogfft->{_note}.' trend='.$suclogfft->{_trend};
		$suclogfft->{_Step}		= $suclogfft->{_Step}.' trend='.$suclogfft->{_trend};

	} else { 
		print("suclogfft, trend, missing trend,\n");
	 }
 }


=head2 sub unwrap 


=cut

 sub unwrap {

	my ( $self,$unwrap )		= @_;
	if ( $unwrap ne $empty_string ) {

		$suclogfft->{_unwrap}		= $unwrap;
		$suclogfft->{_note}		= $suclogfft->{_note}.' unwrap='.$suclogfft->{_unwrap};
		$suclogfft->{_Step}		= $suclogfft->{_Step}.' unwrap='.$suclogfft->{_unwrap};

	} else { 
		print("suclogfft, unwrap, missing unwrap,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suclogfft->{_verbose}		= $verbose;
		$suclogfft->{_note}		= $suclogfft->{_note}.' verbose='.$suclogfft->{_verbose};
		$suclogfft->{_Step}		= $suclogfft->{_Step}.' verbose='.$suclogfft->{_verbose};

	} else { 
		print("suclogfft, verbose, missing verbose,\n");
	 }
 }


=head2 sub zeromean 


=cut

 sub zeromean {

	my ( $self,$zeromean )		= @_;
	if ( $zeromean ne $empty_string ) {

		$suclogfft->{_zeromean}		= $zeromean;
		$suclogfft->{_note}		= $suclogfft->{_note}.' zeromean='.$suclogfft->{_zeromean};
		$suclogfft->{_Step}		= $suclogfft->{_Step}.' zeromean='.$suclogfft->{_zeromean};

	} else { 
		print("suclogfft, zeromean, missing zeromean,\n");
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