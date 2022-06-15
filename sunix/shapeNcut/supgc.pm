package supgc;

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
 SUPGC   -   Programmed Gain Control--apply agc like function	

              but the same function to all traces preserving	

              relative amplitudes spatially.			

 Required parameter:						

 file=             name of input file				



 Optional parameters:						

 ntrscan=200       number of traces to scan for gain function	

 lwindow=1.0       length of time window in seconds		







 Author: John Anderson (visitor to CWP from Mobil)



 Trace header fields accessed: ns, dt





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

my $supgc			= {
	_file					=> '',
	_lwindow					=> '',
	_ntrscan					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$supgc->{_Step}     = 'supgc'.$supgc->{_Step};
	return ( $supgc->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$supgc->{_note}     = 'supgc'.$supgc->{_note};
	return ( $supgc->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$supgc->{_file}			= '';
		$supgc->{_lwindow}			= '';
		$supgc->{_ntrscan}			= '';
		$supgc->{_Step}			= '';
		$supgc->{_note}			= '';
 }


=head2 sub file 


=cut

 sub file {

	my ( $self,$file )		= @_;
	if ( $file ne $empty_string ) {

		$supgc->{_file}		= $file;
		$supgc->{_note}		= $supgc->{_note}.' file='.$supgc->{_file};
		$supgc->{_Step}		= $supgc->{_Step}.' file='.$supgc->{_file};

	} else { 
		print("supgc, file, missing file,\n");
	 }
 }


=head2 sub lwindow 


=cut

 sub lwindow {

	my ( $self,$lwindow )		= @_;
	if ( $lwindow ne $empty_string ) {

		$supgc->{_lwindow}		= $lwindow;
		$supgc->{_note}		= $supgc->{_note}.' lwindow='.$supgc->{_lwindow};
		$supgc->{_Step}		= $supgc->{_Step}.' lwindow='.$supgc->{_lwindow};

	} else { 
		print("supgc, lwindow, missing lwindow,\n");
	 }
 }


=head2 sub ntrscan 


=cut

 sub ntrscan {

	my ( $self,$ntrscan )		= @_;
	if ( $ntrscan ne $empty_string ) {

		$supgc->{_ntrscan}		= $ntrscan;
		$supgc->{_note}		= $supgc->{_note}.' ntrscan='.$supgc->{_ntrscan};
		$supgc->{_Step}		= $supgc->{_Step}.' ntrscan='.$supgc->{_ntrscan};

	} else { 
		print("supgc, ntrscan, missing ntrscan,\n");
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
