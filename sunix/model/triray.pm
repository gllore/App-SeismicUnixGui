package triray;

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
 TRIRAY - dynamic RAY tracing for a TRIangulated sloth model		



  triray <modelfile >rayends [optional parameters]			



 Optional Parameters:							

 xs=(max-min)/2 x coordinate of source (default is halfway across model)

 zs=min	 z coordinate of source (default is at top of model)	

 nangle=101	number of takeoff angles				

 fangle=-45	first takeoff angle (in degrees)			

 langle=45	last takeoff angle (in degrees)				

 rayfile=	file of ray x,z coordinates of ray-edge intersections	

 nxz=101	number of (x,z) in optional rayfile (see notes below)	

 wavefile=	file of ray x,z coordinates uniformly sampled in time	

 nt=101	number of (x,z) in optional wavefile (see notes below)	

 infofile=	ASCII-file to store useful information 		

 fresnelfile=  used if you want to plot the fresnel volumes.		

		default is <fresnelfile.bin> 				

 outparfile=	contains parameters for the plotting software.		

		default is <outpar> 					

 krecord=	if specified, only rays incident at interface with index

		krecord are displayed and stored			

 prim=	   =1, only single-reflected rays are plotted			

		=0, only direct hits are displayed  			

 ffreq=-1	FresnelVolume frequency 				

 refseq=1,0,0  index of reflector followed by sequence of reflection (1)

		transmission(0) or ray stops(-1).			

		The default rayend is at the model boundary.		

		NOTE:refseq must be defined for each reflector		

 NOTES:								

 The rayends file contains ray parameters for the locations at which	

 the rays terminate.  							



 The rayfile is useful for making plots of ray paths.			

 nxz should be larger than twice the number of triangles intersected	

 by the rays.								



 The wavefile is useful for making plots of wavefronts.		

 The time sampling interval in the wavefile is tmax/(nt-1),		

 where tmax is the maximum time for all rays.				



 The infofile is useful for collecting information along the		

 individual rays. The fresnelfile contains data used to plot 		

 the Fresnel volumes. The outparfile stores information used 		

 for the plotting software.						







 AUTHOR:  Dave Hale, Colorado School of Mines, 02/16/91

 MODIFIED:  Andreas Rueger, Colorado School of Mines, 08/12/93

	Modifications include: functions writeFresnel, checkIfSourceIsOnEdge;

		options refseq=, krecord=, prim=, infofile=;

		computation of reflection/transmission losses, attenuation.



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

my $triray			= {
	_fangle					=> '',
	_ffreq					=> '',
	_fresnelfile					=> '',
	_infofile					=> '',
	_krecord					=> '',
	_langle					=> '',
	_nangle					=> '',
	_nt					=> '',
	_nxz					=> '',
	_outparfile					=> '',
	_prim					=> '',
	_rayfile					=> '',
	_refseq					=> '',
	_wavefile					=> '',
	_xs					=> '',
	_zs					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$triray->{_Step}     = 'triray'.$triray->{_Step};
	return ( $triray->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$triray->{_note}     = 'triray'.$triray->{_note};
	return ( $triray->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$triray->{_fangle}			= '';
		$triray->{_ffreq}			= '';
		$triray->{_fresnelfile}			= '';
		$triray->{_infofile}			= '';
		$triray->{_krecord}			= '';
		$triray->{_langle}			= '';
		$triray->{_nangle}			= '';
		$triray->{_nt}			= '';
		$triray->{_nxz}			= '';
		$triray->{_outparfile}			= '';
		$triray->{_prim}			= '';
		$triray->{_rayfile}			= '';
		$triray->{_refseq}			= '';
		$triray->{_wavefile}			= '';
		$triray->{_xs}			= '';
		$triray->{_zs}			= '';
		$triray->{_Step}			= '';
		$triray->{_note}			= '';
 }


=head2 sub fangle 


=cut

 sub fangle {

	my ( $self,$fangle )		= @_;
	if ( $fangle ne $empty_string ) {

		$triray->{_fangle}		= $fangle;
		$triray->{_note}		= $triray->{_note}.' fangle='.$triray->{_fangle};
		$triray->{_Step}		= $triray->{_Step}.' fangle='.$triray->{_fangle};

	} else { 
		print("triray, fangle, missing fangle,\n");
	 }
 }


=head2 sub ffreq 


=cut

 sub ffreq {

	my ( $self,$ffreq )		= @_;
	if ( $ffreq ne $empty_string ) {

		$triray->{_ffreq}		= $ffreq;
		$triray->{_note}		= $triray->{_note}.' ffreq='.$triray->{_ffreq};
		$triray->{_Step}		= $triray->{_Step}.' ffreq='.$triray->{_ffreq};

	} else { 
		print("triray, ffreq, missing ffreq,\n");
	 }
 }


=head2 sub fresnelfile 


=cut

 sub fresnelfile {

	my ( $self,$fresnelfile )		= @_;
	if ( $fresnelfile ne $empty_string ) {

		$triray->{_fresnelfile}		= $fresnelfile;
		$triray->{_note}		= $triray->{_note}.' fresnelfile='.$triray->{_fresnelfile};
		$triray->{_Step}		= $triray->{_Step}.' fresnelfile='.$triray->{_fresnelfile};

	} else { 
		print("triray, fresnelfile, missing fresnelfile,\n");
	 }
 }


=head2 sub infofile 


=cut

 sub infofile {

	my ( $self,$infofile )		= @_;
	if ( $infofile ne $empty_string ) {

		$triray->{_infofile}		= $infofile;
		$triray->{_note}		= $triray->{_note}.' infofile='.$triray->{_infofile};
		$triray->{_Step}		= $triray->{_Step}.' infofile='.$triray->{_infofile};

	} else { 
		print("triray, infofile, missing infofile,\n");
	 }
 }


=head2 sub krecord 


=cut

 sub krecord {

	my ( $self,$krecord )		= @_;
	if ( $krecord ne $empty_string ) {

		$triray->{_krecord}		= $krecord;
		$triray->{_note}		= $triray->{_note}.' krecord='.$triray->{_krecord};
		$triray->{_Step}		= $triray->{_Step}.' krecord='.$triray->{_krecord};

	} else { 
		print("triray, krecord, missing krecord,\n");
	 }
 }


=head2 sub langle 


=cut

 sub langle {

	my ( $self,$langle )		= @_;
	if ( $langle ne $empty_string ) {

		$triray->{_langle}		= $langle;
		$triray->{_note}		= $triray->{_note}.' langle='.$triray->{_langle};
		$triray->{_Step}		= $triray->{_Step}.' langle='.$triray->{_langle};

	} else { 
		print("triray, langle, missing langle,\n");
	 }
 }


=head2 sub nangle 


=cut

 sub nangle {

	my ( $self,$nangle )		= @_;
	if ( $nangle ne $empty_string ) {

		$triray->{_nangle}		= $nangle;
		$triray->{_note}		= $triray->{_note}.' nangle='.$triray->{_nangle};
		$triray->{_Step}		= $triray->{_Step}.' nangle='.$triray->{_nangle};

	} else { 
		print("triray, nangle, missing nangle,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$triray->{_nt}		= $nt;
		$triray->{_note}		= $triray->{_note}.' nt='.$triray->{_nt};
		$triray->{_Step}		= $triray->{_Step}.' nt='.$triray->{_nt};

	} else { 
		print("triray, nt, missing nt,\n");
	 }
 }


=head2 sub nxz 


=cut

 sub nxz {

	my ( $self,$nxz )		= @_;
	if ( $nxz ne $empty_string ) {

		$triray->{_nxz}		= $nxz;
		$triray->{_note}		= $triray->{_note}.' nxz='.$triray->{_nxz};
		$triray->{_Step}		= $triray->{_Step}.' nxz='.$triray->{_nxz};

	} else { 
		print("triray, nxz, missing nxz,\n");
	 }
 }


=head2 sub outparfile 


=cut

 sub outparfile {

	my ( $self,$outparfile )		= @_;
	if ( $outparfile ne $empty_string ) {

		$triray->{_outparfile}		= $outparfile;
		$triray->{_note}		= $triray->{_note}.' outparfile='.$triray->{_outparfile};
		$triray->{_Step}		= $triray->{_Step}.' outparfile='.$triray->{_outparfile};

	} else { 
		print("triray, outparfile, missing outparfile,\n");
	 }
 }


=head2 sub prim 


=cut

 sub prim {

	my ( $self,$prim )		= @_;
	if ( $prim ne $empty_string ) {

		$triray->{_prim}		= $prim;
		$triray->{_note}		= $triray->{_note}.' prim='.$triray->{_prim};
		$triray->{_Step}		= $triray->{_Step}.' prim='.$triray->{_prim};

	} else { 
		print("triray, prim, missing prim,\n");
	 }
 }


=head2 sub rayfile 


=cut

 sub rayfile {

	my ( $self,$rayfile )		= @_;
	if ( $rayfile ne $empty_string ) {

		$triray->{_rayfile}		= $rayfile;
		$triray->{_note}		= $triray->{_note}.' rayfile='.$triray->{_rayfile};
		$triray->{_Step}		= $triray->{_Step}.' rayfile='.$triray->{_rayfile};

	} else { 
		print("triray, rayfile, missing rayfile,\n");
	 }
 }


=head2 sub refseq 


=cut

 sub refseq {

	my ( $self,$refseq )		= @_;
	if ( $refseq ne $empty_string ) {

		$triray->{_refseq}		= $refseq;
		$triray->{_note}		= $triray->{_note}.' refseq='.$triray->{_refseq};
		$triray->{_Step}		= $triray->{_Step}.' refseq='.$triray->{_refseq};

	} else { 
		print("triray, refseq, missing refseq,\n");
	 }
 }


=head2 sub wavefile 


=cut

 sub wavefile {

	my ( $self,$wavefile )		= @_;
	if ( $wavefile ne $empty_string ) {

		$triray->{_wavefile}		= $wavefile;
		$triray->{_note}		= $triray->{_note}.' wavefile='.$triray->{_wavefile};
		$triray->{_Step}		= $triray->{_Step}.' wavefile='.$triray->{_wavefile};

	} else { 
		print("triray, wavefile, missing wavefile,\n");
	 }
 }


=head2 sub xs 


=cut

 sub xs {

	my ( $self,$xs )		= @_;
	if ( $xs ne $empty_string ) {

		$triray->{_xs}		= $xs;
		$triray->{_note}		= $triray->{_note}.' xs='.$triray->{_xs};
		$triray->{_Step}		= $triray->{_Step}.' xs='.$triray->{_xs};

	} else { 
		print("triray, xs, missing xs,\n");
	 }
 }


=head2 sub zs 


=cut

 sub zs {

	my ( $self,$zs )		= @_;
	if ( $zs ne $empty_string ) {

		$triray->{_zs}		= $zs;
		$triray->{_note}		= $triray->{_note}.' zs='.$triray->{_zs};
		$triray->{_Step}		= $triray->{_Step}.' zs='.$triray->{_zs};

	} else { 
		print("triray, zs, missing zs,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 15;

    return($max_index);
}
 
 
1;
