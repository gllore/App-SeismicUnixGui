package hudson;

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
  HUDSON - compute  effective parameters of anisotropic solids	        

	   using Hudson's crack theory.                      		



 Required paramters: <none>                                             



 Optional parameters                                                   



 vp=4.5        p-wave velocity uncracked solid                  	

 vs=2.53       s-wave velocity uncracked solid                         

 rho=2.8       density      						

 cdens=0	crack density					        

 aspect=0      aspect ratio                                            

 fill=0        gas filled cracks                                       

               =1 water filled                                         

 outpar        =/dev/tty   output file                                 

 

Notes:									

 The cracks are assumed to be vertically aligned, penny-shaped and the	

 matrix is isotropic. The resulting anisotropic solid is of HTI symmetry.



 Output:                                                               

 Computes(a) stiffness elements                                        

         (b) density normalized stiffness components                   

         (c) generic Thomsen parameters (vp0,vs0,eps,delta,gamma)      

         (d) equivalent VTI parameters (alpha,beta,ev,dv,gv)           



 





 

 AUTHOR:: Andreas Rueger, Colorado School of Mines, 10/10/96

  

 Additional notes: 

  The routine can be easily modified to allow for any 

  filling adding attenuation is not trivial



 Technical Reference:

  Hudson's theory: Hudson, 1981: Wave speed and attenuation of elastic

                                 waves in material containing cracks.

                                 Geophys. J. R. astr. Soc 64, 133-150

                  Crampin, 1984: Effective anisotropic elastic constants

                                 for waves propagating through cracked

                                 solids: 

				  Geophys. J. R. astr. Soc 76, 135-145

  Equivalent VTI : Rueger, 1996: Reflection coefficients in transversely

                                 isotropic media with vertical and 

                                 horizontal axis of symmetry: Geophysics



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

my $hudson			= {
	_aspect					=> '',
	_cdens					=> '',
	_fill					=> '',
	_outpar					=> '',
	_rho					=> '',
	_vp					=> '',
	_vs					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$hudson->{_Step}     = 'hudson'.$hudson->{_Step};
	return ( $hudson->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$hudson->{_note}     = 'hudson'.$hudson->{_note};
	return ( $hudson->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$hudson->{_aspect}			= '';
		$hudson->{_cdens}			= '';
		$hudson->{_fill}			= '';
		$hudson->{_outpar}			= '';
		$hudson->{_rho}			= '';
		$hudson->{_vp}			= '';
		$hudson->{_vs}			= '';
		$hudson->{_Step}			= '';
		$hudson->{_note}			= '';
 }


=head2 sub aspect 


=cut

 sub aspect {

	my ( $self,$aspect )		= @_;
	if ( $aspect ne $empty_string ) {

		$hudson->{_aspect}		= $aspect;
		$hudson->{_note}		= $hudson->{_note}.' aspect='.$hudson->{_aspect};
		$hudson->{_Step}		= $hudson->{_Step}.' aspect='.$hudson->{_aspect};

	} else { 
		print("hudson, aspect, missing aspect,\n");
	 }
 }


=head2 sub cdens 


=cut

 sub cdens {

	my ( $self,$cdens )		= @_;
	if ( $cdens ne $empty_string ) {

		$hudson->{_cdens}		= $cdens;
		$hudson->{_note}		= $hudson->{_note}.' cdens='.$hudson->{_cdens};
		$hudson->{_Step}		= $hudson->{_Step}.' cdens='.$hudson->{_cdens};

	} else { 
		print("hudson, cdens, missing cdens,\n");
	 }
 }


=head2 sub fill 


=cut

 sub fill {

	my ( $self,$fill )		= @_;
	if ( $fill ne $empty_string ) {

		$hudson->{_fill}		= $fill;
		$hudson->{_note}		= $hudson->{_note}.' fill='.$hudson->{_fill};
		$hudson->{_Step}		= $hudson->{_Step}.' fill='.$hudson->{_fill};

	} else { 
		print("hudson, fill, missing fill,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$hudson->{_outpar}		= $outpar;
		$hudson->{_note}		= $hudson->{_note}.' outpar='.$hudson->{_outpar};
		$hudson->{_Step}		= $hudson->{_Step}.' outpar='.$hudson->{_outpar};

	} else { 
		print("hudson, outpar, missing outpar,\n");
	 }
 }


=head2 sub rho 


=cut

 sub rho {

	my ( $self,$rho )		= @_;
	if ( $rho ne $empty_string ) {

		$hudson->{_rho}		= $rho;
		$hudson->{_note}		= $hudson->{_note}.' rho='.$hudson->{_rho};
		$hudson->{_Step}		= $hudson->{_Step}.' rho='.$hudson->{_rho};

	} else { 
		print("hudson, rho, missing rho,\n");
	 }
 }


=head2 sub vp 


=cut

 sub vp {

	my ( $self,$vp )		= @_;
	if ( $vp ne $empty_string ) {

		$hudson->{_vp}		= $vp;
		$hudson->{_note}		= $hudson->{_note}.' vp='.$hudson->{_vp};
		$hudson->{_Step}		= $hudson->{_Step}.' vp='.$hudson->{_vp};

	} else { 
		print("hudson, vp, missing vp,\n");
	 }
 }


=head2 sub vs 


=cut

 sub vs {

	my ( $self,$vs )		= @_;
	if ( $vs ne $empty_string ) {

		$hudson->{_vs}		= $vs;
		$hudson->{_note}		= $hudson->{_note}.' vs='.$hudson->{_vs};
		$hudson->{_Step}		= $hudson->{_Step}.' vs='.$hudson->{_vs};

	} else { 
		print("hudson, vs, missing vs,\n");
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
