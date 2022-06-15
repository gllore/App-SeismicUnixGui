package sugausstaper;

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
 SUGAUSSTAPER - Multiply traces with gaussian taper		



 sugausstaper < stdin > stdout [optional parameters]		



 Required Parameters:					   	

   <none>							



 Optional parameters:					   	

 key=offset    keyword of header field to weight traces by 	

 x0=300        key value defining the center of gaussian window", 

 xw=50         width of gaussian window in units of key value 	



 Notes:							

 Traces are multiplied with a symmetrical gaussian taper 	

  	w(t)=exp(-((key-x0)/xw)**2)				

 unlike "sutaper" the value of x0 defines center of the taper

 rather than the edges of the data.				



 Credits:



	Thomas Bohlen, formerly of TU Bergakademie, Freiberg GDR

      most recently of U Karlsruhe

          04.01.2002



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

my $sugausstaper			= {
	_key					=> '',
	_x0					=> '',
	_xw					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sugausstaper->{_Step}     = 'sugausstaper'.$sugausstaper->{_Step};
	return ( $sugausstaper->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sugausstaper->{_note}     = 'sugausstaper'.$sugausstaper->{_note};
	return ( $sugausstaper->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sugausstaper->{_key}			= '';
		$sugausstaper->{_x0}			= '';
		$sugausstaper->{_xw}			= '';
		$sugausstaper->{_Step}			= '';
		$sugausstaper->{_note}			= '';
 }


=head2 sub key 


=cut

 sub key {

	my ( $self,$key )		= @_;
	if ( $key ne $empty_string ) {

		$sugausstaper->{_key}		= $key;
		$sugausstaper->{_note}		= $sugausstaper->{_note}.' key='.$sugausstaper->{_key};
		$sugausstaper->{_Step}		= $sugausstaper->{_Step}.' key='.$sugausstaper->{_key};

	} else { 
		print("sugausstaper, key, missing key,\n");
	 }
 }


=head2 sub x0 


=cut

 sub x0 {

	my ( $self,$x0 )		= @_;
	if ( $x0 ne $empty_string ) {

		$sugausstaper->{_x0}		= $x0;
		$sugausstaper->{_note}		= $sugausstaper->{_note}.' x0='.$sugausstaper->{_x0};
		$sugausstaper->{_Step}		= $sugausstaper->{_Step}.' x0='.$sugausstaper->{_x0};

	} else { 
		print("sugausstaper, x0, missing x0,\n");
	 }
 }


=head2 sub xw 


=cut

 sub xw {

	my ( $self,$xw )		= @_;
	if ( $xw ne $empty_string ) {

		$sugausstaper->{_xw}		= $xw;
		$sugausstaper->{_note}		= $sugausstaper->{_note}.' xw='.$sugausstaper->{_xw};
		$sugausstaper->{_Step}		= $sugausstaper->{_Step}.' xw='.$sugausstaper->{_xw};

	} else { 
		print("sugausstaper, xw, missing xw,\n");
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
