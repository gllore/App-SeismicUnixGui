package suwindpoly;

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
 SUWINDPOLY - WINDow data to extract traces on or within a respective	

	POLYgonal line or POLYgon with coordinates specified by header	

	keyword values 							



  suwindpoly <stdin [Required parameters] [Optional params] file=outfile



 Required parameters:							

 x=x1,x2,...	list of X coordinates for vertices			

 y=y1,y2,...	list of Y coordinates for vertices			

 file=file1,file2,..	output filename(s)				



 Optional parameters							

 xkey=fldr	X coordinate header key					

 ykey=ep	Y coordinate header key					

 pass=0 	polyline mode: pass traces near the polygonal line	

		=1 pass all traces interior to polygon			

		=2 pass all traces exterior to polygon			



 Optional parameters used in polyline pass=0 mode only:		

 The following need to be given if the unit increments in the X & Y	

 directions are not equal.  For example, if fldr increments by 1 and	

 ep increments by 4 to form 25 x 25 m bins specify dx=25.0 & dy=6.25.	

 The output binning key will be converted to integers by the scaling	

 with the smaller of the two values.					



 dx=1.0	unit increment distance in X direction			

 dy=1.0	unit increment distance in Y direction			

 ilkey=tracl	key for resulting inline index in polyline mode		

 xlkey=tracr	key for resulting xline index in polyline mode		

 dw=1.0	distance in X-Y coordinate units of extracted line	

		to pass points to output.  Width of resulting line is	

		2*dw.  Ignored if polygon mode is specified.		

 Notes:								

 In polyline mode (pass=0), a single trace may be output multiple times

 if it meets the acceptance criteria (distance from line segment < dw)	

 for multiple line segments. However, the headers will be distinct	

 and will associate the output trace with a line segment. This		

 behavior facilitates creation of 3D supergathers from polyline	

 output. Use susort after running in polyline mode.			



 x=& y=lists should be repeated for as many polygons as needed when  

 pass=1 or pass=2. 							



 In polygon mode, the polygon closes itself from the last vertex to	

 the first.								



 Example:								

  suwindpoly <input.su x=10,20,50 y=0,30,60 dw=10 pass=0 file=out.su	







 Credits:  Reginald H. Beardsley	rhb@acm.org

	    originally: suxarb.c adapted from the SLT/SU package.





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

my $suwindpoly			= {
	_dw					=> '',
	_dx					=> '',
	_dy					=> '',
	_file					=> '',
	_ilkey					=> '',
	_pass					=> '',
	_x					=> '',
	_xkey					=> '',
	_xlkey					=> '',
	_y					=> '',
	_ykey					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suwindpoly->{_Step}     = 'suwindpoly'.$suwindpoly->{_Step};
	return ( $suwindpoly->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suwindpoly->{_note}     = 'suwindpoly'.$suwindpoly->{_note};
	return ( $suwindpoly->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$suwindpoly->{_dw}			= '';
		$suwindpoly->{_dx}			= '';
		$suwindpoly->{_dy}			= '';
		$suwindpoly->{_file}			= '';
		$suwindpoly->{_ilkey}			= '';
		$suwindpoly->{_pass}			= '';
		$suwindpoly->{_x}			= '';
		$suwindpoly->{_xkey}			= '';
		$suwindpoly->{_xlkey}			= '';
		$suwindpoly->{_y}			= '';
		$suwindpoly->{_ykey}			= '';
		$suwindpoly->{_Step}			= '';
		$suwindpoly->{_note}			= '';
 }


=head2 sub dw 


=cut

 sub dw {

	my ( $self,$dw )		= @_;
	if ( $dw ne $empty_string ) {

		$suwindpoly->{_dw}		= $dw;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' dw='.$suwindpoly->{_dw};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' dw='.$suwindpoly->{_dw};

	} else { 
		print("suwindpoly, dw, missing dw,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$suwindpoly->{_dx}		= $dx;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' dx='.$suwindpoly->{_dx};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' dx='.$suwindpoly->{_dx};

	} else { 
		print("suwindpoly, dx, missing dx,\n");
	 }
 }


=head2 sub dy 


=cut

 sub dy {

	my ( $self,$dy )		= @_;
	if ( $dy ne $empty_string ) {

		$suwindpoly->{_dy}		= $dy;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' dy='.$suwindpoly->{_dy};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' dy='.$suwindpoly->{_dy};

	} else { 
		print("suwindpoly, dy, missing dy,\n");
	 }
 }


=head2 sub file 


=cut

 sub file {

	my ( $self,$file )		= @_;
	if ( $file ne $empty_string ) {

		$suwindpoly->{_file}		= $file;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' file='.$suwindpoly->{_file};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' file='.$suwindpoly->{_file};

	} else { 
		print("suwindpoly, file, missing file,\n");
	 }
 }


=head2 sub ilkey 


=cut

 sub ilkey {

	my ( $self,$ilkey )		= @_;
	if ( $ilkey ne $empty_string ) {

		$suwindpoly->{_ilkey}		= $ilkey;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' ilkey='.$suwindpoly->{_ilkey};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' ilkey='.$suwindpoly->{_ilkey};

	} else { 
		print("suwindpoly, ilkey, missing ilkey,\n");
	 }
 }


=head2 sub pass 


=cut

 sub pass {

	my ( $self,$pass )		= @_;
	if ( $pass ne $empty_string ) {

		$suwindpoly->{_pass}		= $pass;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' pass='.$suwindpoly->{_pass};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' pass='.$suwindpoly->{_pass};

	} else { 
		print("suwindpoly, pass, missing pass,\n");
	 }
 }


=head2 sub x 


=cut

 sub x {

	my ( $self,$x )		= @_;
	if ( $x ne $empty_string ) {

		$suwindpoly->{_x}		= $x;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' x='.$suwindpoly->{_x};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' x='.$suwindpoly->{_x};

	} else { 
		print("suwindpoly, x, missing x,\n");
	 }
 }


=head2 sub xkey 


=cut

 sub xkey {

	my ( $self,$xkey )		= @_;
	if ( $xkey ne $empty_string ) {

		$suwindpoly->{_xkey}		= $xkey;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' xkey='.$suwindpoly->{_xkey};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' xkey='.$suwindpoly->{_xkey};

	} else { 
		print("suwindpoly, xkey, missing xkey,\n");
	 }
 }


=head2 sub xlkey 


=cut

 sub xlkey {

	my ( $self,$xlkey )		= @_;
	if ( $xlkey ne $empty_string ) {

		$suwindpoly->{_xlkey}		= $xlkey;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' xlkey='.$suwindpoly->{_xlkey};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' xlkey='.$suwindpoly->{_xlkey};

	} else { 
		print("suwindpoly, xlkey, missing xlkey,\n");
	 }
 }


=head2 sub y 


=cut

 sub y {

	my ( $self,$y )		= @_;
	if ( $y ne $empty_string ) {

		$suwindpoly->{_y}		= $y;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' y='.$suwindpoly->{_y};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' y='.$suwindpoly->{_y};

	} else { 
		print("suwindpoly, y, missing y,\n");
	 }
 }


=head2 sub ykey 


=cut

 sub ykey {

	my ( $self,$ykey )		= @_;
	if ( $ykey ne $empty_string ) {

		$suwindpoly->{_ykey}		= $ykey;
		$suwindpoly->{_note}		= $suwindpoly->{_note}.' ykey='.$suwindpoly->{_ykey};
		$suwindpoly->{_Step}		= $suwindpoly->{_Step}.' ykey='.$suwindpoly->{_ykey};

	} else { 
		print("suwindpoly, ykey, missing ykey,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 10;

    return($max_index);
}
 
 
1;
