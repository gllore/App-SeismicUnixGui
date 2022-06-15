package sutetraray;

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
 SUTETRARAY - 3-D TETRAhedral WaveFront construction RAYtracing	



   sutetray < tetrafile [parameters] > ttfile	 			





 Optional Parameters:							",	

 nxgd=				number of x samples (fastest dimension)	

 nygd=				number of y samples (second dimension) 	

 fxgd=xmin(from tetrafile)	first x sample			  	

 fygd=ymin(from tetrafile)	first y sample				

 shootupward=1			=1 shooting upward, -1 downward		

 dxgd=(xmax-xmin)/(nxgd-1)	x sampling interval		 	

 dygd=(ymax-ymin)/(nygd-1)	y sampling interval			

 takeoff=30.0			max takeoff angle for shooting aperture	

 ntakeoff=5			number of samples in takeoff angle	

 nazimuth=15			number of samples in azimuth		

 maxntris=1000			maximum number of triangles allowed	

 maxnrays=600			maximum number of rays allowed		

 maxnsegs=100			maximum number of ray segments allowed 	

 tmax=10			maximum traveltime traced		

 dtwf=0.05			wavefront step size for raytracing	

 ntwf=(int)(tmax/dtwf)+1	maximum number of wavefronts	  	

 ntwf=MAX(ntwf,ifwf2dump+nwf2dump)				     	

 edgemax=4			maximum triangle length (in dxgd) not to

				be split				

 fsx=fxgd+nxgd/2*dxgd		first source in x			

 dsx=dxgd			x increment in source			

 nsx=1				number of source in x			

 fsy=fygd+nygd/2*dygd		first source in y			

 dsy=dygd			y increment in source		   	

 nsy=1				number of source in y		   	

 fsz=zmin+(zmax-zmin)/2	first source in z			

 dsy=(zmax-zmin)/2		y increment in source		   	

 nsy=1				number of source in y			

 nxt=nxgd*2/2+1	number of x-samples in ttable for sukdmig3d	",	

 nyt=nygd*2/2+1	number of y-samples in ttable for sukdmig3d	

 irefseq=nhz-1,...     reflector sequence				

 crfile=NULL	   file for cosines and ray paths r (for sukdmig3d)	

 sttfile=NULL	  file for surface traveltimes (for visualization)	

 verbose=0		=1 print some useful information		



	The following two files are output for viewer3 to display   	

 rayfile=NULL		ray path file		    			

 wffile=NULL		wavefront file (then must give ifwf2dump)	

 ifwf2dump=20		the first wavefront to dump  			

 nwf2dump=1		the number of wavefronts to dump		

 jpfile=stderr		job print (default: stderr)			





 Disclaimer:								

 This is a research code that will take considerable work to get into  

 the form of a a production level 3D migration code. The code is       

 offered as is, along with tetramod and sukdmig3d, to provide a starting

 point for researchers who wish to write their own 3D migration codes.







 Credits:

  	CWP: Zhaobo Meng, 1996



 Reference:

 Zhaobo Meng and Norman Bleistein, Wavefront Construction (WF) Ray

 Tracing in Tetrahedral Models -- Application to 3-D traveltime and

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

my $sutetraray			= {
	_crfile					=> '',
	_dsx					=> '',
	_dsy					=> '',
	_dtwf					=> '',
	_dxgd					=> '',
	_dygd					=> '',
	_edgemax					=> '',
	_fsx					=> '',
	_fsy					=> '',
	_fsz					=> '',
	_fxgd					=> '',
	_fygd					=> '',
	_ifwf2dump					=> '',
	_irefseq					=> '',
	_jpfile					=> '',
	_maxnrays					=> '',
	_maxnsegs					=> '',
	_maxntris					=> '',
	_nazimuth					=> '',
	_nsx					=> '',
	_nsy					=> '',
	_ntakeoff					=> '',
	_ntwf					=> '',
	_nwf2dump					=> '',
	_nxgd					=> '',
	_nxt					=> '',
	_nygd					=> '',
	_nyt					=> '',
	_rayfile					=> '',
	_shootupward					=> '',
	_sttfile					=> '',
	_takeoff					=> '',
	_tmax					=> '',
	_verbose					=> '',
	_wffile					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sutetraray->{_Step}     = 'sutetraray'.$sutetraray->{_Step};
	return ( $sutetraray->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sutetraray->{_note}     = 'sutetraray'.$sutetraray->{_note};
	return ( $sutetraray->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sutetraray->{_crfile}			= '';
		$sutetraray->{_dsx}			= '';
		$sutetraray->{_dsy}			= '';
		$sutetraray->{_dtwf}			= '';
		$sutetraray->{_dxgd}			= '';
		$sutetraray->{_dygd}			= '';
		$sutetraray->{_edgemax}			= '';
		$sutetraray->{_fsx}			= '';
		$sutetraray->{_fsy}			= '';
		$sutetraray->{_fsz}			= '';
		$sutetraray->{_fxgd}			= '';
		$sutetraray->{_fygd}			= '';
		$sutetraray->{_ifwf2dump}			= '';
		$sutetraray->{_irefseq}			= '';
		$sutetraray->{_jpfile}			= '';
		$sutetraray->{_maxnrays}			= '';
		$sutetraray->{_maxnsegs}			= '';
		$sutetraray->{_maxntris}			= '';
		$sutetraray->{_nazimuth}			= '';
		$sutetraray->{_nsx}			= '';
		$sutetraray->{_nsy}			= '';
		$sutetraray->{_ntakeoff}			= '';
		$sutetraray->{_ntwf}			= '';
		$sutetraray->{_nwf2dump}			= '';
		$sutetraray->{_nxgd}			= '';
		$sutetraray->{_nxt}			= '';
		$sutetraray->{_nygd}			= '';
		$sutetraray->{_nyt}			= '';
		$sutetraray->{_rayfile}			= '';
		$sutetraray->{_shootupward}			= '';
		$sutetraray->{_sttfile}			= '';
		$sutetraray->{_takeoff}			= '';
		$sutetraray->{_tmax}			= '';
		$sutetraray->{_verbose}			= '';
		$sutetraray->{_wffile}			= '';
		$sutetraray->{_Step}			= '';
		$sutetraray->{_note}			= '';
 }


=head2 sub crfile 


=cut

 sub crfile {

	my ( $self,$crfile )		= @_;
	if ( $crfile ne $empty_string ) {

		$sutetraray->{_crfile}		= $crfile;
		$sutetraray->{_note}		= $sutetraray->{_note}.' crfile='.$sutetraray->{_crfile};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' crfile='.$sutetraray->{_crfile};

	} else { 
		print("sutetraray, crfile, missing crfile,\n");
	 }
 }


=head2 sub dsx 


=cut

 sub dsx {

	my ( $self,$dsx )		= @_;
	if ( $dsx ne $empty_string ) {

		$sutetraray->{_dsx}		= $dsx;
		$sutetraray->{_note}		= $sutetraray->{_note}.' dsx='.$sutetraray->{_dsx};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' dsx='.$sutetraray->{_dsx};

	} else { 
		print("sutetraray, dsx, missing dsx,\n");
	 }
 }


=head2 sub dsy 


=cut

 sub dsy {

	my ( $self,$dsy )		= @_;
	if ( $dsy ne $empty_string ) {

		$sutetraray->{_dsy}		= $dsy;
		$sutetraray->{_note}		= $sutetraray->{_note}.' dsy='.$sutetraray->{_dsy};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' dsy='.$sutetraray->{_dsy};

	} else { 
		print("sutetraray, dsy, missing dsy,\n");
	 }
 }


=head2 sub dtwf 


=cut

 sub dtwf {

	my ( $self,$dtwf )		= @_;
	if ( $dtwf ne $empty_string ) {

		$sutetraray->{_dtwf}		= $dtwf;
		$sutetraray->{_note}		= $sutetraray->{_note}.' dtwf='.$sutetraray->{_dtwf};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' dtwf='.$sutetraray->{_dtwf};

	} else { 
		print("sutetraray, dtwf, missing dtwf,\n");
	 }
 }


=head2 sub dxgd 


=cut

 sub dxgd {

	my ( $self,$dxgd )		= @_;
	if ( $dxgd ne $empty_string ) {

		$sutetraray->{_dxgd}		= $dxgd;
		$sutetraray->{_note}		= $sutetraray->{_note}.' dxgd='.$sutetraray->{_dxgd};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' dxgd='.$sutetraray->{_dxgd};

	} else { 
		print("sutetraray, dxgd, missing dxgd,\n");
	 }
 }


=head2 sub dygd 


=cut

 sub dygd {

	my ( $self,$dygd )		= @_;
	if ( $dygd ne $empty_string ) {

		$sutetraray->{_dygd}		= $dygd;
		$sutetraray->{_note}		= $sutetraray->{_note}.' dygd='.$sutetraray->{_dygd};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' dygd='.$sutetraray->{_dygd};

	} else { 
		print("sutetraray, dygd, missing dygd,\n");
	 }
 }


=head2 sub edgemax 


=cut

 sub edgemax {

	my ( $self,$edgemax )		= @_;
	if ( $edgemax ne $empty_string ) {

		$sutetraray->{_edgemax}		= $edgemax;
		$sutetraray->{_note}		= $sutetraray->{_note}.' edgemax='.$sutetraray->{_edgemax};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' edgemax='.$sutetraray->{_edgemax};

	} else { 
		print("sutetraray, edgemax, missing edgemax,\n");
	 }
 }


=head2 sub fsx 


=cut

 sub fsx {

	my ( $self,$fsx )		= @_;
	if ( $fsx ne $empty_string ) {

		$sutetraray->{_fsx}		= $fsx;
		$sutetraray->{_note}		= $sutetraray->{_note}.' fsx='.$sutetraray->{_fsx};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' fsx='.$sutetraray->{_fsx};

	} else { 
		print("sutetraray, fsx, missing fsx,\n");
	 }
 }


=head2 sub fsy 


=cut

 sub fsy {

	my ( $self,$fsy )		= @_;
	if ( $fsy ne $empty_string ) {

		$sutetraray->{_fsy}		= $fsy;
		$sutetraray->{_note}		= $sutetraray->{_note}.' fsy='.$sutetraray->{_fsy};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' fsy='.$sutetraray->{_fsy};

	} else { 
		print("sutetraray, fsy, missing fsy,\n");
	 }
 }


=head2 sub fsz 


=cut

 sub fsz {

	my ( $self,$fsz )		= @_;
	if ( $fsz ne $empty_string ) {

		$sutetraray->{_fsz}		= $fsz;
		$sutetraray->{_note}		= $sutetraray->{_note}.' fsz='.$sutetraray->{_fsz};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' fsz='.$sutetraray->{_fsz};

	} else { 
		print("sutetraray, fsz, missing fsz,\n");
	 }
 }


=head2 sub fxgd 


=cut

 sub fxgd {

	my ( $self,$fxgd )		= @_;
	if ( $fxgd ne $empty_string ) {

		$sutetraray->{_fxgd}		= $fxgd;
		$sutetraray->{_note}		= $sutetraray->{_note}.' fxgd='.$sutetraray->{_fxgd};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' fxgd='.$sutetraray->{_fxgd};

	} else { 
		print("sutetraray, fxgd, missing fxgd,\n");
	 }
 }


=head2 sub fygd 


=cut

 sub fygd {

	my ( $self,$fygd )		= @_;
	if ( $fygd ne $empty_string ) {

		$sutetraray->{_fygd}		= $fygd;
		$sutetraray->{_note}		= $sutetraray->{_note}.' fygd='.$sutetraray->{_fygd};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' fygd='.$sutetraray->{_fygd};

	} else { 
		print("sutetraray, fygd, missing fygd,\n");
	 }
 }


=head2 sub ifwf2dump 


=cut

 sub ifwf2dump {

	my ( $self,$ifwf2dump )		= @_;
	if ( $ifwf2dump ne $empty_string ) {

		$sutetraray->{_ifwf2dump}		= $ifwf2dump;
		$sutetraray->{_note}		= $sutetraray->{_note}.' ifwf2dump='.$sutetraray->{_ifwf2dump};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' ifwf2dump='.$sutetraray->{_ifwf2dump};

	} else { 
		print("sutetraray, ifwf2dump, missing ifwf2dump,\n");
	 }
 }


=head2 sub irefseq 


=cut

 sub irefseq {

	my ( $self,$irefseq )		= @_;
	if ( $irefseq ne $empty_string ) {

		$sutetraray->{_irefseq}		= $irefseq;
		$sutetraray->{_note}		= $sutetraray->{_note}.' irefseq='.$sutetraray->{_irefseq};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' irefseq='.$sutetraray->{_irefseq};

	} else { 
		print("sutetraray, irefseq, missing irefseq,\n");
	 }
 }


=head2 sub jpfile 


=cut

 sub jpfile {

	my ( $self,$jpfile )		= @_;
	if ( $jpfile ne $empty_string ) {

		$sutetraray->{_jpfile}		= $jpfile;
		$sutetraray->{_note}		= $sutetraray->{_note}.' jpfile='.$sutetraray->{_jpfile};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' jpfile='.$sutetraray->{_jpfile};

	} else { 
		print("sutetraray, jpfile, missing jpfile,\n");
	 }
 }


=head2 sub maxnrays 


=cut

 sub maxnrays {

	my ( $self,$maxnrays )		= @_;
	if ( $maxnrays ne $empty_string ) {

		$sutetraray->{_maxnrays}		= $maxnrays;
		$sutetraray->{_note}		= $sutetraray->{_note}.' maxnrays='.$sutetraray->{_maxnrays};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' maxnrays='.$sutetraray->{_maxnrays};

	} else { 
		print("sutetraray, maxnrays, missing maxnrays,\n");
	 }
 }


=head2 sub maxnsegs 


=cut

 sub maxnsegs {

	my ( $self,$maxnsegs )		= @_;
	if ( $maxnsegs ne $empty_string ) {

		$sutetraray->{_maxnsegs}		= $maxnsegs;
		$sutetraray->{_note}		= $sutetraray->{_note}.' maxnsegs='.$sutetraray->{_maxnsegs};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' maxnsegs='.$sutetraray->{_maxnsegs};

	} else { 
		print("sutetraray, maxnsegs, missing maxnsegs,\n");
	 }
 }


=head2 sub maxntris 


=cut

 sub maxntris {

	my ( $self,$maxntris )		= @_;
	if ( $maxntris ne $empty_string ) {

		$sutetraray->{_maxntris}		= $maxntris;
		$sutetraray->{_note}		= $sutetraray->{_note}.' maxntris='.$sutetraray->{_maxntris};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' maxntris='.$sutetraray->{_maxntris};

	} else { 
		print("sutetraray, maxntris, missing maxntris,\n");
	 }
 }


=head2 sub nazimuth 


=cut

 sub nazimuth {

	my ( $self,$nazimuth )		= @_;
	if ( $nazimuth ne $empty_string ) {

		$sutetraray->{_nazimuth}		= $nazimuth;
		$sutetraray->{_note}		= $sutetraray->{_note}.' nazimuth='.$sutetraray->{_nazimuth};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' nazimuth='.$sutetraray->{_nazimuth};

	} else { 
		print("sutetraray, nazimuth, missing nazimuth,\n");
	 }
 }


=head2 sub nsx 


=cut

 sub nsx {

	my ( $self,$nsx )		= @_;
	if ( $nsx ne $empty_string ) {

		$sutetraray->{_nsx}		= $nsx;
		$sutetraray->{_note}		= $sutetraray->{_note}.' nsx='.$sutetraray->{_nsx};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' nsx='.$sutetraray->{_nsx};

	} else { 
		print("sutetraray, nsx, missing nsx,\n");
	 }
 }


=head2 sub nsy 


=cut

 sub nsy {

	my ( $self,$nsy )		= @_;
	if ( $nsy ne $empty_string ) {

		$sutetraray->{_nsy}		= $nsy;
		$sutetraray->{_note}		= $sutetraray->{_note}.' nsy='.$sutetraray->{_nsy};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' nsy='.$sutetraray->{_nsy};

	} else { 
		print("sutetraray, nsy, missing nsy,\n");
	 }
 }


=head2 sub ntakeoff 


=cut

 sub ntakeoff {

	my ( $self,$ntakeoff )		= @_;
	if ( $ntakeoff ne $empty_string ) {

		$sutetraray->{_ntakeoff}		= $ntakeoff;
		$sutetraray->{_note}		= $sutetraray->{_note}.' ntakeoff='.$sutetraray->{_ntakeoff};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' ntakeoff='.$sutetraray->{_ntakeoff};

	} else { 
		print("sutetraray, ntakeoff, missing ntakeoff,\n");
	 }
 }


=head2 sub ntwf 


=cut

 sub ntwf {

	my ( $self,$ntwf )		= @_;
	if ( $ntwf ne $empty_string ) {

		$sutetraray->{_ntwf}		= $ntwf;
		$sutetraray->{_note}		= $sutetraray->{_note}.' ntwf='.$sutetraray->{_ntwf};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' ntwf='.$sutetraray->{_ntwf};

	} else { 
		print("sutetraray, ntwf, missing ntwf,\n");
	 }
 }


=head2 sub nwf2dump 


=cut

 sub nwf2dump {

	my ( $self,$nwf2dump )		= @_;
	if ( $nwf2dump ne $empty_string ) {

		$sutetraray->{_nwf2dump}		= $nwf2dump;
		$sutetraray->{_note}		= $sutetraray->{_note}.' nwf2dump='.$sutetraray->{_nwf2dump};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' nwf2dump='.$sutetraray->{_nwf2dump};

	} else { 
		print("sutetraray, nwf2dump, missing nwf2dump,\n");
	 }
 }


=head2 sub nxgd 


=cut

 sub nxgd {

	my ( $self,$nxgd )		= @_;
	if ( $nxgd ne $empty_string ) {

		$sutetraray->{_nxgd}		= $nxgd;
		$sutetraray->{_note}		= $sutetraray->{_note}.' nxgd='.$sutetraray->{_nxgd};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' nxgd='.$sutetraray->{_nxgd};

	} else { 
		print("sutetraray, nxgd, missing nxgd,\n");
	 }
 }


=head2 sub nxt 


=cut

 sub nxt {

	my ( $self,$nxt )		= @_;
	if ( $nxt ne $empty_string ) {

		$sutetraray->{_nxt}		= $nxt;
		$sutetraray->{_note}		= $sutetraray->{_note}.' nxt='.$sutetraray->{_nxt};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' nxt='.$sutetraray->{_nxt};

	} else { 
		print("sutetraray, nxt, missing nxt,\n");
	 }
 }


=head2 sub nygd 


=cut

 sub nygd {

	my ( $self,$nygd )		= @_;
	if ( $nygd ne $empty_string ) {

		$sutetraray->{_nygd}		= $nygd;
		$sutetraray->{_note}		= $sutetraray->{_note}.' nygd='.$sutetraray->{_nygd};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' nygd='.$sutetraray->{_nygd};

	} else { 
		print("sutetraray, nygd, missing nygd,\n");
	 }
 }


=head2 sub nyt 


=cut

 sub nyt {

	my ( $self,$nyt )		= @_;
	if ( $nyt ne $empty_string ) {

		$sutetraray->{_nyt}		= $nyt;
		$sutetraray->{_note}		= $sutetraray->{_note}.' nyt='.$sutetraray->{_nyt};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' nyt='.$sutetraray->{_nyt};

	} else { 
		print("sutetraray, nyt, missing nyt,\n");
	 }
 }


=head2 sub rayfile 


=cut

 sub rayfile {

	my ( $self,$rayfile )		= @_;
	if ( $rayfile ne $empty_string ) {

		$sutetraray->{_rayfile}		= $rayfile;
		$sutetraray->{_note}		= $sutetraray->{_note}.' rayfile='.$sutetraray->{_rayfile};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' rayfile='.$sutetraray->{_rayfile};

	} else { 
		print("sutetraray, rayfile, missing rayfile,\n");
	 }
 }


=head2 sub shootupward 


=cut

 sub shootupward {

	my ( $self,$shootupward )		= @_;
	if ( $shootupward ne $empty_string ) {

		$sutetraray->{_shootupward}		= $shootupward;
		$sutetraray->{_note}		= $sutetraray->{_note}.' shootupward='.$sutetraray->{_shootupward};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' shootupward='.$sutetraray->{_shootupward};

	} else { 
		print("sutetraray, shootupward, missing shootupward,\n");
	 }
 }


=head2 sub sttfile 


=cut

 sub sttfile {

	my ( $self,$sttfile )		= @_;
	if ( $sttfile ne $empty_string ) {

		$sutetraray->{_sttfile}		= $sttfile;
		$sutetraray->{_note}		= $sutetraray->{_note}.' sttfile='.$sutetraray->{_sttfile};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' sttfile='.$sutetraray->{_sttfile};

	} else { 
		print("sutetraray, sttfile, missing sttfile,\n");
	 }
 }


=head2 sub takeoff 


=cut

 sub takeoff {

	my ( $self,$takeoff )		= @_;
	if ( $takeoff ne $empty_string ) {

		$sutetraray->{_takeoff}		= $takeoff;
		$sutetraray->{_note}		= $sutetraray->{_note}.' takeoff='.$sutetraray->{_takeoff};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' takeoff='.$sutetraray->{_takeoff};

	} else { 
		print("sutetraray, takeoff, missing takeoff,\n");
	 }
 }


=head2 sub tmax 


=cut

 sub tmax {

	my ( $self,$tmax )		= @_;
	if ( $tmax ne $empty_string ) {

		$sutetraray->{_tmax}		= $tmax;
		$sutetraray->{_note}		= $sutetraray->{_note}.' tmax='.$sutetraray->{_tmax};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' tmax='.$sutetraray->{_tmax};

	} else { 
		print("sutetraray, tmax, missing tmax,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$sutetraray->{_verbose}		= $verbose;
		$sutetraray->{_note}		= $sutetraray->{_note}.' verbose='.$sutetraray->{_verbose};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' verbose='.$sutetraray->{_verbose};

	} else { 
		print("sutetraray, verbose, missing verbose,\n");
	 }
 }


=head2 sub wffile 


=cut

 sub wffile {

	my ( $self,$wffile )		= @_;
	if ( $wffile ne $empty_string ) {

		$sutetraray->{_wffile}		= $wffile;
		$sutetraray->{_note}		= $sutetraray->{_note}.' wffile='.$sutetraray->{_wffile};
		$sutetraray->{_Step}		= $sutetraray->{_Step}.' wffile='.$sutetraray->{_wffile};

	} else { 
		print("sutetraray, wffile, missing wffile,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 34;

    return($max_index);
}
 
 
1;
