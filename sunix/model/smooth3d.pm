package smooth3d;

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
 SMOOTH3D - 3D grid velocity SMOOTHing by the damped least squares	



	smooth3d <infile >outfile [parameters]				



 Required Parameters:							

 n1=		number of samples along 1st dimension			

 n2=		number of samples along 2nd dimension			

 n3=		number of samples along 3rd dimension			



 Optional Parameters:							



 Smoothing parameters (0 = no smoothing)				

 r1=0.0	operator length in 1st dimension			

 r2=0.0	operator length in 2nd dimension			

 r3=0.0	operator length in 3rd dimension			



 Sample intervals:							

 d1=1.0	1st dimension						

 d2=1.0	2nd dimension						

 d3=1.0	3rd dimension						

 iter=2	number of iteration used				

 time=0	which dimension the time axis is (0 = no time axis)	

 depth=1	which dimension the depth axis is (ignored when time>0)	

 mu=1		the relative weight at maximum depth (or time)		

 verbose=0	=1 for printing minimum wavelengths			

 slowness=0	=1 smoothing on slowness; =0 smoothing on velocity	

 vminc=0	velocity values below it are cliped before smoothing	

 vmaxc=99999	velocity values above it are cliped before smoothing	



 Notes:								

 1. The larger the smoothing parameters, the smoother the output velocity.

    These parameters are lengths of smoothing operators in each dimension.

 2. iter controls the orders of derivatives to be smoothed in the output

    velocity. e.g., iter=2 means derivatives until 2nd order smoothed.	

 3. mu is the multipler of smoothing parameters at the bottom compared to

    those at the surface.						

 4. Minimum wavelengths of each dimension and the total may be printed	

   for the resulting output velocity is. To compute these parameters for

   the input velocity, use r1=r2=r3=0.					

 5. Smoothing directly on slowness works better to preserve traveltime.

   So the program optionally converts the input velocity into slowness	", 

   and smooths the slowness, then converts back into velocity.		







 Author:  CWP: Zhenyue Liu  March 1995



 Reference:

 Liu, Z., 1994,"A velocity smoothing technique based on damped least squares

		in Project Reveiew, May 10, 1994, Consortium Project on

		Seismic Inverse Methods for Complex Stuctures.



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

my $smooth3d			= {
	_d1					=> '',
	_d2					=> '',
	_d3					=> '',
	_depth					=> '',
	_iter					=> '',
	_mu					=> '',
	_n1					=> '',
	_n2					=> '',
	_n3					=> '',
	_r1					=> '',
	_r2					=> '',
	_r3					=> '',
	_slowness					=> '',
	_time					=> '',
	_verbose					=> '',
	_vmaxc					=> '',
	_vminc					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$smooth3d->{_Step}     = 'smooth3d'.$smooth3d->{_Step};
	return ( $smooth3d->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$smooth3d->{_note}     = 'smooth3d'.$smooth3d->{_note};
	return ( $smooth3d->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$smooth3d->{_d1}			= '';
		$smooth3d->{_d2}			= '';
		$smooth3d->{_d3}			= '';
		$smooth3d->{_depth}			= '';
		$smooth3d->{_iter}			= '';
		$smooth3d->{_mu}			= '';
		$smooth3d->{_n1}			= '';
		$smooth3d->{_n2}			= '';
		$smooth3d->{_n3}			= '';
		$smooth3d->{_r1}			= '';
		$smooth3d->{_r2}			= '';
		$smooth3d->{_r3}			= '';
		$smooth3d->{_slowness}			= '';
		$smooth3d->{_time}			= '';
		$smooth3d->{_verbose}			= '';
		$smooth3d->{_vmaxc}			= '';
		$smooth3d->{_vminc}			= '';
		$smooth3d->{_Step}			= '';
		$smooth3d->{_note}			= '';
 }


=head2 sub d1 


=cut

 sub d1 {

	my ( $self,$d1 )		= @_;
	if ( $d1 ne $empty_string ) {

		$smooth3d->{_d1}		= $d1;
		$smooth3d->{_note}		= $smooth3d->{_note}.' d1='.$smooth3d->{_d1};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' d1='.$smooth3d->{_d1};

	} else { 
		print("smooth3d, d1, missing d1,\n");
	 }
 }


=head2 sub d2 


=cut

 sub d2 {

	my ( $self,$d2 )		= @_;
	if ( $d2 ne $empty_string ) {

		$smooth3d->{_d2}		= $d2;
		$smooth3d->{_note}		= $smooth3d->{_note}.' d2='.$smooth3d->{_d2};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' d2='.$smooth3d->{_d2};

	} else { 
		print("smooth3d, d2, missing d2,\n");
	 }
 }


=head2 sub d3 


=cut

 sub d3 {

	my ( $self,$d3 )		= @_;
	if ( $d3 ne $empty_string ) {

		$smooth3d->{_d3}		= $d3;
		$smooth3d->{_note}		= $smooth3d->{_note}.' d3='.$smooth3d->{_d3};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' d3='.$smooth3d->{_d3};

	} else { 
		print("smooth3d, d3, missing d3,\n");
	 }
 }


=head2 sub depth 


=cut

 sub depth {

	my ( $self,$depth )		= @_;
	if ( $depth ne $empty_string ) {

		$smooth3d->{_depth}		= $depth;
		$smooth3d->{_note}		= $smooth3d->{_note}.' depth='.$smooth3d->{_depth};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' depth='.$smooth3d->{_depth};

	} else { 
		print("smooth3d, depth, missing depth,\n");
	 }
 }


=head2 sub iter 


=cut

 sub iter {

	my ( $self,$iter )		= @_;
	if ( $iter ne $empty_string ) {

		$smooth3d->{_iter}		= $iter;
		$smooth3d->{_note}		= $smooth3d->{_note}.' iter='.$smooth3d->{_iter};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' iter='.$smooth3d->{_iter};

	} else { 
		print("smooth3d, iter, missing iter,\n");
	 }
 }


=head2 sub mu 


=cut

 sub mu {

	my ( $self,$mu )		= @_;
	if ( $mu ne $empty_string ) {

		$smooth3d->{_mu}		= $mu;
		$smooth3d->{_note}		= $smooth3d->{_note}.' mu='.$smooth3d->{_mu};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' mu='.$smooth3d->{_mu};

	} else { 
		print("smooth3d, mu, missing mu,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$smooth3d->{_n1}		= $n1;
		$smooth3d->{_note}		= $smooth3d->{_note}.' n1='.$smooth3d->{_n1};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' n1='.$smooth3d->{_n1};

	} else { 
		print("smooth3d, n1, missing n1,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$smooth3d->{_n2}		= $n2;
		$smooth3d->{_note}		= $smooth3d->{_note}.' n2='.$smooth3d->{_n2};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' n2='.$smooth3d->{_n2};

	} else { 
		print("smooth3d, n2, missing n2,\n");
	 }
 }


=head2 sub n3 


=cut

 sub n3 {

	my ( $self,$n3 )		= @_;
	if ( $n3 ne $empty_string ) {

		$smooth3d->{_n3}		= $n3;
		$smooth3d->{_note}		= $smooth3d->{_note}.' n3='.$smooth3d->{_n3};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' n3='.$smooth3d->{_n3};

	} else { 
		print("smooth3d, n3, missing n3,\n");
	 }
 }


=head2 sub r1 


=cut

 sub r1 {

	my ( $self,$r1 )		= @_;
	if ( $r1 ne $empty_string ) {

		$smooth3d->{_r1}		= $r1;
		$smooth3d->{_note}		= $smooth3d->{_note}.' r1='.$smooth3d->{_r1};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' r1='.$smooth3d->{_r1};

	} else { 
		print("smooth3d, r1, missing r1,\n");
	 }
 }


=head2 sub r2 


=cut

 sub r2 {

	my ( $self,$r2 )		= @_;
	if ( $r2 ne $empty_string ) {

		$smooth3d->{_r2}		= $r2;
		$smooth3d->{_note}		= $smooth3d->{_note}.' r2='.$smooth3d->{_r2};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' r2='.$smooth3d->{_r2};

	} else { 
		print("smooth3d, r2, missing r2,\n");
	 }
 }


=head2 sub r3 


=cut

 sub r3 {

	my ( $self,$r3 )		= @_;
	if ( $r3 ne $empty_string ) {

		$smooth3d->{_r3}		= $r3;
		$smooth3d->{_note}		= $smooth3d->{_note}.' r3='.$smooth3d->{_r3};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' r3='.$smooth3d->{_r3};

	} else { 
		print("smooth3d, r3, missing r3,\n");
	 }
 }


=head2 sub slowness 


=cut

 sub slowness {

	my ( $self,$slowness )		= @_;
	if ( $slowness ne $empty_string ) {

		$smooth3d->{_slowness}		= $slowness;
		$smooth3d->{_note}		= $smooth3d->{_note}.' slowness='.$smooth3d->{_slowness};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' slowness='.$smooth3d->{_slowness};

	} else { 
		print("smooth3d, slowness, missing slowness,\n");
	 }
 }


=head2 sub time 


=cut

 sub time {

	my ( $self,$time )		= @_;
	if ( $time ne $empty_string ) {

		$smooth3d->{_time}		= $time;
		$smooth3d->{_note}		= $smooth3d->{_note}.' time='.$smooth3d->{_time};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' time='.$smooth3d->{_time};

	} else { 
		print("smooth3d, time, missing time,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$smooth3d->{_verbose}		= $verbose;
		$smooth3d->{_note}		= $smooth3d->{_note}.' verbose='.$smooth3d->{_verbose};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' verbose='.$smooth3d->{_verbose};

	} else { 
		print("smooth3d, verbose, missing verbose,\n");
	 }
 }


=head2 sub vmaxc 


=cut

 sub vmaxc {

	my ( $self,$vmaxc )		= @_;
	if ( $vmaxc ne $empty_string ) {

		$smooth3d->{_vmaxc}		= $vmaxc;
		$smooth3d->{_note}		= $smooth3d->{_note}.' vmaxc='.$smooth3d->{_vmaxc};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' vmaxc='.$smooth3d->{_vmaxc};

	} else { 
		print("smooth3d, vmaxc, missing vmaxc,\n");
	 }
 }


=head2 sub vminc 


=cut

 sub vminc {

	my ( $self,$vminc )		= @_;
	if ( $vminc ne $empty_string ) {

		$smooth3d->{_vminc}		= $vminc;
		$smooth3d->{_note}		= $smooth3d->{_note}.' vminc='.$smooth3d->{_vminc};
		$smooth3d->{_Step}		= $smooth3d->{_Step}.' vminc='.$smooth3d->{_vminc};

	} else { 
		print("smooth3d, vminc, missing vminc,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 16;

    return($max_index);
}
 
 
1;
