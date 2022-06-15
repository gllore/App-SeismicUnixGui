package uni2tri;

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
 UNI2TRI - convert UNIformly sampled model to a TRIangulated model	



 uni2tri <slothfile >modelfile n2= n1= [optional parameters]		



 Required Parameters:							

 n1=                    number of samples in first (fast) dimension	

 n2=                    number of samples in second dimension		



 Optional Parameters:							

 d1=1.0                 sampling interval in dimension 1		

 d2=1.0                 sampling interval in dimension 2		

 f1=0.0                 first value in dimension 1			

 f2=0.0                 first value in dimesion 2			

 ifile=                 triangulated model file used as initial model	

 errmax=                maximum sloth error (see notes below)		

 verbose=1              =0 for silence					

                        =1 to report maximum error at each stage to stderr

                        =2 to also write the normalized error to efile	

 efile=emax.dat         filename for error file (for verbose=2)	

 mm=0			output every mm-th intermediate model (0 for none)

 mfile=intmodel        intermediate models written to intmodel%d	

 method=3              =1 add 1 vertex at maximum error		

                       =2 add vertex to every triangle that exceeds errmax

                       =3 method 2, but avoid closely spaced vertices	

 tol=10                closeness criterion for (in samples)		

 sfill=                 x, z, x0, z0, s00, dsdx, dsdz to fill a region	



 Notes:								

 Triangles are constructed until the maximum error is			

 not greater than the user-specified errmax.  The default errmax	

 is 1% of the maximum value in the sampled input file.			



 After the uniform values have been triangulated, the optional sfill	

 parameters are used to fill closed regions bounded by fixed edges.	

 Let (x,z) denote any point inside a closed region.  Values inside	

 this region is determined by s(x,z) = s00+(x-x0)*dsdx+(z-z0)*dsdz.	

 The (x,z) component of the sfill parameter is used to identify a	

 closed region.							



 The uniformly sampled quantity is assumed to be sloth=1/v^2.		







 AUTHOR:  Craig Artley, Colorado School of Mines, 03/31/94

 NOTE:  After a program outlined by Dave Hale, 12/27/90.





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

my $uni2tri			= {
	_d1					=> '',
	_d2					=> '',
	_efile					=> '',
	_errmax					=> '',
	_f1					=> '',
	_f2					=> '',
	_ifile					=> '',
	_method					=> '',
	_mfile					=> '',
	_mm					=> '',
	_n1					=> '',
	_n2					=> '',
	_sfill					=> '',
	_sloth					=> '',
	_tol					=> '',
	_verbose					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$uni2tri->{_Step}     = 'uni2tri'.$uni2tri->{_Step};
	return ( $uni2tri->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$uni2tri->{_note}     = 'uni2tri'.$uni2tri->{_note};
	return ( $uni2tri->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$uni2tri->{_d1}			= '';
		$uni2tri->{_d2}			= '';
		$uni2tri->{_efile}			= '';
		$uni2tri->{_errmax}			= '';
		$uni2tri->{_f1}			= '';
		$uni2tri->{_f2}			= '';
		$uni2tri->{_ifile}			= '';
		$uni2tri->{_method}			= '';
		$uni2tri->{_mfile}			= '';
		$uni2tri->{_mm}			= '';
		$uni2tri->{_n1}			= '';
		$uni2tri->{_n2}			= '';
		$uni2tri->{_sfill}			= '';
		$uni2tri->{_sloth}			= '';
		$uni2tri->{_tol}			= '';
		$uni2tri->{_verbose}			= '';
		$uni2tri->{_Step}			= '';
		$uni2tri->{_note}			= '';
 }


=head2 sub d1 


=cut

 sub d1 {

	my ( $self,$d1 )		= @_;
	if ( $d1 ne $empty_string ) {

		$uni2tri->{_d1}		= $d1;
		$uni2tri->{_note}		= $uni2tri->{_note}.' d1='.$uni2tri->{_d1};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' d1='.$uni2tri->{_d1};

	} else { 
		print("uni2tri, d1, missing d1,\n");
	 }
 }


=head2 sub d2 


=cut

 sub d2 {

	my ( $self,$d2 )		= @_;
	if ( $d2 ne $empty_string ) {

		$uni2tri->{_d2}		= $d2;
		$uni2tri->{_note}		= $uni2tri->{_note}.' d2='.$uni2tri->{_d2};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' d2='.$uni2tri->{_d2};

	} else { 
		print("uni2tri, d2, missing d2,\n");
	 }
 }


=head2 sub efile 


=cut

 sub efile {

	my ( $self,$efile )		= @_;
	if ( $efile ne $empty_string ) {

		$uni2tri->{_efile}		= $efile;
		$uni2tri->{_note}		= $uni2tri->{_note}.' efile='.$uni2tri->{_efile};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' efile='.$uni2tri->{_efile};

	} else { 
		print("uni2tri, efile, missing efile,\n");
	 }
 }


=head2 sub errmax 


=cut

 sub errmax {

	my ( $self,$errmax )		= @_;
	if ( $errmax ne $empty_string ) {

		$uni2tri->{_errmax}		= $errmax;
		$uni2tri->{_note}		= $uni2tri->{_note}.' errmax='.$uni2tri->{_errmax};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' errmax='.$uni2tri->{_errmax};

	} else { 
		print("uni2tri, errmax, missing errmax,\n");
	 }
 }


=head2 sub f1 


=cut

 sub f1 {

	my ( $self,$f1 )		= @_;
	if ( $f1 ne $empty_string ) {

		$uni2tri->{_f1}		= $f1;
		$uni2tri->{_note}		= $uni2tri->{_note}.' f1='.$uni2tri->{_f1};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' f1='.$uni2tri->{_f1};

	} else { 
		print("uni2tri, f1, missing f1,\n");
	 }
 }


=head2 sub f2 


=cut

 sub f2 {

	my ( $self,$f2 )		= @_;
	if ( $f2 ne $empty_string ) {

		$uni2tri->{_f2}		= $f2;
		$uni2tri->{_note}		= $uni2tri->{_note}.' f2='.$uni2tri->{_f2};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' f2='.$uni2tri->{_f2};

	} else { 
		print("uni2tri, f2, missing f2,\n");
	 }
 }


=head2 sub ifile 


=cut

 sub ifile {

	my ( $self,$ifile )		= @_;
	if ( $ifile ne $empty_string ) {

		$uni2tri->{_ifile}		= $ifile;
		$uni2tri->{_note}		= $uni2tri->{_note}.' ifile='.$uni2tri->{_ifile};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' ifile='.$uni2tri->{_ifile};

	} else { 
		print("uni2tri, ifile, missing ifile,\n");
	 }
 }


=head2 sub method 


=cut

 sub method {

	my ( $self,$method )		= @_;
	if ( $method ne $empty_string ) {

		$uni2tri->{_method}		= $method;
		$uni2tri->{_note}		= $uni2tri->{_note}.' method='.$uni2tri->{_method};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' method='.$uni2tri->{_method};

	} else { 
		print("uni2tri, method, missing method,\n");
	 }
 }


=head2 sub mfile 


=cut

 sub mfile {

	my ( $self,$mfile )		= @_;
	if ( $mfile ne $empty_string ) {

		$uni2tri->{_mfile}		= $mfile;
		$uni2tri->{_note}		= $uni2tri->{_note}.' mfile='.$uni2tri->{_mfile};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' mfile='.$uni2tri->{_mfile};

	} else { 
		print("uni2tri, mfile, missing mfile,\n");
	 }
 }


=head2 sub mm 


=cut

 sub mm {

	my ( $self,$mm )		= @_;
	if ( $mm ne $empty_string ) {

		$uni2tri->{_mm}		= $mm;
		$uni2tri->{_note}		= $uni2tri->{_note}.' mm='.$uni2tri->{_mm};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' mm='.$uni2tri->{_mm};

	} else { 
		print("uni2tri, mm, missing mm,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$uni2tri->{_n1}		= $n1;
		$uni2tri->{_note}		= $uni2tri->{_note}.' n1='.$uni2tri->{_n1};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' n1='.$uni2tri->{_n1};

	} else { 
		print("uni2tri, n1, missing n1,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$uni2tri->{_n2}		= $n2;
		$uni2tri->{_note}		= $uni2tri->{_note}.' n2='.$uni2tri->{_n2};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' n2='.$uni2tri->{_n2};

	} else { 
		print("uni2tri, n2, missing n2,\n");
	 }
 }


=head2 sub sfill 


=cut

 sub sfill {

	my ( $self,$sfill )		= @_;
	if ( $sfill ne $empty_string ) {

		$uni2tri->{_sfill}		= $sfill;
		$uni2tri->{_note}		= $uni2tri->{_note}.' sfill='.$uni2tri->{_sfill};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' sfill='.$uni2tri->{_sfill};

	} else { 
		print("uni2tri, sfill, missing sfill,\n");
	 }
 }


=head2 sub sloth 


=cut

 sub sloth {

	my ( $self,$sloth )		= @_;
	if ( $sloth ne $empty_string ) {

		$uni2tri->{_sloth}		= $sloth;
		$uni2tri->{_note}		= $uni2tri->{_note}.' sloth='.$uni2tri->{_sloth};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' sloth='.$uni2tri->{_sloth};

	} else { 
		print("uni2tri, sloth, missing sloth,\n");
	 }
 }


=head2 sub tol 


=cut

 sub tol {

	my ( $self,$tol )		= @_;
	if ( $tol ne $empty_string ) {

		$uni2tri->{_tol}		= $tol;
		$uni2tri->{_note}		= $uni2tri->{_note}.' tol='.$uni2tri->{_tol};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' tol='.$uni2tri->{_tol};

	} else { 
		print("uni2tri, tol, missing tol,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$uni2tri->{_verbose}		= $verbose;
		$uni2tri->{_note}		= $uni2tri->{_note}.' verbose='.$uni2tri->{_verbose};
		$uni2tri->{_Step}		= $uni2tri->{_Step}.' verbose='.$uni2tri->{_verbose};

	} else { 
		print("uni2tri, verbose, missing verbose,\n");
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
