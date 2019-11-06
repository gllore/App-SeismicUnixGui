 package refRealVTI;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  REFREALVTI -  REAL REFL/transm coeff for VTI media and symmetry-axis	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 REFREALVTI -  REAL REFL/transm coeff for VTI media and symmetry-axis	
                 planes of HTI media 					

 refRealVTI  [Optional parameters]	   			        

 Optional parameters:							
 vp1=2          p-wave velocity medium 1 (along symm.axes)	        
 vs1=1          s-wave velocity medium 1 (along symm.axes)	        
 eps1=0         Thomsen's epsilon medium 1				
 delta1=0	 Thomsen's delta medium 1	         		
 rho1=2.7	 density medium 1 					
 axis1=0	 medium 1 is VTI					
		 =1 medium 1 is HTI					
 vp2=2.5         p-wave velocity medium 2 (along symm.axes)	        
 vs2=1.2          s-wave velocity medium 2 (along symm.axes)	        
 eps2=0	 epsilon medium2					
 delta2=0	delta medium 2						
 rho2=3.0	density medium 2 					
 axis2=0	medium 2 is VTI						
		=2 medium 2 is HTI					
 modei=0 	incident mode is qP					
		=1 incident mode is qSV					
 modet=0 	scattered mode						
 rort=1 	reflection(1)	or transmission (0)			
 fangle=0	first angle						
 langle=45	last angle						
 dangle=1	angle increment						
 iscale=0       =1 angle-axis in rad					
                =2 axis  horizontal slowness                           
                =3 sin^2 of incidence angle                            
 ibin=1 	binary output 						
		=0 Ascci output						
 outparfile	=outpar parameter file for plotting			
 coeffile	=coeff.data coefficient-output file			

 Notes:								
 Coefficients are based on Graebner's 1992 Geophysics paper. Note the	
 mistype in the equation for K1. The algorithm can be used for VTI	
 and HTI media on the incidence and scattering side.			



 AUTHOR:: Andreas Rueger, Colorado School of Mines, 01/20/95
       original name of algorithm: graebner1.c

  Technical reference: Graebner, M.; Geophysics, Vol 57, No 11:
		Plane-wave reflection and transmission coefficients
		for a transversely isotropic solid.
		Rueger, A.; Geophysics 1996 (accepted):
		P-wave reflection coefficients ...


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $refRealVTI		= {
		_axis1					=> '',
		_axis2					=> '',
		_coeffile					=> '',
		_dangle					=> '',
		_delta1					=> '',
		_delta2					=> '',
		_eps1					=> '',
		_eps2					=> '',
		_fangle					=> '',
		_ibin					=> '',
		_iscale					=> '',
		_langle					=> '',
		_modei					=> '',
		_modet					=> '',
		_outparfile					=> '',
		_rho1					=> '',
		_rho2					=> '',
		_rort					=> '',
		_vp1					=> '',
		_vp2					=> '',
		_vs1					=> '',
		_vs2					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$refRealVTI->{_Step}     = 'refRealVTI'.$refRealVTI->{_Step};
	return ( $refRealVTI->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$refRealVTI->{_note}     = 'refRealVTI'.$refRealVTI->{_note};
	return ( $refRealVTI->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$refRealVTI->{_axis1}			= '';
		$refRealVTI->{_axis2}			= '';
		$refRealVTI->{_coeffile}			= '';
		$refRealVTI->{_dangle}			= '';
		$refRealVTI->{_delta1}			= '';
		$refRealVTI->{_delta2}			= '';
		$refRealVTI->{_eps1}			= '';
		$refRealVTI->{_eps2}			= '';
		$refRealVTI->{_fangle}			= '';
		$refRealVTI->{_ibin}			= '';
		$refRealVTI->{_iscale}			= '';
		$refRealVTI->{_langle}			= '';
		$refRealVTI->{_modei}			= '';
		$refRealVTI->{_modet}			= '';
		$refRealVTI->{_outparfile}			= '';
		$refRealVTI->{_rho1}			= '';
		$refRealVTI->{_rho2}			= '';
		$refRealVTI->{_rort}			= '';
		$refRealVTI->{_vp1}			= '';
		$refRealVTI->{_vp2}			= '';
		$refRealVTI->{_vs1}			= '';
		$refRealVTI->{_vs2}			= '';
		$refRealVTI->{_Step}			= '';
		$refRealVTI->{_note}			= '';
 }


=head2 sub axis1 


=cut

 sub axis1 {

	my ( $self,$axis1 )		= @_;
	if ( $axis1 ne $empty_string ) {

		$refRealVTI->{_axis1}		= $axis1;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' axis1='.$refRealVTI->{_axis1};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' axis1='.$refRealVTI->{_axis1};

	} else { 
		print("refRealVTI, axis1, missing axis1,\n");
	 }
 }


=head2 sub axis2 


=cut

 sub axis2 {

	my ( $self,$axis2 )		= @_;
	if ( $axis2 ne $empty_string ) {

		$refRealVTI->{_axis2}		= $axis2;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' axis2='.$refRealVTI->{_axis2};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' axis2='.$refRealVTI->{_axis2};

	} else { 
		print("refRealVTI, axis2, missing axis2,\n");
	 }
 }


=head2 sub coeffile 


=cut

 sub coeffile {

	my ( $self,$coeffile )		= @_;
	if ( $coeffile ne $empty_string ) {

		$refRealVTI->{_coeffile}		= $coeffile;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' coeffile='.$refRealVTI->{_coeffile};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' coeffile='.$refRealVTI->{_coeffile};

	} else { 
		print("refRealVTI, coeffile, missing coeffile,\n");
	 }
 }


=head2 sub dangle 


=cut

 sub dangle {

	my ( $self,$dangle )		= @_;
	if ( $dangle ne $empty_string ) {

		$refRealVTI->{_dangle}		= $dangle;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' dangle='.$refRealVTI->{_dangle};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' dangle='.$refRealVTI->{_dangle};

	} else { 
		print("refRealVTI, dangle, missing dangle,\n");
	 }
 }


=head2 sub delta1 


=cut

 sub delta1 {

	my ( $self,$delta1 )		= @_;
	if ( $delta1 ne $empty_string ) {

		$refRealVTI->{_delta1}		= $delta1;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' delta1='.$refRealVTI->{_delta1};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' delta1='.$refRealVTI->{_delta1};

	} else { 
		print("refRealVTI, delta1, missing delta1,\n");
	 }
 }


=head2 sub delta2 


=cut

 sub delta2 {

	my ( $self,$delta2 )		= @_;
	if ( $delta2 ne $empty_string ) {

		$refRealVTI->{_delta2}		= $delta2;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' delta2='.$refRealVTI->{_delta2};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' delta2='.$refRealVTI->{_delta2};

	} else { 
		print("refRealVTI, delta2, missing delta2,\n");
	 }
 }


=head2 sub eps1 


=cut

 sub eps1 {

	my ( $self,$eps1 )		= @_;
	if ( $eps1 ne $empty_string ) {

		$refRealVTI->{_eps1}		= $eps1;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' eps1='.$refRealVTI->{_eps1};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' eps1='.$refRealVTI->{_eps1};

	} else { 
		print("refRealVTI, eps1, missing eps1,\n");
	 }
 }


=head2 sub eps2 


=cut

 sub eps2 {

	my ( $self,$eps2 )		= @_;
	if ( $eps2 ne $empty_string ) {

		$refRealVTI->{_eps2}		= $eps2;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' eps2='.$refRealVTI->{_eps2};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' eps2='.$refRealVTI->{_eps2};

	} else { 
		print("refRealVTI, eps2, missing eps2,\n");
	 }
 }


=head2 sub fangle 


=cut

 sub fangle {

	my ( $self,$fangle )		= @_;
	if ( $fangle ne $empty_string ) {

		$refRealVTI->{_fangle}		= $fangle;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' fangle='.$refRealVTI->{_fangle};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' fangle='.$refRealVTI->{_fangle};

	} else { 
		print("refRealVTI, fangle, missing fangle,\n");
	 }
 }


=head2 sub ibin 


=cut

 sub ibin {

	my ( $self,$ibin )		= @_;
	if ( $ibin ne $empty_string ) {

		$refRealVTI->{_ibin}		= $ibin;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' ibin='.$refRealVTI->{_ibin};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' ibin='.$refRealVTI->{_ibin};

	} else { 
		print("refRealVTI, ibin, missing ibin,\n");
	 }
 }


=head2 sub iscale 


=cut

 sub iscale {

	my ( $self,$iscale )		= @_;
	if ( $iscale ne $empty_string ) {

		$refRealVTI->{_iscale}		= $iscale;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' iscale='.$refRealVTI->{_iscale};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' iscale='.$refRealVTI->{_iscale};

	} else { 
		print("refRealVTI, iscale, missing iscale,\n");
	 }
 }


=head2 sub langle 


=cut

 sub langle {

	my ( $self,$langle )		= @_;
	if ( $langle ne $empty_string ) {

		$refRealVTI->{_langle}		= $langle;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' langle='.$refRealVTI->{_langle};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' langle='.$refRealVTI->{_langle};

	} else { 
		print("refRealVTI, langle, missing langle,\n");
	 }
 }


=head2 sub modei 


=cut

 sub modei {

	my ( $self,$modei )		= @_;
	if ( $modei ne $empty_string ) {

		$refRealVTI->{_modei}		= $modei;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' modei='.$refRealVTI->{_modei};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' modei='.$refRealVTI->{_modei};

	} else { 
		print("refRealVTI, modei, missing modei,\n");
	 }
 }


=head2 sub modet 


=cut

 sub modet {

	my ( $self,$modet )		= @_;
	if ( $modet ne $empty_string ) {

		$refRealVTI->{_modet}		= $modet;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' modet='.$refRealVTI->{_modet};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' modet='.$refRealVTI->{_modet};

	} else { 
		print("refRealVTI, modet, missing modet,\n");
	 }
 }


=head2 sub outparfile 


=cut

 sub outparfile {

	my ( $self,$outparfile )		= @_;
	if ( $outparfile ne $empty_string ) {

		$refRealVTI->{_outparfile}		= $outparfile;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' outparfile='.$refRealVTI->{_outparfile};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' outparfile='.$refRealVTI->{_outparfile};

	} else { 
		print("refRealVTI, outparfile, missing outparfile,\n");
	 }
 }


=head2 sub rho1 


=cut

 sub rho1 {

	my ( $self,$rho1 )		= @_;
	if ( $rho1 ne $empty_string ) {

		$refRealVTI->{_rho1}		= $rho1;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' rho1='.$refRealVTI->{_rho1};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' rho1='.$refRealVTI->{_rho1};

	} else { 
		print("refRealVTI, rho1, missing rho1,\n");
	 }
 }


=head2 sub rho2 


=cut

 sub rho2 {

	my ( $self,$rho2 )		= @_;
	if ( $rho2 ne $empty_string ) {

		$refRealVTI->{_rho2}		= $rho2;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' rho2='.$refRealVTI->{_rho2};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' rho2='.$refRealVTI->{_rho2};

	} else { 
		print("refRealVTI, rho2, missing rho2,\n");
	 }
 }


=head2 sub rort 


=cut

 sub rort {

	my ( $self,$rort )		= @_;
	if ( $rort ne $empty_string ) {

		$refRealVTI->{_rort}		= $rort;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' rort='.$refRealVTI->{_rort};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' rort='.$refRealVTI->{_rort};

	} else { 
		print("refRealVTI, rort, missing rort,\n");
	 }
 }


=head2 sub vp1 


=cut

 sub vp1 {

	my ( $self,$vp1 )		= @_;
	if ( $vp1 ne $empty_string ) {

		$refRealVTI->{_vp1}		= $vp1;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' vp1='.$refRealVTI->{_vp1};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' vp1='.$refRealVTI->{_vp1};

	} else { 
		print("refRealVTI, vp1, missing vp1,\n");
	 }
 }


=head2 sub vp2 


=cut

 sub vp2 {

	my ( $self,$vp2 )		= @_;
	if ( $vp2 ne $empty_string ) {

		$refRealVTI->{_vp2}		= $vp2;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' vp2='.$refRealVTI->{_vp2};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' vp2='.$refRealVTI->{_vp2};

	} else { 
		print("refRealVTI, vp2, missing vp2,\n");
	 }
 }


=head2 sub vs1 


=cut

 sub vs1 {

	my ( $self,$vs1 )		= @_;
	if ( $vs1 ne $empty_string ) {

		$refRealVTI->{_vs1}		= $vs1;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' vs1='.$refRealVTI->{_vs1};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' vs1='.$refRealVTI->{_vs1};

	} else { 
		print("refRealVTI, vs1, missing vs1,\n");
	 }
 }


=head2 sub vs2 


=cut

 sub vs2 {

	my ( $self,$vs2 )		= @_;
	if ( $vs2 ne $empty_string ) {

		$refRealVTI->{_vs2}		= $vs2;
		$refRealVTI->{_note}		= $refRealVTI->{_note}.' vs2='.$refRealVTI->{_vs2};
		$refRealVTI->{_Step}		= $refRealVTI->{_Step}.' vs2='.$refRealVTI->{_vs2};

	} else { 
		print("refRealVTI, vs2, missing vs2,\n");
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