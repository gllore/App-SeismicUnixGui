package subset;

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
 SUBSET - select a SUBSET of the samples from a 3-dimensional file	



 subset <infile >outfile [optional parameters]				



 Optional Parameters:							

 n1=nfloats             number of samples in 1st dimension		

 n2=nfloats/n1          number of samples in 2nd dimension		

 n3=nfloats/(n1*n2)     number of samples in 3rd dimension		

 id1s=1                 increment in samples selected in 1st dimension	

 if1s=0                 index of first sample selected in 1st dimension

 n1s=1+(n1-if1s-1)/id1s number of samples selected in 1st dimension	

 ix1s=if1s,if1s+id1s,...indices of samples selected in 1st dimension	

 id2s=1                 increment in samples selected in 2nd dimension	

 if2s=0                 index of first sample selected in 2nd dimension

 n2s=1+(n2-if2s-1)/id2s number of samples selected in 2nd dimension	

 ix2s=if2s,if2s+id2s,...indices of samples selected in 2nd dimension	

 id3s=1                 increment in samples selected in 3rd dimension	

 if3s=0                 index of first sample selected in 3rd dimension

 n3s=1+(n3-if3s-1)/id3s number of samples selected in 3rd dimension	

 ix3s=if3s,if3s+id3s,...indices of samples selected in 3rd dimension	



 For the 1st dimension, output is selected from input as follows:	

       output[i1s] = input[ix1s[i1s]], for i1s = 0 to n1s-1		

 Likewise for the 2nd and 3rd dimensions.				







 AUTHOR:  Dave Hale, Colorado School of Mines, 07/07/89



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

my $subset			= {
	_i1s					=> '',
	_id1s					=> '',
	_id2s					=> '',
	_id3s					=> '',
	_if1s					=> '',
	_if2s					=> '',
	_if3s					=> '',
	_ix1s					=> '',
	_ix2s					=> '',
	_ix3s					=> '',
	_n1					=> '',
	_n1s					=> '',
	_n2					=> '',
	_n2s					=> '',
	_n3					=> '',
	_n3s					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$subset->{_Step}     = 'subset'.$subset->{_Step};
	return ( $subset->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$subset->{_note}     = 'subset'.$subset->{_note};
	return ( $subset->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$subset->{_i1s}			= '';
		$subset->{_id1s}			= '';
		$subset->{_id2s}			= '';
		$subset->{_id3s}			= '';
		$subset->{_if1s}			= '';
		$subset->{_if2s}			= '';
		$subset->{_if3s}			= '';
		$subset->{_ix1s}			= '';
		$subset->{_ix2s}			= '';
		$subset->{_ix3s}			= '';
		$subset->{_n1}			= '';
		$subset->{_n1s}			= '';
		$subset->{_n2}			= '';
		$subset->{_n2s}			= '';
		$subset->{_n3}			= '';
		$subset->{_n3s}			= '';
		$subset->{_Step}			= '';
		$subset->{_note}			= '';
 }


=head2 sub i1s 


=cut

 sub i1s {

	my ( $self,$i1s )		= @_;
	if ( $i1s ne $empty_string ) {

		$subset->{_i1s}		= $i1s;
		$subset->{_note}		= $subset->{_note}.' i1s='.$subset->{_i1s};
		$subset->{_Step}		= $subset->{_Step}.' i1s='.$subset->{_i1s};

	} else { 
		print("subset, i1s, missing i1s,\n");
	 }
 }


=head2 sub id1s 


=cut

 sub id1s {

	my ( $self,$id1s )		= @_;
	if ( $id1s ne $empty_string ) {

		$subset->{_id1s}		= $id1s;
		$subset->{_note}		= $subset->{_note}.' id1s='.$subset->{_id1s};
		$subset->{_Step}		= $subset->{_Step}.' id1s='.$subset->{_id1s};

	} else { 
		print("subset, id1s, missing id1s,\n");
	 }
 }


=head2 sub id2s 


=cut

 sub id2s {

	my ( $self,$id2s )		= @_;
	if ( $id2s ne $empty_string ) {

		$subset->{_id2s}		= $id2s;
		$subset->{_note}		= $subset->{_note}.' id2s='.$subset->{_id2s};
		$subset->{_Step}		= $subset->{_Step}.' id2s='.$subset->{_id2s};

	} else { 
		print("subset, id2s, missing id2s,\n");
	 }
 }


=head2 sub id3s 


=cut

 sub id3s {

	my ( $self,$id3s )		= @_;
	if ( $id3s ne $empty_string ) {

		$subset->{_id3s}		= $id3s;
		$subset->{_note}		= $subset->{_note}.' id3s='.$subset->{_id3s};
		$subset->{_Step}		= $subset->{_Step}.' id3s='.$subset->{_id3s};

	} else { 
		print("subset, id3s, missing id3s,\n");
	 }
 }


=head2 sub if1s 


=cut

 sub if1s {

	my ( $self,$if1s )		= @_;
	if ( $if1s ne $empty_string ) {

		$subset->{_if1s}		= $if1s;
		$subset->{_note}		= $subset->{_note}.' if1s='.$subset->{_if1s};
		$subset->{_Step}		= $subset->{_Step}.' if1s='.$subset->{_if1s};

	} else { 
		print("subset, if1s, missing if1s,\n");
	 }
 }


=head2 sub if2s 


=cut

 sub if2s {

	my ( $self,$if2s )		= @_;
	if ( $if2s ne $empty_string ) {

		$subset->{_if2s}		= $if2s;
		$subset->{_note}		= $subset->{_note}.' if2s='.$subset->{_if2s};
		$subset->{_Step}		= $subset->{_Step}.' if2s='.$subset->{_if2s};

	} else { 
		print("subset, if2s, missing if2s,\n");
	 }
 }


=head2 sub if3s 


=cut

 sub if3s {

	my ( $self,$if3s )		= @_;
	if ( $if3s ne $empty_string ) {

		$subset->{_if3s}		= $if3s;
		$subset->{_note}		= $subset->{_note}.' if3s='.$subset->{_if3s};
		$subset->{_Step}		= $subset->{_Step}.' if3s='.$subset->{_if3s};

	} else { 
		print("subset, if3s, missing if3s,\n");
	 }
 }


=head2 sub ix1s 


=cut

 sub ix1s {

	my ( $self,$ix1s )		= @_;
	if ( $ix1s ne $empty_string ) {

		$subset->{_ix1s}		= $ix1s;
		$subset->{_note}		= $subset->{_note}.' ix1s='.$subset->{_ix1s};
		$subset->{_Step}		= $subset->{_Step}.' ix1s='.$subset->{_ix1s};

	} else { 
		print("subset, ix1s, missing ix1s,\n");
	 }
 }


=head2 sub ix2s 


=cut

 sub ix2s {

	my ( $self,$ix2s )		= @_;
	if ( $ix2s ne $empty_string ) {

		$subset->{_ix2s}		= $ix2s;
		$subset->{_note}		= $subset->{_note}.' ix2s='.$subset->{_ix2s};
		$subset->{_Step}		= $subset->{_Step}.' ix2s='.$subset->{_ix2s};

	} else { 
		print("subset, ix2s, missing ix2s,\n");
	 }
 }


=head2 sub ix3s 


=cut

 sub ix3s {

	my ( $self,$ix3s )		= @_;
	if ( $ix3s ne $empty_string ) {

		$subset->{_ix3s}		= $ix3s;
		$subset->{_note}		= $subset->{_note}.' ix3s='.$subset->{_ix3s};
		$subset->{_Step}		= $subset->{_Step}.' ix3s='.$subset->{_ix3s};

	} else { 
		print("subset, ix3s, missing ix3s,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$subset->{_n1}		= $n1;
		$subset->{_note}		= $subset->{_note}.' n1='.$subset->{_n1};
		$subset->{_Step}		= $subset->{_Step}.' n1='.$subset->{_n1};

	} else { 
		print("subset, n1, missing n1,\n");
	 }
 }


=head2 sub n1s 


=cut

 sub n1s {

	my ( $self,$n1s )		= @_;
	if ( $n1s ne $empty_string ) {

		$subset->{_n1s}		= $n1s;
		$subset->{_note}		= $subset->{_note}.' n1s='.$subset->{_n1s};
		$subset->{_Step}		= $subset->{_Step}.' n1s='.$subset->{_n1s};

	} else { 
		print("subset, n1s, missing n1s,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$subset->{_n2}		= $n2;
		$subset->{_note}		= $subset->{_note}.' n2='.$subset->{_n2};
		$subset->{_Step}		= $subset->{_Step}.' n2='.$subset->{_n2};

	} else { 
		print("subset, n2, missing n2,\n");
	 }
 }


=head2 sub n2s 


=cut

 sub n2s {

	my ( $self,$n2s )		= @_;
	if ( $n2s ne $empty_string ) {

		$subset->{_n2s}		= $n2s;
		$subset->{_note}		= $subset->{_note}.' n2s='.$subset->{_n2s};
		$subset->{_Step}		= $subset->{_Step}.' n2s='.$subset->{_n2s};

	} else { 
		print("subset, n2s, missing n2s,\n");
	 }
 }


=head2 sub n3 


=cut

 sub n3 {

	my ( $self,$n3 )		= @_;
	if ( $n3 ne $empty_string ) {

		$subset->{_n3}		= $n3;
		$subset->{_note}		= $subset->{_note}.' n3='.$subset->{_n3};
		$subset->{_Step}		= $subset->{_Step}.' n3='.$subset->{_n3};

	} else { 
		print("subset, n3, missing n3,\n");
	 }
 }


=head2 sub n3s 


=cut

 sub n3s {

	my ( $self,$n3s )		= @_;
	if ( $n3s ne $empty_string ) {

		$subset->{_n3s}		= $n3s;
		$subset->{_note}		= $subset->{_note}.' n3s='.$subset->{_n3s};
		$subset->{_Step}		= $subset->{_Step}.' n3s='.$subset->{_n3s};

	} else { 
		print("subset, n3s, missing n3s,\n");
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
