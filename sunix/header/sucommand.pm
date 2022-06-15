package sucommand;

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
 SUCOMMAND - pipe traces having the same key header word to command	



     sucommand <stdin >stdout [Optional parameters]			



 Required parameters:							

 	none								



 Optional parameters: 							

 	verbose=0		wordy output				

 	key=cdp			header key word to pipe on		

 	command="suop nop"    command piped into			

	dir=0		0:  change of header key			

			-1: break in monotonic decrease of header key	

			+1: break in monotonic increase of header key	





Notes:									

 This program permits limited parallel processing capability by opening

 pipes for processes, signaled by a change in key header word value.	







 Credits:

	VT: Matthias Imhof



 Note:

	The "valxxx" subroutines are in su/lib/valpkge.c.  In particular,

      "valcmp" shares the annoying attribute of "strcmp" that

		if (valcmp(type, val, valnew) {

			...

		}

	will be performed when val and valnew are different.





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

my $sucommand			= {
	_command					=> '',
	_dir					=> '',
	_key					=> '',
	_verbose					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sucommand->{_Step}     = 'sucommand'.$sucommand->{_Step};
	return ( $sucommand->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sucommand->{_note}     = 'sucommand'.$sucommand->{_note};
	return ( $sucommand->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sucommand->{_command}			= '';
		$sucommand->{_dir}			= '';
		$sucommand->{_key}			= '';
		$sucommand->{_verbose}			= '';
		$sucommand->{_Step}			= '';
		$sucommand->{_note}			= '';
 }


=head2 sub command 


=cut

 sub command {

	my ( $self,$command )		= @_;
	if ( $command ne $empty_string ) {

		$sucommand->{_command}		= $command;
		$sucommand->{_note}		= $sucommand->{_note}.' command='.$sucommand->{_command};
		$sucommand->{_Step}		= $sucommand->{_Step}.' command='.$sucommand->{_command};

	} else { 
		print("sucommand, command, missing command,\n");
	 }
 }


=head2 sub dir 


=cut

 sub dir {

	my ( $self,$dir )		= @_;
	if ( $dir ne $empty_string ) {

		$sucommand->{_dir}		= $dir;
		$sucommand->{_note}		= $sucommand->{_note}.' dir='.$sucommand->{_dir};
		$sucommand->{_Step}		= $sucommand->{_Step}.' dir='.$sucommand->{_dir};

	} else { 
		print("sucommand, dir, missing dir,\n");
	 }
 }


=head2 sub key 


=cut

 sub key {

	my ( $self,$key )		= @_;
	if ( $key ne $empty_string ) {

		$sucommand->{_key}		= $key;
		$sucommand->{_note}		= $sucommand->{_note}.' key='.$sucommand->{_key};
		$sucommand->{_Step}		= $sucommand->{_Step}.' key='.$sucommand->{_key};

	} else { 
		print("sucommand, key, missing key,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$sucommand->{_verbose}		= $verbose;
		$sucommand->{_note}		= $sucommand->{_note}.' verbose='.$sucommand->{_verbose};
		$sucommand->{_Step}		= $sucommand->{_Step}.' verbose='.$sucommand->{_verbose};

	} else { 
		print("sucommand, verbose, missing verbose,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 3;

    return($max_index);
}
 
 
1;
