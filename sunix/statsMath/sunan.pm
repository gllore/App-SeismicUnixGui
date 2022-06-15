package sunan;

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
 SUNAN - remove NaNs & Infs from the input stream		



    sunan < in.su >out.su					



 Optional parameters:						

 verbose=1	echo locations of NaNs or Infs to stderr	

	        =0 silent					

 ...user defined ... 						



 value=0.0	NaNs and Inf replacement value			

 ... and/or....						

 interp=0	=1 replace NaNs and Infs by interpolating	

                   neighboring finite values			



 Notes:							

 A simple program to remove NaNs and Infs from an input stream.

 The program sets NaNs and Infs to "value" if interp=0. When	

 interp=1 NaNs are replaced with the average of neighboring values

 provided that the neighboring values are finite, otherwise	

 NaNs and Infs are replaced by "value".			





 Author: Reginald H. Beardsley  2003   rhb@acm.org



  A simple program to remove NaNs & Infs from an input stream. They

  shouldn't be there, but it can be hard to find the cause and fix

  the problem if you can't look at the data.



  Interpolation idea comes from a version of sunan modified by

  Balasz Nemeth while at Potash Corporation in Saskatchewan.







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

my $sunan			= {
	_interp					=> '',
	_value					=> '',
	_verbose					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sunan->{_Step}     = 'sunan'.$sunan->{_Step};
	return ( $sunan->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sunan->{_note}     = 'sunan'.$sunan->{_note};
	return ( $sunan->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sunan->{_interp}			= '';
		$sunan->{_value}			= '';
		$sunan->{_verbose}			= '';
		$sunan->{_Step}			= '';
		$sunan->{_note}			= '';
 }


=head2 sub interp 


=cut

 sub interp {

	my ( $self,$interp )		= @_;
	if ( $interp ne $empty_string ) {

		$sunan->{_interp}		= $interp;
		$sunan->{_note}		= $sunan->{_note}.' interp='.$sunan->{_interp};
		$sunan->{_Step}		= $sunan->{_Step}.' interp='.$sunan->{_interp};

	} else { 
		print("sunan, interp, missing interp,\n");
	 }
 }


=head2 sub value 


=cut

 sub value {

	my ( $self,$value )		= @_;
	if ( $value ne $empty_string ) {

		$sunan->{_value}		= $value;
		$sunan->{_note}		= $sunan->{_note}.' value='.$sunan->{_value};
		$sunan->{_Step}		= $sunan->{_Step}.' value='.$sunan->{_value};

	} else { 
		print("sunan, value, missing value,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$sunan->{_verbose}		= $verbose;
		$sunan->{_note}		= $sunan->{_note}.' verbose='.$sunan->{_verbose};
		$sunan->{_Step}		= $sunan->{_Step}.' verbose='.$sunan->{_verbose};

	} else { 
		print("sunan, verbose, missing verbose,\n");
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
