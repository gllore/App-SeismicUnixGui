package hti2stiff;

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
 HTI2STIFF - convert HTI parameters alpha, beta, d(V), e(V), gamma	

		into stiffness tensor					



    hti2stiff  [optional parameter] (output is to   outpar)		



 Optional Parameters							

 alpha=2	    isotropy-plane p-wave velocity		   	

 beta=1	     fast isotropy-plan s-wave velocity			

 ev=0		e(V) 							

 dv=0		d(V)							

 gamma=0	    shear-wave splitting parameter			

 rho=1		density							

 sign		     sign of c13+c55 ( for most materials sign=1)	

 outpar=/dev/tty    output parameter file				



 Output:								

  c_ijkl	    stiffness components for x1=symmetry axis		

		    x3= vertical					







 Credits:   Andreas Rueger, CWP Aug 01, 1996



 Reference: Andreas Rueger, P-wave reflection coefficients for

    transverse isotropy with vertical and horizontal axis

	    of symmetry,  GEOPHYSICS





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

my $hti2stiff			= {
	_alpha					=> '',
	_beta					=> '',
	_dv					=> '',
	_ev					=> '',
	_gamma					=> '',
	_outpar					=> '',
	_rho					=> '',
	_sign					=> '',
	_x1					=> '',
	_x3					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$hti2stiff->{_Step}     = 'hti2stiff'.$hti2stiff->{_Step};
	return ( $hti2stiff->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$hti2stiff->{_note}     = 'hti2stiff'.$hti2stiff->{_note};
	return ( $hti2stiff->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$hti2stiff->{_alpha}			= '';
		$hti2stiff->{_beta}			= '';
		$hti2stiff->{_dv}			= '';
		$hti2stiff->{_ev}			= '';
		$hti2stiff->{_gamma}			= '';
		$hti2stiff->{_outpar}			= '';
		$hti2stiff->{_rho}			= '';
		$hti2stiff->{_sign}			= '';
		$hti2stiff->{_x1}			= '';
		$hti2stiff->{_x3}			= '';
		$hti2stiff->{_Step}			= '';
		$hti2stiff->{_note}			= '';
 }


=head2 sub alpha 


=cut

 sub alpha {

	my ( $self,$alpha )		= @_;
	if ( $alpha ne $empty_string ) {

		$hti2stiff->{_alpha}		= $alpha;
		$hti2stiff->{_note}		= $hti2stiff->{_note}.' alpha='.$hti2stiff->{_alpha};
		$hti2stiff->{_Step}		= $hti2stiff->{_Step}.' alpha='.$hti2stiff->{_alpha};

	} else { 
		print("hti2stiff, alpha, missing alpha,\n");
	 }
 }


=head2 sub beta 


=cut

 sub beta {

	my ( $self,$beta )		= @_;
	if ( $beta ne $empty_string ) {

		$hti2stiff->{_beta}		= $beta;
		$hti2stiff->{_note}		= $hti2stiff->{_note}.' beta='.$hti2stiff->{_beta};
		$hti2stiff->{_Step}		= $hti2stiff->{_Step}.' beta='.$hti2stiff->{_beta};

	} else { 
		print("hti2stiff, beta, missing beta,\n");
	 }
 }


=head2 sub dv 


=cut

 sub dv {

	my ( $self,$dv )		= @_;
	if ( $dv ne $empty_string ) {

		$hti2stiff->{_dv}		= $dv;
		$hti2stiff->{_note}		= $hti2stiff->{_note}.' dv='.$hti2stiff->{_dv};
		$hti2stiff->{_Step}		= $hti2stiff->{_Step}.' dv='.$hti2stiff->{_dv};

	} else { 
		print("hti2stiff, dv, missing dv,\n");
	 }
 }


=head2 sub ev 


=cut

 sub ev {

	my ( $self,$ev )		= @_;
	if ( $ev ne $empty_string ) {

		$hti2stiff->{_ev}		= $ev;
		$hti2stiff->{_note}		= $hti2stiff->{_note}.' ev='.$hti2stiff->{_ev};
		$hti2stiff->{_Step}		= $hti2stiff->{_Step}.' ev='.$hti2stiff->{_ev};

	} else { 
		print("hti2stiff, ev, missing ev,\n");
	 }
 }


=head2 sub gamma 


=cut

 sub gamma {

	my ( $self,$gamma )		= @_;
	if ( $gamma ne $empty_string ) {

		$hti2stiff->{_gamma}		= $gamma;
		$hti2stiff->{_note}		= $hti2stiff->{_note}.' gamma='.$hti2stiff->{_gamma};
		$hti2stiff->{_Step}		= $hti2stiff->{_Step}.' gamma='.$hti2stiff->{_gamma};

	} else { 
		print("hti2stiff, gamma, missing gamma,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$hti2stiff->{_outpar}		= $outpar;
		$hti2stiff->{_note}		= $hti2stiff->{_note}.' outpar='.$hti2stiff->{_outpar};
		$hti2stiff->{_Step}		= $hti2stiff->{_Step}.' outpar='.$hti2stiff->{_outpar};

	} else { 
		print("hti2stiff, outpar, missing outpar,\n");
	 }
 }


=head2 sub rho 


=cut

 sub rho {

	my ( $self,$rho )		= @_;
	if ( $rho ne $empty_string ) {

		$hti2stiff->{_rho}		= $rho;
		$hti2stiff->{_note}		= $hti2stiff->{_note}.' rho='.$hti2stiff->{_rho};
		$hti2stiff->{_Step}		= $hti2stiff->{_Step}.' rho='.$hti2stiff->{_rho};

	} else { 
		print("hti2stiff, rho, missing rho,\n");
	 }
 }


=head2 sub sign 


=cut

 sub sign {

	my ( $self,$sign )		= @_;
	if ( $sign ne $empty_string ) {

		$hti2stiff->{_sign}		= $sign;
		$hti2stiff->{_note}		= $hti2stiff->{_note}.' sign='.$hti2stiff->{_sign};
		$hti2stiff->{_Step}		= $hti2stiff->{_Step}.' sign='.$hti2stiff->{_sign};

	} else { 
		print("hti2stiff, sign, missing sign,\n");
	 }
 }


=head2 sub x1 


=cut

 sub x1 {

	my ( $self,$x1 )		= @_;
	if ( $x1 ne $empty_string ) {

		$hti2stiff->{_x1}		= $x1;
		$hti2stiff->{_note}		= $hti2stiff->{_note}.' x1='.$hti2stiff->{_x1};
		$hti2stiff->{_Step}		= $hti2stiff->{_Step}.' x1='.$hti2stiff->{_x1};

	} else { 
		print("hti2stiff, x1, missing x1,\n");
	 }
 }


=head2 sub x3 


=cut

 sub x3 {

	my ( $self,$x3 )		= @_;
	if ( $x3 ne $empty_string ) {

		$hti2stiff->{_x3}		= $x3;
		$hti2stiff->{_note}		= $hti2stiff->{_note}.' x3='.$hti2stiff->{_x3};
		$hti2stiff->{_Step}		= $hti2stiff->{_Step}.' x3='.$hti2stiff->{_x3};

	} else { 
		print("hti2stiff, x3, missing x3,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 9;

    return($max_index);
}
 
 
1;
