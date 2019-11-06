 package linrort;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  LINRORT - linearized P-P, P-S1 and P-S2 reflection coefficients 	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 LINRORT - linearized P-P, P-S1 and P-S2 reflection coefficients 	
		for a horizontal interface separating two of any of the	
		following halfspaces: ISOTROPIC, VTI, HTI and ORTHORHOMBIC. 

   linrort [optional parameters]					

 hspace1=ISO	medium type of the incidence halfspace:		 	
		=ISO ... isotropic					
		=VTI ... VTI anisotropy				 	
		=HTI ... HTI anisotropy				 	
		=ORT ... ORTHORHOMBIC anisotropy			
 for ISO:								
 vp1=2	 	P-wave velocity, halfspace1				
 vs1=1		S-wave velocity, halfspace1				
 rho1=2.7	density, halfspace1					

 for VTI:								
 vp1=2		P-wave vertical velocity (V33), halfspace1		
 vs1=1		S-wave vertical velocity (V44=V55), halfspace1		
 rho1=2.7	density, halfspace1					
 eps1=0	Thomsen's generic epsilon, halfspace1			
 delta1=0	Thomsen's generic delta, halfspace1			
 gamma1=0	Thomsen's generic gamma, halfspace1			", 

 for HTI:								
 vp1=2	 P-wave vertical velocity (V33), halfspace1			
 vs1=1	 "fast" S-wave vertical velocity (V44), halfspace1		
 rho1=2.7	density, halfspace1					
 eps1_v=0	Tsvankin's "vertical" epsilon, halfspace1		
 delta1_v=0	Tsvankin's "vertical" delta, halfspace1		
 gamma1_v=0	Tsvankin's "vertical" gamma, halfspace1		",	

 for ORT:								
 vp1=2		P-wave vertical velocity (V33), halfspace1		
 vs1=1	 x2-polarized S-wave vertical velocity (V44), halfspace1 	
 rho1=2.7	density, halfspace1					
 eps1_1=0	Tsvankin's epsilon in [x2,x3] plane, halfspace1	 	
 delta1_1=0	Tsvankin's delta in [x2,x3] plane, halfspace1		
 gamma1_1=0	Tsvankin's gamma in [x2,x3] plane, halfspace1	  	
 eps1_2=0	Tsvankin's epsilon in [x1,x3] plane, halfspace1		
 delta1_2=0	Tsvankin's delta in [x1,x3] plane, halfspace1		
 gamma1_2=0	Tsvankin's gamma in [x1,x3] plane, halfspace1	  	
 delta1_3=0	Tsvankin's delta in [x1,x2] plane, halfspace1		

 hspace2=ISO	medium type of the reflecting halfspace (the same	
		convention as above)					

 medium parameters of the 2nd halfspace follow the same convention	
 as above:								

 vp2=2.5		 vs2=1.2		rho2=3.0		
 eps2=0		  delta2=0					
 eps2_v=0		delta2_v=0		gamma2_v=0		
 eps2_1=0		delta2_1=0		gamma2_1=0		
 eps2_2=0		delta2_2=0		gamma2_2=0		
 delta2_3=0								

	(note you do not need "gamma2" parameter for evaluation	
	of weak-anisotropy reflection coefficients)			

 a_file=-1	the string '-1' ... incidence and azimuth angles are	
		generated automatically using the setup values below	
		a_file=file_name ... incidence and azimuth angles are	
		read from a file "file_name"; the program expects a	
		file of two columns [inc. angle, azimuth]		

 in the case of a_file=-1:						
 fangle=0	first incidence phase angle				
 langle=30	last incidence angle					
 dangle=1	incidence angle increment				
 fazim=0	first azimuth (in deg)				  	
 lazim=0	last azimuth  (in deg)				  	
 dazim=1	azimuth increment (in deg)				

 kappa=0.	azimuthal rotation of the lower halfspace2 (e.t. a	
		symmetry axis plane for HTI, or a symmetry plane for	
		ORTHORHOMBIC) with respect to the x1-axis		

 out_inf=info.out	information output file				
 out_P=Rpp.out	file with Rpp reflection coefficients			
 out_S=Rps.out	file with Rps reflection coefficients			
 out_SVSH=Rsvsh.out  file with SV and SH projections of reflection	
			coefficients					
 out_Error=error.out file containing error estimates evaluated during  
			the computation of the reflection coefficients;	


 Output:								
 out_P:								
 inc. phase angle, azimuth, reflection coefficient; for a_file=-1, the 
 inc. angle is the fast dimension					
 out_S:								
 inc. phase angle, azimuth, Rps1, Rps2, cos(PHI), sin(PHI); for	
 a_file=-1, the inc. angle is the fast dimension			", 
 out_SVSH:								
 inc. phase angle, azimuth, Rsv, Rsh, cos(PHI), sin(PHI); for	  
 a_file=-1, the inc. angle is the fast dimension			
 out_Error:								
 error estimates of Rpp, Rpsv and Rpsh approximations; global error is 
 analysed as well as partial contributions to the error due to the	
 isotropic velocity contrasts, and due to anisotropic  upper and lower 
 halfspaces. The error file is self-explanatory, see also descriptions 
 of subroutines P_err_2nd_order, SV_err_2nd_order and SH_err_2nd_order.


 Adopted Convention:							

 The right-hand Cartesian coordinate system with the x3-axis pointing  
 upward has been chosen. The upper halfspace (halfspace1)		
 contains the incident P-wave. Incidence angles can vary from <0,PI/2),
 azimuths are unlimited, +azimuth sense counted from x1->x2 axes	
 (azimuth=0 corresponds to the direction of x1-axis). In the current	
 version, the coordinate system is attached to the halfspace1 (e.t.	
 the symmetry axis plane of HTI halfspace1, or one of symmetry planes  
 of ORTHORHOMBIC halfspace1, is aligned with the x1-axis), however, the
 halfspace2 can be arbitrarily rotated along the x3-axis with respect  
 to the halfspace1. The positive weak-anisotropy polarization of the	
 reflected P-P wave (e.t. positive P-P reflection coefficient) is close
 to the direction of isotropic slowness vector of the wave (pointing	
 outward the interface). Similarly, weak-anisotropy S-wave reflection  
 coefficients are described in terms of "SV" and "SH" isotropic	
 polarizations, "SV" and "SH" being unit vectors in the plane	
 perpendicular to the isotropic slowness vector. Then, the positive	
 "SV" polarization vector lies in the incidence plane and points	
 towards the interface, and positive "SH" polarization vector is	
 perpendicular to the incidence plane, aligned with the positive	
 x2-axis, if azimuth=0. Rotation angle "PHI", characterizing a	
 rotation of "the best projection" of the S1-wave polarization	
 vector in the isotropic SV-SH plane in the incidence halfspace1, is	
 counted in the positive sense from "SV" axis (PHI=0) towards the	
 "SH" axis (PHI=PI/2). Of course, S2 is perpendicular to S1, and	
 the projection of S1 and S2 polarizations onto the SV-SH plane	
 coincides with SV and SH directions, respectively, for PHI=0.		

 The units for velocities are km/s, angles I/O are in degrees		

 Additional Notes:							
	The coefficients are computed as functions of phase incidence	
	angle and azimuth (determined by the incidence slowness vector).
	Vertical symmetry planes of the HTI and				
	ORTHORHOMBIC halfspaces can be arbitrarily rotated along the	
	x3-axis. The linearization is based on the assumption of weak	", 
	contrast in elastic medium parameters across the interface,	
	and the assumption of weak anisotropy in both halfspaces.	
	See the "Adopted Convention" paragraph below for a proper	
	input.								


 
  Author: Petr Jilek, CSM-CWP, December 1999.


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $linrort		= {
		_PHI					=> '',
		_a_file					=> '',
		_azimuth					=> '',
		_dangle					=> '',
		_dazim					=> '',
		_delta1					=> '',
		_delta1_1					=> '',
		_delta1_2					=> '',
		_delta1_3					=> '',
		_delta1_v					=> '',
		_delta2_3					=> '',
		_eps1					=> '',
		_eps1_1					=> '',
		_eps1_2					=> '',
		_eps1_v					=> '',
		_eps2					=> '',
		_eps2_1					=> '',
		_eps2_2					=> '',
		_eps2_v					=> '',
		_fangle					=> '',
		_fazim					=> '',
		_gamma1					=> '',
		_gamma1_1					=> '',
		_gamma1_2					=> '',
		_gamma1_v					=> '',
		_hspace1					=> '',
		_hspace2					=> '',
		_kappa					=> '',
		_langle					=> '',
		_lazim					=> '',
		_out_Error					=> '',
		_out_P					=> '',
		_out_S					=> '',
		_out_SVSH					=> '',
		_out_inf					=> '',
		_rho1					=> '',
		_vp1					=> '',
		_vp2					=> '',
		_vs1					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$linrort->{_Step}     = 'linrort'.$linrort->{_Step};
	return ( $linrort->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$linrort->{_note}     = 'linrort'.$linrort->{_note};
	return ( $linrort->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$linrort->{_PHI}			= '';
		$linrort->{_a_file}			= '';
		$linrort->{_azimuth}			= '';
		$linrort->{_dangle}			= '';
		$linrort->{_dazim}			= '';
		$linrort->{_delta1}			= '';
		$linrort->{_delta1_1}			= '';
		$linrort->{_delta1_2}			= '';
		$linrort->{_delta1_3}			= '';
		$linrort->{_delta1_v}			= '';
		$linrort->{_delta2_3}			= '';
		$linrort->{_eps1}			= '';
		$linrort->{_eps1_1}			= '';
		$linrort->{_eps1_2}			= '';
		$linrort->{_eps1_v}			= '';
		$linrort->{_eps2}			= '';
		$linrort->{_eps2_1}			= '';
		$linrort->{_eps2_2}			= '';
		$linrort->{_eps2_v}			= '';
		$linrort->{_fangle}			= '';
		$linrort->{_fazim}			= '';
		$linrort->{_gamma1}			= '';
		$linrort->{_gamma1_1}			= '';
		$linrort->{_gamma1_2}			= '';
		$linrort->{_gamma1_v}			= '';
		$linrort->{_hspace1}			= '';
		$linrort->{_hspace2}			= '';
		$linrort->{_kappa}			= '';
		$linrort->{_langle}			= '';
		$linrort->{_lazim}			= '';
		$linrort->{_out_Error}			= '';
		$linrort->{_out_P}			= '';
		$linrort->{_out_S}			= '';
		$linrort->{_out_SVSH}			= '';
		$linrort->{_out_inf}			= '';
		$linrort->{_rho1}			= '';
		$linrort->{_vp1}			= '';
		$linrort->{_vp2}			= '';
		$linrort->{_vs1}			= '';
		$linrort->{_Step}			= '';
		$linrort->{_note}			= '';
 }


=head2 sub PHI 


=cut

 sub PHI {

	my ( $self,$PHI )		= @_;
	if ( $PHI ne $empty_string ) {

		$linrort->{_PHI}		= $PHI;
		$linrort->{_note}		= $linrort->{_note}.' PHI='.$linrort->{_PHI};
		$linrort->{_Step}		= $linrort->{_Step}.' PHI='.$linrort->{_PHI};

	} else { 
		print("linrort, PHI, missing PHI,\n");
	 }
 }


=head2 sub a_file 


=cut

 sub a_file {

	my ( $self,$a_file )		= @_;
	if ( $a_file ne $empty_string ) {

		$linrort->{_a_file}		= $a_file;
		$linrort->{_note}		= $linrort->{_note}.' a_file='.$linrort->{_a_file};
		$linrort->{_Step}		= $linrort->{_Step}.' a_file='.$linrort->{_a_file};

	} else { 
		print("linrort, a_file, missing a_file,\n");
	 }
 }


=head2 sub azimuth 


=cut

 sub azimuth {

	my ( $self,$azimuth )		= @_;
	if ( $azimuth ne $empty_string ) {

		$linrort->{_azimuth}		= $azimuth;
		$linrort->{_note}		= $linrort->{_note}.' azimuth='.$linrort->{_azimuth};
		$linrort->{_Step}		= $linrort->{_Step}.' azimuth='.$linrort->{_azimuth};

	} else { 
		print("linrort, azimuth, missing azimuth,\n");
	 }
 }


=head2 sub dangle 


=cut

 sub dangle {

	my ( $self,$dangle )		= @_;
	if ( $dangle ne $empty_string ) {

		$linrort->{_dangle}		= $dangle;
		$linrort->{_note}		= $linrort->{_note}.' dangle='.$linrort->{_dangle};
		$linrort->{_Step}		= $linrort->{_Step}.' dangle='.$linrort->{_dangle};

	} else { 
		print("linrort, dangle, missing dangle,\n");
	 }
 }


=head2 sub dazim 


=cut

 sub dazim {

	my ( $self,$dazim )		= @_;
	if ( $dazim ne $empty_string ) {

		$linrort->{_dazim}		= $dazim;
		$linrort->{_note}		= $linrort->{_note}.' dazim='.$linrort->{_dazim};
		$linrort->{_Step}		= $linrort->{_Step}.' dazim='.$linrort->{_dazim};

	} else { 
		print("linrort, dazim, missing dazim,\n");
	 }
 }


=head2 sub delta1 


=cut

 sub delta1 {

	my ( $self,$delta1 )		= @_;
	if ( $delta1 ne $empty_string ) {

		$linrort->{_delta1}		= $delta1;
		$linrort->{_note}		= $linrort->{_note}.' delta1='.$linrort->{_delta1};
		$linrort->{_Step}		= $linrort->{_Step}.' delta1='.$linrort->{_delta1};

	} else { 
		print("linrort, delta1, missing delta1,\n");
	 }
 }


=head2 sub delta1_1 


=cut

 sub delta1_1 {

	my ( $self,$delta1_1 )		= @_;
	if ( $delta1_1 ne $empty_string ) {

		$linrort->{_delta1_1}		= $delta1_1;
		$linrort->{_note}		= $linrort->{_note}.' delta1_1='.$linrort->{_delta1_1};
		$linrort->{_Step}		= $linrort->{_Step}.' delta1_1='.$linrort->{_delta1_1};

	} else { 
		print("linrort, delta1_1, missing delta1_1,\n");
	 }
 }


=head2 sub delta1_2 


=cut

 sub delta1_2 {

	my ( $self,$delta1_2 )		= @_;
	if ( $delta1_2 ne $empty_string ) {

		$linrort->{_delta1_2}		= $delta1_2;
		$linrort->{_note}		= $linrort->{_note}.' delta1_2='.$linrort->{_delta1_2};
		$linrort->{_Step}		= $linrort->{_Step}.' delta1_2='.$linrort->{_delta1_2};

	} else { 
		print("linrort, delta1_2, missing delta1_2,\n");
	 }
 }


=head2 sub delta1_3 


=cut

 sub delta1_3 {

	my ( $self,$delta1_3 )		= @_;
	if ( $delta1_3 ne $empty_string ) {

		$linrort->{_delta1_3}		= $delta1_3;
		$linrort->{_note}		= $linrort->{_note}.' delta1_3='.$linrort->{_delta1_3};
		$linrort->{_Step}		= $linrort->{_Step}.' delta1_3='.$linrort->{_delta1_3};

	} else { 
		print("linrort, delta1_3, missing delta1_3,\n");
	 }
 }


=head2 sub delta1_v 


=cut

 sub delta1_v {

	my ( $self,$delta1_v )		= @_;
	if ( $delta1_v ne $empty_string ) {

		$linrort->{_delta1_v}		= $delta1_v;
		$linrort->{_note}		= $linrort->{_note}.' delta1_v='.$linrort->{_delta1_v};
		$linrort->{_Step}		= $linrort->{_Step}.' delta1_v='.$linrort->{_delta1_v};

	} else { 
		print("linrort, delta1_v, missing delta1_v,\n");
	 }
 }


=head2 sub delta2_3 


=cut

 sub delta2_3 {

	my ( $self,$delta2_3 )		= @_;
	if ( $delta2_3 ne $empty_string ) {

		$linrort->{_delta2_3}		= $delta2_3;
		$linrort->{_note}		= $linrort->{_note}.' delta2_3='.$linrort->{_delta2_3};
		$linrort->{_Step}		= $linrort->{_Step}.' delta2_3='.$linrort->{_delta2_3};

	} else { 
		print("linrort, delta2_3, missing delta2_3,\n");
	 }
 }


=head2 sub eps1 


=cut

 sub eps1 {

	my ( $self,$eps1 )		= @_;
	if ( $eps1 ne $empty_string ) {

		$linrort->{_eps1}		= $eps1;
		$linrort->{_note}		= $linrort->{_note}.' eps1='.$linrort->{_eps1};
		$linrort->{_Step}		= $linrort->{_Step}.' eps1='.$linrort->{_eps1};

	} else { 
		print("linrort, eps1, missing eps1,\n");
	 }
 }


=head2 sub eps1_1 


=cut

 sub eps1_1 {

	my ( $self,$eps1_1 )		= @_;
	if ( $eps1_1 ne $empty_string ) {

		$linrort->{_eps1_1}		= $eps1_1;
		$linrort->{_note}		= $linrort->{_note}.' eps1_1='.$linrort->{_eps1_1};
		$linrort->{_Step}		= $linrort->{_Step}.' eps1_1='.$linrort->{_eps1_1};

	} else { 
		print("linrort, eps1_1, missing eps1_1,\n");
	 }
 }


=head2 sub eps1_2 


=cut

 sub eps1_2 {

	my ( $self,$eps1_2 )		= @_;
	if ( $eps1_2 ne $empty_string ) {

		$linrort->{_eps1_2}		= $eps1_2;
		$linrort->{_note}		= $linrort->{_note}.' eps1_2='.$linrort->{_eps1_2};
		$linrort->{_Step}		= $linrort->{_Step}.' eps1_2='.$linrort->{_eps1_2};

	} else { 
		print("linrort, eps1_2, missing eps1_2,\n");
	 }
 }


=head2 sub eps1_v 


=cut

 sub eps1_v {

	my ( $self,$eps1_v )		= @_;
	if ( $eps1_v ne $empty_string ) {

		$linrort->{_eps1_v}		= $eps1_v;
		$linrort->{_note}		= $linrort->{_note}.' eps1_v='.$linrort->{_eps1_v};
		$linrort->{_Step}		= $linrort->{_Step}.' eps1_v='.$linrort->{_eps1_v};

	} else { 
		print("linrort, eps1_v, missing eps1_v,\n");
	 }
 }


=head2 sub eps2 


=cut

 sub eps2 {

	my ( $self,$eps2 )		= @_;
	if ( $eps2 ne $empty_string ) {

		$linrort->{_eps2}		= $eps2;
		$linrort->{_note}		= $linrort->{_note}.' eps2='.$linrort->{_eps2};
		$linrort->{_Step}		= $linrort->{_Step}.' eps2='.$linrort->{_eps2};

	} else { 
		print("linrort, eps2, missing eps2,\n");
	 }
 }


=head2 sub eps2_1 


=cut

 sub eps2_1 {

	my ( $self,$eps2_1 )		= @_;
	if ( $eps2_1 ne $empty_string ) {

		$linrort->{_eps2_1}		= $eps2_1;
		$linrort->{_note}		= $linrort->{_note}.' eps2_1='.$linrort->{_eps2_1};
		$linrort->{_Step}		= $linrort->{_Step}.' eps2_1='.$linrort->{_eps2_1};

	} else { 
		print("linrort, eps2_1, missing eps2_1,\n");
	 }
 }


=head2 sub eps2_2 


=cut

 sub eps2_2 {

	my ( $self,$eps2_2 )		= @_;
	if ( $eps2_2 ne $empty_string ) {

		$linrort->{_eps2_2}		= $eps2_2;
		$linrort->{_note}		= $linrort->{_note}.' eps2_2='.$linrort->{_eps2_2};
		$linrort->{_Step}		= $linrort->{_Step}.' eps2_2='.$linrort->{_eps2_2};

	} else { 
		print("linrort, eps2_2, missing eps2_2,\n");
	 }
 }


=head2 sub eps2_v 


=cut

 sub eps2_v {

	my ( $self,$eps2_v )		= @_;
	if ( $eps2_v ne $empty_string ) {

		$linrort->{_eps2_v}		= $eps2_v;
		$linrort->{_note}		= $linrort->{_note}.' eps2_v='.$linrort->{_eps2_v};
		$linrort->{_Step}		= $linrort->{_Step}.' eps2_v='.$linrort->{_eps2_v};

	} else { 
		print("linrort, eps2_v, missing eps2_v,\n");
	 }
 }


=head2 sub fangle 


=cut

 sub fangle {

	my ( $self,$fangle )		= @_;
	if ( $fangle ne $empty_string ) {

		$linrort->{_fangle}		= $fangle;
		$linrort->{_note}		= $linrort->{_note}.' fangle='.$linrort->{_fangle};
		$linrort->{_Step}		= $linrort->{_Step}.' fangle='.$linrort->{_fangle};

	} else { 
		print("linrort, fangle, missing fangle,\n");
	 }
 }


=head2 sub fazim 


=cut

 sub fazim {

	my ( $self,$fazim )		= @_;
	if ( $fazim ne $empty_string ) {

		$linrort->{_fazim}		= $fazim;
		$linrort->{_note}		= $linrort->{_note}.' fazim='.$linrort->{_fazim};
		$linrort->{_Step}		= $linrort->{_Step}.' fazim='.$linrort->{_fazim};

	} else { 
		print("linrort, fazim, missing fazim,\n");
	 }
 }


=head2 sub gamma1 


=cut

 sub gamma1 {

	my ( $self,$gamma1 )		= @_;
	if ( $gamma1 ne $empty_string ) {

		$linrort->{_gamma1}		= $gamma1;
		$linrort->{_note}		= $linrort->{_note}.' gamma1='.$linrort->{_gamma1};
		$linrort->{_Step}		= $linrort->{_Step}.' gamma1='.$linrort->{_gamma1};

	} else { 
		print("linrort, gamma1, missing gamma1,\n");
	 }
 }


=head2 sub gamma1_1 


=cut

 sub gamma1_1 {

	my ( $self,$gamma1_1 )		= @_;
	if ( $gamma1_1 ne $empty_string ) {

		$linrort->{_gamma1_1}		= $gamma1_1;
		$linrort->{_note}		= $linrort->{_note}.' gamma1_1='.$linrort->{_gamma1_1};
		$linrort->{_Step}		= $linrort->{_Step}.' gamma1_1='.$linrort->{_gamma1_1};

	} else { 
		print("linrort, gamma1_1, missing gamma1_1,\n");
	 }
 }


=head2 sub gamma1_2 


=cut

 sub gamma1_2 {

	my ( $self,$gamma1_2 )		= @_;
	if ( $gamma1_2 ne $empty_string ) {

		$linrort->{_gamma1_2}		= $gamma1_2;
		$linrort->{_note}		= $linrort->{_note}.' gamma1_2='.$linrort->{_gamma1_2};
		$linrort->{_Step}		= $linrort->{_Step}.' gamma1_2='.$linrort->{_gamma1_2};

	} else { 
		print("linrort, gamma1_2, missing gamma1_2,\n");
	 }
 }


=head2 sub gamma1_v 


=cut

 sub gamma1_v {

	my ( $self,$gamma1_v )		= @_;
	if ( $gamma1_v ne $empty_string ) {

		$linrort->{_gamma1_v}		= $gamma1_v;
		$linrort->{_note}		= $linrort->{_note}.' gamma1_v='.$linrort->{_gamma1_v};
		$linrort->{_Step}		= $linrort->{_Step}.' gamma1_v='.$linrort->{_gamma1_v};

	} else { 
		print("linrort, gamma1_v, missing gamma1_v,\n");
	 }
 }


=head2 sub hspace1 


=cut

 sub hspace1 {

	my ( $self,$hspace1 )		= @_;
	if ( $hspace1 ne $empty_string ) {

		$linrort->{_hspace1}		= $hspace1;
		$linrort->{_note}		= $linrort->{_note}.' hspace1='.$linrort->{_hspace1};
		$linrort->{_Step}		= $linrort->{_Step}.' hspace1='.$linrort->{_hspace1};

	} else { 
		print("linrort, hspace1, missing hspace1,\n");
	 }
 }


=head2 sub hspace2 


=cut

 sub hspace2 {

	my ( $self,$hspace2 )		= @_;
	if ( $hspace2 ne $empty_string ) {

		$linrort->{_hspace2}		= $hspace2;
		$linrort->{_note}		= $linrort->{_note}.' hspace2='.$linrort->{_hspace2};
		$linrort->{_Step}		= $linrort->{_Step}.' hspace2='.$linrort->{_hspace2};

	} else { 
		print("linrort, hspace2, missing hspace2,\n");
	 }
 }


=head2 sub kappa 


=cut

 sub kappa {

	my ( $self,$kappa )		= @_;
	if ( $kappa ne $empty_string ) {

		$linrort->{_kappa}		= $kappa;
		$linrort->{_note}		= $linrort->{_note}.' kappa='.$linrort->{_kappa};
		$linrort->{_Step}		= $linrort->{_Step}.' kappa='.$linrort->{_kappa};

	} else { 
		print("linrort, kappa, missing kappa,\n");
	 }
 }


=head2 sub langle 


=cut

 sub langle {

	my ( $self,$langle )		= @_;
	if ( $langle ne $empty_string ) {

		$linrort->{_langle}		= $langle;
		$linrort->{_note}		= $linrort->{_note}.' langle='.$linrort->{_langle};
		$linrort->{_Step}		= $linrort->{_Step}.' langle='.$linrort->{_langle};

	} else { 
		print("linrort, langle, missing langle,\n");
	 }
 }


=head2 sub lazim 


=cut

 sub lazim {

	my ( $self,$lazim )		= @_;
	if ( $lazim ne $empty_string ) {

		$linrort->{_lazim}		= $lazim;
		$linrort->{_note}		= $linrort->{_note}.' lazim='.$linrort->{_lazim};
		$linrort->{_Step}		= $linrort->{_Step}.' lazim='.$linrort->{_lazim};

	} else { 
		print("linrort, lazim, missing lazim,\n");
	 }
 }


=head2 sub out_Error 


=cut

 sub out_Error {

	my ( $self,$out_Error )		= @_;
	if ( $out_Error ne $empty_string ) {

		$linrort->{_out_Error}		= $out_Error;
		$linrort->{_note}		= $linrort->{_note}.' out_Error='.$linrort->{_out_Error};
		$linrort->{_Step}		= $linrort->{_Step}.' out_Error='.$linrort->{_out_Error};

	} else { 
		print("linrort, out_Error, missing out_Error,\n");
	 }
 }


=head2 sub out_P 


=cut

 sub out_P {

	my ( $self,$out_P )		= @_;
	if ( $out_P ne $empty_string ) {

		$linrort->{_out_P}		= $out_P;
		$linrort->{_note}		= $linrort->{_note}.' out_P='.$linrort->{_out_P};
		$linrort->{_Step}		= $linrort->{_Step}.' out_P='.$linrort->{_out_P};

	} else { 
		print("linrort, out_P, missing out_P,\n");
	 }
 }


=head2 sub out_S 


=cut

 sub out_S {

	my ( $self,$out_S )		= @_;
	if ( $out_S ne $empty_string ) {

		$linrort->{_out_S}		= $out_S;
		$linrort->{_note}		= $linrort->{_note}.' out_S='.$linrort->{_out_S};
		$linrort->{_Step}		= $linrort->{_Step}.' out_S='.$linrort->{_out_S};

	} else { 
		print("linrort, out_S, missing out_S,\n");
	 }
 }


=head2 sub out_SVSH 


=cut

 sub out_SVSH {

	my ( $self,$out_SVSH )		= @_;
	if ( $out_SVSH ne $empty_string ) {

		$linrort->{_out_SVSH}		= $out_SVSH;
		$linrort->{_note}		= $linrort->{_note}.' out_SVSH='.$linrort->{_out_SVSH};
		$linrort->{_Step}		= $linrort->{_Step}.' out_SVSH='.$linrort->{_out_SVSH};

	} else { 
		print("linrort, out_SVSH, missing out_SVSH,\n");
	 }
 }


=head2 sub out_inf 


=cut

 sub out_inf {

	my ( $self,$out_inf )		= @_;
	if ( $out_inf ne $empty_string ) {

		$linrort->{_out_inf}		= $out_inf;
		$linrort->{_note}		= $linrort->{_note}.' out_inf='.$linrort->{_out_inf};
		$linrort->{_Step}		= $linrort->{_Step}.' out_inf='.$linrort->{_out_inf};

	} else { 
		print("linrort, out_inf, missing out_inf,\n");
	 }
 }


=head2 sub rho1 


=cut

 sub rho1 {

	my ( $self,$rho1 )		= @_;
	if ( $rho1 ne $empty_string ) {

		$linrort->{_rho1}		= $rho1;
		$linrort->{_note}		= $linrort->{_note}.' rho1='.$linrort->{_rho1};
		$linrort->{_Step}		= $linrort->{_Step}.' rho1='.$linrort->{_rho1};

	} else { 
		print("linrort, rho1, missing rho1,\n");
	 }
 }


=head2 sub vp1 


=cut

 sub vp1 {

	my ( $self,$vp1 )		= @_;
	if ( $vp1 ne $empty_string ) {

		$linrort->{_vp1}		= $vp1;
		$linrort->{_note}		= $linrort->{_note}.' vp1='.$linrort->{_vp1};
		$linrort->{_Step}		= $linrort->{_Step}.' vp1='.$linrort->{_vp1};

	} else { 
		print("linrort, vp1, missing vp1,\n");
	 }
 }


=head2 sub vp2 


=cut

 sub vp2 {

	my ( $self,$vp2 )		= @_;
	if ( $vp2 ne $empty_string ) {

		$linrort->{_vp2}		= $vp2;
		$linrort->{_note}		= $linrort->{_note}.' vp2='.$linrort->{_vp2};
		$linrort->{_Step}		= $linrort->{_Step}.' vp2='.$linrort->{_vp2};

	} else { 
		print("linrort, vp2, missing vp2,\n");
	 }
 }


=head2 sub vs1 


=cut

 sub vs1 {

	my ( $self,$vs1 )		= @_;
	if ( $vs1 ne $empty_string ) {

		$linrort->{_vs1}		= $vs1;
		$linrort->{_note}		= $linrort->{_note}.' vs1='.$linrort->{_vs1};
		$linrort->{_Step}		= $linrort->{_Step}.' vs1='.$linrort->{_vs1};

	} else { 
		print("linrort, vs1, missing vs1,\n");
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