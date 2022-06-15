package xpsp;

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
 XPSP - Display conforming PostScript in an X-window



 xpsp < stdin

 

 opt=null



 Note: this is the most advanced version of xepsb and xepsp. 

 Caveat: your  system must have Display PostScript Graphics

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

my $xpsp			= {
	_opt					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$xpsp->{_Step}     = 'xpsp'.$xpsp->{_Step};
	return ( $xpsp->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$xpsp->{_note}     = 'xpsp'.$xpsp->{_note};
	return ( $xpsp->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$xpsp->{_opt}			= '';
		$xpsp->{_Step}			= '';
		$xpsp->{_note}			= '';
 }


=head2 sub opt 


=cut

 sub opt {

	my ( $self,$opt )		= @_;
	if ( $opt ne $empty_string ) {

		$xpsp->{_opt}		= $opt;
		$xpsp->{_note}		= $xpsp->{_note}.' opt='.$xpsp->{_opt};
		$xpsp->{_Step}		= $xpsp->{_Step}.' opt='.$xpsp->{_opt};

	} else { 
		print("xpsp, opt, missing opt,\n");
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
