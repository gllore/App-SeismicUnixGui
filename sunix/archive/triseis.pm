 package triseis;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  TRISEIS - Gaussian beam synthetic seismograms for a sloth model	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 TRISEIS - Gaussian beam synthetic seismograms for a sloth model	

  triseis <modelfile >seisfile xs= zs= xg= zg= [optional parameters]	

 Required Parameters:							
 xs=            x coordinates of source surface			
 zs=            z coordinates of source surface			
 xg=            x coordinates of receiver surface			
 zg=            z coordinates of receiver surface			

 Optional Parameters:							
 ns=1           number of sources uniformly distributed along s surface
 ds=            increment between source locations (see notes below)	
 fs=0.0         first source location (relative to start of s surface)	
 ng=101         number of receivers uniformly distributed along g surface
 dg=            increment between receiver locations (see notes below)	
 fg=0.0         first receiver location (relative to start of g surface)
 dgds=0.0       change in receiver location with respect to source location
 krecord=1      integer index of receiver surface (see notes below)	
 kreflect=-1    integer index of reflecting surface (see notes below)	
 prim           =1, only single-reflected rays are considered 		",     
                =0, only direct hits are considered  			
 bw=0           beamwidth at peak frequency				
 nt=251         number of time samples					
 dt=0.004       time sampling interval					
 ft=0.0         first time sample					
 nangle=101     number of ray takeoff angles				
 fangle=-45     first ray takeoff angle (in degrees)			
 langle=45      last ray takeoff angle (in degrees)			
 reftrans=0     =1 complex refl/transm. coefficients considered 	
 atten=0        =1 add noncausal attenuation 				
                =2 add causal attenuation 				
 lscale=        if defined restricts range of extrapolation		
 fpeak=0.1/dt   peak frequency of ricker wavelet 			
 aperture=      maximum angle of receiver aperture 			

 NOTES:								
 Only rays that terminate with index krecord will contribute to the	
 synthetic seismograms at the receiver (xg,zg) locations.  The		
 source and receiver locations are determined by cubic spline		
 interpolation of the specified (xs,zs) and (xg,zg) coordinates.	
 The default source location increment (ds) is determined to span	
 the source surface defined by (xs,zs).  Likewise for dg.		



 AUTHOR:  Dave Hale, Colorado School of Mines, 02/09/91
 MODIFIED:  Andreas Rueger, Colorado School of Mines, 08/18/93
	Modifications include: 2.5-D amplitudes, correction for ref/transm,
			timewindow, lscale, aperture, beam width, etc.

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $triseis		= {
		_aperture					=> '',
		_atten					=> '',
		_bw					=> '',
		_dg					=> '',
		_dgds					=> '',
		_ds					=> '',
		_dt					=> '',
		_fangle					=> '',
		_fg					=> '',
		_fpeak					=> '',
		_fs					=> '',
		_ft					=> '',
		_krecord					=> '',
		_kreflect					=> '',
		_langle					=> '',
		_lscale					=> '',
		_nangle					=> '',
		_ng					=> '',
		_ns					=> '',
		_nt					=> '',
		_prim					=> '',
		_reftrans					=> '',
		_xg					=> '',
		_xs					=> '',
		_zg					=> '',
		_zs					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$triseis->{_Step}     = 'triseis'.$triseis->{_Step};
	return ( $triseis->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$triseis->{_note}     = 'triseis'.$triseis->{_note};
	return ( $triseis->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$triseis->{_aperture}			= '';
		$triseis->{_atten}			= '';
		$triseis->{_bw}			= '';
		$triseis->{_dg}			= '';
		$triseis->{_dgds}			= '';
		$triseis->{_ds}			= '';
		$triseis->{_dt}			= '';
		$triseis->{_fangle}			= '';
		$triseis->{_fg}			= '';
		$triseis->{_fpeak}			= '';
		$triseis->{_fs}			= '';
		$triseis->{_ft}			= '';
		$triseis->{_krecord}			= '';
		$triseis->{_kreflect}			= '';
		$triseis->{_langle}			= '';
		$triseis->{_lscale}			= '';
		$triseis->{_nangle}			= '';
		$triseis->{_ng}			= '';
		$triseis->{_ns}			= '';
		$triseis->{_nt}			= '';
		$triseis->{_prim}			= '';
		$triseis->{_reftrans}			= '';
		$triseis->{_xg}			= '';
		$triseis->{_xs}			= '';
		$triseis->{_zg}			= '';
		$triseis->{_zs}			= '';
		$triseis->{_Step}			= '';
		$triseis->{_note}			= '';
 }


=head2 sub aperture 


=cut

 sub aperture {

	my ( $self,$aperture )		= @_;
	if ( $aperture ne $empty_string ) {

		$triseis->{_aperture}		= $aperture;
		$triseis->{_note}		= $triseis->{_note}.' aperture='.$triseis->{_aperture};
		$triseis->{_Step}		= $triseis->{_Step}.' aperture='.$triseis->{_aperture};

	} else { 
		print("triseis, aperture, missing aperture,\n");
	 }
 }


=head2 sub atten 


=cut

 sub atten {

	my ( $self,$atten )		= @_;
	if ( $atten ne $empty_string ) {

		$triseis->{_atten}		= $atten;
		$triseis->{_note}		= $triseis->{_note}.' atten='.$triseis->{_atten};
		$triseis->{_Step}		= $triseis->{_Step}.' atten='.$triseis->{_atten};

	} else { 
		print("triseis, atten, missing atten,\n");
	 }
 }


=head2 sub bw 


=cut

 sub bw {

	my ( $self,$bw )		= @_;
	if ( $bw ne $empty_string ) {

		$triseis->{_bw}		= $bw;
		$triseis->{_note}		= $triseis->{_note}.' bw='.$triseis->{_bw};
		$triseis->{_Step}		= $triseis->{_Step}.' bw='.$triseis->{_bw};

	} else { 
		print("triseis, bw, missing bw,\n");
	 }
 }


=head2 sub dg 


=cut

 sub dg {

	my ( $self,$dg )		= @_;
	if ( $dg ne $empty_string ) {

		$triseis->{_dg}		= $dg;
		$triseis->{_note}		= $triseis->{_note}.' dg='.$triseis->{_dg};
		$triseis->{_Step}		= $triseis->{_Step}.' dg='.$triseis->{_dg};

	} else { 
		print("triseis, dg, missing dg,\n");
	 }
 }


=head2 sub dgds 


=cut

 sub dgds {

	my ( $self,$dgds )		= @_;
	if ( $dgds ne $empty_string ) {

		$triseis->{_dgds}		= $dgds;
		$triseis->{_note}		= $triseis->{_note}.' dgds='.$triseis->{_dgds};
		$triseis->{_Step}		= $triseis->{_Step}.' dgds='.$triseis->{_dgds};

	} else { 
		print("triseis, dgds, missing dgds,\n");
	 }
 }


=head2 sub ds 


=cut

 sub ds {

	my ( $self,$ds )		= @_;
	if ( $ds ne $empty_string ) {

		$triseis->{_ds}		= $ds;
		$triseis->{_note}		= $triseis->{_note}.' ds='.$triseis->{_ds};
		$triseis->{_Step}		= $triseis->{_Step}.' ds='.$triseis->{_ds};

	} else { 
		print("triseis, ds, missing ds,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$triseis->{_dt}		= $dt;
		$triseis->{_note}		= $triseis->{_note}.' dt='.$triseis->{_dt};
		$triseis->{_Step}		= $triseis->{_Step}.' dt='.$triseis->{_dt};

	} else { 
		print("triseis, dt, missing dt,\n");
	 }
 }


=head2 sub fangle 


=cut

 sub fangle {

	my ( $self,$fangle )		= @_;
	if ( $fangle ne $empty_string ) {

		$triseis->{_fangle}		= $fangle;
		$triseis->{_note}		= $triseis->{_note}.' fangle='.$triseis->{_fangle};
		$triseis->{_Step}		= $triseis->{_Step}.' fangle='.$triseis->{_fangle};

	} else { 
		print("triseis, fangle, missing fangle,\n");
	 }
 }


=head2 sub fg 


=cut

 sub fg {

	my ( $self,$fg )		= @_;
	if ( $fg ne $empty_string ) {

		$triseis->{_fg}		= $fg;
		$triseis->{_note}		= $triseis->{_note}.' fg='.$triseis->{_fg};
		$triseis->{_Step}		= $triseis->{_Step}.' fg='.$triseis->{_fg};

	} else { 
		print("triseis, fg, missing fg,\n");
	 }
 }


=head2 sub fpeak 


=cut

 sub fpeak {

	my ( $self,$fpeak )		= @_;
	if ( $fpeak ne $empty_string ) {

		$triseis->{_fpeak}		= $fpeak;
		$triseis->{_note}		= $triseis->{_note}.' fpeak='.$triseis->{_fpeak};
		$triseis->{_Step}		= $triseis->{_Step}.' fpeak='.$triseis->{_fpeak};

	} else { 
		print("triseis, fpeak, missing fpeak,\n");
	 }
 }


=head2 sub fs 


=cut

 sub fs {

	my ( $self,$fs )		= @_;
	if ( $fs ne $empty_string ) {

		$triseis->{_fs}		= $fs;
		$triseis->{_note}		= $triseis->{_note}.' fs='.$triseis->{_fs};
		$triseis->{_Step}		= $triseis->{_Step}.' fs='.$triseis->{_fs};

	} else { 
		print("triseis, fs, missing fs,\n");
	 }
 }


=head2 sub ft 


=cut

 sub ft {

	my ( $self,$ft )		= @_;
	if ( $ft ne $empty_string ) {

		$triseis->{_ft}		= $ft;
		$triseis->{_note}		= $triseis->{_note}.' ft='.$triseis->{_ft};
		$triseis->{_Step}		= $triseis->{_Step}.' ft='.$triseis->{_ft};

	} else { 
		print("triseis, ft, missing ft,\n");
	 }
 }


=head2 sub krecord 


=cut

 sub krecord {

	my ( $self,$krecord )		= @_;
	if ( $krecord ne $empty_string ) {

		$triseis->{_krecord}		= $krecord;
		$triseis->{_note}		= $triseis->{_note}.' krecord='.$triseis->{_krecord};
		$triseis->{_Step}		= $triseis->{_Step}.' krecord='.$triseis->{_krecord};

	} else { 
		print("triseis, krecord, missing krecord,\n");
	 }
 }


=head2 sub kreflect 


=cut

 sub kreflect {

	my ( $self,$kreflect )		= @_;
	if ( $kreflect ne $empty_string ) {

		$triseis->{_kreflect}		= $kreflect;
		$triseis->{_note}		= $triseis->{_note}.' kreflect='.$triseis->{_kreflect};
		$triseis->{_Step}		= $triseis->{_Step}.' kreflect='.$triseis->{_kreflect};

	} else { 
		print("triseis, kreflect, missing kreflect,\n");
	 }
 }


=head2 sub langle 


=cut

 sub langle {

	my ( $self,$langle )		= @_;
	if ( $langle ne $empty_string ) {

		$triseis->{_langle}		= $langle;
		$triseis->{_note}		= $triseis->{_note}.' langle='.$triseis->{_langle};
		$triseis->{_Step}		= $triseis->{_Step}.' langle='.$triseis->{_langle};

	} else { 
		print("triseis, langle, missing langle,\n");
	 }
 }


=head2 sub lscale 


=cut

 sub lscale {

	my ( $self,$lscale )		= @_;
	if ( $lscale ne $empty_string ) {

		$triseis->{_lscale}		= $lscale;
		$triseis->{_note}		= $triseis->{_note}.' lscale='.$triseis->{_lscale};
		$triseis->{_Step}		= $triseis->{_Step}.' lscale='.$triseis->{_lscale};

	} else { 
		print("triseis, lscale, missing lscale,\n");
	 }
 }


=head2 sub nangle 


=cut

 sub nangle {

	my ( $self,$nangle )		= @_;
	if ( $nangle ne $empty_string ) {

		$triseis->{_nangle}		= $nangle;
		$triseis->{_note}		= $triseis->{_note}.' nangle='.$triseis->{_nangle};
		$triseis->{_Step}		= $triseis->{_Step}.' nangle='.$triseis->{_nangle};

	} else { 
		print("triseis, nangle, missing nangle,\n");
	 }
 }


=head2 sub ng 


=cut

 sub ng {

	my ( $self,$ng )		= @_;
	if ( $ng ne $empty_string ) {

		$triseis->{_ng}		= $ng;
		$triseis->{_note}		= $triseis->{_note}.' ng='.$triseis->{_ng};
		$triseis->{_Step}		= $triseis->{_Step}.' ng='.$triseis->{_ng};

	} else { 
		print("triseis, ng, missing ng,\n");
	 }
 }


=head2 sub ns 


=cut

 sub ns {

	my ( $self,$ns )		= @_;
	if ( $ns ne $empty_string ) {

		$triseis->{_ns}		= $ns;
		$triseis->{_note}		= $triseis->{_note}.' ns='.$triseis->{_ns};
		$triseis->{_Step}		= $triseis->{_Step}.' ns='.$triseis->{_ns};

	} else { 
		print("triseis, ns, missing ns,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$triseis->{_nt}		= $nt;
		$triseis->{_note}		= $triseis->{_note}.' nt='.$triseis->{_nt};
		$triseis->{_Step}		= $triseis->{_Step}.' nt='.$triseis->{_nt};

	} else { 
		print("triseis, nt, missing nt,\n");
	 }
 }


=head2 sub prim 


=cut

 sub prim {

	my ( $self,$prim )		= @_;
	if ( $prim ne $empty_string ) {

		$triseis->{_prim}		= $prim;
		$triseis->{_note}		= $triseis->{_note}.' prim='.$triseis->{_prim};
		$triseis->{_Step}		= $triseis->{_Step}.' prim='.$triseis->{_prim};

	} else { 
		print("triseis, prim, missing prim,\n");
	 }
 }


=head2 sub reftrans 


=cut

 sub reftrans {

	my ( $self,$reftrans )		= @_;
	if ( $reftrans ne $empty_string ) {

		$triseis->{_reftrans}		= $reftrans;
		$triseis->{_note}		= $triseis->{_note}.' reftrans='.$triseis->{_reftrans};
		$triseis->{_Step}		= $triseis->{_Step}.' reftrans='.$triseis->{_reftrans};

	} else { 
		print("triseis, reftrans, missing reftrans,\n");
	 }
 }


=head2 sub xg 


=cut

 sub xg {

	my ( $self,$xg )		= @_;
	if ( $xg ne $empty_string ) {

		$triseis->{_xg}		= $xg;
		$triseis->{_note}		= $triseis->{_note}.' xg='.$triseis->{_xg};
		$triseis->{_Step}		= $triseis->{_Step}.' xg='.$triseis->{_xg};

	} else { 
		print("triseis, xg, missing xg,\n");
	 }
 }


=head2 sub xs 


=cut

 sub xs {

	my ( $self,$xs )		= @_;
	if ( $xs ne $empty_string ) {

		$triseis->{_xs}		= $xs;
		$triseis->{_note}		= $triseis->{_note}.' xs='.$triseis->{_xs};
		$triseis->{_Step}		= $triseis->{_Step}.' xs='.$triseis->{_xs};

	} else { 
		print("triseis, xs, missing xs,\n");
	 }
 }


=head2 sub zg 


=cut

 sub zg {

	my ( $self,$zg )		= @_;
	if ( $zg ne $empty_string ) {

		$triseis->{_zg}		= $zg;
		$triseis->{_note}		= $triseis->{_note}.' zg='.$triseis->{_zg};
		$triseis->{_Step}		= $triseis->{_Step}.' zg='.$triseis->{_zg};

	} else { 
		print("triseis, zg, missing zg,\n");
	 }
 }


=head2 sub zs 


=cut

 sub zs {

	my ( $self,$zs )		= @_;
	if ( $zs ne $empty_string ) {

		$triseis->{_zs}		= $zs;
		$triseis->{_note}		= $triseis->{_note}.' zs='.$triseis->{_zs};
		$triseis->{_Step}		= $triseis->{_Step}.' zs='.$triseis->{_zs};

	} else { 
		print("triseis, zs, missing zs,\n");
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