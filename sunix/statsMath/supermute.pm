package supermute;

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
 SUPERMUTE - permute or transpose a 3d datacube	 		



 supermute <stdin >sdout	 					



 Required parameters:							

 none									



 Optional parameters:							

 n1=ns from header		number of samples in the fast direction	

 n2=ntr from header		number of samples in the med direction	",	

 n3=1				number of samples in the slow direction	



 o1=1				new fast direction			

 o2=2				new med direction			

 o3=3				new slow direction			



 d1=1				output interval in new fast direction	

 d2=1				output interval in new med direction	

 d3=1				output interval in new slow direction	



 Notes:								

 header fields d1 and d2 default to d1=1.0 and d2=1.0			



 Credits:



	VT: Matthias Imhof



 Trace header fields accessed: ns, ntr

 Trace header fields modified: d1=1, f1=1, d2=1, f2=1, ns, ntr



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

my $supermute			= {
	_d1					=> '',
	_d2					=> '',
	_d3					=> '',
	_n1					=> '',
	_n2					=> '',
	_n3					=> '',
	_o1					=> '',
	_o2					=> '',
	_o3					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$supermute->{_Step}     = 'supermute'.$supermute->{_Step};
	return ( $supermute->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$supermute->{_note}     = 'supermute'.$supermute->{_note};
	return ( $supermute->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$supermute->{_d1}			= '';
		$supermute->{_d2}			= '';
		$supermute->{_d3}			= '';
		$supermute->{_n1}			= '';
		$supermute->{_n2}			= '';
		$supermute->{_n3}			= '';
		$supermute->{_o1}			= '';
		$supermute->{_o2}			= '';
		$supermute->{_o3}			= '';
		$supermute->{_Step}			= '';
		$supermute->{_note}			= '';
 }


=head2 sub d1 


=cut

 sub d1 {

	my ( $self,$d1 )		= @_;
	if ( $d1 ne $empty_string ) {

		$supermute->{_d1}		= $d1;
		$supermute->{_note}		= $supermute->{_note}.' d1='.$supermute->{_d1};
		$supermute->{_Step}		= $supermute->{_Step}.' d1='.$supermute->{_d1};

	} else { 
		print("supermute, d1, missing d1,\n");
	 }
 }


=head2 sub d2 


=cut

 sub d2 {

	my ( $self,$d2 )		= @_;
	if ( $d2 ne $empty_string ) {

		$supermute->{_d2}		= $d2;
		$supermute->{_note}		= $supermute->{_note}.' d2='.$supermute->{_d2};
		$supermute->{_Step}		= $supermute->{_Step}.' d2='.$supermute->{_d2};

	} else { 
		print("supermute, d2, missing d2,\n");
	 }
 }


=head2 sub d3 


=cut

 sub d3 {

	my ( $self,$d3 )		= @_;
	if ( $d3 ne $empty_string ) {

		$supermute->{_d3}		= $d3;
		$supermute->{_note}		= $supermute->{_note}.' d3='.$supermute->{_d3};
		$supermute->{_Step}		= $supermute->{_Step}.' d3='.$supermute->{_d3};

	} else { 
		print("supermute, d3, missing d3,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$supermute->{_n1}		= $n1;
		$supermute->{_note}		= $supermute->{_note}.' n1='.$supermute->{_n1};
		$supermute->{_Step}		= $supermute->{_Step}.' n1='.$supermute->{_n1};

	} else { 
		print("supermute, n1, missing n1,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$supermute->{_n2}		= $n2;
		$supermute->{_note}		= $supermute->{_note}.' n2='.$supermute->{_n2};
		$supermute->{_Step}		= $supermute->{_Step}.' n2='.$supermute->{_n2};

	} else { 
		print("supermute, n2, missing n2,\n");
	 }
 }


=head2 sub n3 


=cut

 sub n3 {

	my ( $self,$n3 )		= @_;
	if ( $n3 ne $empty_string ) {

		$supermute->{_n3}		= $n3;
		$supermute->{_note}		= $supermute->{_note}.' n3='.$supermute->{_n3};
		$supermute->{_Step}		= $supermute->{_Step}.' n3='.$supermute->{_n3};

	} else { 
		print("supermute, n3, missing n3,\n");
	 }
 }


=head2 sub o1 


=cut

 sub o1 {

	my ( $self,$o1 )		= @_;
	if ( $o1 ne $empty_string ) {

		$supermute->{_o1}		= $o1;
		$supermute->{_note}		= $supermute->{_note}.' o1='.$supermute->{_o1};
		$supermute->{_Step}		= $supermute->{_Step}.' o1='.$supermute->{_o1};

	} else { 
		print("supermute, o1, missing o1,\n");
	 }
 }


=head2 sub o2 


=cut

 sub o2 {

	my ( $self,$o2 )		= @_;
	if ( $o2 ne $empty_string ) {

		$supermute->{_o2}		= $o2;
		$supermute->{_note}		= $supermute->{_note}.' o2='.$supermute->{_o2};
		$supermute->{_Step}		= $supermute->{_Step}.' o2='.$supermute->{_o2};

	} else { 
		print("supermute, o2, missing o2,\n");
	 }
 }


=head2 sub o3 


=cut

 sub o3 {

	my ( $self,$o3 )		= @_;
	if ( $o3 ne $empty_string ) {

		$supermute->{_o3}		= $o3;
		$supermute->{_note}		= $supermute->{_note}.' o3='.$supermute->{_o3};
		$supermute->{_Step}		= $supermute->{_Step}.' o3='.$supermute->{_o3};

	} else { 
		print("supermute, o3, missing o3,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 8;

    return($max_index);
}
 
 
1;
