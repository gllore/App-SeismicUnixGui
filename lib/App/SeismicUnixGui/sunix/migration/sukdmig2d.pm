package App::SeismicUnixGui::sunix::migration::sukdmig2d;

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
SUKDMIG2D - Kirchhoff Depth Migration of 2D poststack/prestack data	



    sukdmig2d  infile=  outfile=  ttfile=   [parameters] 		



 Required parameters:							

 infile=stdin		file for input seismic traces			

 outfile=stdout	file for common offset migration output  	

 ttfile=		file for input traveltime tables		



 ...  The following 9 parameters describe traveltime tables:		

 fzt= 			first depth sample in traveltime table		

 nzt= 			number of depth samples in traveltime table	

 dzt=			depth interval in traveltime table		

 fxt=			first lateral sample in traveltime table	

 nxt=			number of lateral samples in traveltime table	

 dxt=			lateral interval in traveltime table		

 fs= 			x-coordinate of first source			

 ns= 			number of sources				

 ds= 			x-coordinate increment of sources		



 Optional Parameters:							

 dt= or from header (dt) 	time sampling interval of input data	

 ft= or from header (ft) 	first time sample of input data		

 dxm= or from header (d2) 	sampling interval of midpoints 		

 fzo=fzt		    z-coordinate of first point in output trace	

 dzo=0.2*dzt		vertical spacing of output trace 		

 nzo=5*(nzt-1)+1 	number of points in output trace		",	

 fxo=fxt		    x-coordinate of first output trace 		

 dxo=0.5*dxt		horizontal spacing of output trace 		

 nxo=2*(nxt-1)+1  	number of output traces 			",	

 off0=0		   	first offest in output 			

 doff=99999		offset increment in output 			

 noff=1	 	number of offsets in output 			",	

 absoff=0      flag for using absolute offsets of input traces		

               =0 means use offset=gx-sx                		

               =1 means use abs(gx-sx)                  		

 limoff=0      flag for only using input traces that fall within the range

               of defined output offset bins (off0,doff,noff) 		

               =0 means use all input traces                 		

               =1 means limit traces used by offset           		

 fmax=0.25/dt		frequency-highcut for input traces		

 offmax=99999		maximum absolute offset allowed in migration 	

 aperx=nxt*dxt/2  	migration lateral aperature 			

 angmax=60		migration angle aperature from vertical 	

 v0=1500(m/s)		reference velocity value at surface		",	

 dvz=0.0  		reference velocity vertical gradient		



 ls=1			flag for line source				

 jpfile=stderr		job print file name 				



 mtr=100  		print verbal information at every mtr traces	

 ntr=100000		maximum number of input traces to be migrated	

 npv=0			flag of computing quantities for velocity analysis

 rscale=1000.0 	scaling for roundoff error suppression		



   ...if npv>0 specify the following three files:			

 tvfile=tvfile		input file of traveltime variation tables	

			tv[ns][nxt][nzt]				

 csfile=csfile		input file of cosine tables cs[ns][nxt][nzt]	

 outfile1=outfile1	file containning additional migration output   	

			with extra amplitude				



 Notes:								

 1. Traveltime tables were generated by program rayt2d (or other ones)	

    on relatively coarse grids, with dimension ns*nxt*nzt. In the	

    migration process, traveltimes are interpolated into shot/gephone 	

    positions and output grids.					

 2. Input seismic traces must be SU format and can be any type of 	

    gathers (common shot, common offset, common CDP, and so on).	", 

 3. Migrated traces are output in CDP gathers if velocity analysis	

    is required, with dimension nxo*noff*nzo.  			", 

 4. If the offset value of an input trace is not in the offset array 	

    of output, the nearest one in the array is chosen. 		

 5. Memory requirement for this program is about			

    	[ns*nxt*nzt+noff*nxo*nzo+4*nr*nzt+5*nxt*nzt+npa*(2*ns*nxt*nzt   

	+noff*nxo*nzo+4*nxt*nzt)]*4 bytes				

    where nr = 1+min(nxt*dxt,0.5*offmax+aperx)/dxo. 			

 6. Amplitudes are computed using the reference velocity profile, v(z),

    specified by the parameters v0= and dvz=.				

 7. Input traces must specify source and receiver positions via the header

    fields tr.sx and tr.gx. Offset is computed automatically.		

 8. if limoff=0, input traces from outside the range defined by off0, doff, 

    noff, will get migrated into the extremal offset bins/planes.  E.g. if 

    absoff=0 and limoff=0, all traces with gx<sx will get migrated into the 

    off0 bin.





 Author:  Zhenyue Liu, 03/01/95,  Colorado School of Mines 

 Modifcations:

    Gary Billings, Talisman Energy, Sept 2005:  added absoff, limoff.



 Trace header fields accessed: ns, dt, delrt, d2

 Trace header fields modified: sx, gx



 

=head2 User's notes (Juan Lorenzo)
untested

=cut


=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';


=head2 Import packages

=cut

use App::SeismicUnixGui::misc::L_SU_global_constants;

use App::SeismicUnixGui::misc::SeismicUnix qw ($go $in $off $on $out $ps $to $suffix_ascii $suffix_bin $suffix_ps $suffix_segy $suffix_su);
use App::SeismicUnixGui::configs::big_streams::Project_config;


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

my $sukdmig2d			= {
	_absoff					=> '',
	_angmax					=> '',
	_aperx					=> '',
	_csfile					=> '',
	_doff					=> '',
	_ds					=> '',
	_dt					=> '',
	_dvz					=> '',
	_dxm					=> '',
	_dxo					=> '',
	_dxt					=> '',
	_dzo					=> '',
	_dzt					=> '',
	_fmax					=> '',
	_fs					=> '',
	_ft					=> '',
	_fxo					=> '',
	_fxt					=> '',
	_fzo					=> '',
	_fzt					=> '',
	_infile					=> '',
	_jpfile					=> '',
	_limoff					=> '',
	_ls					=> '',
	_mtr					=> '',
	_noff					=> '',
	_npv					=> '',
	_nr					=> '',
	_ns					=> '',
	_ntr					=> '',
	_nxo					=> '',
	_nxt					=> '',
	_nzo					=> '',
	_nzt					=> '',
	_off0					=> '',
	_offmax					=> '',
	_offset					=> '',
	_outfile					=> '',
	_outfile1					=> '',
	_rscale					=> '',
	_ttfile					=> '',
	_tvfile					=> '',
	_v0					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sukdmig2d->{_Step}     = 'sukdmig2d'.$sukdmig2d->{_Step};
	return ( $sukdmig2d->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sukdmig2d->{_note}     = 'sukdmig2d'.$sukdmig2d->{_note};
	return ( $sukdmig2d->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sukdmig2d->{_absoff}			= '';
		$sukdmig2d->{_angmax}			= '';
		$sukdmig2d->{_aperx}			= '';
		$sukdmig2d->{_csfile}			= '';
		$sukdmig2d->{_doff}			= '';
		$sukdmig2d->{_ds}			= '';
		$sukdmig2d->{_dt}			= '';
		$sukdmig2d->{_dvz}			= '';
		$sukdmig2d->{_dxm}			= '';
		$sukdmig2d->{_dxo}			= '';
		$sukdmig2d->{_dxt}			= '';
		$sukdmig2d->{_dzo}			= '';
		$sukdmig2d->{_dzt}			= '';
		$sukdmig2d->{_fmax}			= '';
		$sukdmig2d->{_fs}			= '';
		$sukdmig2d->{_ft}			= '';
		$sukdmig2d->{_fxo}			= '';
		$sukdmig2d->{_fxt}			= '';
		$sukdmig2d->{_fzo}			= '';
		$sukdmig2d->{_fzt}			= '';
		$sukdmig2d->{_infile}			= '';
		$sukdmig2d->{_jpfile}			= '';
		$sukdmig2d->{_limoff}			= '';
		$sukdmig2d->{_ls}			= '';
		$sukdmig2d->{_mtr}			= '';
		$sukdmig2d->{_noff}			= '';
		$sukdmig2d->{_npv}			= '';
		$sukdmig2d->{_nr}			= '';
		$sukdmig2d->{_ns}			= '';
		$sukdmig2d->{_ntr}			= '';
		$sukdmig2d->{_nxo}			= '';
		$sukdmig2d->{_nxt}			= '';
		$sukdmig2d->{_nzo}			= '';
		$sukdmig2d->{_nzt}			= '';
		$sukdmig2d->{_off0}			= '';
		$sukdmig2d->{_offmax}			= '';
		$sukdmig2d->{_offset}			= '';
		$sukdmig2d->{_outfile}			= '';
		$sukdmig2d->{_outfile1}			= '';
		$sukdmig2d->{_rscale}			= '';
		$sukdmig2d->{_ttfile}			= '';
		$sukdmig2d->{_tvfile}			= '';
		$sukdmig2d->{_v0}			= '';
		$sukdmig2d->{_Step}			= '';
		$sukdmig2d->{_note}			= '';
 }


=head2 sub absoff 


=cut

 sub absoff {

	my ( $self,$absoff )		= @_;
	if ( $absoff ne $empty_string ) {

		$sukdmig2d->{_absoff}		= $absoff;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' absoff='.$sukdmig2d->{_absoff};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' absoff='.$sukdmig2d->{_absoff};

	} else { 
		print("sukdmig2d, absoff, missing absoff,\n");
	 }
 }


=head2 sub angmax 


=cut

 sub angmax {

	my ( $self,$angmax )		= @_;
	if ( $angmax ne $empty_string ) {

		$sukdmig2d->{_angmax}		= $angmax;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' angmax='.$sukdmig2d->{_angmax};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' angmax='.$sukdmig2d->{_angmax};

	} else { 
		print("sukdmig2d, angmax, missing angmax,\n");
	 }
 }


=head2 sub aperx 


=cut

 sub aperx {

	my ( $self,$aperx )		= @_;
	if ( $aperx ne $empty_string ) {

		$sukdmig2d->{_aperx}		= $aperx;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' aperx='.$sukdmig2d->{_aperx};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' aperx='.$sukdmig2d->{_aperx};

	} else { 
		print("sukdmig2d, aperx, missing aperx,\n");
	 }
 }


=head2 sub csfile 


=cut

 sub csfile {

	my ( $self,$csfile )		= @_;
	if ( $csfile ne $empty_string ) {

		$sukdmig2d->{_csfile}		= $csfile;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' csfile='.$sukdmig2d->{_csfile};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' csfile='.$sukdmig2d->{_csfile};

	} else { 
		print("sukdmig2d, csfile, missing csfile,\n");
	 }
 }


=head2 sub doff 


=cut

 sub doff {

	my ( $self,$doff )		= @_;
	if ( $doff ne $empty_string ) {

		$sukdmig2d->{_doff}		= $doff;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' doff='.$sukdmig2d->{_doff};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' doff='.$sukdmig2d->{_doff};

	} else { 
		print("sukdmig2d, doff, missing doff,\n");
	 }
 }


=head2 sub ds 


=cut

 sub ds {

	my ( $self,$ds )		= @_;
	if ( $ds ne $empty_string ) {

		$sukdmig2d->{_ds}		= $ds;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' ds='.$sukdmig2d->{_ds};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' ds='.$sukdmig2d->{_ds};

	} else { 
		print("sukdmig2d, ds, missing ds,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$sukdmig2d->{_dt}		= $dt;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' dt='.$sukdmig2d->{_dt};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' dt='.$sukdmig2d->{_dt};

	} else { 
		print("sukdmig2d, dt, missing dt,\n");
	 }
 }


=head2 sub dvz 


=cut

 sub dvz {

	my ( $self,$dvz )		= @_;
	if ( $dvz ne $empty_string ) {

		$sukdmig2d->{_dvz}		= $dvz;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' dvz='.$sukdmig2d->{_dvz};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' dvz='.$sukdmig2d->{_dvz};

	} else { 
		print("sukdmig2d, dvz, missing dvz,\n");
	 }
 }


=head2 sub dxm 


=cut

 sub dxm {

	my ( $self,$dxm )		= @_;
	if ( $dxm ne $empty_string ) {

		$sukdmig2d->{_dxm}		= $dxm;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' dxm='.$sukdmig2d->{_dxm};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' dxm='.$sukdmig2d->{_dxm};

	} else { 
		print("sukdmig2d, dxm, missing dxm,\n");
	 }
 }


=head2 sub dxo 


=cut

 sub dxo {

	my ( $self,$dxo )		= @_;
	if ( $dxo ne $empty_string ) {

		$sukdmig2d->{_dxo}		= $dxo;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' dxo='.$sukdmig2d->{_dxo};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' dxo='.$sukdmig2d->{_dxo};

	} else { 
		print("sukdmig2d, dxo, missing dxo,\n");
	 }
 }


=head2 sub dxt 


=cut

 sub dxt {

	my ( $self,$dxt )		= @_;
	if ( $dxt ne $empty_string ) {

		$sukdmig2d->{_dxt}		= $dxt;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' dxt='.$sukdmig2d->{_dxt};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' dxt='.$sukdmig2d->{_dxt};

	} else { 
		print("sukdmig2d, dxt, missing dxt,\n");
	 }
 }


=head2 sub dzo 


=cut

 sub dzo {

	my ( $self,$dzo )		= @_;
	if ( $dzo ne $empty_string ) {

		$sukdmig2d->{_dzo}		= $dzo;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' dzo='.$sukdmig2d->{_dzo};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' dzo='.$sukdmig2d->{_dzo};

	} else { 
		print("sukdmig2d, dzo, missing dzo,\n");
	 }
 }


=head2 sub dzt 


=cut

 sub dzt {

	my ( $self,$dzt )		= @_;
	if ( $dzt ne $empty_string ) {

		$sukdmig2d->{_dzt}		= $dzt;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' dzt='.$sukdmig2d->{_dzt};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' dzt='.$sukdmig2d->{_dzt};

	} else { 
		print("sukdmig2d, dzt, missing dzt,\n");
	 }
 }


=head2 sub fmax 


=cut

 sub fmax {

	my ( $self,$fmax )		= @_;
	if ( $fmax ne $empty_string ) {

		$sukdmig2d->{_fmax}		= $fmax;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' fmax='.$sukdmig2d->{_fmax};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' fmax='.$sukdmig2d->{_fmax};

	} else { 
		print("sukdmig2d, fmax, missing fmax,\n");
	 }
 }


=head2 sub fs 


=cut

 sub fs {

	my ( $self,$fs )		= @_;
	if ( $fs ne $empty_string ) {

		$sukdmig2d->{_fs}		= $fs;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' fs='.$sukdmig2d->{_fs};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' fs='.$sukdmig2d->{_fs};

	} else { 
		print("sukdmig2d, fs, missing fs,\n");
	 }
 }


=head2 sub ft 


=cut

 sub ft {

	my ( $self,$ft )		= @_;
	if ( $ft ne $empty_string ) {

		$sukdmig2d->{_ft}		= $ft;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' ft='.$sukdmig2d->{_ft};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' ft='.$sukdmig2d->{_ft};

	} else { 
		print("sukdmig2d, ft, missing ft,\n");
	 }
 }


=head2 sub fxo 


=cut

 sub fxo {

	my ( $self,$fxo )		= @_;
	if ( $fxo ne $empty_string ) {

		$sukdmig2d->{_fxo}		= $fxo;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' fxo='.$sukdmig2d->{_fxo};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' fxo='.$sukdmig2d->{_fxo};

	} else { 
		print("sukdmig2d, fxo, missing fxo,\n");
	 }
 }


=head2 sub fxt 


=cut

 sub fxt {

	my ( $self,$fxt )		= @_;
	if ( $fxt ne $empty_string ) {

		$sukdmig2d->{_fxt}		= $fxt;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' fxt='.$sukdmig2d->{_fxt};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' fxt='.$sukdmig2d->{_fxt};

	} else { 
		print("sukdmig2d, fxt, missing fxt,\n");
	 }
 }


=head2 sub fzo 


=cut

 sub fzo {

	my ( $self,$fzo )		= @_;
	if ( $fzo ne $empty_string ) {

		$sukdmig2d->{_fzo}		= $fzo;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' fzo='.$sukdmig2d->{_fzo};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' fzo='.$sukdmig2d->{_fzo};

	} else { 
		print("sukdmig2d, fzo, missing fzo,\n");
	 }
 }


=head2 sub fzt 


=cut

 sub fzt {

	my ( $self,$fzt )		= @_;
	if ( $fzt ne $empty_string ) {

		$sukdmig2d->{_fzt}		= $fzt;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' fzt='.$sukdmig2d->{_fzt};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' fzt='.$sukdmig2d->{_fzt};

	} else { 
		print("sukdmig2d, fzt, missing fzt,\n");
	 }
 }


=head2 sub infile 


=cut

 sub infile {

	my ( $self,$infile )		= @_;
	if ( $infile ne $empty_string ) {

		$sukdmig2d->{_infile}		= $infile;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' infile='.$sukdmig2d->{_infile};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' infile='.$sukdmig2d->{_infile};

	} else { 
		print("sukdmig2d, infile, missing infile,\n");
	 }
 }


=head2 sub jpfile 


=cut

 sub jpfile {

	my ( $self,$jpfile )		= @_;
	if ( $jpfile ne $empty_string ) {

		$sukdmig2d->{_jpfile}		= $jpfile;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' jpfile='.$sukdmig2d->{_jpfile};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' jpfile='.$sukdmig2d->{_jpfile};

	} else { 
		print("sukdmig2d, jpfile, missing jpfile,\n");
	 }
 }


=head2 sub limoff 


=cut

 sub limoff {

	my ( $self,$limoff )		= @_;
	if ( $limoff ne $empty_string ) {

		$sukdmig2d->{_limoff}		= $limoff;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' limoff='.$sukdmig2d->{_limoff};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' limoff='.$sukdmig2d->{_limoff};

	} else { 
		print("sukdmig2d, limoff, missing limoff,\n");
	 }
 }


=head2 sub ls 


=cut

 sub ls {

	my ( $self,$ls )		= @_;
	if ( $ls ne $empty_string ) {

		$sukdmig2d->{_ls}		= $ls;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' ls='.$sukdmig2d->{_ls};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' ls='.$sukdmig2d->{_ls};

	} else { 
		print("sukdmig2d, ls, missing ls,\n");
	 }
 }


=head2 sub mtr 


=cut

 sub mtr {

	my ( $self,$mtr )		= @_;
	if ( $mtr ne $empty_string ) {

		$sukdmig2d->{_mtr}		= $mtr;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' mtr='.$sukdmig2d->{_mtr};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' mtr='.$sukdmig2d->{_mtr};

	} else { 
		print("sukdmig2d, mtr, missing mtr,\n");
	 }
 }


=head2 sub noff 


=cut

 sub noff {

	my ( $self,$noff )		= @_;
	if ( $noff ne $empty_string ) {

		$sukdmig2d->{_noff}		= $noff;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' noff='.$sukdmig2d->{_noff};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' noff='.$sukdmig2d->{_noff};

	} else { 
		print("sukdmig2d, noff, missing noff,\n");
	 }
 }


=head2 sub npv 


=cut

 sub npv {

	my ( $self,$npv )		= @_;
	if ( $npv ne $empty_string ) {

		$sukdmig2d->{_npv}		= $npv;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' npv='.$sukdmig2d->{_npv};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' npv='.$sukdmig2d->{_npv};

	} else { 
		print("sukdmig2d, npv, missing npv,\n");
	 }
 }


=head2 sub nr 


=cut

 sub nr {

	my ( $self,$nr )		= @_;
	if ( $nr ne $empty_string ) {

		$sukdmig2d->{_nr}		= $nr;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' nr='.$sukdmig2d->{_nr};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' nr='.$sukdmig2d->{_nr};

	} else { 
		print("sukdmig2d, nr, missing nr,\n");
	 }
 }


=head2 sub ns 


=cut

 sub ns {

	my ( $self,$ns )		= @_;
	if ( $ns ne $empty_string ) {

		$sukdmig2d->{_ns}		= $ns;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' ns='.$sukdmig2d->{_ns};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' ns='.$sukdmig2d->{_ns};

	} else { 
		print("sukdmig2d, ns, missing ns,\n");
	 }
 }


=head2 sub ntr 


=cut

 sub ntr {

	my ( $self,$ntr )		= @_;
	if ( $ntr ne $empty_string ) {

		$sukdmig2d->{_ntr}		= $ntr;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' ntr='.$sukdmig2d->{_ntr};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' ntr='.$sukdmig2d->{_ntr};

	} else { 
		print("sukdmig2d, ntr, missing ntr,\n");
	 }
 }


=head2 sub nxo 


=cut

 sub nxo {

	my ( $self,$nxo )		= @_;
	if ( $nxo ne $empty_string ) {

		$sukdmig2d->{_nxo}		= $nxo;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' nxo='.$sukdmig2d->{_nxo};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' nxo='.$sukdmig2d->{_nxo};

	} else { 
		print("sukdmig2d, nxo, missing nxo,\n");
	 }
 }


=head2 sub nxt 


=cut

 sub nxt {

	my ( $self,$nxt )		= @_;
	if ( $nxt ne $empty_string ) {

		$sukdmig2d->{_nxt}		= $nxt;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' nxt='.$sukdmig2d->{_nxt};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' nxt='.$sukdmig2d->{_nxt};

	} else { 
		print("sukdmig2d, nxt, missing nxt,\n");
	 }
 }


=head2 sub nzo 


=cut

 sub nzo {

	my ( $self,$nzo )		= @_;
	if ( $nzo ne $empty_string ) {

		$sukdmig2d->{_nzo}		= $nzo;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' nzo='.$sukdmig2d->{_nzo};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' nzo='.$sukdmig2d->{_nzo};

	} else { 
		print("sukdmig2d, nzo, missing nzo,\n");
	 }
 }


=head2 sub nzt 


=cut

 sub nzt {

	my ( $self,$nzt )		= @_;
	if ( $nzt ne $empty_string ) {

		$sukdmig2d->{_nzt}		= $nzt;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' nzt='.$sukdmig2d->{_nzt};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' nzt='.$sukdmig2d->{_nzt};

	} else { 
		print("sukdmig2d, nzt, missing nzt,\n");
	 }
 }


=head2 sub off0 


=cut

 sub off0 {

	my ( $self,$off0 )		= @_;
	if ( $off0 ne $empty_string ) {

		$sukdmig2d->{_off0}		= $off0;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' off0='.$sukdmig2d->{_off0};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' off0='.$sukdmig2d->{_off0};

	} else { 
		print("sukdmig2d, off0, missing off0,\n");
	 }
 }


=head2 sub offmax 


=cut

 sub offmax {

	my ( $self,$offmax )		= @_;
	if ( $offmax ne $empty_string ) {

		$sukdmig2d->{_offmax}		= $offmax;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' offmax='.$sukdmig2d->{_offmax};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' offmax='.$sukdmig2d->{_offmax};

	} else { 
		print("sukdmig2d, offmax, missing offmax,\n");
	 }
 }


=head2 sub offset 


=cut

 sub offset {

	my ( $self,$offset )		= @_;
	if ( $offset ne $empty_string ) {

		$sukdmig2d->{_offset}		= $offset;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' offset='.$sukdmig2d->{_offset};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' offset='.$sukdmig2d->{_offset};

	} else { 
		print("sukdmig2d, offset, missing offset,\n");
	 }
 }


=head2 sub outfile 


=cut

 sub outfile {

	my ( $self,$outfile )		= @_;
	if ( $outfile ne $empty_string ) {

		$sukdmig2d->{_outfile}		= $outfile;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' outfile='.$sukdmig2d->{_outfile};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' outfile='.$sukdmig2d->{_outfile};

	} else { 
		print("sukdmig2d, outfile, missing outfile,\n");
	 }
 }


=head2 sub outfile1 


=cut

 sub outfile1 {

	my ( $self,$outfile1 )		= @_;
	if ( $outfile1 ne $empty_string ) {

		$sukdmig2d->{_outfile1}		= $outfile1;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' outfile1='.$sukdmig2d->{_outfile1};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' outfile1='.$sukdmig2d->{_outfile1};

	} else { 
		print("sukdmig2d, outfile1, missing outfile1,\n");
	 }
 }


=head2 sub rscale 


=cut

 sub rscale {

	my ( $self,$rscale )		= @_;
	if ( $rscale ne $empty_string ) {

		$sukdmig2d->{_rscale}		= $rscale;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' rscale='.$sukdmig2d->{_rscale};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' rscale='.$sukdmig2d->{_rscale};

	} else { 
		print("sukdmig2d, rscale, missing rscale,\n");
	 }
 }


=head2 sub ttfile 


=cut

 sub ttfile {

	my ( $self,$ttfile )		= @_;
	if ( $ttfile ne $empty_string ) {

		$sukdmig2d->{_ttfile}		= $ttfile;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' ttfile='.$sukdmig2d->{_ttfile};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' ttfile='.$sukdmig2d->{_ttfile};

	} else { 
		print("sukdmig2d, ttfile, missing ttfile,\n");
	 }
 }


=head2 sub tvfile 


=cut

 sub tvfile {

	my ( $self,$tvfile )		= @_;
	if ( $tvfile ne $empty_string ) {

		$sukdmig2d->{_tvfile}		= $tvfile;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' tvfile='.$sukdmig2d->{_tvfile};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' tvfile='.$sukdmig2d->{_tvfile};

	} else { 
		print("sukdmig2d, tvfile, missing tvfile,\n");
	 }
 }


=head2 sub v0 


=cut

 sub v0 {

	my ( $self,$v0 )		= @_;
	if ( $v0 ne $empty_string ) {

		$sukdmig2d->{_v0}		= $v0;
		$sukdmig2d->{_note}		= $sukdmig2d->{_note}.' v0='.$sukdmig2d->{_v0};
		$sukdmig2d->{_Step}		= $sukdmig2d->{_Step}.' v0='.$sukdmig2d->{_v0};

	} else { 
		print("sukdmig2d, v0, missing v0,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 42;

    return($max_index);
}
 
 
1;
