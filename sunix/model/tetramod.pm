package tetramod;

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
 TETRAMOD - TETRAhedron MODel builder. In each layer, velocity gradient

       is constant or a 2-D grid; horizons could be a uniform grid and/or

       added by a 2-D grid specified.   				



 tetramod [parameters] > tetrafile		 			



 Required parameters:							



 nxhz=		number of samples (2nd dimension) for horizons		

 nyhz=		number of samples (1st dimension) for horizons		

 hzfile=	output xhz,yhz,zhz,v0hz,v1hz for viewer3                



 Optional parameters:							



 xmin=0       	x of the lower left point in the model	        	

 ymin=0        y of the lower left point in the model                  

 xmax=2        x of the upper right point in the model                 

 ymax=2        y of the upper right point in the model                 

 zmax=(max z)  max z in the model                                      

 blt=1.0       bottom layer thickness                                  

 nhz=1		number of layers in the model (except the model base)	

 ficth=-1      ficticious horizons (no velocity interpolation based on them)

 The following four numbers define the four corners for 3-D model;	

 z00=0,0.6,1.2,... 	z at (xmin,ymin) on each horizon		

 z01=0,0.6,1.2,... 	z at (xmin,ymax) on each horizon		

 z10=0,0.6,1.2,... 	z at (xmax,ymin) on each horizon                

 z11=0,0.6,1.2,... 	z at (xmax,ymax) on each horizon                

 v00=1.0,2.0,3.0,...	v at (xmin,ymin) on each horizon		

 v01=1.0,2.0,3.0,...	v at (xmin,ymax) on each horizon		

 v10=1.0,2.0,3.0,...	v at (xmax,xmin) on each horizon                

 v11=1.0,2.0,3.0,...	v at (xmax,xmax) on each horizon                

 dvdz00=0,0,0,...   	dvdz at (xmin,ymin) on each horizon		

 dvdz01=0,0,0,...   	dvdz at (xmin,ymax) on each horizon		

 dvdz10=0,0,0,...   	dvdz at (xmax,xmin) on each horizon             

 dvdz11=0,0,0,...   	dvdz at (xmax,xmax) on each horizon             

 x0file=   	x grid for horizon 0 					

 y0file=   	y grid for horizon 0 					

 z0file=	z grid for horizon 0 added to 4-z interpolation   	

 v0file=	v grid for horizon 0 added to 4-v interpolation   	

 dvdz0file=	dvdz grid for horizon 00 added to 4-dvdz interpolation	



 x1file=	x grid for horizon 1					

 y1file=	y grid for horizon 1					

 z1file=	z grid for horizon 1 added to 4-z interpolation  	

 v1file=	v grid for horizon 1 added to 4-v interpolation  	

 dvdz1file=	dvdz grid for horizon 1 added to 4-dvdz interpolation	

 ...		for horizon  #2, #3 #4, etc... 				

 verbose=0	=1 print some useful iinformation			



 Remarks:								

 TETRAMOD defines its own grammar to describe a 3-D model (including a 

 tetra file for ray tracer SUTETRARAY and a horizon file for VIEWER3   



 Disclaimer:                                                           

 This is a research code that will take considerable work to get into  

 the form of a a production level 3D migration code. The code is       

 offered as is, along with tetramod and sukdmig3d, to provide a starting

 point for researchers who wish to write their own 3D migration codes.







 Credits:

  	CWP: Zhaobo Meng, 1996



  Reference:

  Zhaobo Meng and Norman Bleistein, Wavefront Construction (WF) Ray

 "Tracing in Tetrahedral Models -- Application to 3-D traveltime and

  ray path computations, CWP report 251, 1997





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

my $tetramod			= {
	_blt					=> '',
	_dvdz00					=> '',
	_dvdz01					=> '',
	_dvdz0file					=> '',
	_dvdz10					=> '',
	_dvdz11					=> '',
	_dvdz1file					=> '',
	_ficth					=> '',
	_hzfile					=> '',
	_nhz					=> '',
	_nxhz					=> '',
	_nyhz					=> '',
	_v00					=> '',
	_v01					=> '',
	_v0file					=> '',
	_v10					=> '',
	_v11					=> '',
	_v1file					=> '',
	_verbose					=> '',
	_x0file					=> '',
	_x1file					=> '',
	_xmax					=> '',
	_xmin					=> '',
	_y0file					=> '',
	_y1file					=> '',
	_ymax					=> '',
	_ymin					=> '',
	_z00					=> '',
	_z01					=> '',
	_z0file					=> '',
	_z10					=> '',
	_z11					=> '',
	_z1file					=> '',
	_zmax					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$tetramod->{_Step}     = 'tetramod'.$tetramod->{_Step};
	return ( $tetramod->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$tetramod->{_note}     = 'tetramod'.$tetramod->{_note};
	return ( $tetramod->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$tetramod->{_blt}			= '';
		$tetramod->{_dvdz00}			= '';
		$tetramod->{_dvdz01}			= '';
		$tetramod->{_dvdz0file}			= '';
		$tetramod->{_dvdz10}			= '';
		$tetramod->{_dvdz11}			= '';
		$tetramod->{_dvdz1file}			= '';
		$tetramod->{_ficth}			= '';
		$tetramod->{_hzfile}			= '';
		$tetramod->{_nhz}			= '';
		$tetramod->{_nxhz}			= '';
		$tetramod->{_nyhz}			= '';
		$tetramod->{_v00}			= '';
		$tetramod->{_v01}			= '';
		$tetramod->{_v0file}			= '';
		$tetramod->{_v10}			= '';
		$tetramod->{_v11}			= '';
		$tetramod->{_v1file}			= '';
		$tetramod->{_verbose}			= '';
		$tetramod->{_x0file}			= '';
		$tetramod->{_x1file}			= '';
		$tetramod->{_xmax}			= '';
		$tetramod->{_xmin}			= '';
		$tetramod->{_y0file}			= '';
		$tetramod->{_y1file}			= '';
		$tetramod->{_ymax}			= '';
		$tetramod->{_ymin}			= '';
		$tetramod->{_z00}			= '';
		$tetramod->{_z01}			= '';
		$tetramod->{_z0file}			= '';
		$tetramod->{_z10}			= '';
		$tetramod->{_z11}			= '';
		$tetramod->{_z1file}			= '';
		$tetramod->{_zmax}			= '';
		$tetramod->{_Step}			= '';
		$tetramod->{_note}			= '';
 }


=head2 sub blt 


=cut

 sub blt {

	my ( $self,$blt )		= @_;
	if ( $blt ne $empty_string ) {

		$tetramod->{_blt}		= $blt;
		$tetramod->{_note}		= $tetramod->{_note}.' blt='.$tetramod->{_blt};
		$tetramod->{_Step}		= $tetramod->{_Step}.' blt='.$tetramod->{_blt};

	} else { 
		print("tetramod, blt, missing blt,\n");
	 }
 }


=head2 sub dvdz00 


=cut

 sub dvdz00 {

	my ( $self,$dvdz00 )		= @_;
	if ( $dvdz00 ne $empty_string ) {

		$tetramod->{_dvdz00}		= $dvdz00;
		$tetramod->{_note}		= $tetramod->{_note}.' dvdz00='.$tetramod->{_dvdz00};
		$tetramod->{_Step}		= $tetramod->{_Step}.' dvdz00='.$tetramod->{_dvdz00};

	} else { 
		print("tetramod, dvdz00, missing dvdz00,\n");
	 }
 }


=head2 sub dvdz01 


=cut

 sub dvdz01 {

	my ( $self,$dvdz01 )		= @_;
	if ( $dvdz01 ne $empty_string ) {

		$tetramod->{_dvdz01}		= $dvdz01;
		$tetramod->{_note}		= $tetramod->{_note}.' dvdz01='.$tetramod->{_dvdz01};
		$tetramod->{_Step}		= $tetramod->{_Step}.' dvdz01='.$tetramod->{_dvdz01};

	} else { 
		print("tetramod, dvdz01, missing dvdz01,\n");
	 }
 }


=head2 sub dvdz0file 


=cut

 sub dvdz0file {

	my ( $self,$dvdz0file )		= @_;
	if ( $dvdz0file ne $empty_string ) {

		$tetramod->{_dvdz0file}		= $dvdz0file;
		$tetramod->{_note}		= $tetramod->{_note}.' dvdz0file='.$tetramod->{_dvdz0file};
		$tetramod->{_Step}		= $tetramod->{_Step}.' dvdz0file='.$tetramod->{_dvdz0file};

	} else { 
		print("tetramod, dvdz0file, missing dvdz0file,\n");
	 }
 }


=head2 sub dvdz10 


=cut

 sub dvdz10 {

	my ( $self,$dvdz10 )		= @_;
	if ( $dvdz10 ne $empty_string ) {

		$tetramod->{_dvdz10}		= $dvdz10;
		$tetramod->{_note}		= $tetramod->{_note}.' dvdz10='.$tetramod->{_dvdz10};
		$tetramod->{_Step}		= $tetramod->{_Step}.' dvdz10='.$tetramod->{_dvdz10};

	} else { 
		print("tetramod, dvdz10, missing dvdz10,\n");
	 }
 }


=head2 sub dvdz11 


=cut

 sub dvdz11 {

	my ( $self,$dvdz11 )		= @_;
	if ( $dvdz11 ne $empty_string ) {

		$tetramod->{_dvdz11}		= $dvdz11;
		$tetramod->{_note}		= $tetramod->{_note}.' dvdz11='.$tetramod->{_dvdz11};
		$tetramod->{_Step}		= $tetramod->{_Step}.' dvdz11='.$tetramod->{_dvdz11};

	} else { 
		print("tetramod, dvdz11, missing dvdz11,\n");
	 }
 }


=head2 sub dvdz1file 


=cut

 sub dvdz1file {

	my ( $self,$dvdz1file )		= @_;
	if ( $dvdz1file ne $empty_string ) {

		$tetramod->{_dvdz1file}		= $dvdz1file;
		$tetramod->{_note}		= $tetramod->{_note}.' dvdz1file='.$tetramod->{_dvdz1file};
		$tetramod->{_Step}		= $tetramod->{_Step}.' dvdz1file='.$tetramod->{_dvdz1file};

	} else { 
		print("tetramod, dvdz1file, missing dvdz1file,\n");
	 }
 }


=head2 sub ficth 


=cut

 sub ficth {

	my ( $self,$ficth )		= @_;
	if ( $ficth ne $empty_string ) {

		$tetramod->{_ficth}		= $ficth;
		$tetramod->{_note}		= $tetramod->{_note}.' ficth='.$tetramod->{_ficth};
		$tetramod->{_Step}		= $tetramod->{_Step}.' ficth='.$tetramod->{_ficth};

	} else { 
		print("tetramod, ficth, missing ficth,\n");
	 }
 }


=head2 sub hzfile 


=cut

 sub hzfile {

	my ( $self,$hzfile )		= @_;
	if ( $hzfile ne $empty_string ) {

		$tetramod->{_hzfile}		= $hzfile;
		$tetramod->{_note}		= $tetramod->{_note}.' hzfile='.$tetramod->{_hzfile};
		$tetramod->{_Step}		= $tetramod->{_Step}.' hzfile='.$tetramod->{_hzfile};

	} else { 
		print("tetramod, hzfile, missing hzfile,\n");
	 }
 }


=head2 sub nhz 


=cut

 sub nhz {

	my ( $self,$nhz )		= @_;
	if ( $nhz ne $empty_string ) {

		$tetramod->{_nhz}		= $nhz;
		$tetramod->{_note}		= $tetramod->{_note}.' nhz='.$tetramod->{_nhz};
		$tetramod->{_Step}		= $tetramod->{_Step}.' nhz='.$tetramod->{_nhz};

	} else { 
		print("tetramod, nhz, missing nhz,\n");
	 }
 }


=head2 sub nxhz 


=cut

 sub nxhz {

	my ( $self,$nxhz )		= @_;
	if ( $nxhz ne $empty_string ) {

		$tetramod->{_nxhz}		= $nxhz;
		$tetramod->{_note}		= $tetramod->{_note}.' nxhz='.$tetramod->{_nxhz};
		$tetramod->{_Step}		= $tetramod->{_Step}.' nxhz='.$tetramod->{_nxhz};

	} else { 
		print("tetramod, nxhz, missing nxhz,\n");
	 }
 }


=head2 sub nyhz 


=cut

 sub nyhz {

	my ( $self,$nyhz )		= @_;
	if ( $nyhz ne $empty_string ) {

		$tetramod->{_nyhz}		= $nyhz;
		$tetramod->{_note}		= $tetramod->{_note}.' nyhz='.$tetramod->{_nyhz};
		$tetramod->{_Step}		= $tetramod->{_Step}.' nyhz='.$tetramod->{_nyhz};

	} else { 
		print("tetramod, nyhz, missing nyhz,\n");
	 }
 }


=head2 sub v00 


=cut

 sub v00 {

	my ( $self,$v00 )		= @_;
	if ( $v00 ne $empty_string ) {

		$tetramod->{_v00}		= $v00;
		$tetramod->{_note}		= $tetramod->{_note}.' v00='.$tetramod->{_v00};
		$tetramod->{_Step}		= $tetramod->{_Step}.' v00='.$tetramod->{_v00};

	} else { 
		print("tetramod, v00, missing v00,\n");
	 }
 }


=head2 sub v01 


=cut

 sub v01 {

	my ( $self,$v01 )		= @_;
	if ( $v01 ne $empty_string ) {

		$tetramod->{_v01}		= $v01;
		$tetramod->{_note}		= $tetramod->{_note}.' v01='.$tetramod->{_v01};
		$tetramod->{_Step}		= $tetramod->{_Step}.' v01='.$tetramod->{_v01};

	} else { 
		print("tetramod, v01, missing v01,\n");
	 }
 }


=head2 sub v0file 


=cut

 sub v0file {

	my ( $self,$v0file )		= @_;
	if ( $v0file ne $empty_string ) {

		$tetramod->{_v0file}		= $v0file;
		$tetramod->{_note}		= $tetramod->{_note}.' v0file='.$tetramod->{_v0file};
		$tetramod->{_Step}		= $tetramod->{_Step}.' v0file='.$tetramod->{_v0file};

	} else { 
		print("tetramod, v0file, missing v0file,\n");
	 }
 }


=head2 sub v10 


=cut

 sub v10 {

	my ( $self,$v10 )		= @_;
	if ( $v10 ne $empty_string ) {

		$tetramod->{_v10}		= $v10;
		$tetramod->{_note}		= $tetramod->{_note}.' v10='.$tetramod->{_v10};
		$tetramod->{_Step}		= $tetramod->{_Step}.' v10='.$tetramod->{_v10};

	} else { 
		print("tetramod, v10, missing v10,\n");
	 }
 }


=head2 sub v11 


=cut

 sub v11 {

	my ( $self,$v11 )		= @_;
	if ( $v11 ne $empty_string ) {

		$tetramod->{_v11}		= $v11;
		$tetramod->{_note}		= $tetramod->{_note}.' v11='.$tetramod->{_v11};
		$tetramod->{_Step}		= $tetramod->{_Step}.' v11='.$tetramod->{_v11};

	} else { 
		print("tetramod, v11, missing v11,\n");
	 }
 }


=head2 sub v1file 


=cut

 sub v1file {

	my ( $self,$v1file )		= @_;
	if ( $v1file ne $empty_string ) {

		$tetramod->{_v1file}		= $v1file;
		$tetramod->{_note}		= $tetramod->{_note}.' v1file='.$tetramod->{_v1file};
		$tetramod->{_Step}		= $tetramod->{_Step}.' v1file='.$tetramod->{_v1file};

	} else { 
		print("tetramod, v1file, missing v1file,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$tetramod->{_verbose}		= $verbose;
		$tetramod->{_note}		= $tetramod->{_note}.' verbose='.$tetramod->{_verbose};
		$tetramod->{_Step}		= $tetramod->{_Step}.' verbose='.$tetramod->{_verbose};

	} else { 
		print("tetramod, verbose, missing verbose,\n");
	 }
 }


=head2 sub x0file 


=cut

 sub x0file {

	my ( $self,$x0file )		= @_;
	if ( $x0file ne $empty_string ) {

		$tetramod->{_x0file}		= $x0file;
		$tetramod->{_note}		= $tetramod->{_note}.' x0file='.$tetramod->{_x0file};
		$tetramod->{_Step}		= $tetramod->{_Step}.' x0file='.$tetramod->{_x0file};

	} else { 
		print("tetramod, x0file, missing x0file,\n");
	 }
 }


=head2 sub x1file 


=cut

 sub x1file {

	my ( $self,$x1file )		= @_;
	if ( $x1file ne $empty_string ) {

		$tetramod->{_x1file}		= $x1file;
		$tetramod->{_note}		= $tetramod->{_note}.' x1file='.$tetramod->{_x1file};
		$tetramod->{_Step}		= $tetramod->{_Step}.' x1file='.$tetramod->{_x1file};

	} else { 
		print("tetramod, x1file, missing x1file,\n");
	 }
 }


=head2 sub xmax 


=cut

 sub xmax {

	my ( $self,$xmax )		= @_;
	if ( $xmax ne $empty_string ) {

		$tetramod->{_xmax}		= $xmax;
		$tetramod->{_note}		= $tetramod->{_note}.' xmax='.$tetramod->{_xmax};
		$tetramod->{_Step}		= $tetramod->{_Step}.' xmax='.$tetramod->{_xmax};

	} else { 
		print("tetramod, xmax, missing xmax,\n");
	 }
 }


=head2 sub xmin 


=cut

 sub xmin {

	my ( $self,$xmin )		= @_;
	if ( $xmin ne $empty_string ) {

		$tetramod->{_xmin}		= $xmin;
		$tetramod->{_note}		= $tetramod->{_note}.' xmin='.$tetramod->{_xmin};
		$tetramod->{_Step}		= $tetramod->{_Step}.' xmin='.$tetramod->{_xmin};

	} else { 
		print("tetramod, xmin, missing xmin,\n");
	 }
 }


=head2 sub y0file 


=cut

 sub y0file {

	my ( $self,$y0file )		= @_;
	if ( $y0file ne $empty_string ) {

		$tetramod->{_y0file}		= $y0file;
		$tetramod->{_note}		= $tetramod->{_note}.' y0file='.$tetramod->{_y0file};
		$tetramod->{_Step}		= $tetramod->{_Step}.' y0file='.$tetramod->{_y0file};

	} else { 
		print("tetramod, y0file, missing y0file,\n");
	 }
 }


=head2 sub y1file 


=cut

 sub y1file {

	my ( $self,$y1file )		= @_;
	if ( $y1file ne $empty_string ) {

		$tetramod->{_y1file}		= $y1file;
		$tetramod->{_note}		= $tetramod->{_note}.' y1file='.$tetramod->{_y1file};
		$tetramod->{_Step}		= $tetramod->{_Step}.' y1file='.$tetramod->{_y1file};

	} else { 
		print("tetramod, y1file, missing y1file,\n");
	 }
 }


=head2 sub ymax 


=cut

 sub ymax {

	my ( $self,$ymax )		= @_;
	if ( $ymax ne $empty_string ) {

		$tetramod->{_ymax}		= $ymax;
		$tetramod->{_note}		= $tetramod->{_note}.' ymax='.$tetramod->{_ymax};
		$tetramod->{_Step}		= $tetramod->{_Step}.' ymax='.$tetramod->{_ymax};

	} else { 
		print("tetramod, ymax, missing ymax,\n");
	 }
 }


=head2 sub ymin 


=cut

 sub ymin {

	my ( $self,$ymin )		= @_;
	if ( $ymin ne $empty_string ) {

		$tetramod->{_ymin}		= $ymin;
		$tetramod->{_note}		= $tetramod->{_note}.' ymin='.$tetramod->{_ymin};
		$tetramod->{_Step}		= $tetramod->{_Step}.' ymin='.$tetramod->{_ymin};

	} else { 
		print("tetramod, ymin, missing ymin,\n");
	 }
 }


=head2 sub z00 


=cut

 sub z00 {

	my ( $self,$z00 )		= @_;
	if ( $z00 ne $empty_string ) {

		$tetramod->{_z00}		= $z00;
		$tetramod->{_note}		= $tetramod->{_note}.' z00='.$tetramod->{_z00};
		$tetramod->{_Step}		= $tetramod->{_Step}.' z00='.$tetramod->{_z00};

	} else { 
		print("tetramod, z00, missing z00,\n");
	 }
 }


=head2 sub z01 


=cut

 sub z01 {

	my ( $self,$z01 )		= @_;
	if ( $z01 ne $empty_string ) {

		$tetramod->{_z01}		= $z01;
		$tetramod->{_note}		= $tetramod->{_note}.' z01='.$tetramod->{_z01};
		$tetramod->{_Step}		= $tetramod->{_Step}.' z01='.$tetramod->{_z01};

	} else { 
		print("tetramod, z01, missing z01,\n");
	 }
 }


=head2 sub z0file 


=cut

 sub z0file {

	my ( $self,$z0file )		= @_;
	if ( $z0file ne $empty_string ) {

		$tetramod->{_z0file}		= $z0file;
		$tetramod->{_note}		= $tetramod->{_note}.' z0file='.$tetramod->{_z0file};
		$tetramod->{_Step}		= $tetramod->{_Step}.' z0file='.$tetramod->{_z0file};

	} else { 
		print("tetramod, z0file, missing z0file,\n");
	 }
 }


=head2 sub z10 


=cut

 sub z10 {

	my ( $self,$z10 )		= @_;
	if ( $z10 ne $empty_string ) {

		$tetramod->{_z10}		= $z10;
		$tetramod->{_note}		= $tetramod->{_note}.' z10='.$tetramod->{_z10};
		$tetramod->{_Step}		= $tetramod->{_Step}.' z10='.$tetramod->{_z10};

	} else { 
		print("tetramod, z10, missing z10,\n");
	 }
 }


=head2 sub z11 


=cut

 sub z11 {

	my ( $self,$z11 )		= @_;
	if ( $z11 ne $empty_string ) {

		$tetramod->{_z11}		= $z11;
		$tetramod->{_note}		= $tetramod->{_note}.' z11='.$tetramod->{_z11};
		$tetramod->{_Step}		= $tetramod->{_Step}.' z11='.$tetramod->{_z11};

	} else { 
		print("tetramod, z11, missing z11,\n");
	 }
 }


=head2 sub z1file 


=cut

 sub z1file {

	my ( $self,$z1file )		= @_;
	if ( $z1file ne $empty_string ) {

		$tetramod->{_z1file}		= $z1file;
		$tetramod->{_note}		= $tetramod->{_note}.' z1file='.$tetramod->{_z1file};
		$tetramod->{_Step}		= $tetramod->{_Step}.' z1file='.$tetramod->{_z1file};

	} else { 
		print("tetramod, z1file, missing z1file,\n");
	 }
 }


=head2 sub zmax 


=cut

 sub zmax {

	my ( $self,$zmax )		= @_;
	if ( $zmax ne $empty_string ) {

		$tetramod->{_zmax}		= $zmax;
		$tetramod->{_note}		= $tetramod->{_note}.' zmax='.$tetramod->{_zmax};
		$tetramod->{_Step}		= $tetramod->{_Step}.' zmax='.$tetramod->{_zmax};

	} else { 
		print("tetramod, zmax, missing zmax,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 33;

    return($max_index);
}
 
 
1;
