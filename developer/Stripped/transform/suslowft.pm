 package suslowft;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUSLOWFT - Fourier Transforms by a (SLOW) DFT algorithm (Not an FFT)
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUSLOWFT - Fourier Transforms by a (SLOW) DFT algorithm (Not an FFT)

 suslowft <stdin >sdout sign=1 				

 Required parameters:						
 	none							

 Optional parameters:						
 	sign=1			sign in exponent of fft		
 	dt=from header		sampling interval		

 Trace header fields accessed: ns, dt				
 Trace header fields modified: ns, dt, trid			

 Notes: To facilitate further processing, the sampling interval
       in frequency and first frequency (0) are set in the	
	output header.						
 Warning: This program is *not* fft based. Use only for demo 	
 	   purposes, *not* for large data processing.		

 	No check is made that the data are real time traces!	
 suslowft | suslowift is not quite a no-op since the trace     
 length will usually be longer due to fft padding.             

 Caveats:                                                              
 No check is made that the data IS real time traces!                   

 Output is type complex. To view amplitude, phase or real, imaginary   
 parts, use    suamp                                                   

 Examples:                                                             
 suslowft < stdin | suamp mode=amp | ....                                 
 suslowft < stdin | suamp mode=phase | ....                               
 suslowft < stdin | suamp mode=real | ....                                
 suslowft < stdin | suamp mode=imag | ....                                



 Credits:

	CWP: Shuki, Chris, Jack

 Note: leave dt set for later inversion


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suslowft		= {
		_dt					=> '',
		_mode					=> '',
		_sign					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suslowft->{_Step}     = 'suslowft'.$suslowft->{_Step};
	return ( $suslowft->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suslowft->{_note}     = 'suslowft'.$suslowft->{_note};
	return ( $suslowft->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suslowft->{_dt}			= '';
		$suslowft->{_mode}			= '';
		$suslowft->{_sign}			= '';
		$suslowft->{_Step}			= '';
		$suslowft->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$suslowft->{_dt}		= $dt;
		$suslowft->{_note}		= $suslowft->{_note}.' dt='.$suslowft->{_dt};
		$suslowft->{_Step}		= $suslowft->{_Step}.' dt='.$suslowft->{_dt};

	} else { 
		print("suslowft, dt, missing dt,\n");
	 }
 }


=head2 sub mode 


=cut

 sub mode {

	my ( $self,$mode )		= @_;
	if ( $mode ne $empty_string ) {

		$suslowft->{_mode}		= $mode;
		$suslowft->{_note}		= $suslowft->{_note}.' mode='.$suslowft->{_mode};
		$suslowft->{_Step}		= $suslowft->{_Step}.' mode='.$suslowft->{_mode};

	} else { 
		print("suslowft, mode, missing mode,\n");
	 }
 }


=head2 sub sign 


=cut

 sub sign {

	my ( $self,$sign )		= @_;
	if ( $sign ne $empty_string ) {

		$suslowft->{_sign}		= $sign;
		$suslowft->{_note}		= $suslowft->{_note}.' sign='.$suslowft->{_sign};
		$suslowft->{_Step}		= $suslowft->{_Step}.' sign='.$suslowft->{_sign};

	} else { 
		print("suslowft, sign, missing sign,\n");
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