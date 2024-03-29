package App::SeismicUnixGui::sunix::migration::sumigfd;

=head2 SYNOPSIS

PERL PROGRAM NAME: 

AUTHOR:  

DATE:

DESCRIPTION:

Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES
 SUMIGFD - 45-90 degree Finite difference depth migration for		

           zero-offset data.						



   sumigfd <infile >outfile vfile= [optional parameters]		



 Required Parameters:							

 nz=		number of depth sapmles					

 dz=		depth sampling interval					

 vfile=	name of file containing velocities			

 		(see Notes below concerning format of this file)	



 Optional Parameters:							

 dt=from header(dt) or .004    time sampling interval			

 dx=from header(d2) or 1.0	midpoint sampling interval		

 dip=45,65,79,80,87,89,90  	Maximum angle of dip reflector		



 tmpdir=	if non-empty, use the value as a directory path		

		prefix for storing temporary files; else if the		

		the CWP_TMPDIR environment variable is set use		

		its value for the path; else use tmpfile()		

 

 Notes:								", 

 The computation cost by dip angle is 45=65=79<80<87<89<90		

 

 The input velocity file \'vfile\' consists of C-style binary floats.	", 

 The structure of this file is vfile[iz][ix]. Note that this means that

 the x-direction is the fastest direction instead of z-direction! Such a

 structure is more convenient for the downward continuation type	

 migration algorithm than using z as fastest dimension as in other SU	

 programs. (In C  v[iz][ix] denotes a v(x,z) array, whereas v[ix][iz]  

 denotes a v(z,x) array, the opposite of what Matlab and Fortran	

 programmers may expect.)						", 

 

 Because most of the tools in the SU package (such as  unif2, unisam2,	

 and makevel) produce output with the structure vfile[ix][iz], you will

 need to transpose the velocity files created by these programs. You may

 use the SU program \'transp\' in SU to transpose such files into the	

 required vfile[iz][ix] structure.					





 

 Credits: CWP Baoniu Han, April 20th, 1998



 Trace header fields accessed: ns, dt, delrt, d2

 Trace header fields modified: ns, dt, delrt



=head2 User's notes (Juan Lorenzo)
untested

=cut


=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';


=head2 Import packages

=cut

use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';

use App::SeismicUnixGui::misc::SeismicUnix qw($go $in $off $on $out $ps $to $suffix_ascii $suffix_bin $suffix_ps $suffix_segy $suffix_su);
use aliased 'App::SeismicUnixGui::configs::big_streams::Project_config';


=head2 instantiation of packages

=cut

my $get					= L_SU_global_constants->new();
my $Project				= Project_config->new();
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

my $sumigfd			= {
	_dip					=> '',
	_dt					=> '',
	_dx					=> '',
	_dz					=> '',
	_nz					=> '',
	_tmpdir					=> '',
	_vfile					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sumigfd->{_Step}     = 'sumigfd'.$sumigfd->{_Step};
	return ( $sumigfd->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sumigfd->{_note}     = 'sumigfd'.$sumigfd->{_note};
	return ( $sumigfd->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sumigfd->{_dip}			= '';
		$sumigfd->{_dt}			= '';
		$sumigfd->{_dx}			= '';
		$sumigfd->{_dz}			= '';
		$sumigfd->{_nz}			= '';
		$sumigfd->{_tmpdir}			= '';
		$sumigfd->{_vfile}			= '';
		$sumigfd->{_Step}			= '';
		$sumigfd->{_note}			= '';
 }



=head2 sub dip 


=cut

 sub dip {

	my ( $self,$dip )		= @_;
	if ( $dip ne $empty_string ) {

		$sumigfd->{_dip}		= $dip;
		$sumigfd->{_note}		= $sumigfd->{_note}.' dip='.$sumigfd->{_dip};
		$sumigfd->{_Step}		= $sumigfd->{_Step}.' dip='.$sumigfd->{_dip};

	} else { 
		print("sumigfd, dip, missing dip,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$sumigfd->{_dt}		= $dt;
		$sumigfd->{_note}		= $sumigfd->{_note}.' dt='.$sumigfd->{_dt};
		$sumigfd->{_Step}		= $sumigfd->{_Step}.' dt='.$sumigfd->{_dt};

	} else { 
		print("sumigfd, dt, missing dt,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$sumigfd->{_dx}		= $dx;
		$sumigfd->{_note}		= $sumigfd->{_note}.' dx='.$sumigfd->{_dx};
		$sumigfd->{_Step}		= $sumigfd->{_Step}.' dx='.$sumigfd->{_dx};

	} else { 
		print("sumigfd, dx, missing dx,\n");
	 }
 }


=head2 sub dz 


=cut

 sub dz {

	my ( $self,$dz )		= @_;
	if ( $dz ne $empty_string ) {

		$sumigfd->{_dz}		= $dz;
		$sumigfd->{_note}		= $sumigfd->{_note}.' dz='.$sumigfd->{_dz};
		$sumigfd->{_Step}		= $sumigfd->{_Step}.' dz='.$sumigfd->{_dz};

	} else { 
		print("sumigfd, dz, missing dz,\n");
	 }
 }


=head2 sub nz 


=cut

 sub nz {

	my ( $self,$nz )		= @_;
	if ( $nz ne $empty_string ) {

		$sumigfd->{_nz}		= $nz;
		$sumigfd->{_note}		= $sumigfd->{_note}.' nz='.$sumigfd->{_nz};
		$sumigfd->{_Step}		= $sumigfd->{_Step}.' nz='.$sumigfd->{_nz};

	} else { 
		print("sumigfd, nz, missing nz,\n");
	 }
 }


=head2 sub tmpdir 


=cut

 sub tmpdir {

	my ( $self,$tmpdir )		= @_;
	if ( $tmpdir ne $empty_string ) {

		$sumigfd->{_tmpdir}		= $tmpdir;
		$sumigfd->{_note}		= $sumigfd->{_note}.' tmpdir='.$sumigfd->{_tmpdir};
		$sumigfd->{_Step}		= $sumigfd->{_Step}.' tmpdir='.$sumigfd->{_tmpdir};

	} else { 
		print("sumigfd, tmpdir, missing tmpdir,\n");
	 }
 }


=head2 sub vfile 


=cut

 sub vfile {

	my ( $self,$vfile )		= @_;
	if ( $vfile ne $empty_string ) {

		$sumigfd->{_vfile}		= $vfile;
		$sumigfd->{_note}		= $sumigfd->{_note}.' vfile='.$sumigfd->{_vfile};
		$sumigfd->{_Step}		= $sumigfd->{_Step}.' vfile='.$sumigfd->{_vfile};

	} else { 
		print("sumigfd, vfile, missing vfile,\n");
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
