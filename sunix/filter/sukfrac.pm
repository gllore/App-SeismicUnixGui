package sukfrac;

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
 SUKFRAC - apply FRACtional powers of i|k| to data, with phase shift 



     sukfrac <infile >outfile [optional parameters]			



 Optional parameters:							

  power=0		exponent of (i*sqrt(k1^2 + k2^2))^power		

			=0 ===> phase shift only			

			>0 ===> differentiation				

			<0 ===> integration				

  sign=1		sign on transform exponent       		

  d1=1.0		x1 sampling interval				

  d2=1.0		x2 sampling interval				

  phasefac=0		phase shift by phase=phasefac*PI		

  ...directional derivative, active only if angle= is set ....		

  angle=		if set applies operator directionally in the	

			direction specified by the value of angle,	

			-360.0 <= angle < 359.99999 degress		



 Notes:								

 The relation: w = 2 pi F is well known for frequency, but there	

 doesn't seem to be a commonly used letter corresponding to F for the	

 spatial conjugate transform variables.  We use K1 and K2 for this.	

 More specifically we assume a phase:					

		-i(k1 x1 + k2 x2) = -2 pi i(K1 x1 + K2 x2).		

 and K1, K2 define our respective wavenumbers.				



 Algorithms 								

 	g(x1,x2)=Re[2DINVFFT{ ( (sign) i |k|)^power 2DFFT(f)}e^i(phase)]

 where: 								

       |k| = sqrt[ (k1)^2 + (k2)^2 ] 					

 or when angle= is set 						

       |k| = sqrt[ (k1  cos(angle) )^2 + (k2 sin(angle) )^2 ] 		



 In the default mode a factor of (i|k|)^(power) is applied in the 	

 transform domain. For time data the time axis direction is taken to 	

 be the k1-direction.  The effect of this filter is to differentiate   

 the input in the normal direction to any curvilinear features in	

 in the data, and thus be a non-directional-specific edge enhancer.	



 If angle= is set, then the intended effect is a derivative in the 	

 direction specified by the angle, with the k1-direction being angle=0,

 corresponding to curves whose normals lie in the x1-direction. 	



 Caveat:								

 Large amplitude errors will result of the data set has too few points.



 Examples:								

 Edge sharpening: 							

 Laplacean : 								

    sukfrac < image_data  power=2 phasefac=-1 | ... 			



 Image enhancement:							

   Derivative filter:							

    sukfrac < image_data  power=1 phasefac=-.5 | ... 			



 Image enhancement:							

   Half derivative (this one is the best for photographs): 		

    sukfrac < image_data  power=.5 phasefac=-.25 | ... 		





 Credits:

     CWP: John Stockwell, June 1997, based on sufrac.



 Trace header fields accessed: ns, d1, d2



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

my $sukfrac			= {
	_angle					=> '',
	_d1					=> '',
	_d2					=> '',
	_phasefac					=> '',
	_power					=> '',
	_sign					=> '',
	_w					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sukfrac->{_Step}     = 'sukfrac'.$sukfrac->{_Step};
	return ( $sukfrac->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sukfrac->{_note}     = 'sukfrac'.$sukfrac->{_note};
	return ( $sukfrac->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sukfrac->{_angle}			= '';
		$sukfrac->{_d1}			= '';
		$sukfrac->{_d2}			= '';
		$sukfrac->{_phasefac}			= '';
		$sukfrac->{_power}			= '';
		$sukfrac->{_sign}			= '';
		$sukfrac->{_w}			= '';
		$sukfrac->{_Step}			= '';
		$sukfrac->{_note}			= '';
 }


=head2 sub angle 


=cut

 sub angle {

	my ( $self,$angle )		= @_;
	if ( $angle ne $empty_string ) {

		$sukfrac->{_angle}		= $angle;
		$sukfrac->{_note}		= $sukfrac->{_note}.' angle='.$sukfrac->{_angle};
		$sukfrac->{_Step}		= $sukfrac->{_Step}.' angle='.$sukfrac->{_angle};

	} else { 
		print("sukfrac, angle, missing angle,\n");
	 }
 }


=head2 sub d1 


=cut

 sub d1 {

	my ( $self,$d1 )		= @_;
	if ( $d1 ne $empty_string ) {

		$sukfrac->{_d1}		= $d1;
		$sukfrac->{_note}		= $sukfrac->{_note}.' d1='.$sukfrac->{_d1};
		$sukfrac->{_Step}		= $sukfrac->{_Step}.' d1='.$sukfrac->{_d1};

	} else { 
		print("sukfrac, d1, missing d1,\n");
	 }
 }


=head2 sub d2 


=cut

 sub d2 {

	my ( $self,$d2 )		= @_;
	if ( $d2 ne $empty_string ) {

		$sukfrac->{_d2}		= $d2;
		$sukfrac->{_note}		= $sukfrac->{_note}.' d2='.$sukfrac->{_d2};
		$sukfrac->{_Step}		= $sukfrac->{_Step}.' d2='.$sukfrac->{_d2};

	} else { 
		print("sukfrac, d2, missing d2,\n");
	 }
 }


=head2 sub phasefac 


=cut

 sub phasefac {

	my ( $self,$phasefac )		= @_;
	if ( $phasefac ne $empty_string ) {

		$sukfrac->{_phasefac}		= $phasefac;
		$sukfrac->{_note}		= $sukfrac->{_note}.' phasefac='.$sukfrac->{_phasefac};
		$sukfrac->{_Step}		= $sukfrac->{_Step}.' phasefac='.$sukfrac->{_phasefac};

	} else { 
		print("sukfrac, phasefac, missing phasefac,\n");
	 }
 }


=head2 sub power 


=cut

 sub power {

	my ( $self,$power )		= @_;
	if ( $power ne $empty_string ) {

		$sukfrac->{_power}		= $power;
		$sukfrac->{_note}		= $sukfrac->{_note}.' power='.$sukfrac->{_power};
		$sukfrac->{_Step}		= $sukfrac->{_Step}.' power='.$sukfrac->{_power};

	} else { 
		print("sukfrac, power, missing power,\n");
	 }
 }


=head2 sub sign 


=cut

 sub sign {

	my ( $self,$sign )		= @_;
	if ( $sign ne $empty_string ) {

		$sukfrac->{_sign}		= $sign;
		$sukfrac->{_note}		= $sukfrac->{_note}.' sign='.$sukfrac->{_sign};
		$sukfrac->{_Step}		= $sukfrac->{_Step}.' sign='.$sukfrac->{_sign};

	} else { 
		print("sukfrac, sign, missing sign,\n");
	 }
 }


=head2 sub w 


=cut

 sub w {

	my ( $self,$w )		= @_;
	if ( $w ne $empty_string ) {

		$sukfrac->{_w}		= $w;
		$sukfrac->{_note}		= $sukfrac->{_note}.' w='.$sukfrac->{_w};
		$sukfrac->{_Step}		= $sukfrac->{_Step}.' w='.$sukfrac->{_w};

	} else { 
		print("sukfrac, w, missing w,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 6;

    return($max_index);
}
 
 
1;
