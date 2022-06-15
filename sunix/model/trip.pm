package trip;

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
 TRIP - TRI-Plane 3D data viewer					



 trip < datain [parameters] 		 				



 Required parameters:							

 n1=	   	number of x samples (1st dimension)		     	

 n2=	   	number of y samples (2nd dimension) 			

 n3=		number of z samples (3nd dimension) 			



 Optional Parameters:							

 cx=n2/n2s/2 (integer) x-intercept of view plane facing x-axis		",	

 cy=n3/n3s/2 (integer) y-intercept of view plane facing y-axis		",	

 cz=n1/n1s/2 (integer) z-intercept of view plane facing z-axis		

 n1s=1	stride in the fastest dimension					

 n2s=1	stride in the second dimension					

 n3s=1	stride in the third dimension					

 hue=1		for hue and 0 for bw 					

 q=-0.6,0.06,-0.06,0.8 define the quaternion				

 tbs=0.8 the lager the slower it rotates                     	 	





 Credits:

  	CWP: Zhaobo Meng, 1996



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

my $trip			= {
	_cx					=> '',
	_cy					=> '',
	_cz					=> '',
	_hue					=> '',
	_n1					=> '',
	_n1s					=> '',
	_n2					=> '',
	_n2s					=> '',
	_n3					=> '',
	_n3s					=> '',
	_q					=> '',
	_tbs					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$trip->{_Step}     = 'trip'.$trip->{_Step};
	return ( $trip->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$trip->{_note}     = 'trip'.$trip->{_note};
	return ( $trip->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$trip->{_cx}			= '';
		$trip->{_cy}			= '';
		$trip->{_cz}			= '';
		$trip->{_hue}			= '';
		$trip->{_n1}			= '';
		$trip->{_n1s}			= '';
		$trip->{_n2}			= '';
		$trip->{_n2s}			= '';
		$trip->{_n3}			= '';
		$trip->{_n3s}			= '';
		$trip->{_q}			= '';
		$trip->{_tbs}			= '';
		$trip->{_Step}			= '';
		$trip->{_note}			= '';
 }


=head2 sub cx 


=cut

 sub cx {

	my ( $self,$cx )		= @_;
	if ( $cx ne $empty_string ) {

		$trip->{_cx}		= $cx;
		$trip->{_note}		= $trip->{_note}.' cx='.$trip->{_cx};
		$trip->{_Step}		= $trip->{_Step}.' cx='.$trip->{_cx};

	} else { 
		print("trip, cx, missing cx,\n");
	 }
 }


=head2 sub cy 


=cut

 sub cy {

	my ( $self,$cy )		= @_;
	if ( $cy ne $empty_string ) {

		$trip->{_cy}		= $cy;
		$trip->{_note}		= $trip->{_note}.' cy='.$trip->{_cy};
		$trip->{_Step}		= $trip->{_Step}.' cy='.$trip->{_cy};

	} else { 
		print("trip, cy, missing cy,\n");
	 }
 }


=head2 sub cz 


=cut

 sub cz {

	my ( $self,$cz )		= @_;
	if ( $cz ne $empty_string ) {

		$trip->{_cz}		= $cz;
		$trip->{_note}		= $trip->{_note}.' cz='.$trip->{_cz};
		$trip->{_Step}		= $trip->{_Step}.' cz='.$trip->{_cz};

	} else { 
		print("trip, cz, missing cz,\n");
	 }
 }


=head2 sub hue 


=cut

 sub hue {

	my ( $self,$hue )		= @_;
	if ( $hue ne $empty_string ) {

		$trip->{_hue}		= $hue;
		$trip->{_note}		= $trip->{_note}.' hue='.$trip->{_hue};
		$trip->{_Step}		= $trip->{_Step}.' hue='.$trip->{_hue};

	} else { 
		print("trip, hue, missing hue,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$trip->{_n1}		= $n1;
		$trip->{_note}		= $trip->{_note}.' n1='.$trip->{_n1};
		$trip->{_Step}		= $trip->{_Step}.' n1='.$trip->{_n1};

	} else { 
		print("trip, n1, missing n1,\n");
	 }
 }


=head2 sub n1s 


=cut

 sub n1s {

	my ( $self,$n1s )		= @_;
	if ( $n1s ne $empty_string ) {

		$trip->{_n1s}		= $n1s;
		$trip->{_note}		= $trip->{_note}.' n1s='.$trip->{_n1s};
		$trip->{_Step}		= $trip->{_Step}.' n1s='.$trip->{_n1s};

	} else { 
		print("trip, n1s, missing n1s,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$trip->{_n2}		= $n2;
		$trip->{_note}		= $trip->{_note}.' n2='.$trip->{_n2};
		$trip->{_Step}		= $trip->{_Step}.' n2='.$trip->{_n2};

	} else { 
		print("trip, n2, missing n2,\n");
	 }
 }


=head2 sub n2s 


=cut

 sub n2s {

	my ( $self,$n2s )		= @_;
	if ( $n2s ne $empty_string ) {

		$trip->{_n2s}		= $n2s;
		$trip->{_note}		= $trip->{_note}.' n2s='.$trip->{_n2s};
		$trip->{_Step}		= $trip->{_Step}.' n2s='.$trip->{_n2s};

	} else { 
		print("trip, n2s, missing n2s,\n");
	 }
 }


=head2 sub n3 


=cut

 sub n3 {

	my ( $self,$n3 )		= @_;
	if ( $n3 ne $empty_string ) {

		$trip->{_n3}		= $n3;
		$trip->{_note}		= $trip->{_note}.' n3='.$trip->{_n3};
		$trip->{_Step}		= $trip->{_Step}.' n3='.$trip->{_n3};

	} else { 
		print("trip, n3, missing n3,\n");
	 }
 }


=head2 sub n3s 


=cut

 sub n3s {

	my ( $self,$n3s )		= @_;
	if ( $n3s ne $empty_string ) {

		$trip->{_n3s}		= $n3s;
		$trip->{_note}		= $trip->{_note}.' n3s='.$trip->{_n3s};
		$trip->{_Step}		= $trip->{_Step}.' n3s='.$trip->{_n3s};

	} else { 
		print("trip, n3s, missing n3s,\n");
	 }
 }


=head2 sub q 


=cut

 sub q {

	my ( $self,$q )		= @_;
	if ( $q ne $empty_string ) {

		$trip->{_q}		= $q;
		$trip->{_note}		= $trip->{_note}.' q='.$trip->{_q};
		$trip->{_Step}		= $trip->{_Step}.' q='.$trip->{_q};

	} else { 
		print("trip, q, missing q,\n");
	 }
 }


=head2 sub tbs 


=cut

 sub tbs {

	my ( $self,$tbs )		= @_;
	if ( $tbs ne $empty_string ) {

		$trip->{_tbs}		= $tbs;
		$trip->{_note}		= $trip->{_note}.' tbs='.$trip->{_tbs};
		$trip->{_Step}		= $trip->{_Step}.' tbs='.$trip->{_tbs};

	} else { 
		print("trip, tbs, missing tbs,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 11;

    return($max_index);
}
 
 
1;
