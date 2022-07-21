package App::SeismicUnixGui::sunix::data::suoldtonew;

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
 SUOLDTONEW - convert existing su data to xdr format		



 suoldtonew <oldsu >newsu  					



 Required parameters:						

	none							



 Optional parameters:						

	none							

    opt=null

  

 Notes:							

 This program is used to convert native machine datasets to	

 xdr-based, system-independent format.				







 Author: Stewart A. Levin, Mobil, 1966

  



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

use App::SeismicUnixGui::misc::SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $suffix_bin);
use App::SeismicUnixGui::configs::big_streams::Project_config;


=head2 instantiation of packages

=cut

my $get					= new L_SU_global_constants();
my $Project				= new Project_config();
my $DATA_SEISMIC_SU		= $Project->DATA_SEISMIC_SU();
my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN();
my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT();

my $var				= $get->var();
my $on				= $var->{_on};
my $off				= $var->{_off};
my $true			= $var->{_true};
my $false			= $var->{_false};
my $empty_string	= $var->{_empty_string};

=head2 Encapsulated
hash of private variables

=cut

my $suoldtonew			= {
	_opt					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suoldtonew->{_Step}     = 'suoldtonew'.$suoldtonew->{_Step};
	return ( $suoldtonew->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suoldtonew->{_note}     = 'suoldtonew'.$suoldtonew->{_note};
	return ( $suoldtonew->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$suoldtonew->{_opt}			= '';
		$suoldtonew->{_Step}			= '';
		$suoldtonew->{_note}			= '';
 }


=head2 sub opt 


=cut

 sub opt {

	my ( $self,$opt )		= @_;
	if ( $opt ne $empty_string ) {

		$suoldtonew->{_opt}		= $opt;
		$suoldtonew->{_note}		= $suoldtonew->{_note}.' opt='.$suoldtonew->{_opt};
		$suoldtonew->{_Step}		= $suoldtonew->{_Step}.' opt='.$suoldtonew->{_opt};

	} else { 
		print("suoldtonew, opt, missing opt,\n");
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
