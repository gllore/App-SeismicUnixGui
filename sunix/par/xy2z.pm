package xy2z;

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
 XY2Z - converts (X,Y)-pairs to spike Z values on a uniform grid	



    xy2z < stdin npairs= [optional parameters] >stdout 		



 Required parameter:							

 npairs= 	number of pairs input					



 Optional parameter:							

 scale=1.0	value to scale spikes by				

 nx1=100 	dimension of first (fast) dimension of output array	

 nx2=100 	dimension of second (slow) dimension of output array	

 x1pad=2	zero padding in x1 dimension				

 x2pad=2	zero padding in x2 dimension				

 yx=0		assume (x,y) pairs 					

 		=1	assume (y,x) pairs 				



 Notes: 								

 Converts ordered (x,y) pairs to spike x1values, of height=scale on a 	

 uniform grid.								





 Credits:

	CWP: John Stockwell, Nov 1995



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

my $xy2z			= {
	_height					=> '',
	_npairs					=> '',
	_nx1					=> '',
	_nx2					=> '',
	_scale					=> '',
	_x1pad					=> '',
	_x2pad					=> '',
	_yx					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$xy2z->{_Step}     = 'xy2z'.$xy2z->{_Step};
	return ( $xy2z->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$xy2z->{_note}     = 'xy2z'.$xy2z->{_note};
	return ( $xy2z->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$xy2z->{_height}			= '';
		$xy2z->{_npairs}			= '';
		$xy2z->{_nx1}			= '';
		$xy2z->{_nx2}			= '';
		$xy2z->{_scale}			= '';
		$xy2z->{_x1pad}			= '';
		$xy2z->{_x2pad}			= '';
		$xy2z->{_yx}			= '';
		$xy2z->{_Step}			= '';
		$xy2z->{_note}			= '';
 }


=head2 sub height 


=cut

 sub height {

	my ( $self,$height )		= @_;
	if ( $height ne $empty_string ) {

		$xy2z->{_height}		= $height;
		$xy2z->{_note}		= $xy2z->{_note}.' height='.$xy2z->{_height};
		$xy2z->{_Step}		= $xy2z->{_Step}.' height='.$xy2z->{_height};

	} else { 
		print("xy2z, height, missing height,\n");
	 }
 }


=head2 sub npairs 


=cut

 sub npairs {

	my ( $self,$npairs )		= @_;
	if ( $npairs ne $empty_string ) {

		$xy2z->{_npairs}		= $npairs;
		$xy2z->{_note}		= $xy2z->{_note}.' npairs='.$xy2z->{_npairs};
		$xy2z->{_Step}		= $xy2z->{_Step}.' npairs='.$xy2z->{_npairs};

	} else { 
		print("xy2z, npairs, missing npairs,\n");
	 }
 }


=head2 sub nx1 


=cut

 sub nx1 {

	my ( $self,$nx1 )		= @_;
	if ( $nx1 ne $empty_string ) {

		$xy2z->{_nx1}		= $nx1;
		$xy2z->{_note}		= $xy2z->{_note}.' nx1='.$xy2z->{_nx1};
		$xy2z->{_Step}		= $xy2z->{_Step}.' nx1='.$xy2z->{_nx1};

	} else { 
		print("xy2z, nx1, missing nx1,\n");
	 }
 }


=head2 sub nx2 


=cut

 sub nx2 {

	my ( $self,$nx2 )		= @_;
	if ( $nx2 ne $empty_string ) {

		$xy2z->{_nx2}		= $nx2;
		$xy2z->{_note}		= $xy2z->{_note}.' nx2='.$xy2z->{_nx2};
		$xy2z->{_Step}		= $xy2z->{_Step}.' nx2='.$xy2z->{_nx2};

	} else { 
		print("xy2z, nx2, missing nx2,\n");
	 }
 }


=head2 sub scale 


=cut

 sub scale {

	my ( $self,$scale )		= @_;
	if ( $scale ne $empty_string ) {

		$xy2z->{_scale}		= $scale;
		$xy2z->{_note}		= $xy2z->{_note}.' scale='.$xy2z->{_scale};
		$xy2z->{_Step}		= $xy2z->{_Step}.' scale='.$xy2z->{_scale};

	} else { 
		print("xy2z, scale, missing scale,\n");
	 }
 }


=head2 sub x1pad 


=cut

 sub x1pad {

	my ( $self,$x1pad )		= @_;
	if ( $x1pad ne $empty_string ) {

		$xy2z->{_x1pad}		= $x1pad;
		$xy2z->{_note}		= $xy2z->{_note}.' x1pad='.$xy2z->{_x1pad};
		$xy2z->{_Step}		= $xy2z->{_Step}.' x1pad='.$xy2z->{_x1pad};

	} else { 
		print("xy2z, x1pad, missing x1pad,\n");
	 }
 }


=head2 sub x2pad 


=cut

 sub x2pad {

	my ( $self,$x2pad )		= @_;
	if ( $x2pad ne $empty_string ) {

		$xy2z->{_x2pad}		= $x2pad;
		$xy2z->{_note}		= $xy2z->{_note}.' x2pad='.$xy2z->{_x2pad};
		$xy2z->{_Step}		= $xy2z->{_Step}.' x2pad='.$xy2z->{_x2pad};

	} else { 
		print("xy2z, x2pad, missing x2pad,\n");
	 }
 }


=head2 sub yx 


=cut

 sub yx {

	my ( $self,$yx )		= @_;
	if ( $yx ne $empty_string ) {

		$xy2z->{_yx}		= $yx;
		$xy2z->{_note}		= $xy2z->{_note}.' yx='.$xy2z->{_yx};
		$xy2z->{_Step}		= $xy2z->{_Step}.' yx='.$xy2z->{_yx};

	} else { 
		print("xy2z, yx, missing yx,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 7;

    return($max_index);
}
 
 
1;
