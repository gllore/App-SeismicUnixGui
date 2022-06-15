package rayt2dan;

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
 RAYT2DAN -- P- and SV-wave raytracing in 2D anisotropic media		



 rayt2dan > ttime parameterfiles nt= nx= nz= [optional parameters]	



 Required Parameters:							

 VP0file=		        name of file containing VP0(x,z)		

 nt=                    number of time samples	for each ray		

 nx=                    number of samples (x) for the parameter fields	

 nz=                    number of samples (z) for the parameter fields	



 Optional Parameters:							

 SV=0			 for P-waves, SV=1 for Shear waves		



 Parameters defining the velocity field				

 dt=0.008                 time sampling interval			",	

 fx=0                     first lateral sample (x) in parameter field  

 fz=0                     first lateral sample (z) in parameter field  

 dx=100.0                 sample spacing (x) for the parameter fields	

 dz=100.0                 sample spacing (z) for the parameter fields	

	

 Parameters defining the takeoff angle of a ray at a source position	",	

 fa=-60                 first take-off angle of rays (degrees)         

 na=61                  number of rays					",      

 da=2                   increment of take-off angle			

 amin=0                 minimum emergence angle; must be > -90 degrees	

 amax=90                maximum emergence angle; must be < 90 degrees	



 Parameters defining the output traveltime table			

 fxo=fx                 first lateral sample in traveltime table	

 nxo=nx                 number of later samples in traveltime table	

 dxo=dx                 lateral interval in traveltime table		

 fzo=fz                 first depth sample in traveltime table		

 nzo=nz                 number of depth samples in traveltime table	

 dzo=dz                 depth interval in traveltime table		

 fac=0.01               factor to determine the radius of extrap. 	



 Parameters defining the source positions			        

 fsx=fx                 x-coordinate of first source                   

 nsx=1                  number of sources                              

 dsx=2*dxo              x-coordinate increment of sources              

 aperx=0.5*nx*dx        ray tracing aperature in x-direction           



 Files for general anisotropic parameters confined to a vertical plane:

 a1111file=name of file containing a1111(x,z)		

 a1133file=name of file containing a1133(x,z)		

 VS0file=name of file containing VS0(x,z)		

 a1113file=name of file containing a1113(x,z)		

 a3313file=name of file containing a3313(x,z)		



 For transversely isotropic media Thomsen's parameters could be used:	

 deltafile=name of file containing delta(x,z)		

 epsilonfile=name of file containing epsilon(x,z)		



 if anisotropy parameters are not given the program considers		", 

 isotropic media.							", 





 Credits:

      Debashish Sarkar                  

		 

		

   Technical Reference:



	Cerveny, V., 1972, Seismic rays and ray intensities 

	in inhomogeneous anisotropic media: 

	Geophys. J. R. Astr. Soc., 29, 1--13.



 	Hangya, A., 1986, Gaussian beams in anisotropic elastic media:

      Geophys. J. R. Astr. Soc., 85, 473--563.

	

	Gajewski, D. and Psencik, I., 1987, Computation of high frequency 

	seismic wavefields in 3-D  laterally inhomogeneous anisotropic 

 	media: Geophys. J. R. Astr. Soc., 91, 383-411.

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

my $rayt2dan			= {
	_SV					=> '',
	_VP0file					=> '',
	_VS0file					=> '',
	_a1111file					=> '',
	_a1113file					=> '',
	_a1133file					=> '',
	_a3313file					=> '',
	_amax					=> '',
	_amin					=> '',
	_aperx					=> '',
	_da					=> '',
	_deltafile					=> '',
	_dsx					=> '',
	_dt					=> '',
	_dx					=> '',
	_dxo					=> '',
	_dz					=> '',
	_dzo					=> '',
	_epsilonfile					=> '',
	_fa					=> '',
	_fac					=> '',
	_fsx					=> '',
	_fx					=> '',
	_fxo					=> '',
	_fz					=> '',
	_fzo					=> '',
	_na					=> '',
	_nsx					=> '',
	_nt					=> '',
	_nx					=> '',
	_nxo					=> '',
	_nz					=> '',
	_nzo					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$rayt2dan->{_Step}     = 'rayt2dan'.$rayt2dan->{_Step};
	return ( $rayt2dan->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$rayt2dan->{_note}     = 'rayt2dan'.$rayt2dan->{_note};
	return ( $rayt2dan->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$rayt2dan->{_SV}			= '';
		$rayt2dan->{_VP0file}			= '';
		$rayt2dan->{_VS0file}			= '';
		$rayt2dan->{_a1111file}			= '';
		$rayt2dan->{_a1113file}			= '';
		$rayt2dan->{_a1133file}			= '';
		$rayt2dan->{_a3313file}			= '';
		$rayt2dan->{_amax}			= '';
		$rayt2dan->{_amin}			= '';
		$rayt2dan->{_aperx}			= '';
		$rayt2dan->{_da}			= '';
		$rayt2dan->{_deltafile}			= '';
		$rayt2dan->{_dsx}			= '';
		$rayt2dan->{_dt}			= '';
		$rayt2dan->{_dx}			= '';
		$rayt2dan->{_dxo}			= '';
		$rayt2dan->{_dz}			= '';
		$rayt2dan->{_dzo}			= '';
		$rayt2dan->{_epsilonfile}			= '';
		$rayt2dan->{_fa}			= '';
		$rayt2dan->{_fac}			= '';
		$rayt2dan->{_fsx}			= '';
		$rayt2dan->{_fx}			= '';
		$rayt2dan->{_fxo}			= '';
		$rayt2dan->{_fz}			= '';
		$rayt2dan->{_fzo}			= '';
		$rayt2dan->{_na}			= '';
		$rayt2dan->{_nsx}			= '';
		$rayt2dan->{_nt}			= '';
		$rayt2dan->{_nx}			= '';
		$rayt2dan->{_nxo}			= '';
		$rayt2dan->{_nz}			= '';
		$rayt2dan->{_nzo}			= '';
		$rayt2dan->{_Step}			= '';
		$rayt2dan->{_note}			= '';
 }


=head2 sub SV 


=cut

 sub SV {

	my ( $self,$SV )		= @_;
	if ( $SV ne $empty_string ) {

		$rayt2dan->{_SV}		= $SV;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' SV='.$rayt2dan->{_SV};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' SV='.$rayt2dan->{_SV};

	} else { 
		print("rayt2dan, SV, missing SV,\n");
	 }
 }


=head2 sub VP0file 


=cut

 sub VP0file {

	my ( $self,$VP0file )		= @_;
	if ( $VP0file ne $empty_string ) {

		$rayt2dan->{_VP0file}		= $VP0file;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' VP0file='.$rayt2dan->{_VP0file};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' VP0file='.$rayt2dan->{_VP0file};

	} else { 
		print("rayt2dan, VP0file, missing VP0file,\n");
	 }
 }


=head2 sub VS0file 


=cut

 sub VS0file {

	my ( $self,$VS0file )		= @_;
	if ( $VS0file ne $empty_string ) {

		$rayt2dan->{_VS0file}		= $VS0file;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' VS0file='.$rayt2dan->{_VS0file};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' VS0file='.$rayt2dan->{_VS0file};

	} else { 
		print("rayt2dan, VS0file, missing VS0file,\n");
	 }
 }


=head2 sub a1111file 


=cut

 sub a1111file {

	my ( $self,$a1111file )		= @_;
	if ( $a1111file ne $empty_string ) {

		$rayt2dan->{_a1111file}		= $a1111file;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' a1111file='.$rayt2dan->{_a1111file};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' a1111file='.$rayt2dan->{_a1111file};

	} else { 
		print("rayt2dan, a1111file, missing a1111file,\n");
	 }
 }


=head2 sub a1113file 


=cut

 sub a1113file {

	my ( $self,$a1113file )		= @_;
	if ( $a1113file ne $empty_string ) {

		$rayt2dan->{_a1113file}		= $a1113file;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' a1113file='.$rayt2dan->{_a1113file};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' a1113file='.$rayt2dan->{_a1113file};

	} else { 
		print("rayt2dan, a1113file, missing a1113file,\n");
	 }
 }


=head2 sub a1133file 


=cut

 sub a1133file {

	my ( $self,$a1133file )		= @_;
	if ( $a1133file ne $empty_string ) {

		$rayt2dan->{_a1133file}		= $a1133file;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' a1133file='.$rayt2dan->{_a1133file};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' a1133file='.$rayt2dan->{_a1133file};

	} else { 
		print("rayt2dan, a1133file, missing a1133file,\n");
	 }
 }


=head2 sub a3313file 


=cut

 sub a3313file {

	my ( $self,$a3313file )		= @_;
	if ( $a3313file ne $empty_string ) {

		$rayt2dan->{_a3313file}		= $a3313file;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' a3313file='.$rayt2dan->{_a3313file};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' a3313file='.$rayt2dan->{_a3313file};

	} else { 
		print("rayt2dan, a3313file, missing a3313file,\n");
	 }
 }


=head2 sub amax 


=cut

 sub amax {

	my ( $self,$amax )		= @_;
	if ( $amax ne $empty_string ) {

		$rayt2dan->{_amax}		= $amax;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' amax='.$rayt2dan->{_amax};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' amax='.$rayt2dan->{_amax};

	} else { 
		print("rayt2dan, amax, missing amax,\n");
	 }
 }


=head2 sub amin 


=cut

 sub amin {

	my ( $self,$amin )		= @_;
	if ( $amin ne $empty_string ) {

		$rayt2dan->{_amin}		= $amin;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' amin='.$rayt2dan->{_amin};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' amin='.$rayt2dan->{_amin};

	} else { 
		print("rayt2dan, amin, missing amin,\n");
	 }
 }


=head2 sub aperx 


=cut

 sub aperx {

	my ( $self,$aperx )		= @_;
	if ( $aperx ne $empty_string ) {

		$rayt2dan->{_aperx}		= $aperx;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' aperx='.$rayt2dan->{_aperx};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' aperx='.$rayt2dan->{_aperx};

	} else { 
		print("rayt2dan, aperx, missing aperx,\n");
	 }
 }


=head2 sub da 


=cut

 sub da {

	my ( $self,$da )		= @_;
	if ( $da ne $empty_string ) {

		$rayt2dan->{_da}		= $da;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' da='.$rayt2dan->{_da};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' da='.$rayt2dan->{_da};

	} else { 
		print("rayt2dan, da, missing da,\n");
	 }
 }


=head2 sub deltafile 


=cut

 sub deltafile {

	my ( $self,$deltafile )		= @_;
	if ( $deltafile ne $empty_string ) {

		$rayt2dan->{_deltafile}		= $deltafile;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' deltafile='.$rayt2dan->{_deltafile};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' deltafile='.$rayt2dan->{_deltafile};

	} else { 
		print("rayt2dan, deltafile, missing deltafile,\n");
	 }
 }


=head2 sub dsx 


=cut

 sub dsx {

	my ( $self,$dsx )		= @_;
	if ( $dsx ne $empty_string ) {

		$rayt2dan->{_dsx}		= $dsx;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' dsx='.$rayt2dan->{_dsx};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' dsx='.$rayt2dan->{_dsx};

	} else { 
		print("rayt2dan, dsx, missing dsx,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$rayt2dan->{_dt}		= $dt;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' dt='.$rayt2dan->{_dt};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' dt='.$rayt2dan->{_dt};

	} else { 
		print("rayt2dan, dt, missing dt,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$rayt2dan->{_dx}		= $dx;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' dx='.$rayt2dan->{_dx};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' dx='.$rayt2dan->{_dx};

	} else { 
		print("rayt2dan, dx, missing dx,\n");
	 }
 }


=head2 sub dxo 


=cut

 sub dxo {

	my ( $self,$dxo )		= @_;
	if ( $dxo ne $empty_string ) {

		$rayt2dan->{_dxo}		= $dxo;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' dxo='.$rayt2dan->{_dxo};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' dxo='.$rayt2dan->{_dxo};

	} else { 
		print("rayt2dan, dxo, missing dxo,\n");
	 }
 }


=head2 sub dz 


=cut

 sub dz {

	my ( $self,$dz )		= @_;
	if ( $dz ne $empty_string ) {

		$rayt2dan->{_dz}		= $dz;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' dz='.$rayt2dan->{_dz};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' dz='.$rayt2dan->{_dz};

	} else { 
		print("rayt2dan, dz, missing dz,\n");
	 }
 }


=head2 sub dzo 


=cut

 sub dzo {

	my ( $self,$dzo )		= @_;
	if ( $dzo ne $empty_string ) {

		$rayt2dan->{_dzo}		= $dzo;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' dzo='.$rayt2dan->{_dzo};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' dzo='.$rayt2dan->{_dzo};

	} else { 
		print("rayt2dan, dzo, missing dzo,\n");
	 }
 }


=head2 sub epsilonfile 


=cut

 sub epsilonfile {

	my ( $self,$epsilonfile )		= @_;
	if ( $epsilonfile ne $empty_string ) {

		$rayt2dan->{_epsilonfile}		= $epsilonfile;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' epsilonfile='.$rayt2dan->{_epsilonfile};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' epsilonfile='.$rayt2dan->{_epsilonfile};

	} else { 
		print("rayt2dan, epsilonfile, missing epsilonfile,\n");
	 }
 }


=head2 sub fa 


=cut

 sub fa {

	my ( $self,$fa )		= @_;
	if ( $fa ne $empty_string ) {

		$rayt2dan->{_fa}		= $fa;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' fa='.$rayt2dan->{_fa};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' fa='.$rayt2dan->{_fa};

	} else { 
		print("rayt2dan, fa, missing fa,\n");
	 }
 }


=head2 sub fac 


=cut

 sub fac {

	my ( $self,$fac )		= @_;
	if ( $fac ne $empty_string ) {

		$rayt2dan->{_fac}		= $fac;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' fac='.$rayt2dan->{_fac};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' fac='.$rayt2dan->{_fac};

	} else { 
		print("rayt2dan, fac, missing fac,\n");
	 }
 }


=head2 sub fsx 


=cut

 sub fsx {

	my ( $self,$fsx )		= @_;
	if ( $fsx ne $empty_string ) {

		$rayt2dan->{_fsx}		= $fsx;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' fsx='.$rayt2dan->{_fsx};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' fsx='.$rayt2dan->{_fsx};

	} else { 
		print("rayt2dan, fsx, missing fsx,\n");
	 }
 }


=head2 sub fx 


=cut

 sub fx {

	my ( $self,$fx )		= @_;
	if ( $fx ne $empty_string ) {

		$rayt2dan->{_fx}		= $fx;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' fx='.$rayt2dan->{_fx};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' fx='.$rayt2dan->{_fx};

	} else { 
		print("rayt2dan, fx, missing fx,\n");
	 }
 }


=head2 sub fxo 


=cut

 sub fxo {

	my ( $self,$fxo )		= @_;
	if ( $fxo ne $empty_string ) {

		$rayt2dan->{_fxo}		= $fxo;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' fxo='.$rayt2dan->{_fxo};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' fxo='.$rayt2dan->{_fxo};

	} else { 
		print("rayt2dan, fxo, missing fxo,\n");
	 }
 }


=head2 sub fz 


=cut

 sub fz {

	my ( $self,$fz )		= @_;
	if ( $fz ne $empty_string ) {

		$rayt2dan->{_fz}		= $fz;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' fz='.$rayt2dan->{_fz};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' fz='.$rayt2dan->{_fz};

	} else { 
		print("rayt2dan, fz, missing fz,\n");
	 }
 }


=head2 sub fzo 


=cut

 sub fzo {

	my ( $self,$fzo )		= @_;
	if ( $fzo ne $empty_string ) {

		$rayt2dan->{_fzo}		= $fzo;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' fzo='.$rayt2dan->{_fzo};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' fzo='.$rayt2dan->{_fzo};

	} else { 
		print("rayt2dan, fzo, missing fzo,\n");
	 }
 }


=head2 sub na 


=cut

 sub na {

	my ( $self,$na )		= @_;
	if ( $na ne $empty_string ) {

		$rayt2dan->{_na}		= $na;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' na='.$rayt2dan->{_na};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' na='.$rayt2dan->{_na};

	} else { 
		print("rayt2dan, na, missing na,\n");
	 }
 }


=head2 sub nsx 


=cut

 sub nsx {

	my ( $self,$nsx )		= @_;
	if ( $nsx ne $empty_string ) {

		$rayt2dan->{_nsx}		= $nsx;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' nsx='.$rayt2dan->{_nsx};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' nsx='.$rayt2dan->{_nsx};

	} else { 
		print("rayt2dan, nsx, missing nsx,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$rayt2dan->{_nt}		= $nt;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' nt='.$rayt2dan->{_nt};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' nt='.$rayt2dan->{_nt};

	} else { 
		print("rayt2dan, nt, missing nt,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$rayt2dan->{_nx}		= $nx;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' nx='.$rayt2dan->{_nx};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' nx='.$rayt2dan->{_nx};

	} else { 
		print("rayt2dan, nx, missing nx,\n");
	 }
 }


=head2 sub nxo 


=cut

 sub nxo {

	my ( $self,$nxo )		= @_;
	if ( $nxo ne $empty_string ) {

		$rayt2dan->{_nxo}		= $nxo;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' nxo='.$rayt2dan->{_nxo};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' nxo='.$rayt2dan->{_nxo};

	} else { 
		print("rayt2dan, nxo, missing nxo,\n");
	 }
 }


=head2 sub nz 


=cut

 sub nz {

	my ( $self,$nz )		= @_;
	if ( $nz ne $empty_string ) {

		$rayt2dan->{_nz}		= $nz;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' nz='.$rayt2dan->{_nz};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' nz='.$rayt2dan->{_nz};

	} else { 
		print("rayt2dan, nz, missing nz,\n");
	 }
 }


=head2 sub nzo 


=cut

 sub nzo {

	my ( $self,$nzo )		= @_;
	if ( $nzo ne $empty_string ) {

		$rayt2dan->{_nzo}		= $nzo;
		$rayt2dan->{_note}		= $rayt2dan->{_note}.' nzo='.$rayt2dan->{_nzo};
		$rayt2dan->{_Step}		= $rayt2dan->{_Step}.' nzo='.$rayt2dan->{_nzo};

	} else { 
		print("rayt2dan, nzo, missing nzo,\n");
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
