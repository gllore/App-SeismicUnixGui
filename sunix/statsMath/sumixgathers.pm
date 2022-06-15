package sumixgathers;

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
 SUMIXGATHERS - mix two gathers					



 sumixgathers file1 file2 > stdout [optional parameters]		



 Required Parameters:							

 ntr=tr.ntr	if ntr header field is not set, then ntr is mandatory	



 Optional Parameters: none						



 Notes: Both files have to be sorted by offset				

 Mixes two gathers keeping only the traces of the first file		

 if the offset is the same. The purpose is to substitute only		

 traces non existing in file1 by traces interpolated store in file2. 	", 



 Example. If file1 is original data file and file 2 is obtained by	

 resampling with Radon transform, then the output contains original  	

 traces with gaps filled						







 Credits:

	Daniel Trad. UBC

 Trace header fields accessed: ns, dt, ntr

 Copyright (c) University of British Columbia, 1999.

 All rights reserved.





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

my $sumixgathers			= {
	_ntr					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sumixgathers->{_Step}     = 'sumixgathers'.$sumixgathers->{_Step};
	return ( $sumixgathers->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sumixgathers->{_note}     = 'sumixgathers'.$sumixgathers->{_note};
	return ( $sumixgathers->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sumixgathers->{_ntr}			= '';
		$sumixgathers->{_Step}			= '';
		$sumixgathers->{_note}			= '';
 }


=head2 sub ntr 


=cut

 sub ntr {

	my ( $self,$ntr )		= @_;
	if ( $ntr ne $empty_string ) {

		$sumixgathers->{_ntr}		= $ntr;
		$sumixgathers->{_note}		= $sumixgathers->{_note}.' ntr='.$sumixgathers->{_ntr};
		$sumixgathers->{_Step}		= $sumixgathers->{_Step}.' ntr='.$sumixgathers->{_ntr};

	} else { 
		print("sumixgathers, ntr, missing ntr,\n");
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
