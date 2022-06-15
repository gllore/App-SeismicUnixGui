package sudipdivcor;

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
 SUDIPDIVCOR - Dip-dependent Divergence (spreading) correction	



	sudipdivcor <stdin >stdout  [optional parms]		



 Required Parameters:						

	dxcdp	distance between sucessive cdps	in meters	



 Optional Parameters:						

	np=50		number of slopes			

	tmig=0.0	times corresponding to rms velocities in vmig

	vmig=1500.0	rms velocities corresponding to times in tmig

	vfile=binary	(non-ascii) file containing velocities vmig(t) 

	conv=0		=1 to apply the conventional divergence correction

	trans=0		=1 to include transmission factors 	

	verbose=0	=1 for diagnostic print			



 Notes:								

 The tmig, vmig arrays specify an rms velocity function of time.

 Linear interpolation and constant extrapolation is used to determine

 rms velocities at times not specified.  Values specified in tmig

 must increase monotonically.					



 Alternatively, rms velocities may be stored in a binary file

 containing one velocity for every time sample.  If vfile is	

 specified, then the tmig and vmig arrays are ignored.		

 The time of the first sample is assumed to be constant, and is

 taken as the value of the first trace header field delrt. 	



 Whereas the conventional divergence correction (sudivcor) is	

 valid only for horizontal reflectors, which have zero reflection

 slope, the dip-dependent divergence correction is valid for any

 reflector dip or reflection slope.  Only the conventional	

 correction will be applied to the data if conv=1 is specified. 

 Note that the conventional correction over-amplifies		

 reflections from dipping beds					



 The transmission factor should be applied when the divergence 

 corrected data is to be migrated with a reverse time migration 

 based on the constant density wave equation.			



 Trace header fields accessed:  ns, dt, delrt			



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

my $sudipdivcor			= {
	_conv					=> '',
	_np					=> '',
	_tmig					=> '',
	_trans					=> '',
	_verbose					=> '',
	_vfile					=> '',
	_vmig					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sudipdivcor->{_Step}     = 'sudipdivcor'.$sudipdivcor->{_Step};
	return ( $sudipdivcor->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sudipdivcor->{_note}     = 'sudipdivcor'.$sudipdivcor->{_note};
	return ( $sudipdivcor->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sudipdivcor->{_conv}			= '';
		$sudipdivcor->{_np}			= '';
		$sudipdivcor->{_tmig}			= '';
		$sudipdivcor->{_trans}			= '';
		$sudipdivcor->{_verbose}			= '';
		$sudipdivcor->{_vfile}			= '';
		$sudipdivcor->{_vmig}			= '';
		$sudipdivcor->{_Step}			= '';
		$sudipdivcor->{_note}			= '';
 }


=head2 sub conv 


=cut

 sub conv {

	my ( $self,$conv )		= @_;
	if ( $conv ne $empty_string ) {

		$sudipdivcor->{_conv}		= $conv;
		$sudipdivcor->{_note}		= $sudipdivcor->{_note}.' conv='.$sudipdivcor->{_conv};
		$sudipdivcor->{_Step}		= $sudipdivcor->{_Step}.' conv='.$sudipdivcor->{_conv};

	} else { 
		print("sudipdivcor, conv, missing conv,\n");
	 }
 }


=head2 sub np 


=cut

 sub np {

	my ( $self,$np )		= @_;
	if ( $np ne $empty_string ) {

		$sudipdivcor->{_np}		= $np;
		$sudipdivcor->{_note}		= $sudipdivcor->{_note}.' np='.$sudipdivcor->{_np};
		$sudipdivcor->{_Step}		= $sudipdivcor->{_Step}.' np='.$sudipdivcor->{_np};

	} else { 
		print("sudipdivcor, np, missing np,\n");
	 }
 }


=head2 sub tmig 


=cut

 sub tmig {

	my ( $self,$tmig )		= @_;
	if ( $tmig ne $empty_string ) {

		$sudipdivcor->{_tmig}		= $tmig;
		$sudipdivcor->{_note}		= $sudipdivcor->{_note}.' tmig='.$sudipdivcor->{_tmig};
		$sudipdivcor->{_Step}		= $sudipdivcor->{_Step}.' tmig='.$sudipdivcor->{_tmig};

	} else { 
		print("sudipdivcor, tmig, missing tmig,\n");
	 }
 }


=head2 sub trans 


=cut

 sub trans {

	my ( $self,$trans )		= @_;
	if ( $trans ne $empty_string ) {

		$sudipdivcor->{_trans}		= $trans;
		$sudipdivcor->{_note}		= $sudipdivcor->{_note}.' trans='.$sudipdivcor->{_trans};
		$sudipdivcor->{_Step}		= $sudipdivcor->{_Step}.' trans='.$sudipdivcor->{_trans};

	} else { 
		print("sudipdivcor, trans, missing trans,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$sudipdivcor->{_verbose}		= $verbose;
		$sudipdivcor->{_note}		= $sudipdivcor->{_note}.' verbose='.$sudipdivcor->{_verbose};
		$sudipdivcor->{_Step}		= $sudipdivcor->{_Step}.' verbose='.$sudipdivcor->{_verbose};

	} else { 
		print("sudipdivcor, verbose, missing verbose,\n");
	 }
 }


=head2 sub vfile 


=cut

 sub vfile {

	my ( $self,$vfile )		= @_;
	if ( $vfile ne $empty_string ) {

		$sudipdivcor->{_vfile}		= $vfile;
		$sudipdivcor->{_note}		= $sudipdivcor->{_note}.' vfile='.$sudipdivcor->{_vfile};
		$sudipdivcor->{_Step}		= $sudipdivcor->{_Step}.' vfile='.$sudipdivcor->{_vfile};

	} else { 
		print("sudipdivcor, vfile, missing vfile,\n");
	 }
 }


=head2 sub vmig 


=cut

 sub vmig {

	my ( $self,$vmig )		= @_;
	if ( $vmig ne $empty_string ) {

		$sudipdivcor->{_vmig}		= $vmig;
		$sudipdivcor->{_note}		= $sudipdivcor->{_note}.' vmig='.$sudipdivcor->{_vmig};
		$sudipdivcor->{_Step}		= $sudipdivcor->{_Step}.' vmig='.$sudipdivcor->{_vmig};

	} else { 
		print("sudipdivcor, vmig, missing vmig,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 6;

    return($max_index);
}
 
 
1;
