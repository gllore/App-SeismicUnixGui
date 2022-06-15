package sucentsamp;

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
 SUCENTSAMP - CENTRoid SAMPle seismic traces			



  sucentsamp <stdin [optional parameters] >sdout  		



 Required parameters:						

 	none							



 Optional parameters:						

 	dt=from header		sampling interval		

	verbose=1		=0 to stop advisory messages	



 Notes: 							

 This program takes seismic traces as input, and returns traces

 consisting of spikes of height equal to the area of each lobe 

 of each oscillation, located at the centroid of the lobe in	

 question. The height of each spike equal to the area of the   

 corresponding lobe.						



 Caveat: No check is made that the data are real time traces!	





 Credits:



	Providence Technologies: Tom Morgan 



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

my $sucentsamp			= {
	_dt					=> '',
	_verbose					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sucentsamp->{_Step}     = 'sucentsamp'.$sucentsamp->{_Step};
	return ( $sucentsamp->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sucentsamp->{_note}     = 'sucentsamp'.$sucentsamp->{_note};
	return ( $sucentsamp->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sucentsamp->{_dt}			= '';
		$sucentsamp->{_verbose}			= '';
		$sucentsamp->{_Step}			= '';
		$sucentsamp->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$sucentsamp->{_dt}		= $dt;
		$sucentsamp->{_note}		= $sucentsamp->{_note}.' dt='.$sucentsamp->{_dt};
		$sucentsamp->{_Step}		= $sucentsamp->{_Step}.' dt='.$sucentsamp->{_dt};

	} else { 
		print("sucentsamp, dt, missing dt,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$sucentsamp->{_verbose}		= $verbose;
		$sucentsamp->{_note}		= $sucentsamp->{_note}.' verbose='.$sucentsamp->{_verbose};
		$sucentsamp->{_Step}		= $sucentsamp->{_Step}.' verbose='.$sucentsamp->{_verbose};

	} else { 
		print("sucentsamp, verbose, missing verbose,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 1;

    return($max_index);
}
 
 
1;
