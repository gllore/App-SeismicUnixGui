 package suradon;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SURADON - compute forward or reverse Radon transform or remove multiples
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SURADON - compute forward or reverse Radon transform or remove multiples
           by using the parabolic Radon transform to estimate multiples
           and subtract.						

     suradon <stdin >stdout [Optional Parameters]			

 Optional Parameters:							
 choose=0    0  Forward Radon transform				
             1  Compute data minus multiples				
             2  Compute estimate of multiples				
             3  Compute forward and reverse transform			
             4  Compute inverse Radon transform			
 igopt=1     1  parabolic transform: g(x) = offset**2			
             2  Foster/Mosher psuedo hyperbolic transform		
                   g(x) = sqrt(depth**2 + offset**2)			
             3  Linear tau-p: g(x) = offset				
             4  abs linear tau-p: g(x) = abs(offset)			
 offref=2000.    reference maximum offset to which maximum and minimum	
                 moveout times are associated				
 interoff=0.     intercept offset to which tau-p times are associated	
 pmin=-200       minimum moveout in ms on reference offset		
 pmax=400        maximum moveout in ms on reference offset		
 dp=16           moveout increment in ms on reference offset		
 pmula=80        moveout in ms on reference offset where multiples begin
                     at maximum time					
 pmulb=200       moveout in ms on reference offset where multiples begin
                     at zero time					
 depthref=500.   Reference depth for Foster/Mosher hyperbolic transform
 nwin=1          number of windows to use through the mute zone	
 f1=60.          High-end frequency before taper off			
 f2=80.          High-end frequency					
 prewhite=0.1    Prewhitening factor in percent.			
 cdpkey=cdp      name of header word for defining ensemble		
 offkey=offset   name of header word with spatial information		
 nxmax=240       maximum number of input traces per ensemble		
 ltaper=7	  taper (integer) for mute tapering function		

 Optimizing Parameters:						
 The following parameters are occasionally used to avoid spatial aliasing
 problems on the linear tau-p transform.  Not recommended for other	
 transforms...								
 ninterp=0      number of traces to interpolate between each input trace
                   prior to computing transform			
 freq1=4.0      low-end frequency in Hz for picking (good default: 3 Hz)
                (Known bug: freq1 cannot be zero) 
 freq2=20.0     high-end frequency in Hz for picking (good default: 20 Hz)
 lagc=400       length of AGC operator for picking (good default: 400 ms)
 lent=5         length of time smoother in samples for picker		
                     (good default: 5 samples)				
 lenx=7         length of space smoother in samples for picker		
                     (good default: 1 sample)				
 xopt=1         1 = use differences for spatial derivative		
                        (works with irregular spacing)			
                0 = use FFT derivative for spatial derivatives		
                      (more accurate but requires regular spacing and	
                      at least 16 input tracs--will switch to differences
                      automatically if have less than 16 input traces)	


 Credits:
	CWP: John Anderson (visitor to CSM from Mobil) Spring 1993

 Multiple removal notes:
	Usually the input data are NMO corrected CMP gathers.  The
	first pass is to compute a parabolic Radon transform and
 	identify the multiples in the transform domain.  Then, the
 	module is run on all the data using "choose=1" to estimate
 	and subtract the multiples.  See the May, 1993 CWP Project
	Review for more extensive documentation.

 NWIN notes:
	The parabolic transform runs with higher resolution if the
 	mute zone is honored.  When "nwin" is specified larger than
   	one (say 6), then multiple windows are used through the mute
 	zone.  It is assumed in this case that the input data are
 	sorted by the offkey header item from small offset to large
 	offset.  This causes the code to run 6 times longer.  The
      mute time is taken from the "muts" header word.
      You may have to manually set this header field yourself, if
      it is not already set.

 References:
 Anderson, J. E., 1993, Parabolic and linear 2-D, tau-p transforms
       using the generalized radon tranform, in May 11-14, 1993
       Project Review, Consortium Project on Seismic Inverse methods
       for Complex Structures, CWP-137, Center for Wave Phenomena
       internal report.
 Other References cited in above paper:
 Beylkin, G,.1987, The discrete Radon transform: IEEE Transactions
       of Acoustics, Speech, and Signal Processing, 35, 162-712.
 Chapman, C.H.,1981, Generalized Radon transforms and slant stacks:
       Geophysical Journal of the Royal Astronomical Society, 66,
       445-453.
 Foster, D. J. and Mosher, C. C., 1990, Multiple supression
       using curvilinear Radon transforms: SEG Expanded Abstracts 1990,
       1647-1650.
 Foster, D. J. and Mosher, C. C., 1992, Suppression of multiples
       using the Radon transform: Geophysics, 57, No. 3, 386-395.
 Gulunay, N., 1990, F-X domain least-squares Tau-P and Tau-Q: SEG
       Expanded Abstracts 1990, 1607-1610.
 Hampson, D., 1986, Inverse velocity stacking for multiple elimination:
       J. Can. Soc. Expl. Geophs., 22, 44-55.
 Hampson, D., 1987, The discrete Radon transform: a new tool for image
       enhancement and noise suppression: SEG Expanded Abstracts 1978,
       141-143.
 Johnston, D.E., 1990, Which multiple suppression method should I use?
       SEG Expanded Abstracts 1990, 1750-1752.

 Trace header words accessed: ns, dt, cdpkey, offkey, muts

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suradon		= {
		_cdpkey					=> '',
		_choose					=> '',
		_depthref					=> '',
		_dp					=> '',
		_f1					=> '',
		_f2					=> '',
		_freq1					=> '',
		_freq2					=> '',
		_igopt					=> '',
		_interoff					=> '',
		_lagc					=> '',
		_lent					=> '',
		_lenx					=> '',
		_ltaper					=> '',
		_ninterp					=> '',
		_nwin					=> '',
		_nxmax					=> '',
		_offkey					=> '',
		_offref					=> '',
		_pmax					=> '',
		_pmin					=> '',
		_pmula					=> '',
		_pmulb					=> '',
		_prewhite					=> '',
		_xopt					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suradon->{_Step}     = 'suradon'.$suradon->{_Step};
	return ( $suradon->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suradon->{_note}     = 'suradon'.$suradon->{_note};
	return ( $suradon->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suradon->{_cdpkey}			= '';
		$suradon->{_choose}			= '';
		$suradon->{_depthref}			= '';
		$suradon->{_dp}			= '';
		$suradon->{_f1}			= '';
		$suradon->{_f2}			= '';
		$suradon->{_freq1}			= '';
		$suradon->{_freq2}			= '';
		$suradon->{_igopt}			= '';
		$suradon->{_interoff}			= '';
		$suradon->{_lagc}			= '';
		$suradon->{_lent}			= '';
		$suradon->{_lenx}			= '';
		$suradon->{_ltaper}			= '';
		$suradon->{_ninterp}			= '';
		$suradon->{_nwin}			= '';
		$suradon->{_nxmax}			= '';
		$suradon->{_offkey}			= '';
		$suradon->{_offref}			= '';
		$suradon->{_pmax}			= '';
		$suradon->{_pmin}			= '';
		$suradon->{_pmula}			= '';
		$suradon->{_pmulb}			= '';
		$suradon->{_prewhite}			= '';
		$suradon->{_xopt}			= '';
		$suradon->{_Step}			= '';
		$suradon->{_note}			= '';
 }


=head2 sub cdpkey 


=cut

 sub cdpkey {

	my ( $self,$cdpkey )		= @_;
	if ( $cdpkey ne $empty_string ) {

		$suradon->{_cdpkey}		= $cdpkey;
		$suradon->{_note}		= $suradon->{_note}.' cdpkey='.$suradon->{_cdpkey};
		$suradon->{_Step}		= $suradon->{_Step}.' cdpkey='.$suradon->{_cdpkey};

	} else { 
		print("suradon, cdpkey, missing cdpkey,\n");
	 }
 }


=head2 sub choose 


=cut

 sub choose {

	my ( $self,$choose )		= @_;
	if ( $choose ne $empty_string ) {

		$suradon->{_choose}		= $choose;
		$suradon->{_note}		= $suradon->{_note}.' choose='.$suradon->{_choose};
		$suradon->{_Step}		= $suradon->{_Step}.' choose='.$suradon->{_choose};

	} else { 
		print("suradon, choose, missing choose,\n");
	 }
 }


=head2 sub depthref 


=cut

 sub depthref {

	my ( $self,$depthref )		= @_;
	if ( $depthref ne $empty_string ) {

		$suradon->{_depthref}		= $depthref;
		$suradon->{_note}		= $suradon->{_note}.' depthref='.$suradon->{_depthref};
		$suradon->{_Step}		= $suradon->{_Step}.' depthref='.$suradon->{_depthref};

	} else { 
		print("suradon, depthref, missing depthref,\n");
	 }
 }


=head2 sub dp 


=cut

 sub dp {

	my ( $self,$dp )		= @_;
	if ( $dp ne $empty_string ) {

		$suradon->{_dp}		= $dp;
		$suradon->{_note}		= $suradon->{_note}.' dp='.$suradon->{_dp};
		$suradon->{_Step}		= $suradon->{_Step}.' dp='.$suradon->{_dp};

	} else { 
		print("suradon, dp, missing dp,\n");
	 }
 }


=head2 sub f1 


=cut

 sub f1 {

	my ( $self,$f1 )		= @_;
	if ( $f1 ne $empty_string ) {

		$suradon->{_f1}		= $f1;
		$suradon->{_note}		= $suradon->{_note}.' f1='.$suradon->{_f1};
		$suradon->{_Step}		= $suradon->{_Step}.' f1='.$suradon->{_f1};

	} else { 
		print("suradon, f1, missing f1,\n");
	 }
 }


=head2 sub f2 


=cut

 sub f2 {

	my ( $self,$f2 )		= @_;
	if ( $f2 ne $empty_string ) {

		$suradon->{_f2}		= $f2;
		$suradon->{_note}		= $suradon->{_note}.' f2='.$suradon->{_f2};
		$suradon->{_Step}		= $suradon->{_Step}.' f2='.$suradon->{_f2};

	} else { 
		print("suradon, f2, missing f2,\n");
	 }
 }


=head2 sub freq1 


=cut

 sub freq1 {

	my ( $self,$freq1 )		= @_;
	if ( $freq1 ne $empty_string ) {

		$suradon->{_freq1}		= $freq1;
		$suradon->{_note}		= $suradon->{_note}.' freq1='.$suradon->{_freq1};
		$suradon->{_Step}		= $suradon->{_Step}.' freq1='.$suradon->{_freq1};

	} else { 
		print("suradon, freq1, missing freq1,\n");
	 }
 }


=head2 sub freq2 


=cut

 sub freq2 {

	my ( $self,$freq2 )		= @_;
	if ( $freq2 ne $empty_string ) {

		$suradon->{_freq2}		= $freq2;
		$suradon->{_note}		= $suradon->{_note}.' freq2='.$suradon->{_freq2};
		$suradon->{_Step}		= $suradon->{_Step}.' freq2='.$suradon->{_freq2};

	} else { 
		print("suradon, freq2, missing freq2,\n");
	 }
 }


=head2 sub igopt 


=cut

 sub igopt {

	my ( $self,$igopt )		= @_;
	if ( $igopt ne $empty_string ) {

		$suradon->{_igopt}		= $igopt;
		$suradon->{_note}		= $suradon->{_note}.' igopt='.$suradon->{_igopt};
		$suradon->{_Step}		= $suradon->{_Step}.' igopt='.$suradon->{_igopt};

	} else { 
		print("suradon, igopt, missing igopt,\n");
	 }
 }


=head2 sub interoff 


=cut

 sub interoff {

	my ( $self,$interoff )		= @_;
	if ( $interoff ne $empty_string ) {

		$suradon->{_interoff}		= $interoff;
		$suradon->{_note}		= $suradon->{_note}.' interoff='.$suradon->{_interoff};
		$suradon->{_Step}		= $suradon->{_Step}.' interoff='.$suradon->{_interoff};

	} else { 
		print("suradon, interoff, missing interoff,\n");
	 }
 }


=head2 sub lagc 


=cut

 sub lagc {

	my ( $self,$lagc )		= @_;
	if ( $lagc ne $empty_string ) {

		$suradon->{_lagc}		= $lagc;
		$suradon->{_note}		= $suradon->{_note}.' lagc='.$suradon->{_lagc};
		$suradon->{_Step}		= $suradon->{_Step}.' lagc='.$suradon->{_lagc};

	} else { 
		print("suradon, lagc, missing lagc,\n");
	 }
 }


=head2 sub lent 


=cut

 sub lent {

	my ( $self,$lent )		= @_;
	if ( $lent ne $empty_string ) {

		$suradon->{_lent}		= $lent;
		$suradon->{_note}		= $suradon->{_note}.' lent='.$suradon->{_lent};
		$suradon->{_Step}		= $suradon->{_Step}.' lent='.$suradon->{_lent};

	} else { 
		print("suradon, lent, missing lent,\n");
	 }
 }


=head2 sub lenx 


=cut

 sub lenx {

	my ( $self,$lenx )		= @_;
	if ( $lenx ne $empty_string ) {

		$suradon->{_lenx}		= $lenx;
		$suradon->{_note}		= $suradon->{_note}.' lenx='.$suradon->{_lenx};
		$suradon->{_Step}		= $suradon->{_Step}.' lenx='.$suradon->{_lenx};

	} else { 
		print("suradon, lenx, missing lenx,\n");
	 }
 }


=head2 sub ltaper 


=cut

 sub ltaper {

	my ( $self,$ltaper )		= @_;
	if ( $ltaper ne $empty_string ) {

		$suradon->{_ltaper}		= $ltaper;
		$suradon->{_note}		= $suradon->{_note}.' ltaper='.$suradon->{_ltaper};
		$suradon->{_Step}		= $suradon->{_Step}.' ltaper='.$suradon->{_ltaper};

	} else { 
		print("suradon, ltaper, missing ltaper,\n");
	 }
 }


=head2 sub ninterp 


=cut

 sub ninterp {

	my ( $self,$ninterp )		= @_;
	if ( $ninterp ne $empty_string ) {

		$suradon->{_ninterp}		= $ninterp;
		$suradon->{_note}		= $suradon->{_note}.' ninterp='.$suradon->{_ninterp};
		$suradon->{_Step}		= $suradon->{_Step}.' ninterp='.$suradon->{_ninterp};

	} else { 
		print("suradon, ninterp, missing ninterp,\n");
	 }
 }


=head2 sub nwin 


=cut

 sub nwin {

	my ( $self,$nwin )		= @_;
	if ( $nwin ne $empty_string ) {

		$suradon->{_nwin}		= $nwin;
		$suradon->{_note}		= $suradon->{_note}.' nwin='.$suradon->{_nwin};
		$suradon->{_Step}		= $suradon->{_Step}.' nwin='.$suradon->{_nwin};

	} else { 
		print("suradon, nwin, missing nwin,\n");
	 }
 }


=head2 sub nxmax 


=cut

 sub nxmax {

	my ( $self,$nxmax )		= @_;
	if ( $nxmax ne $empty_string ) {

		$suradon->{_nxmax}		= $nxmax;
		$suradon->{_note}		= $suradon->{_note}.' nxmax='.$suradon->{_nxmax};
		$suradon->{_Step}		= $suradon->{_Step}.' nxmax='.$suradon->{_nxmax};

	} else { 
		print("suradon, nxmax, missing nxmax,\n");
	 }
 }


=head2 sub offkey 


=cut

 sub offkey {

	my ( $self,$offkey )		= @_;
	if ( $offkey ne $empty_string ) {

		$suradon->{_offkey}		= $offkey;
		$suradon->{_note}		= $suradon->{_note}.' offkey='.$suradon->{_offkey};
		$suradon->{_Step}		= $suradon->{_Step}.' offkey='.$suradon->{_offkey};

	} else { 
		print("suradon, offkey, missing offkey,\n");
	 }
 }


=head2 sub offref 


=cut

 sub offref {

	my ( $self,$offref )		= @_;
	if ( $offref ne $empty_string ) {

		$suradon->{_offref}		= $offref;
		$suradon->{_note}		= $suradon->{_note}.' offref='.$suradon->{_offref};
		$suradon->{_Step}		= $suradon->{_Step}.' offref='.$suradon->{_offref};

	} else { 
		print("suradon, offref, missing offref,\n");
	 }
 }


=head2 sub pmax 


=cut

 sub pmax {

	my ( $self,$pmax )		= @_;
	if ( $pmax ne $empty_string ) {

		$suradon->{_pmax}		= $pmax;
		$suradon->{_note}		= $suradon->{_note}.' pmax='.$suradon->{_pmax};
		$suradon->{_Step}		= $suradon->{_Step}.' pmax='.$suradon->{_pmax};

	} else { 
		print("suradon, pmax, missing pmax,\n");
	 }
 }


=head2 sub pmin 


=cut

 sub pmin {

	my ( $self,$pmin )		= @_;
	if ( $pmin ne $empty_string ) {

		$suradon->{_pmin}		= $pmin;
		$suradon->{_note}		= $suradon->{_note}.' pmin='.$suradon->{_pmin};
		$suradon->{_Step}		= $suradon->{_Step}.' pmin='.$suradon->{_pmin};

	} else { 
		print("suradon, pmin, missing pmin,\n");
	 }
 }


=head2 sub pmula 


=cut

 sub pmula {

	my ( $self,$pmula )		= @_;
	if ( $pmula ne $empty_string ) {

		$suradon->{_pmula}		= $pmula;
		$suradon->{_note}		= $suradon->{_note}.' pmula='.$suradon->{_pmula};
		$suradon->{_Step}		= $suradon->{_Step}.' pmula='.$suradon->{_pmula};

	} else { 
		print("suradon, pmula, missing pmula,\n");
	 }
 }


=head2 sub pmulb 


=cut

 sub pmulb {

	my ( $self,$pmulb )		= @_;
	if ( $pmulb ne $empty_string ) {

		$suradon->{_pmulb}		= $pmulb;
		$suradon->{_note}		= $suradon->{_note}.' pmulb='.$suradon->{_pmulb};
		$suradon->{_Step}		= $suradon->{_Step}.' pmulb='.$suradon->{_pmulb};

	} else { 
		print("suradon, pmulb, missing pmulb,\n");
	 }
 }


=head2 sub prewhite 


=cut

 sub prewhite {

	my ( $self,$prewhite )		= @_;
	if ( $prewhite ne $empty_string ) {

		$suradon->{_prewhite}		= $prewhite;
		$suradon->{_note}		= $suradon->{_note}.' prewhite='.$suradon->{_prewhite};
		$suradon->{_Step}		= $suradon->{_Step}.' prewhite='.$suradon->{_prewhite};

	} else { 
		print("suradon, prewhite, missing prewhite,\n");
	 }
 }


=head2 sub xopt 


=cut

 sub xopt {

	my ( $self,$xopt )		= @_;
	if ( $xopt ne $empty_string ) {

		$suradon->{_xopt}		= $xopt;
		$suradon->{_note}		= $suradon->{_note}.' xopt='.$suradon->{_xopt};
		$suradon->{_Step}		= $suradon->{_Step}.' xopt='.$suradon->{_xopt};

	} else { 
		print("suradon, xopt, missing xopt,\n");
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