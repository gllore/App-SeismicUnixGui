package mrafxzwt;

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
 MRAFXZWT - Multi-Resolution Analysis of a function F(X,Z) by Wavelet	

	 Transform. Modified to perform different levels of resolution  

        analysis for each dimension and also to allow to transform     

        back only the lower level of resolution.  		      	



    mrafxzwt [parameters] < infile > mrafile 			 	



 Required Parameters:							

 n1=		size of first (fast) dimension				

 n2=		size of second (slow) dimension 			



 Optional Parameters:							

 p1=		maximum integer such that 2^p1 <= n1			

 p2=		maximum integer such that 2^p2 <= n2			

 order=6	order of Daubechies wavelet used (even, 4<=order<=20)	

 mralevel1=3   maximum multi-resolution analysis level in dimension 1	

 mralevel2=3   maximum multi-resolution analysis level in dimension 2	

 trunc=0.0	truncation level (percentage) of the reconstruction	

 verbose=0	=1 to print some useful information			

 reconfile=    reconstructed data file to write			

 reconmrafile= reconstructed data file in MRA domain to write		

 dfile=	difference between infile and reconfile to write        

 dmrafile=	difference between mrafile and reconmrafile to write    

 dconly=0      =1 keep only dc	component of MRA			

 verbose=0     =1 to print some useful information                     

 if (n1 or n2 is not integer powers of 2) specify the following:	

 	nc1=n1/2 center of trimmed image in the 1st dimension           

 	nc2=n2/2 center of trimmed image in the 2nd dimension           

	trimfile= if given, output the trimmed file			



 Notes:								

 This program performs multi-resolution analysis of an input function	

 f(x,z) via the wavelet transform method. Daubechies's least asymmetric

 wavelets are used. The smallest wavelet coefficient retained is given	

 by trunc times the absolute maximum size coefficient in the MRA.	

 

 The input dimensions of the data must be expressed by (p1,p2) which   



  Author: Zhaobo Meng, 11/25/95, Colorado School of Mines             *

  Modified:  Carlos E. Theodoro, 06/25/97, Colorado School of Mines   *

	Included options for:                           	        *

	- different level of resolutionf or each dimension;   	        *

	- transform back the lower level of resolution, only.		*

									*

 Reference:								*

 Daubechies, I., 1988, Orthonormal Bases of Compactly Supported	* 

 Wavelets, Communications on Pure and Applied Mathematics, Vol. XLI,  *

 909-996.				 				* 

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

my $mrafxzwt			= {
	_dconly					=> '',
	_dfile					=> '',
	_dmrafile					=> '',
	_mralevel1					=> '',
	_mralevel2					=> '',
	_n1					=> '',
	_n2					=> '',
	_nc1					=> '',
	_nc2					=> '',
	_order					=> '',
	_p1					=> '',
	_p2					=> '',
	_reconfile					=> '',
	_reconmrafile					=> '',
	_trimfile					=> '',
	_trunc					=> '',
	_verbose					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$mrafxzwt->{_Step}     = 'mrafxzwt'.$mrafxzwt->{_Step};
	return ( $mrafxzwt->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$mrafxzwt->{_note}     = 'mrafxzwt'.$mrafxzwt->{_note};
	return ( $mrafxzwt->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$mrafxzwt->{_dconly}			= '';
		$mrafxzwt->{_dfile}			= '';
		$mrafxzwt->{_dmrafile}			= '';
		$mrafxzwt->{_mralevel1}			= '';
		$mrafxzwt->{_mralevel2}			= '';
		$mrafxzwt->{_n1}			= '';
		$mrafxzwt->{_n2}			= '';
		$mrafxzwt->{_nc1}			= '';
		$mrafxzwt->{_nc2}			= '';
		$mrafxzwt->{_order}			= '';
		$mrafxzwt->{_p1}			= '';
		$mrafxzwt->{_p2}			= '';
		$mrafxzwt->{_reconfile}			= '';
		$mrafxzwt->{_reconmrafile}			= '';
		$mrafxzwt->{_trimfile}			= '';
		$mrafxzwt->{_trunc}			= '';
		$mrafxzwt->{_verbose}			= '';
		$mrafxzwt->{_Step}			= '';
		$mrafxzwt->{_note}			= '';
 }


=head2 sub dconly 


=cut

 sub dconly {

	my ( $self,$dconly )		= @_;
	if ( $dconly ne $empty_string ) {

		$mrafxzwt->{_dconly}		= $dconly;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' dconly='.$mrafxzwt->{_dconly};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' dconly='.$mrafxzwt->{_dconly};

	} else { 
		print("mrafxzwt, dconly, missing dconly,\n");
	 }
 }


=head2 sub dfile 


=cut

 sub dfile {

	my ( $self,$dfile )		= @_;
	if ( $dfile ne $empty_string ) {

		$mrafxzwt->{_dfile}		= $dfile;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' dfile='.$mrafxzwt->{_dfile};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' dfile='.$mrafxzwt->{_dfile};

	} else { 
		print("mrafxzwt, dfile, missing dfile,\n");
	 }
 }


=head2 sub dmrafile 


=cut

 sub dmrafile {

	my ( $self,$dmrafile )		= @_;
	if ( $dmrafile ne $empty_string ) {

		$mrafxzwt->{_dmrafile}		= $dmrafile;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' dmrafile='.$mrafxzwt->{_dmrafile};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' dmrafile='.$mrafxzwt->{_dmrafile};

	} else { 
		print("mrafxzwt, dmrafile, missing dmrafile,\n");
	 }
 }


=head2 sub mralevel1 


=cut

 sub mralevel1 {

	my ( $self,$mralevel1 )		= @_;
	if ( $mralevel1 ne $empty_string ) {

		$mrafxzwt->{_mralevel1}		= $mralevel1;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' mralevel1='.$mrafxzwt->{_mralevel1};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' mralevel1='.$mrafxzwt->{_mralevel1};

	} else { 
		print("mrafxzwt, mralevel1, missing mralevel1,\n");
	 }
 }


=head2 sub mralevel2 


=cut

 sub mralevel2 {

	my ( $self,$mralevel2 )		= @_;
	if ( $mralevel2 ne $empty_string ) {

		$mrafxzwt->{_mralevel2}		= $mralevel2;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' mralevel2='.$mrafxzwt->{_mralevel2};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' mralevel2='.$mrafxzwt->{_mralevel2};

	} else { 
		print("mrafxzwt, mralevel2, missing mralevel2,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$mrafxzwt->{_n1}		= $n1;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' n1='.$mrafxzwt->{_n1};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' n1='.$mrafxzwt->{_n1};

	} else { 
		print("mrafxzwt, n1, missing n1,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$mrafxzwt->{_n2}		= $n2;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' n2='.$mrafxzwt->{_n2};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' n2='.$mrafxzwt->{_n2};

	} else { 
		print("mrafxzwt, n2, missing n2,\n");
	 }
 }


=head2 sub nc1 


=cut

 sub nc1 {

	my ( $self,$nc1 )		= @_;
	if ( $nc1 ne $empty_string ) {

		$mrafxzwt->{_nc1}		= $nc1;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' nc1='.$mrafxzwt->{_nc1};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' nc1='.$mrafxzwt->{_nc1};

	} else { 
		print("mrafxzwt, nc1, missing nc1,\n");
	 }
 }


=head2 sub nc2 


=cut

 sub nc2 {

	my ( $self,$nc2 )		= @_;
	if ( $nc2 ne $empty_string ) {

		$mrafxzwt->{_nc2}		= $nc2;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' nc2='.$mrafxzwt->{_nc2};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' nc2='.$mrafxzwt->{_nc2};

	} else { 
		print("mrafxzwt, nc2, missing nc2,\n");
	 }
 }


=head2 sub order 


=cut

 sub order {

	my ( $self,$order )		= @_;
	if ( $order ne $empty_string ) {

		$mrafxzwt->{_order}		= $order;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' order='.$mrafxzwt->{_order};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' order='.$mrafxzwt->{_order};

	} else { 
		print("mrafxzwt, order, missing order,\n");
	 }
 }


=head2 sub p1 


=cut

 sub p1 {

	my ( $self,$p1 )		= @_;
	if ( $p1 ne $empty_string ) {

		$mrafxzwt->{_p1}		= $p1;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' p1='.$mrafxzwt->{_p1};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' p1='.$mrafxzwt->{_p1};

	} else { 
		print("mrafxzwt, p1, missing p1,\n");
	 }
 }


=head2 sub p2 


=cut

 sub p2 {

	my ( $self,$p2 )		= @_;
	if ( $p2 ne $empty_string ) {

		$mrafxzwt->{_p2}		= $p2;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' p2='.$mrafxzwt->{_p2};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' p2='.$mrafxzwt->{_p2};

	} else { 
		print("mrafxzwt, p2, missing p2,\n");
	 }
 }


=head2 sub reconfile 


=cut

 sub reconfile {

	my ( $self,$reconfile )		= @_;
	if ( $reconfile ne $empty_string ) {

		$mrafxzwt->{_reconfile}		= $reconfile;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' reconfile='.$mrafxzwt->{_reconfile};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' reconfile='.$mrafxzwt->{_reconfile};

	} else { 
		print("mrafxzwt, reconfile, missing reconfile,\n");
	 }
 }


=head2 sub reconmrafile 


=cut

 sub reconmrafile {

	my ( $self,$reconmrafile )		= @_;
	if ( $reconmrafile ne $empty_string ) {

		$mrafxzwt->{_reconmrafile}		= $reconmrafile;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' reconmrafile='.$mrafxzwt->{_reconmrafile};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' reconmrafile='.$mrafxzwt->{_reconmrafile};

	} else { 
		print("mrafxzwt, reconmrafile, missing reconmrafile,\n");
	 }
 }


=head2 sub trimfile 


=cut

 sub trimfile {

	my ( $self,$trimfile )		= @_;
	if ( $trimfile ne $empty_string ) {

		$mrafxzwt->{_trimfile}		= $trimfile;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' trimfile='.$mrafxzwt->{_trimfile};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' trimfile='.$mrafxzwt->{_trimfile};

	} else { 
		print("mrafxzwt, trimfile, missing trimfile,\n");
	 }
 }


=head2 sub trunc 


=cut

 sub trunc {

	my ( $self,$trunc )		= @_;
	if ( $trunc ne $empty_string ) {

		$mrafxzwt->{_trunc}		= $trunc;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' trunc='.$mrafxzwt->{_trunc};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' trunc='.$mrafxzwt->{_trunc};

	} else { 
		print("mrafxzwt, trunc, missing trunc,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$mrafxzwt->{_verbose}		= $verbose;
		$mrafxzwt->{_note}		= $mrafxzwt->{_note}.' verbose='.$mrafxzwt->{_verbose};
		$mrafxzwt->{_Step}		= $mrafxzwt->{_Step}.' verbose='.$mrafxzwt->{_verbose};

	} else { 
		print("mrafxzwt, verbose, missing verbose,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 16;

    return($max_index);
}
 
 
1;
