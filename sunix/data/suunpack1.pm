package suunpack1;

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
SUUNPACK1 - unpack segy trace data from chars to floats	



    suunpack1 <packed_file >unpacked_file			



suunpack1 is the approximate inverse of supack1		

opt=null




 Credits:

	CWP: Jack K. Cohen, Shuki Ronen, Brian Sumner



 Caveats:

	This program is for single site use with supack1.  See the

	supack1 header comments.



 Notes:

	ungpow and unscale are defined in segy.h

	opt = CHARPACK is defined in su.h and segy.h





 Trace header fields accessed: ns, opt, ungpow, unscale

 Trace header fields modified:     opt, ungpow, unscale



=head2 User's notes (Juan Lorenzo)
untested

=cut


=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';


=head2 Import packages

=cut

use LSeismicUnix::misc::L_SU_global_constants;

use LSeismicUnix::misc::SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $suffix_bin);
use LSeismicUnix::configs::big_streams::Project_config;


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

my $suunpack1			= {
	_opt					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suunpack1->{_Step}     = 'suunpack1'.$suunpack1->{_Step};
	return ( $suunpack1->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suunpack1->{_note}     = 'suunpack1'.$suunpack1->{_note};
	return ( $suunpack1->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$suunpack1->{_opt}			= '';
		$suunpack1->{_Step}			= '';
		$suunpack1->{_note}			= '';
 }


=head2 sub opt 


=cut

 sub opt {

	my ( $self,$opt )		= @_;
#	if ( $opt ne $empty_string 
#		 or $opt eq $empty_string ) {
#
#		$suunpack1->{_opt}		= $opt;
#		$suunpack1->{_note}		= $suunpack1->{_note}.' opt='.$suunpack1->{_opt};
#		$suunpack1->{_Step}		= $suunpack1->{_Step}.' opt='.$suunpack1->{_opt};
#
#	} else { 
#		print("suunpack1, opt, missing opt,\n");
#	 }
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
