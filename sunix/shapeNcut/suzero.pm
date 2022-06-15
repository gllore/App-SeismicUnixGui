package suzero;

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
 SUZERO -- zero-out (or set constant) data within a time window	



 suzero itmax= < indata > outdata				



 Required parameters						

 	itmax=		last time sample to zero out		



 Optional parameters						

 	itmin=0		first time sample to zero out		

 	value=0		value to set				



 See also: sukill, sumute					





 Credits:

	CWP: Chris

	Geocon: Garry Perratt (added value= option)



 Trace header fields accessed: ns

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

my $suzero			= {
	_itmax					=> '',
	_itmin					=> '',
	_value					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suzero->{_Step}     = 'suzero'.$suzero->{_Step};
	return ( $suzero->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suzero->{_note}     = 'suzero'.$suzero->{_note};
	return ( $suzero->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$suzero->{_itmax}			= '';
		$suzero->{_itmin}			= '';
		$suzero->{_value}			= '';
		$suzero->{_Step}			= '';
		$suzero->{_note}			= '';
 }


=head2 sub itmax 


=cut

 sub itmax {

	my ( $self,$itmax )		= @_;
	if ( $itmax ne $empty_string ) {

		$suzero->{_itmax}		= $itmax;
		$suzero->{_note}		= $suzero->{_note}.' itmax='.$suzero->{_itmax};
		$suzero->{_Step}		= $suzero->{_Step}.' itmax='.$suzero->{_itmax};

	} else { 
		print("suzero, itmax, missing itmax,\n");
	 }
 }


=head2 sub itmin 


=cut

 sub itmin {

	my ( $self,$itmin )		= @_;
	if ( $itmin ne $empty_string ) {

		$suzero->{_itmin}		= $itmin;
		$suzero->{_note}		= $suzero->{_note}.' itmin='.$suzero->{_itmin};
		$suzero->{_Step}		= $suzero->{_Step}.' itmin='.$suzero->{_itmin};

	} else { 
		print("suzero, itmin, missing itmin,\n");
	 }
 }


=head2 sub value 


=cut

 sub value {

	my ( $self,$value )		= @_;
	if ( $value ne $empty_string ) {

		$suzero->{_value}		= $value;
		$suzero->{_note}		= $suzero->{_note}.' value='.$suzero->{_value};
		$suzero->{_Step}		= $suzero->{_Step}.' value='.$suzero->{_value};

	} else { 
		print("suzero, value, missing value,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 2;

    return($max_index);
}
 
 
1;
