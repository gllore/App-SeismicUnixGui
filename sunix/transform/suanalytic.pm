package suanalytic;

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
 SUANALYTIC - use the Hilbert transform to generate an ANALYTIC	

		(complex) trace						



 suanalytic <stdin >sdout 						



 Optional Parameter:							

 phaserot=		phase rotation in degrees of complex trace	



 Notes:								



 The output are complex valued traces. The analytic trace is defined as",  

   ctr[ i ] = indata[i] + i hilb[indata[t]]				

 where the imaginary part is the hilbert tranform of the original trace



 The Hilbert transform is computed in the direct (time) domain		



 If phaserot is set, then a phase rotated complex trace is produced	

   ctr[ i ] = cos[phaserot]*indata[i] + i sin[phaserot]* hilb[indata[t]]



 Use "suamp" to extract real, imaginary, amplitude (modulus), etc 	

 Exmple:								

 suanalytic < sudata | suamp mode=amp | suxgraph 			







 Use "suattributes" for instantaneous phase, frequency, etc.		





 Credits:

    CWP: John Stockwell, based on suhilb by Jack K. Cohen.



 Trace header fields accessed: ns, trid



 Technical references:

 Oppenheim, A. V. and Schafer, R. W. (1999).

     Discrete-Time Signal Processing. Prentice Hall Signal Processing Series.

     Prentice Hall, New Jersey, 2.

 Taner, M. T., F. Koehler, and R. E. Sheriff, 1979, Complex seismic 

    trace analysis: Geophysics, 44, 1041-1063. 





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

my $suanalytic			= {
	_mode					=> '',
	_phaserot					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suanalytic->{_Step}     = 'suanalytic'.$suanalytic->{_Step};
	return ( $suanalytic->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suanalytic->{_note}     = 'suanalytic'.$suanalytic->{_note};
	return ( $suanalytic->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$suanalytic->{_mode}			= '';
		$suanalytic->{_phaserot}			= '';
		$suanalytic->{_Step}			= '';
		$suanalytic->{_note}			= '';
 }


=head2 sub mode 


=cut

 sub mode {

	my ( $self,$mode )		= @_;
	if ( $mode ne $empty_string ) {

		$suanalytic->{_mode}		= $mode;
		$suanalytic->{_note}		= $suanalytic->{_note}.' mode='.$suanalytic->{_mode};
		$suanalytic->{_Step}		= $suanalytic->{_Step}.' mode='.$suanalytic->{_mode};

	} else { 
		print("suanalytic, mode, missing mode,\n");
	 }
 }


=head2 sub phaserot 


=cut

 sub phaserot {

	my ( $self,$phaserot )		= @_;
	if ( $phaserot ne $empty_string ) {

		$suanalytic->{_phaserot}		= $phaserot;
		$suanalytic->{_note}		= $suanalytic->{_note}.' phaserot='.$suanalytic->{_phaserot};
		$suanalytic->{_Step}		= $suanalytic->{_Step}.' phaserot='.$suanalytic->{_phaserot};

	} else { 
		print("suanalytic, phaserot, missing phaserot,\n");
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
