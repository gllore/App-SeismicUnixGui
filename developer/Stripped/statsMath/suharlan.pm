 package suharlan;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUHARLAN - signal-noise separation by the invertible linear		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUHARLAN - signal-noise separation by the invertible linear		
	    transformation method of Harlan, 1984			

   suharlan <infile >outfile  [optional parameters]			

 Required Parameters:						 	
 <none>								

 Optional Parameters:							
 FLAGS:								
 niter=1	number of requested iterations				
 anenv=1	=1 for positive analytic envelopes			
		=0 for no analytic envelopes (not recommended)		
 scl=0		=1 to scale output traces (not recommended)		
 plot=3	=0 for no plots. =1 for 1-D plots only			
		=2 for 2-D plots only. =3 for all plots			
 norm=1	=0 not to normalize reliability values			
 verbose=1	=0 not to print processing information			
 rgt=2		=1 for uniform random generator				
		=2 for gaussian random generator			
 sts=1		=0 for no smoothing (not recommended)			

 tmpdir= 	 if non-empty, use the value as a directory path	
		 prefix for storing temporary files; else if the	
	         the CWP_TMPDIR environment variable is set use		
	         its value for the path; else use tmpfile()		

 General Parameters:							
 dx=20		offset sampling interval (m)				
 fx=0	  	offset on first trace (m)				
 dt=0.004	time sampling interval (s)				

 Tau-P Transform Parameters:						
 gopt=1	=1 for parabolic transform. =2 for Foster/Mosher	
		=3 for linear. =4 for absolute value of linear		
 pmin1=-400	minimum moveout at farthest offset for fwd transf(ms)	
 pmax1=400	maximum moveout at farthest offset for fwd transf(ms)	
 pmin2=pmin1	minimum moveout at farthest offset for inv transf(ms)	
 pmax2=pmax1	maximum moveout at farthest offset for inv transf(ms)	
 np=100	number of p-values for taup transform			
 prewhite=0.01	prewhitening value (suggested between 0.1 and 0,01)	
 offref=2000	reference offset for p-values (m)			
 depthref=500	reference depth for Foster/Mosher taup (if gopt=4)	
 pmula=pmax1	maximum p-value preserved in the data (ms)		
 pmulb=pmax1	minimum p-value muted on the data (ms)			
 ninterp=0	number of traces to interpolate in input data		

 Extraction Parameters:						
 nintlh=50	number of intervals (bins) in histograms		
 sditer=5	number of steepest descent iterations to compute ps	
 c=0.04	maximum noise allowed in a sample of signal(%)		
 rel1=0.5	reliability value for first pass of the extraction	
 rel2=0.75	reliability value for second pass of the extraction	

 Smoothing Parameters:							", 
 r1=10		number of points for damped lsq vertical smoothing	
 r2=2		number of points for damped lsq horizontal smoothing	


 Output Files:								
 signal=out_signal 	name of output file for extracted signal	
 noise=out_noise 	name of output file for extracted noise		


 Notes:								
 The signal-noise separation algorithm was developed by Dr. Bill Harlan
 in 1984. It can be used to separate events that can be focused by a	
 linear transformation (signal) from events that can't (noise). The	
 linear transform is whatever is well siuted for the application at	
 hand. Here, only the discrete Radon transform is used, so the program	
 is capable of separating events focused by that transform (linear,	
 parabolic or time-invariantly hyperbolic). Should other transform be	
 required, the changes to the program will be relatively		
 straightforward.							

 The reliability parameter is the most critical one to determine what	
 to extract as signal and what to reject as noise. It should be tested	
 for every dataset. The way to test it is to start with a small value,	
 say 0.1 or 0.01. If too much noise is present in the extracted noise,	
 it is too low. If too much signal was extracted, that is, part of the	
 signal was lost, it is too big. All other parameters have good default
 values and should perhaps not be changed in a first encounter with the
 program. The transform parameters are also critical. They should be	
 chosen such that no aliasing is present and such that the range of	
 interesting slopes is spanned by the transform but not much more. The 
 program suradon.c has more documentation on the transform paramters.	



 Credits:
 	Gabriel Alvarez CWP (1995) 
	Some subroutines are direct translations to C from Fortran versions
 	written by Dr. Bill Harlan (1984)

 References:

 	Harlan, S., Claerbout, J., and Roca, F. (1984), Signal/noise
	separation and velocity estimation, Geophysics, v. 49, no. 11,
	p 1869-1880. 

 	Harlan, S. (1988), Separation of signal and noise applied to
	vertical seismic profiles, Geophysics, v. 53, no. 7,
	p 932-946. 

	Alvarez, G. (1995), Comparison of moveout-based approaches to
	ground roll and multiple suppression, MSc., Department of 
	Geophysics, Colorado School of Mines, (Chapter 3 deals
	exclusively with this method).


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suharlan		= {
		_anenv					=> '',
		_c					=> '',
		_depthref					=> '',
		_dt					=> '',
		_dx					=> '',
		_fx					=> '',
		_gopt					=> '',
		_ninterp					=> '',
		_nintlh					=> '',
		_niter					=> '',
		_noise					=> '',
		_norm					=> '',
		_np					=> '',
		_offref					=> '',
		_plot					=> '',
		_pmax1					=> '',
		_pmax2					=> '',
		_pmin1					=> '',
		_pmin2					=> '',
		_pmula					=> '',
		_pmulb					=> '',
		_prewhite					=> '',
		_r1					=> '',
		_r2					=> '',
		_rel1					=> '',
		_rel2					=> '',
		_rgt					=> '',
		_scl					=> '',
		_sditer					=> '',
		_signal					=> '',
		_sts					=> '',
		_tmpdir					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suharlan->{_Step}     = 'suharlan'.$suharlan->{_Step};
	return ( $suharlan->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suharlan->{_note}     = 'suharlan'.$suharlan->{_note};
	return ( $suharlan->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suharlan->{_anenv}			= '';
		$suharlan->{_c}			= '';
		$suharlan->{_depthref}			= '';
		$suharlan->{_dt}			= '';
		$suharlan->{_dx}			= '';
		$suharlan->{_fx}			= '';
		$suharlan->{_gopt}			= '';
		$suharlan->{_ninterp}			= '';
		$suharlan->{_nintlh}			= '';
		$suharlan->{_niter}			= '';
		$suharlan->{_noise}			= '';
		$suharlan->{_norm}			= '';
		$suharlan->{_np}			= '';
		$suharlan->{_offref}			= '';
		$suharlan->{_plot}			= '';
		$suharlan->{_pmax1}			= '';
		$suharlan->{_pmax2}			= '';
		$suharlan->{_pmin1}			= '';
		$suharlan->{_pmin2}			= '';
		$suharlan->{_pmula}			= '';
		$suharlan->{_pmulb}			= '';
		$suharlan->{_prewhite}			= '';
		$suharlan->{_r1}			= '';
		$suharlan->{_r2}			= '';
		$suharlan->{_rel1}			= '';
		$suharlan->{_rel2}			= '';
		$suharlan->{_rgt}			= '';
		$suharlan->{_scl}			= '';
		$suharlan->{_sditer}			= '';
		$suharlan->{_signal}			= '';
		$suharlan->{_sts}			= '';
		$suharlan->{_tmpdir}			= '';
		$suharlan->{_verbose}			= '';
		$suharlan->{_Step}			= '';
		$suharlan->{_note}			= '';
 }


=head2 sub anenv 


=cut

 sub anenv {

	my ( $self,$anenv )		= @_;
	if ( $anenv ne $empty_string ) {

		$suharlan->{_anenv}		= $anenv;
		$suharlan->{_note}		= $suharlan->{_note}.' anenv='.$suharlan->{_anenv};
		$suharlan->{_Step}		= $suharlan->{_Step}.' anenv='.$suharlan->{_anenv};

	} else { 
		print("suharlan, anenv, missing anenv,\n");
	 }
 }


=head2 sub c 


=cut

 sub c {

	my ( $self,$c )		= @_;
	if ( $c ne $empty_string ) {

		$suharlan->{_c}		= $c;
		$suharlan->{_note}		= $suharlan->{_note}.' c='.$suharlan->{_c};
		$suharlan->{_Step}		= $suharlan->{_Step}.' c='.$suharlan->{_c};

	} else { 
		print("suharlan, c, missing c,\n");
	 }
 }


=head2 sub depthref 


=cut

 sub depthref {

	my ( $self,$depthref )		= @_;
	if ( $depthref ne $empty_string ) {

		$suharlan->{_depthref}		= $depthref;
		$suharlan->{_note}		= $suharlan->{_note}.' depthref='.$suharlan->{_depthref};
		$suharlan->{_Step}		= $suharlan->{_Step}.' depthref='.$suharlan->{_depthref};

	} else { 
		print("suharlan, depthref, missing depthref,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$suharlan->{_dt}		= $dt;
		$suharlan->{_note}		= $suharlan->{_note}.' dt='.$suharlan->{_dt};
		$suharlan->{_Step}		= $suharlan->{_Step}.' dt='.$suharlan->{_dt};

	} else { 
		print("suharlan, dt, missing dt,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$suharlan->{_dx}		= $dx;
		$suharlan->{_note}		= $suharlan->{_note}.' dx='.$suharlan->{_dx};
		$suharlan->{_Step}		= $suharlan->{_Step}.' dx='.$suharlan->{_dx};

	} else { 
		print("suharlan, dx, missing dx,\n");
	 }
 }


=head2 sub fx 


=cut

 sub fx {

	my ( $self,$fx )		= @_;
	if ( $fx ne $empty_string ) {

		$suharlan->{_fx}		= $fx;
		$suharlan->{_note}		= $suharlan->{_note}.' fx='.$suharlan->{_fx};
		$suharlan->{_Step}		= $suharlan->{_Step}.' fx='.$suharlan->{_fx};

	} else { 
		print("suharlan, fx, missing fx,\n");
	 }
 }


=head2 sub gopt 


=cut

 sub gopt {

	my ( $self,$gopt )		= @_;
	if ( $gopt ne $empty_string ) {

		$suharlan->{_gopt}		= $gopt;
		$suharlan->{_note}		= $suharlan->{_note}.' gopt='.$suharlan->{_gopt};
		$suharlan->{_Step}		= $suharlan->{_Step}.' gopt='.$suharlan->{_gopt};

	} else { 
		print("suharlan, gopt, missing gopt,\n");
	 }
 }


=head2 sub ninterp 


=cut

 sub ninterp {

	my ( $self,$ninterp )		= @_;
	if ( $ninterp ne $empty_string ) {

		$suharlan->{_ninterp}		= $ninterp;
		$suharlan->{_note}		= $suharlan->{_note}.' ninterp='.$suharlan->{_ninterp};
		$suharlan->{_Step}		= $suharlan->{_Step}.' ninterp='.$suharlan->{_ninterp};

	} else { 
		print("suharlan, ninterp, missing ninterp,\n");
	 }
 }


=head2 sub nintlh 


=cut

 sub nintlh {

	my ( $self,$nintlh )		= @_;
	if ( $nintlh ne $empty_string ) {

		$suharlan->{_nintlh}		= $nintlh;
		$suharlan->{_note}		= $suharlan->{_note}.' nintlh='.$suharlan->{_nintlh};
		$suharlan->{_Step}		= $suharlan->{_Step}.' nintlh='.$suharlan->{_nintlh};

	} else { 
		print("suharlan, nintlh, missing nintlh,\n");
	 }
 }


=head2 sub niter 


=cut

 sub niter {

	my ( $self,$niter )		= @_;
	if ( $niter ne $empty_string ) {

		$suharlan->{_niter}		= $niter;
		$suharlan->{_note}		= $suharlan->{_note}.' niter='.$suharlan->{_niter};
		$suharlan->{_Step}		= $suharlan->{_Step}.' niter='.$suharlan->{_niter};

	} else { 
		print("suharlan, niter, missing niter,\n");
	 }
 }


=head2 sub noise 


=cut

 sub noise {

	my ( $self,$noise )		= @_;
	if ( $noise ne $empty_string ) {

		$suharlan->{_noise}		= $noise;
		$suharlan->{_note}		= $suharlan->{_note}.' noise='.$suharlan->{_noise};
		$suharlan->{_Step}		= $suharlan->{_Step}.' noise='.$suharlan->{_noise};

	} else { 
		print("suharlan, noise, missing noise,\n");
	 }
 }


=head2 sub norm 


=cut

 sub norm {

	my ( $self,$norm )		= @_;
	if ( $norm ne $empty_string ) {

		$suharlan->{_norm}		= $norm;
		$suharlan->{_note}		= $suharlan->{_note}.' norm='.$suharlan->{_norm};
		$suharlan->{_Step}		= $suharlan->{_Step}.' norm='.$suharlan->{_norm};

	} else { 
		print("suharlan, norm, missing norm,\n");
	 }
 }


=head2 sub np 


=cut

 sub np {

	my ( $self,$np )		= @_;
	if ( $np ne $empty_string ) {

		$suharlan->{_np}		= $np;
		$suharlan->{_note}		= $suharlan->{_note}.' np='.$suharlan->{_np};
		$suharlan->{_Step}		= $suharlan->{_Step}.' np='.$suharlan->{_np};

	} else { 
		print("suharlan, np, missing np,\n");
	 }
 }


=head2 sub offref 


=cut

 sub offref {

	my ( $self,$offref )		= @_;
	if ( $offref ne $empty_string ) {

		$suharlan->{_offref}		= $offref;
		$suharlan->{_note}		= $suharlan->{_note}.' offref='.$suharlan->{_offref};
		$suharlan->{_Step}		= $suharlan->{_Step}.' offref='.$suharlan->{_offref};

	} else { 
		print("suharlan, offref, missing offref,\n");
	 }
 }


=head2 sub plot 


=cut

 sub plot {

	my ( $self,$plot )		= @_;
	if ( $plot ne $empty_string ) {

		$suharlan->{_plot}		= $plot;
		$suharlan->{_note}		= $suharlan->{_note}.' plot='.$suharlan->{_plot};
		$suharlan->{_Step}		= $suharlan->{_Step}.' plot='.$suharlan->{_plot};

	} else { 
		print("suharlan, plot, missing plot,\n");
	 }
 }


=head2 sub pmax1 


=cut

 sub pmax1 {

	my ( $self,$pmax1 )		= @_;
	if ( $pmax1 ne $empty_string ) {

		$suharlan->{_pmax1}		= $pmax1;
		$suharlan->{_note}		= $suharlan->{_note}.' pmax1='.$suharlan->{_pmax1};
		$suharlan->{_Step}		= $suharlan->{_Step}.' pmax1='.$suharlan->{_pmax1};

	} else { 
		print("suharlan, pmax1, missing pmax1,\n");
	 }
 }


=head2 sub pmax2 


=cut

 sub pmax2 {

	my ( $self,$pmax2 )		= @_;
	if ( $pmax2 ne $empty_string ) {

		$suharlan->{_pmax2}		= $pmax2;
		$suharlan->{_note}		= $suharlan->{_note}.' pmax2='.$suharlan->{_pmax2};
		$suharlan->{_Step}		= $suharlan->{_Step}.' pmax2='.$suharlan->{_pmax2};

	} else { 
		print("suharlan, pmax2, missing pmax2,\n");
	 }
 }


=head2 sub pmin1 


=cut

 sub pmin1 {

	my ( $self,$pmin1 )		= @_;
	if ( $pmin1 ne $empty_string ) {

		$suharlan->{_pmin1}		= $pmin1;
		$suharlan->{_note}		= $suharlan->{_note}.' pmin1='.$suharlan->{_pmin1};
		$suharlan->{_Step}		= $suharlan->{_Step}.' pmin1='.$suharlan->{_pmin1};

	} else { 
		print("suharlan, pmin1, missing pmin1,\n");
	 }
 }


=head2 sub pmin2 


=cut

 sub pmin2 {

	my ( $self,$pmin2 )		= @_;
	if ( $pmin2 ne $empty_string ) {

		$suharlan->{_pmin2}		= $pmin2;
		$suharlan->{_note}		= $suharlan->{_note}.' pmin2='.$suharlan->{_pmin2};
		$suharlan->{_Step}		= $suharlan->{_Step}.' pmin2='.$suharlan->{_pmin2};

	} else { 
		print("suharlan, pmin2, missing pmin2,\n");
	 }
 }


=head2 sub pmula 


=cut

 sub pmula {

	my ( $self,$pmula )		= @_;
	if ( $pmula ne $empty_string ) {

		$suharlan->{_pmula}		= $pmula;
		$suharlan->{_note}		= $suharlan->{_note}.' pmula='.$suharlan->{_pmula};
		$suharlan->{_Step}		= $suharlan->{_Step}.' pmula='.$suharlan->{_pmula};

	} else { 
		print("suharlan, pmula, missing pmula,\n");
	 }
 }


=head2 sub pmulb 


=cut

 sub pmulb {

	my ( $self,$pmulb )		= @_;
	if ( $pmulb ne $empty_string ) {

		$suharlan->{_pmulb}		= $pmulb;
		$suharlan->{_note}		= $suharlan->{_note}.' pmulb='.$suharlan->{_pmulb};
		$suharlan->{_Step}		= $suharlan->{_Step}.' pmulb='.$suharlan->{_pmulb};

	} else { 
		print("suharlan, pmulb, missing pmulb,\n");
	 }
 }


=head2 sub prewhite 


=cut

 sub prewhite {

	my ( $self,$prewhite )		= @_;
	if ( $prewhite ne $empty_string ) {

		$suharlan->{_prewhite}		= $prewhite;
		$suharlan->{_note}		= $suharlan->{_note}.' prewhite='.$suharlan->{_prewhite};
		$suharlan->{_Step}		= $suharlan->{_Step}.' prewhite='.$suharlan->{_prewhite};

	} else { 
		print("suharlan, prewhite, missing prewhite,\n");
	 }
 }


=head2 sub r1 


=cut

 sub r1 {

	my ( $self,$r1 )		= @_;
	if ( $r1 ne $empty_string ) {

		$suharlan->{_r1}		= $r1;
		$suharlan->{_note}		= $suharlan->{_note}.' r1='.$suharlan->{_r1};
		$suharlan->{_Step}		= $suharlan->{_Step}.' r1='.$suharlan->{_r1};

	} else { 
		print("suharlan, r1, missing r1,\n");
	 }
 }


=head2 sub r2 


=cut

 sub r2 {

	my ( $self,$r2 )		= @_;
	if ( $r2 ne $empty_string ) {

		$suharlan->{_r2}		= $r2;
		$suharlan->{_note}		= $suharlan->{_note}.' r2='.$suharlan->{_r2};
		$suharlan->{_Step}		= $suharlan->{_Step}.' r2='.$suharlan->{_r2};

	} else { 
		print("suharlan, r2, missing r2,\n");
	 }
 }


=head2 sub rel1 


=cut

 sub rel1 {

	my ( $self,$rel1 )		= @_;
	if ( $rel1 ne $empty_string ) {

		$suharlan->{_rel1}		= $rel1;
		$suharlan->{_note}		= $suharlan->{_note}.' rel1='.$suharlan->{_rel1};
		$suharlan->{_Step}		= $suharlan->{_Step}.' rel1='.$suharlan->{_rel1};

	} else { 
		print("suharlan, rel1, missing rel1,\n");
	 }
 }


=head2 sub rel2 


=cut

 sub rel2 {

	my ( $self,$rel2 )		= @_;
	if ( $rel2 ne $empty_string ) {

		$suharlan->{_rel2}		= $rel2;
		$suharlan->{_note}		= $suharlan->{_note}.' rel2='.$suharlan->{_rel2};
		$suharlan->{_Step}		= $suharlan->{_Step}.' rel2='.$suharlan->{_rel2};

	} else { 
		print("suharlan, rel2, missing rel2,\n");
	 }
 }


=head2 sub rgt 


=cut

 sub rgt {

	my ( $self,$rgt )		= @_;
	if ( $rgt ne $empty_string ) {

		$suharlan->{_rgt}		= $rgt;
		$suharlan->{_note}		= $suharlan->{_note}.' rgt='.$suharlan->{_rgt};
		$suharlan->{_Step}		= $suharlan->{_Step}.' rgt='.$suharlan->{_rgt};

	} else { 
		print("suharlan, rgt, missing rgt,\n");
	 }
 }


=head2 sub scl 


=cut

 sub scl {

	my ( $self,$scl )		= @_;
	if ( $scl ne $empty_string ) {

		$suharlan->{_scl}		= $scl;
		$suharlan->{_note}		= $suharlan->{_note}.' scl='.$suharlan->{_scl};
		$suharlan->{_Step}		= $suharlan->{_Step}.' scl='.$suharlan->{_scl};

	} else { 
		print("suharlan, scl, missing scl,\n");
	 }
 }


=head2 sub sditer 


=cut

 sub sditer {

	my ( $self,$sditer )		= @_;
	if ( $sditer ne $empty_string ) {

		$suharlan->{_sditer}		= $sditer;
		$suharlan->{_note}		= $suharlan->{_note}.' sditer='.$suharlan->{_sditer};
		$suharlan->{_Step}		= $suharlan->{_Step}.' sditer='.$suharlan->{_sditer};

	} else { 
		print("suharlan, sditer, missing sditer,\n");
	 }
 }


=head2 sub signal 


=cut

 sub signal {

	my ( $self,$signal )		= @_;
	if ( $signal ne $empty_string ) {

		$suharlan->{_signal}		= $signal;
		$suharlan->{_note}		= $suharlan->{_note}.' signal='.$suharlan->{_signal};
		$suharlan->{_Step}		= $suharlan->{_Step}.' signal='.$suharlan->{_signal};

	} else { 
		print("suharlan, signal, missing signal,\n");
	 }
 }


=head2 sub sts 


=cut

 sub sts {

	my ( $self,$sts )		= @_;
	if ( $sts ne $empty_string ) {

		$suharlan->{_sts}		= $sts;
		$suharlan->{_note}		= $suharlan->{_note}.' sts='.$suharlan->{_sts};
		$suharlan->{_Step}		= $suharlan->{_Step}.' sts='.$suharlan->{_sts};

	} else { 
		print("suharlan, sts, missing sts,\n");
	 }
 }


=head2 sub tmpdir 


=cut

 sub tmpdir {

	my ( $self,$tmpdir )		= @_;
	if ( $tmpdir ne $empty_string ) {

		$suharlan->{_tmpdir}		= $tmpdir;
		$suharlan->{_note}		= $suharlan->{_note}.' tmpdir='.$suharlan->{_tmpdir};
		$suharlan->{_Step}		= $suharlan->{_Step}.' tmpdir='.$suharlan->{_tmpdir};

	} else { 
		print("suharlan, tmpdir, missing tmpdir,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suharlan->{_verbose}		= $verbose;
		$suharlan->{_note}		= $suharlan->{_note}.' verbose='.$suharlan->{_verbose};
		$suharlan->{_Step}		= $suharlan->{_Step}.' verbose='.$suharlan->{_verbose};

	} else { 
		print("suharlan, verbose, missing verbose,\n");
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