 package suwaveform;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUWAVEFORM - generate a seismic wavelet				
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUWAVEFORM - generate a seismic wavelet				

 suwaveform <stdin >stdout [optional parameters]			

 Required parameters:						  	
	one of the optional parameters listed below			

 Optional parameters:						  	
	type=akb	wavelet type					
		   akb:	AKB wavelet defined by max frequency fpeak	
		   berlage: Berlage wavelet				
		   gauss:   Gaussian wavelet defined by frequency fpeak	
		   gaussd:  Gaussian first derivative wavelet		
		   ricker1: Ricker wavelet defined by frequency fpeak	
		   ricker2: Ricker wavelet defined by half and period	
		   spike:   spike wavelet, shifted by time tspike	
		   unit:	unit wavelet, i.e. amplitude = 1 = const.

	dt=0.004	time sampling interval in seconds		
	ns=		if set, number of samples in  output trace	

	fpeak=20.0	peak frequency of a Berlage, Ricker, or Gaussian,
		   and maximum frequency of an AKB wavelet in Hz	

	half=1/fpeak   Ricker wavelet "ricker2": half-length		
	period=c*half  Ricker wavelet "ricker2": period (c=sqrt(6)/pi)
	distort=0.0	Ricker wavelet "ricker2": distortion factor	
	decay=4*fpeak  Berlage wavelet: exponential decay factor in 1/sec
	tn=2	   Berlage wavelet: time exponent			
	ipa=-90	Berlage wavelet: initial phase angle in degrees		
	tspike=0.0	Spike wavelet: time at spike in seconds		
	verbose=0	1: echo output wavelet length			


 Notes:								
	If ns is not defined, the program determines the trace length	
	depending on the dominant signal period.			   

	The Ricker wavelet "ricker1" and the Gaussian wavelet "gauss
	are zero-phase. For these two wavelets, the trace header word	
	delrt is set such that the peak amplitude is at t=0 seconds.	
	If this is not acceptable, use "sushw key=delrt a=0".		

	The Ricker wavelets can be defined either by the peak frequency	
	fpeak ("ricker1") or by its half-length, the period, and a	
	distortion factor ("ricker2"). "ricker" is an acceptable	
	alias for "ricker1".						

	The Berlage wavelet is defined by the peak frequency fpeak, a time 
	time exponent tn describing the wavelet shape at its beginning,	
	and an exponential decay factor describing the amplitude decay	
	towards later times. The parameters tn and decay are non-negative, 
	real numbers; tn is typically a small integer number and decay a   
	multiple of the dominant signal period 1/fpeak. Additionally, an   
	initial phase angle can be given; use -90 or 90 degrees for	
	zero-amplitude at the beginning.				   

	For an AKB wavelet, fpeak is the maximum frequency; the peak	
	frequency is about 1/3 of the fpeak value.			 

	The output wavelet can be normalized or scaled with "sugain".	
	Use "suvibro" to generate a Vibroseis sweep.			

 Example:								
 A normalized, zero-phase Ricker wavelet with a peak frequency		
 of 15 Hz is generated and convolved with a spike dataset:		

	suwaveform type=ricker1 fpeak=15 | sugain pbal=1 > wavelet.su	
	suplane npl=1 | suconv sufile=wavelet.su | suxwigb		

 Gaussian and derivatives of Gaussians:				
 Use "sudgwaveform" to generate these				

 Caveat:								
	This program does not check for aliasing.			



 Author: 
	Nils Maercklin, RISSC, University of Napoli, Italy, 2006

 References:
	Aldridge, D. F. (1990). The Berlage wavelet. 
	Geophysics, vol. 55(11), p. 1508-1511.
	Alford, R., Kelly, K., and Boore, D. (1947). Accuracy
	of finite-difference modeling of the acoustic wave
	equation. Geophysics, vol. 39, p. 834-842. (AKB wavelet)
	Sheriff, R. E. (2002). Encyclopedic dictionary of 
	applied geophysics. Society of Exploration Geophysicists,
	Tulsa. (Ricker wavelet, page 301)

 Notes:
	For more information on the wavelets type "sudoc waveforms" 
	or have a look at "$CWPROOT/src/cwp/lib/waveforms.c".

 Credits: 
	CWP, the authors of the subroutines in "waveforms.c".

 Trace header fields set: ns, dt, trid, delrt

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suwaveform		= {
		_amplitude					=> '',
		_decay					=> '',
		_distort					=> '',
		_dt					=> '',
		_fpeak					=> '',
		_half					=> '',
		_ipa					=> '',
		_key					=> '',
		_npl					=> '',
		_ns					=> '',
		_period					=> '',
		_t					=> '',
		_tn					=> '',
		_tspike					=> '',
		_type					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suwaveform->{_Step}     = 'suwaveform'.$suwaveform->{_Step};
	return ( $suwaveform->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suwaveform->{_note}     = 'suwaveform'.$suwaveform->{_note};
	return ( $suwaveform->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suwaveform->{_amplitude}			= '';
		$suwaveform->{_decay}			= '';
		$suwaveform->{_distort}			= '';
		$suwaveform->{_dt}			= '';
		$suwaveform->{_fpeak}			= '';
		$suwaveform->{_half}			= '';
		$suwaveform->{_ipa}			= '';
		$suwaveform->{_key}			= '';
		$suwaveform->{_npl}			= '';
		$suwaveform->{_ns}			= '';
		$suwaveform->{_period}			= '';
		$suwaveform->{_t}			= '';
		$suwaveform->{_tn}			= '';
		$suwaveform->{_tspike}			= '';
		$suwaveform->{_type}			= '';
		$suwaveform->{_verbose}			= '';
		$suwaveform->{_Step}			= '';
		$suwaveform->{_note}			= '';
 }


=head2 sub amplitude 


=cut

 sub amplitude {

	my ( $self,$amplitude )		= @_;
	if ( $amplitude ne $empty_string ) {

		$suwaveform->{_amplitude}		= $amplitude;
		$suwaveform->{_note}		= $suwaveform->{_note}.' amplitude='.$suwaveform->{_amplitude};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' amplitude='.$suwaveform->{_amplitude};

	} else { 
		print("suwaveform, amplitude, missing amplitude,\n");
	 }
 }


=head2 sub decay 


=cut

 sub decay {

	my ( $self,$decay )		= @_;
	if ( $decay ne $empty_string ) {

		$suwaveform->{_decay}		= $decay;
		$suwaveform->{_note}		= $suwaveform->{_note}.' decay='.$suwaveform->{_decay};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' decay='.$suwaveform->{_decay};

	} else { 
		print("suwaveform, decay, missing decay,\n");
	 }
 }


=head2 sub distort 


=cut

 sub distort {

	my ( $self,$distort )		= @_;
	if ( $distort ne $empty_string ) {

		$suwaveform->{_distort}		= $distort;
		$suwaveform->{_note}		= $suwaveform->{_note}.' distort='.$suwaveform->{_distort};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' distort='.$suwaveform->{_distort};

	} else { 
		print("suwaveform, distort, missing distort,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$suwaveform->{_dt}		= $dt;
		$suwaveform->{_note}		= $suwaveform->{_note}.' dt='.$suwaveform->{_dt};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' dt='.$suwaveform->{_dt};

	} else { 
		print("suwaveform, dt, missing dt,\n");
	 }
 }


=head2 sub fpeak 


=cut

 sub fpeak {

	my ( $self,$fpeak )		= @_;
	if ( $fpeak ne $empty_string ) {

		$suwaveform->{_fpeak}		= $fpeak;
		$suwaveform->{_note}		= $suwaveform->{_note}.' fpeak='.$suwaveform->{_fpeak};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' fpeak='.$suwaveform->{_fpeak};

	} else { 
		print("suwaveform, fpeak, missing fpeak,\n");
	 }
 }


=head2 sub half 


=cut

 sub half {

	my ( $self,$half )		= @_;
	if ( $half ne $empty_string ) {

		$suwaveform->{_half}		= $half;
		$suwaveform->{_note}		= $suwaveform->{_note}.' half='.$suwaveform->{_half};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' half='.$suwaveform->{_half};

	} else { 
		print("suwaveform, half, missing half,\n");
	 }
 }


=head2 sub ipa 


=cut

 sub ipa {

	my ( $self,$ipa )		= @_;
	if ( $ipa ne $empty_string ) {

		$suwaveform->{_ipa}		= $ipa;
		$suwaveform->{_note}		= $suwaveform->{_note}.' ipa='.$suwaveform->{_ipa};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' ipa='.$suwaveform->{_ipa};

	} else { 
		print("suwaveform, ipa, missing ipa,\n");
	 }
 }


=head2 sub key 


=cut

 sub key {

	my ( $self,$key )		= @_;
	if ( $key ne $empty_string ) {

		$suwaveform->{_key}		= $key;
		$suwaveform->{_note}		= $suwaveform->{_note}.' key='.$suwaveform->{_key};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' key='.$suwaveform->{_key};

	} else { 
		print("suwaveform, key, missing key,\n");
	 }
 }


=head2 sub npl 


=cut

 sub npl {

	my ( $self,$npl )		= @_;
	if ( $npl ne $empty_string ) {

		$suwaveform->{_npl}		= $npl;
		$suwaveform->{_note}		= $suwaveform->{_note}.' npl='.$suwaveform->{_npl};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' npl='.$suwaveform->{_npl};

	} else { 
		print("suwaveform, npl, missing npl,\n");
	 }
 }


=head2 sub ns 


=cut

 sub ns {

	my ( $self,$ns )		= @_;
	if ( $ns ne $empty_string ) {

		$suwaveform->{_ns}		= $ns;
		$suwaveform->{_note}		= $suwaveform->{_note}.' ns='.$suwaveform->{_ns};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' ns='.$suwaveform->{_ns};

	} else { 
		print("suwaveform, ns, missing ns,\n");
	 }
 }


=head2 sub period 


=cut

 sub period {

	my ( $self,$period )		= @_;
	if ( $period ne $empty_string ) {

		$suwaveform->{_period}		= $period;
		$suwaveform->{_note}		= $suwaveform->{_note}.' period='.$suwaveform->{_period};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' period='.$suwaveform->{_period};

	} else { 
		print("suwaveform, period, missing period,\n");
	 }
 }


=head2 sub t 


=cut

 sub t {

	my ( $self,$t )		= @_;
	if ( $t ne $empty_string ) {

		$suwaveform->{_t}		= $t;
		$suwaveform->{_note}		= $suwaveform->{_note}.' t='.$suwaveform->{_t};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' t='.$suwaveform->{_t};

	} else { 
		print("suwaveform, t, missing t,\n");
	 }
 }


=head2 sub tn 


=cut

 sub tn {

	my ( $self,$tn )		= @_;
	if ( $tn ne $empty_string ) {

		$suwaveform->{_tn}		= $tn;
		$suwaveform->{_note}		= $suwaveform->{_note}.' tn='.$suwaveform->{_tn};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' tn='.$suwaveform->{_tn};

	} else { 
		print("suwaveform, tn, missing tn,\n");
	 }
 }


=head2 sub tspike 


=cut

 sub tspike {

	my ( $self,$tspike )		= @_;
	if ( $tspike ne $empty_string ) {

		$suwaveform->{_tspike}		= $tspike;
		$suwaveform->{_note}		= $suwaveform->{_note}.' tspike='.$suwaveform->{_tspike};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' tspike='.$suwaveform->{_tspike};

	} else { 
		print("suwaveform, tspike, missing tspike,\n");
	 }
 }


=head2 sub type 


=cut

 sub type {

	my ( $self,$type )		= @_;
	if ( $type ne $empty_string ) {

		$suwaveform->{_type}		= $type;
		$suwaveform->{_note}		= $suwaveform->{_note}.' type='.$suwaveform->{_type};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' type='.$suwaveform->{_type};

	} else { 
		print("suwaveform, type, missing type,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suwaveform->{_verbose}		= $verbose;
		$suwaveform->{_note}		= $suwaveform->{_note}.' verbose='.$suwaveform->{_verbose};
		$suwaveform->{_Step}		= $suwaveform->{_Step}.' verbose='.$suwaveform->{_verbose};

	} else { 
		print("suwaveform, verbose, missing verbose,\n");
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