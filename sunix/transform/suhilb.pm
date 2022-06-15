package suhilb;

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
 SUHILB - Hilbert transform					



 suhilb <stdin >sdout 						



 Note: the transform is computed in the direct (time) domain   



option=null



 Credits:

	CWP: Jack Cohen   

      CWP: John Stockwell, modified to use Dave Hale's hilbert() subroutine



 Trace header fields accessed: ns, trid



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

my $suhilb			= {
	_option					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suhilb->{_Step}     = 'suhilb'.$suhilb->{_Step};
	return ( $suhilb->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suhilb->{_note}     = 'suhilb'.$suhilb->{_note};
	return ( $suhilb->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$suhilb->{_option}			= '';
		$suhilb->{_Step}			= '';
		$suhilb->{_note}			= '';
 }


=head2 sub option 


=cut

 sub option {

	my ( $self,$option )		= @_;
	if ( $option ne $empty_string ) {

		$suhilb->{_option}		= $option;
		$suhilb->{_note}		= $suhilb->{_note}.' option='.$suhilb->{_option};
		$suhilb->{_Step}		= $suhilb->{_Step}.' option='.$suhilb->{_option};

	} else { 
		print("suhilb, option, missing option,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 0;

    return($max_index);
}
 
 
1;
