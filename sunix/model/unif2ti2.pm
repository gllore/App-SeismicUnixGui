package unif2ti2;

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
 UNIF2TI - generate a 2-D UNIFormly sampled profile of stiffness 	

 	coefficients of a layered medium (only for P waves). 		



  unif2ti < infile [Parameters]					



 Required Parameters:							

 none 									



 Optional Parameters:							

 ninf=5	number of interfaces					

 nx=100	number of x samples (2nd dimension)			

 nz=100	number of z samples (1st dimension)			

 dx=10		x sampling interval					

 dz=10		z sampling interval					

 ns=0          number of samples in vertical direction for smoothing   

		parameters across boundary				



 npmax=201	maximum number of points on interfaces			



 fx=0.0	first x sample						

 fz=0.0	first z sample						





 x0=0.0,0.0,..., 	distance x at which vp00 and vs00 are specified	

 z0=0.0,0.0,..., 	depth z at which vp00 and vs00 are specified	



 vp00=1500,2000,...,	P-velocity at each x0,z0 (m/sec)		

 eps00=0,0,0...,	Thomsen parameter epsilon at each x0,z0		

 delta00=0,0,0...,	Thomsen	parameter delta at each x0,z0		

 rho00=1000,1100,...,	density at each x0,z0 (kg/m^3)			



 dvpdx=0.0,0.0,...,	x-derivative of P-velocity (dvp/dx)		

 dvpdz=0.0,0.0,...,	z-derivative of P-velocity (dvs/dz)		



 dedx=0.0,0.0,...,	x-derivative of epsilon (de/dx)			

 dedz=0.0,0.0,...,	z-derivative of epsilon with depth z (de/dz)	



 dddx=0.0,0.0,...,	x-derivative of delta (dd/dx)			

 dddz=0.0,0.0,...,	z-derivative of delta (dd/dz)			



 drdx=0.0,0.0,...,	x-derivative of density (d rho/dx)		

 drdz=0.0,0.0,...,	z-derivative of density (d rho/dz)		



 nufile= 		binary file containning tilt value at each grid point





 ...output filenames 							

 c11_file=c11_file	output filename for c11 values	 		

 c13_file=c13_file	output filename for c13 values	 		

 c15_file=c15_file	output filename for c15 values	 		

 c33_file=c33_file	output filename for c33 values	 		

 c35_file=c35_file	output filename for c35 values	 		

 c55_file=c55_file	output filename for c55 values	 		





 method=linear		for linear interpolation of interface		

 			=mono for monotonic cubic interpolation of interface

			=akima for Akima's cubic interpolation of interface

			=spline for cubic spline interpolation of interface



 tfile=		=testfilename  if set, a sample input dataset is

 			 output to "testfilename".			



 Notes:								

 The input file is an ASCII file containing x z values representing a	

 piecewise continuous velocity model with a flat surface on top.	



 The surface and each successive boundary between media is represented 

 by a list of selected x z pairs written column form. The first and	

 last x values must be the same for all boundaries. Use the entry	

 1.0  -99999  to separate the entries for successive boundaries. No	

 boundary may cross another. Note that the choice of the method of	

 interpolation may cause boundaries to cross that do not appear to	

 cross in the input data file.						



 The number of interfaces is specified by the parameter "ninf". This 

 number does not include the top surface of the model. The input data	

 format is the same as a CSHOT model file with all comments removed.	



 The algorithm works by transforming the P-wavespeed, Thomsen parameters 

 epsilon and delta, and the tilt of the symmetry axis into density-normalized", 

 stiffness coefficients. 						



 At this stage, the tilt-field file can be prepared using the 		

 Matlab M-file nu_mod.m based on 2D interpolation between interfaces.  ", 

 The binary file contains nu values at each grid point.		

 The interfaces are obtained by interpolation on the picked ones 	

 stored in the infile, and the symmetry axis at each point of interface

 is assumed to be parallel to the normal direction.			



 Common ranges of Thomsen parameters are				

  epsilon:  0.0 -> 0.5							

  delta:   -0.2 -> 0.4							





 If the tilt-field file is not given, the model will be assumed to 	

 have VTI symmetry. 				 			



 Example using test input file generating feature:			

 unif2aniso tfile=testfilename  produces a 5 interface demonstration model

 unif2aniso < testfilename 						

 ximage < c11_file n1=100 n2=100					

 ximage < c13_file n1=100 n2=100					

 ximage < c15_file n1=100 n2=100					

 ximage < c33_file n1=100 n2=100					

 ximage < c35_file n1=100 n2=100					

 ximage < c55_file n1=100 n2=100					

 ximage < rho_file n1=100 n2=100					







 Credits:

      Modified by Pengfei Cai (CWP), Dec 2011

      Modified by Xiaoxiang Wang (CWP), Aug 2010

 	Based on program unif2aniso by John Stockwell, 2005 





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

my $unif2ti2			= {
	_c11_file					=> '',
	_c13_file					=> '',
	_c15_file					=> '',
	_c33_file					=> '',
	_c35_file					=> '',
	_c55_file					=> '',
	_dddx					=> '',
	_dddz					=> '',
	_dedx					=> '',
	_dedz					=> '',
	_delta00					=> '',
	_drdx					=> '',
	_drdz					=> '',
	_dvpdx					=> '',
	_dvpdz					=> '',
	_dx					=> '',
	_dz					=> '',
	_eps00					=> '',
	_fx					=> '',
	_fz					=> '',
	_method					=> '',
	_n1					=> '',
	_ninf					=> '',
	_npmax					=> '',
	_ns					=> '',
	_nufile					=> '',
	_nx					=> '',
	_nz					=> '',
	_rho00					=> '',
	_tfile					=> '',
	_vp00					=> '',
	_x0					=> '',
	_z0					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$unif2ti2->{_Step}     = 'unif2ti2'.$unif2ti2->{_Step};
	return ( $unif2ti2->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$unif2ti2->{_note}     = 'unif2ti2'.$unif2ti2->{_note};
	return ( $unif2ti2->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$unif2ti2->{_c11_file}			= '';
		$unif2ti2->{_c13_file}			= '';
		$unif2ti2->{_c15_file}			= '';
		$unif2ti2->{_c33_file}			= '';
		$unif2ti2->{_c35_file}			= '';
		$unif2ti2->{_c55_file}			= '';
		$unif2ti2->{_dddx}			= '';
		$unif2ti2->{_dddz}			= '';
		$unif2ti2->{_dedx}			= '';
		$unif2ti2->{_dedz}			= '';
		$unif2ti2->{_delta00}			= '';
		$unif2ti2->{_drdx}			= '';
		$unif2ti2->{_drdz}			= '';
		$unif2ti2->{_dvpdx}			= '';
		$unif2ti2->{_dvpdz}			= '';
		$unif2ti2->{_dx}			= '';
		$unif2ti2->{_dz}			= '';
		$unif2ti2->{_eps00}			= '';
		$unif2ti2->{_fx}			= '';
		$unif2ti2->{_fz}			= '';
		$unif2ti2->{_method}			= '';
		$unif2ti2->{_n1}			= '';
		$unif2ti2->{_ninf}			= '';
		$unif2ti2->{_npmax}			= '';
		$unif2ti2->{_ns}			= '';
		$unif2ti2->{_nufile}			= '';
		$unif2ti2->{_nx}			= '';
		$unif2ti2->{_nz}			= '';
		$unif2ti2->{_rho00}			= '';
		$unif2ti2->{_tfile}			= '';
		$unif2ti2->{_vp00}			= '';
		$unif2ti2->{_x0}			= '';
		$unif2ti2->{_z0}			= '';
		$unif2ti2->{_Step}			= '';
		$unif2ti2->{_note}			= '';
 }


=head2 sub c11_file 


=cut

 sub c11_file {

	my ( $self,$c11_file )		= @_;
	if ( $c11_file ne $empty_string ) {

		$unif2ti2->{_c11_file}		= $c11_file;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' c11_file='.$unif2ti2->{_c11_file};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' c11_file='.$unif2ti2->{_c11_file};

	} else { 
		print("unif2ti2, c11_file, missing c11_file,\n");
	 }
 }


=head2 sub c13_file 


=cut

 sub c13_file {

	my ( $self,$c13_file )		= @_;
	if ( $c13_file ne $empty_string ) {

		$unif2ti2->{_c13_file}		= $c13_file;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' c13_file='.$unif2ti2->{_c13_file};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' c13_file='.$unif2ti2->{_c13_file};

	} else { 
		print("unif2ti2, c13_file, missing c13_file,\n");
	 }
 }


=head2 sub c15_file 


=cut

 sub c15_file {

	my ( $self,$c15_file )		= @_;
	if ( $c15_file ne $empty_string ) {

		$unif2ti2->{_c15_file}		= $c15_file;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' c15_file='.$unif2ti2->{_c15_file};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' c15_file='.$unif2ti2->{_c15_file};

	} else { 
		print("unif2ti2, c15_file, missing c15_file,\n");
	 }
 }


=head2 sub c33_file 


=cut

 sub c33_file {

	my ( $self,$c33_file )		= @_;
	if ( $c33_file ne $empty_string ) {

		$unif2ti2->{_c33_file}		= $c33_file;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' c33_file='.$unif2ti2->{_c33_file};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' c33_file='.$unif2ti2->{_c33_file};

	} else { 
		print("unif2ti2, c33_file, missing c33_file,\n");
	 }
 }


=head2 sub c35_file 


=cut

 sub c35_file {

	my ( $self,$c35_file )		= @_;
	if ( $c35_file ne $empty_string ) {

		$unif2ti2->{_c35_file}		= $c35_file;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' c35_file='.$unif2ti2->{_c35_file};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' c35_file='.$unif2ti2->{_c35_file};

	} else { 
		print("unif2ti2, c35_file, missing c35_file,\n");
	 }
 }


=head2 sub c55_file 


=cut

 sub c55_file {

	my ( $self,$c55_file )		= @_;
	if ( $c55_file ne $empty_string ) {

		$unif2ti2->{_c55_file}		= $c55_file;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' c55_file='.$unif2ti2->{_c55_file};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' c55_file='.$unif2ti2->{_c55_file};

	} else { 
		print("unif2ti2, c55_file, missing c55_file,\n");
	 }
 }


=head2 sub dddx 


=cut

 sub dddx {

	my ( $self,$dddx )		= @_;
	if ( $dddx ne $empty_string ) {

		$unif2ti2->{_dddx}		= $dddx;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' dddx='.$unif2ti2->{_dddx};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' dddx='.$unif2ti2->{_dddx};

	} else { 
		print("unif2ti2, dddx, missing dddx,\n");
	 }
 }


=head2 sub dddz 


=cut

 sub dddz {

	my ( $self,$dddz )		= @_;
	if ( $dddz ne $empty_string ) {

		$unif2ti2->{_dddz}		= $dddz;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' dddz='.$unif2ti2->{_dddz};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' dddz='.$unif2ti2->{_dddz};

	} else { 
		print("unif2ti2, dddz, missing dddz,\n");
	 }
 }


=head2 sub dedx 


=cut

 sub dedx {

	my ( $self,$dedx )		= @_;
	if ( $dedx ne $empty_string ) {

		$unif2ti2->{_dedx}		= $dedx;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' dedx='.$unif2ti2->{_dedx};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' dedx='.$unif2ti2->{_dedx};

	} else { 
		print("unif2ti2, dedx, missing dedx,\n");
	 }
 }


=head2 sub dedz 


=cut

 sub dedz {

	my ( $self,$dedz )		= @_;
	if ( $dedz ne $empty_string ) {

		$unif2ti2->{_dedz}		= $dedz;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' dedz='.$unif2ti2->{_dedz};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' dedz='.$unif2ti2->{_dedz};

	} else { 
		print("unif2ti2, dedz, missing dedz,\n");
	 }
 }


=head2 sub delta00 


=cut

 sub delta00 {

	my ( $self,$delta00 )		= @_;
	if ( $delta00 ne $empty_string ) {

		$unif2ti2->{_delta00}		= $delta00;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' delta00='.$unif2ti2->{_delta00};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' delta00='.$unif2ti2->{_delta00};

	} else { 
		print("unif2ti2, delta00, missing delta00,\n");
	 }
 }


=head2 sub drdx 


=cut

 sub drdx {

	my ( $self,$drdx )		= @_;
	if ( $drdx ne $empty_string ) {

		$unif2ti2->{_drdx}		= $drdx;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' drdx='.$unif2ti2->{_drdx};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' drdx='.$unif2ti2->{_drdx};

	} else { 
		print("unif2ti2, drdx, missing drdx,\n");
	 }
 }


=head2 sub drdz 


=cut

 sub drdz {

	my ( $self,$drdz )		= @_;
	if ( $drdz ne $empty_string ) {

		$unif2ti2->{_drdz}		= $drdz;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' drdz='.$unif2ti2->{_drdz};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' drdz='.$unif2ti2->{_drdz};

	} else { 
		print("unif2ti2, drdz, missing drdz,\n");
	 }
 }


=head2 sub dvpdx 


=cut

 sub dvpdx {

	my ( $self,$dvpdx )		= @_;
	if ( $dvpdx ne $empty_string ) {

		$unif2ti2->{_dvpdx}		= $dvpdx;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' dvpdx='.$unif2ti2->{_dvpdx};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' dvpdx='.$unif2ti2->{_dvpdx};

	} else { 
		print("unif2ti2, dvpdx, missing dvpdx,\n");
	 }
 }


=head2 sub dvpdz 


=cut

 sub dvpdz {

	my ( $self,$dvpdz )		= @_;
	if ( $dvpdz ne $empty_string ) {

		$unif2ti2->{_dvpdz}		= $dvpdz;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' dvpdz='.$unif2ti2->{_dvpdz};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' dvpdz='.$unif2ti2->{_dvpdz};

	} else { 
		print("unif2ti2, dvpdz, missing dvpdz,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$unif2ti2->{_dx}		= $dx;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' dx='.$unif2ti2->{_dx};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' dx='.$unif2ti2->{_dx};

	} else { 
		print("unif2ti2, dx, missing dx,\n");
	 }
 }


=head2 sub dz 


=cut

 sub dz {

	my ( $self,$dz )		= @_;
	if ( $dz ne $empty_string ) {

		$unif2ti2->{_dz}		= $dz;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' dz='.$unif2ti2->{_dz};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' dz='.$unif2ti2->{_dz};

	} else { 
		print("unif2ti2, dz, missing dz,\n");
	 }
 }


=head2 sub eps00 


=cut

 sub eps00 {

	my ( $self,$eps00 )		= @_;
	if ( $eps00 ne $empty_string ) {

		$unif2ti2->{_eps00}		= $eps00;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' eps00='.$unif2ti2->{_eps00};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' eps00='.$unif2ti2->{_eps00};

	} else { 
		print("unif2ti2, eps00, missing eps00,\n");
	 }
 }


=head2 sub fx 


=cut

 sub fx {

	my ( $self,$fx )		= @_;
	if ( $fx ne $empty_string ) {

		$unif2ti2->{_fx}		= $fx;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' fx='.$unif2ti2->{_fx};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' fx='.$unif2ti2->{_fx};

	} else { 
		print("unif2ti2, fx, missing fx,\n");
	 }
 }


=head2 sub fz 


=cut

 sub fz {

	my ( $self,$fz )		= @_;
	if ( $fz ne $empty_string ) {

		$unif2ti2->{_fz}		= $fz;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' fz='.$unif2ti2->{_fz};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' fz='.$unif2ti2->{_fz};

	} else { 
		print("unif2ti2, fz, missing fz,\n");
	 }
 }


=head2 sub method 


=cut

 sub method {

	my ( $self,$method )		= @_;
	if ( $method ne $empty_string ) {

		$unif2ti2->{_method}		= $method;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' method='.$unif2ti2->{_method};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' method='.$unif2ti2->{_method};

	} else { 
		print("unif2ti2, method, missing method,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$unif2ti2->{_n1}		= $n1;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' n1='.$unif2ti2->{_n1};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' n1='.$unif2ti2->{_n1};

	} else { 
		print("unif2ti2, n1, missing n1,\n");
	 }
 }


=head2 sub ninf 


=cut

 sub ninf {

	my ( $self,$ninf )		= @_;
	if ( $ninf ne $empty_string ) {

		$unif2ti2->{_ninf}		= $ninf;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' ninf='.$unif2ti2->{_ninf};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' ninf='.$unif2ti2->{_ninf};

	} else { 
		print("unif2ti2, ninf, missing ninf,\n");
	 }
 }


=head2 sub npmax 


=cut

 sub npmax {

	my ( $self,$npmax )		= @_;
	if ( $npmax ne $empty_string ) {

		$unif2ti2->{_npmax}		= $npmax;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' npmax='.$unif2ti2->{_npmax};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' npmax='.$unif2ti2->{_npmax};

	} else { 
		print("unif2ti2, npmax, missing npmax,\n");
	 }
 }


=head2 sub ns 


=cut

 sub ns {

	my ( $self,$ns )		= @_;
	if ( $ns ne $empty_string ) {

		$unif2ti2->{_ns}		= $ns;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' ns='.$unif2ti2->{_ns};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' ns='.$unif2ti2->{_ns};

	} else { 
		print("unif2ti2, ns, missing ns,\n");
	 }
 }


=head2 sub nufile 


=cut

 sub nufile {

	my ( $self,$nufile )		= @_;
	if ( $nufile ne $empty_string ) {

		$unif2ti2->{_nufile}		= $nufile;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' nufile='.$unif2ti2->{_nufile};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' nufile='.$unif2ti2->{_nufile};

	} else { 
		print("unif2ti2, nufile, missing nufile,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$unif2ti2->{_nx}		= $nx;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' nx='.$unif2ti2->{_nx};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' nx='.$unif2ti2->{_nx};

	} else { 
		print("unif2ti2, nx, missing nx,\n");
	 }
 }


=head2 sub nz 


=cut

 sub nz {

	my ( $self,$nz )		= @_;
	if ( $nz ne $empty_string ) {

		$unif2ti2->{_nz}		= $nz;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' nz='.$unif2ti2->{_nz};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' nz='.$unif2ti2->{_nz};

	} else { 
		print("unif2ti2, nz, missing nz,\n");
	 }
 }


=head2 sub rho00 


=cut

 sub rho00 {

	my ( $self,$rho00 )		= @_;
	if ( $rho00 ne $empty_string ) {

		$unif2ti2->{_rho00}		= $rho00;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' rho00='.$unif2ti2->{_rho00};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' rho00='.$unif2ti2->{_rho00};

	} else { 
		print("unif2ti2, rho00, missing rho00,\n");
	 }
 }


=head2 sub tfile 


=cut

 sub tfile {

	my ( $self,$tfile )		= @_;
	if ( $tfile ne $empty_string ) {

		$unif2ti2->{_tfile}		= $tfile;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' tfile='.$unif2ti2->{_tfile};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' tfile='.$unif2ti2->{_tfile};

	} else { 
		print("unif2ti2, tfile, missing tfile,\n");
	 }
 }


=head2 sub vp00 


=cut

 sub vp00 {

	my ( $self,$vp00 )		= @_;
	if ( $vp00 ne $empty_string ) {

		$unif2ti2->{_vp00}		= $vp00;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' vp00='.$unif2ti2->{_vp00};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' vp00='.$unif2ti2->{_vp00};

	} else { 
		print("unif2ti2, vp00, missing vp00,\n");
	 }
 }


=head2 sub x0 


=cut

 sub x0 {

	my ( $self,$x0 )		= @_;
	if ( $x0 ne $empty_string ) {

		$unif2ti2->{_x0}		= $x0;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' x0='.$unif2ti2->{_x0};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' x0='.$unif2ti2->{_x0};

	} else { 
		print("unif2ti2, x0, missing x0,\n");
	 }
 }


=head2 sub z0 


=cut

 sub z0 {

	my ( $self,$z0 )		= @_;
	if ( $z0 ne $empty_string ) {

		$unif2ti2->{_z0}		= $z0;
		$unif2ti2->{_note}		= $unif2ti2->{_note}.' z0='.$unif2ti2->{_z0};
		$unif2ti2->{_Step}		= $unif2ti2->{_Step}.' z0='.$unif2ti2->{_z0};

	} else { 
		print("unif2ti2, z0, missing z0,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 32;

    return($max_index);
}
 
 
1;
