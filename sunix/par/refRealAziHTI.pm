package refRealAziHTI;

=head2 SYNOPSIS

PACKAGE NAME: 

AUTHOR:  

DATE:

DESCRIPTION:

Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES
 REFREALAZIHTI -  REAL AZImuthal REFL/transm coeff for HTI media 	



 refRealAziHTI  [optional parameters]	>coeff.data 			



 Optional parameters: 							

 vp1=2         p-wave velocity medium 1 (with respect to symm.axes)	

 vs1=1         s-wave velocity medium 1 (with respect to symm.axes)	

 eps1=0        epsilon medium1						

 delta1=0	delta medium 1						

 gamma1=0	gamma medium 1						

 rho1=2.7	density medium 1 					

 vp2=2         p-wave velocity medium 2 (with respect to symm.axes)	

 vs2=1         s-wave velocity medium 2 (with respect to symm.axes)	

 eps2=0        epsilon medium 2					

 delta2=0	delta medium 2						

 gamma2=0	gamma medium 2						

 rho2=2.7	density medium 2 					

 modei=0 	incident mode is qP					

		=1 incident mode is qSV					

		=2 incident mode is SP					

 modet=0 	scattered mode						

 rort=1 	reflection(1)	or transmission (0)			

 azimuth=0	azimuth with respect to x1-axis (clockwise)		

 fangle=0	first incidence angle					

 langle=45	last incidence angle					

 dangle=1	angle increment						

 iscale=0      default: angle in degrees				

		=1 angle-axis in rad                                    

               =2 axis  horizontal slowness                            

               =3 sin^2 of incidence angle                             

 ibin=1 	binary output 						

		=0 Ascci output						

 outparfile	=outpar parameter file for plotting			

 coeffile	=coeff.data coefficient-output file			

 test=1 	activate testing routines in code			

 info=0 	output intermediate results				



 Notes:								

 Axes of symmetry have to coincide in both media.  This code computes	

 all 6 REAL reflection/transmissions coefficients on the fly. However,	

 the set-up is such Real reflection/transmission coefficients in 	

 HTI-media with coinciding symmetry axes.				

 However, the set-up is such that currently only one coefficient is	

 dumped into the output. This is easily changed.  The solution of the	

 scattering problem is obtained numerically and involves the Gaussian	

 elimination of a 6X6 matrix.						", 







 AUTHOR:: Andreas Rueger, Colorado School of Mines, 02/10/95

                original name of code <graebnerTIH.c>

           modified, extended version of this code <refTIH3D>

 

  Technical references:



 	Sebastian Geoltrain: Asymptotic solutions to direct

		and inverse scattering in anisotropic elastic media;

		CWP 082.

	Graebner, M.; Geophysics, Vol 57, No 11:

		Plane-wave reflection and transmission coefficients

		for a transversely isotropic solid.

	Cerveny, V., 1972, Seismic rays and ray intensities in inhomogeneous 	

		anisotropic media: Geophys. J. R. astr. Soc., 29, 1-13.



	.. and some derivations by Andreas Rueger.



 If propagation is perpendicular or 

 parallel to the symmetry axis, the solution is analytic (see 		

 graebner2D.c and rtRealIso.c		



=head2 User's notes (Juan Lorenzo)
untested

=cut


=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';


=head2 Import packages

=cut

use L_SU_global_constants();

use SeismicUnix qw ($go $in $off $on $out $ps $to $suffix_ascii $suffix_bin $suffix_ps $suffix_segy $suffix_su);
use Project_config;


=head2 instantiation of packages

=cut

my $get					= new L_SU_global_constants();
my $Project				= new Project_config();
my $DATA_SEISMIC_SU		= $Project->DATA_SEISMIC_SU();
my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN();
my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT();

my $PS_SEISMIC      	= $Project->PS_SEISMIC();

my $var				= $get->var();
my $on				= $var->{_on};
my $off				= $var->{_off};
my $true			= $var->{_true};
my $false			= $var->{_false};
my $empty_string	= $var->{_empty_string};

=head2 Encapsulated
hash of private variables

=cut

my $refRealAziHTI			= {
	_azimuth					=> '',
	_coeffile					=> '',
	_dangle					=> '',
	_delta1					=> '',
	_delta2					=> '',
	_eps1					=> '',
	_eps2					=> '',
	_fangle					=> '',
	_gamma1					=> '',
	_gamma2					=> '',
	_ibin					=> '',
	_info					=> '',
	_iscale					=> '',
	_langle					=> '',
	_modei					=> '',
	_modet					=> '',
	_outparfile					=> '',
	_rho1					=> '',
	_rho2					=> '',
	_rort					=> '',
	_test					=> '',
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

	$refRealAziHTI->{_Step}     = 'refRealAziHTI'.$refRealAziHTI->{_Step};
	return ( $refRealAziHTI->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$refRealAziHTI->{_note}     = 'refRealAziHTI'.$refRealAziHTI->{_note};
	return ( $refRealAziHTI->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$refRealAziHTI->{_azimuth}			= '';
		$refRealAziHTI->{_coeffile}			= '';
		$refRealAziHTI->{_dangle}			= '';
		$refRealAziHTI->{_delta1}			= '';
		$refRealAziHTI->{_delta2}			= '';
		$refRealAziHTI->{_eps1}			= '';
		$refRealAziHTI->{_eps2}			= '';
		$refRealAziHTI->{_fangle}			= '';
		$refRealAziHTI->{_gamma1}			= '';
		$refRealAziHTI->{_gamma2}			= '';
		$refRealAziHTI->{_ibin}			= '';
		$refRealAziHTI->{_info}			= '';
		$refRealAziHTI->{_iscale}			= '';
		$refRealAziHTI->{_langle}			= '';
		$refRealAziHTI->{_modei}			= '';
		$refRealAziHTI->{_modet}			= '';
		$refRealAziHTI->{_outparfile}			= '';
		$refRealAziHTI->{_rho1}			= '';
		$refRealAziHTI->{_rho2}			= '';
		$refRealAziHTI->{_rort}			= '';
		$refRealAziHTI->{_test}			= '';
		$refRealAziHTI->{_vp1}			= '';
		$refRealAziHTI->{_vp2}			= '';
		$refRealAziHTI->{_vs1}			= '';
		$refRealAziHTI->{_vs2}			= '';
		$refRealAziHTI->{_Step}			= '';
		$refRealAziHTI->{_note}			= '';
 }


=head2 sub azimuth 


=cut

 sub azimuth {

	my ( $self,$azimuth )		= @_;
	if ( $azimuth ne $empty_string ) {

		$refRealAziHTI->{_azimuth}		= $azimuth;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' azimuth='.$refRealAziHTI->{_azimuth};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' azimuth='.$refRealAziHTI->{_azimuth};

	} else { 
		print("refRealAziHTI, azimuth, missing azimuth,\n");
	 }
 }


=head2 sub coeffile 


=cut

 sub coeffile {

	my ( $self,$coeffile )		= @_;
	if ( $coeffile ne $empty_string ) {

		$refRealAziHTI->{_coeffile}		= $coeffile;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' coeffile='.$refRealAziHTI->{_coeffile};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' coeffile='.$refRealAziHTI->{_coeffile};

	} else { 
		print("refRealAziHTI, coeffile, missing coeffile,\n");
	 }
 }


=head2 sub dangle 


=cut

 sub dangle {

	my ( $self,$dangle )		= @_;
	if ( $dangle ne $empty_string ) {

		$refRealAziHTI->{_dangle}		= $dangle;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' dangle='.$refRealAziHTI->{_dangle};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' dangle='.$refRealAziHTI->{_dangle};

	} else { 
		print("refRealAziHTI, dangle, missing dangle,\n");
	 }
 }


=head2 sub delta1 


=cut

 sub delta1 {

	my ( $self,$delta1 )		= @_;
	if ( $delta1 ne $empty_string ) {

		$refRealAziHTI->{_delta1}		= $delta1;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' delta1='.$refRealAziHTI->{_delta1};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' delta1='.$refRealAziHTI->{_delta1};

	} else { 
		print("refRealAziHTI, delta1, missing delta1,\n");
	 }
 }


=head2 sub delta2 


=cut

 sub delta2 {

	my ( $self,$delta2 )		= @_;
	if ( $delta2 ne $empty_string ) {

		$refRealAziHTI->{_delta2}		= $delta2;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' delta2='.$refRealAziHTI->{_delta2};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' delta2='.$refRealAziHTI->{_delta2};

	} else { 
		print("refRealAziHTI, delta2, missing delta2,\n");
	 }
 }


=head2 sub eps1 


=cut

 sub eps1 {

	my ( $self,$eps1 )		= @_;
	if ( $eps1 ne $empty_string ) {

		$refRealAziHTI->{_eps1}		= $eps1;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' eps1='.$refRealAziHTI->{_eps1};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' eps1='.$refRealAziHTI->{_eps1};

	} else { 
		print("refRealAziHTI, eps1, missing eps1,\n");
	 }
 }


=head2 sub eps2 


=cut

 sub eps2 {

	my ( $self,$eps2 )		= @_;
	if ( $eps2 ne $empty_string ) {

		$refRealAziHTI->{_eps2}		= $eps2;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' eps2='.$refRealAziHTI->{_eps2};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' eps2='.$refRealAziHTI->{_eps2};

	} else { 
		print("refRealAziHTI, eps2, missing eps2,\n");
	 }
 }


=head2 sub fangle 


=cut

 sub fangle {

	my ( $self,$fangle )		= @_;
	if ( $fangle ne $empty_string ) {

		$refRealAziHTI->{_fangle}		= $fangle;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' fangle='.$refRealAziHTI->{_fangle};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' fangle='.$refRealAziHTI->{_fangle};

	} else { 
		print("refRealAziHTI, fangle, missing fangle,\n");
	 }
 }


=head2 sub gamma1 


=cut

 sub gamma1 {

	my ( $self,$gamma1 )		= @_;
	if ( $gamma1 ne $empty_string ) {

		$refRealAziHTI->{_gamma1}		= $gamma1;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' gamma1='.$refRealAziHTI->{_gamma1};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' gamma1='.$refRealAziHTI->{_gamma1};

	} else { 
		print("refRealAziHTI, gamma1, missing gamma1,\n");
	 }
 }


=head2 sub gamma2 


=cut

 sub gamma2 {

	my ( $self,$gamma2 )		= @_;
	if ( $gamma2 ne $empty_string ) {

		$refRealAziHTI->{_gamma2}		= $gamma2;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' gamma2='.$refRealAziHTI->{_gamma2};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' gamma2='.$refRealAziHTI->{_gamma2};

	} else { 
		print("refRealAziHTI, gamma2, missing gamma2,\n");
	 }
 }


=head2 sub ibin 


=cut

 sub ibin {

	my ( $self,$ibin )		= @_;
	if ( $ibin ne $empty_string ) {

		$refRealAziHTI->{_ibin}		= $ibin;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' ibin='.$refRealAziHTI->{_ibin};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' ibin='.$refRealAziHTI->{_ibin};

	} else { 
		print("refRealAziHTI, ibin, missing ibin,\n");
	 }
 }


=head2 sub info 


=cut

 sub info {

	my ( $self,$info )		= @_;
	if ( $info ne $empty_string ) {

		$refRealAziHTI->{_info}		= $info;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' info='.$refRealAziHTI->{_info};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' info='.$refRealAziHTI->{_info};

	} else { 
		print("refRealAziHTI, info, missing info,\n");
	 }
 }


=head2 sub iscale 


=cut

 sub iscale {

	my ( $self,$iscale )		= @_;
	if ( $iscale ne $empty_string ) {

		$refRealAziHTI->{_iscale}		= $iscale;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' iscale='.$refRealAziHTI->{_iscale};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' iscale='.$refRealAziHTI->{_iscale};

	} else { 
		print("refRealAziHTI, iscale, missing iscale,\n");
	 }
 }


=head2 sub langle 


=cut

 sub langle {

	my ( $self,$langle )		= @_;
	if ( $langle ne $empty_string ) {

		$refRealAziHTI->{_langle}		= $langle;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' langle='.$refRealAziHTI->{_langle};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' langle='.$refRealAziHTI->{_langle};

	} else { 
		print("refRealAziHTI, langle, missing langle,\n");
	 }
 }


=head2 sub modei 


=cut

 sub modei {

	my ( $self,$modei )		= @_;
	if ( $modei ne $empty_string ) {

		$refRealAziHTI->{_modei}		= $modei;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' modei='.$refRealAziHTI->{_modei};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' modei='.$refRealAziHTI->{_modei};

	} else { 
		print("refRealAziHTI, modei, missing modei,\n");
	 }
 }


=head2 sub modet 


=cut

 sub modet {

	my ( $self,$modet )		= @_;
	if ( $modet ne $empty_string ) {

		$refRealAziHTI->{_modet}		= $modet;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' modet='.$refRealAziHTI->{_modet};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' modet='.$refRealAziHTI->{_modet};

	} else { 
		print("refRealAziHTI, modet, missing modet,\n");
	 }
 }


=head2 sub outparfile 


=cut

 sub outparfile {

	my ( $self,$outparfile )		= @_;
	if ( $outparfile ne $empty_string ) {

		$refRealAziHTI->{_outparfile}		= $outparfile;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' outparfile='.$refRealAziHTI->{_outparfile};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' outparfile='.$refRealAziHTI->{_outparfile};

	} else { 
		print("refRealAziHTI, outparfile, missing outparfile,\n");
	 }
 }


=head2 sub rho1 


=cut

 sub rho1 {

	my ( $self,$rho1 )		= @_;
	if ( $rho1 ne $empty_string ) {

		$refRealAziHTI->{_rho1}		= $rho1;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' rho1='.$refRealAziHTI->{_rho1};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' rho1='.$refRealAziHTI->{_rho1};

	} else { 
		print("refRealAziHTI, rho1, missing rho1,\n");
	 }
 }


=head2 sub rho2 


=cut

 sub rho2 {

	my ( $self,$rho2 )		= @_;
	if ( $rho2 ne $empty_string ) {

		$refRealAziHTI->{_rho2}		= $rho2;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' rho2='.$refRealAziHTI->{_rho2};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' rho2='.$refRealAziHTI->{_rho2};

	} else { 
		print("refRealAziHTI, rho2, missing rho2,\n");
	 }
 }


=head2 sub rort 


=cut

 sub rort {

	my ( $self,$rort )		= @_;
	if ( $rort ne $empty_string ) {

		$refRealAziHTI->{_rort}		= $rort;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' rort='.$refRealAziHTI->{_rort};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' rort='.$refRealAziHTI->{_rort};

	} else { 
		print("refRealAziHTI, rort, missing rort,\n");
	 }
 }


=head2 sub test 


=cut

 sub test {

	my ( $self,$test )		= @_;
	if ( $test ne $empty_string ) {

		$refRealAziHTI->{_test}		= $test;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' test='.$refRealAziHTI->{_test};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' test='.$refRealAziHTI->{_test};

	} else { 
		print("refRealAziHTI, test, missing test,\n");
	 }
 }


=head2 sub vp1 


=cut

 sub vp1 {

	my ( $self,$vp1 )		= @_;
	if ( $vp1 ne $empty_string ) {

		$refRealAziHTI->{_vp1}		= $vp1;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' vp1='.$refRealAziHTI->{_vp1};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' vp1='.$refRealAziHTI->{_vp1};

	} else { 
		print("refRealAziHTI, vp1, missing vp1,\n");
	 }
 }


=head2 sub vp2 


=cut

 sub vp2 {

	my ( $self,$vp2 )		= @_;
	if ( $vp2 ne $empty_string ) {

		$refRealAziHTI->{_vp2}		= $vp2;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' vp2='.$refRealAziHTI->{_vp2};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' vp2='.$refRealAziHTI->{_vp2};

	} else { 
		print("refRealAziHTI, vp2, missing vp2,\n");
	 }
 }


=head2 sub vs1 


=cut

 sub vs1 {

	my ( $self,$vs1 )		= @_;
	if ( $vs1 ne $empty_string ) {

		$refRealAziHTI->{_vs1}		= $vs1;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' vs1='.$refRealAziHTI->{_vs1};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' vs1='.$refRealAziHTI->{_vs1};

	} else { 
		print("refRealAziHTI, vs1, missing vs1,\n");
	 }
 }


=head2 sub vs2 


=cut

 sub vs2 {

	my ( $self,$vs2 )		= @_;
	if ( $vs2 ne $empty_string ) {

		$refRealAziHTI->{_vs2}		= $vs2;
		$refRealAziHTI->{_note}		= $refRealAziHTI->{_note}.' vs2='.$refRealAziHTI->{_vs2};
		$refRealAziHTI->{_Step}		= $refRealAziHTI->{_Step}.' vs2='.$refRealAziHTI->{_vs2};

	} else { 
		print("refRealAziHTI, vs2, missing vs2,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 24;

    return($max_index);
}
 
 
1;
