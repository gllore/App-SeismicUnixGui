package lprop;

=head2 SYNOPSIS
true
PACKAGE NAME:
AUTHOR:  

DATE:

DESCRIPTION:

Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS
true
=head3 SEISMIC UNIX NOTES
 LPROP - List PROPerties of root window of default screen of display 



 Usage:  lprop

  opt=null



=head2 User's notes (Juan Lorenzo)
untested

=cut

=head2 CHANGES and their DATEStrue

=cut

use Moose;
our $VERSION = '0.0.1';

=head2 Import packages

=cut

use LSeismicUnix::misc::L_SU_global_constants;

use LSeismicUnix::misc::SeismicUnix
  qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $suffix_bin);
use LSeismicUnix::configs::big_streams::Project_config;

=head2 instantiation of packages

=cut

my $get              = new L_SU_global_constants();
my $Project          = new Project_config();
my $DATA_SEISMIC_SU  = $Project->DATA_SEISMIC_SU();
my $DATA_SEISMIC_BIN = $Project->DATA_SEISMIC_BIN();
my $DATA_SEISMIC_TXT = $Project->DATA_SEISMIC_TXT();

my $var          = $get->var();
my $on           = $var->{_on};
my $off          = $var->{_off};
my $true         = $var->{_true};
my $false        = $var->{_false};
my $empty_string = $var->{_empty_string};

=head2 Encapsulated
hash of private variables

=cut

my $lprop = {
	_opt  => '',
	_Step => '',
	_note => '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

sub Step {

	$lprop->{_Step} = 'lprop' . $lprop->{_Step};
	return ( $lprop->{_Step} );

}

=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

sub note {

	$lprop->{_note} = 'lprop' . $lprop->{_note};
	return ( $lprop->{_note} );

}

=head2 sub clear

=cut

sub clear {

	$lprop->{_opt}  = '';
	$lprop->{_Step} = '';
	$lprop->{_note} = '';
}

=head2 sub opt 


=cut

sub opt {

	my ( $self, $opt ) = @_;
	if ( $opt ne $empty_string ) {

		$lprop->{_opt}  = $opt;
		$lprop->{_note} = $lprop->{_note} . ' opt=' . $lprop->{_opt};
		$lprop->{_Step} = $lprop->{_Step} . ' opt=' . $lprop->{_opt};

	}
	else {
		print("lprop, opt, missing opt,\n");
	}
}

=head2 sub get_max_index

max index = number of input variables -1
 
=cut

sub get_max_index {
	my ($self) = @_;
	my $max_index = 0;

	return ($max_index);
}

1;
