package suocext;

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
 SUOCEXT - smaller Offset EXTrapolation via Offset Continuation        

           method for common-offset gathers                            



 suocext <stdin >stdout cdpmin= cdpmax= dxcdp= noffmix= offextr= [...]	



 Required Parameters:							

 cdpmin=	minimum cdp (integer number) for which to apply DMO	

 cdpmax=	maximum cdp (integer number) for which to apply DMO	

 dxcdp=	distance between adjacent cdp bins (m)			

 noffmix=	number of offsets to mix (see notes)			

 offextr=	offset to extrapolate					



 Optional Parameters:							

 tdmo=0.0	times corresponding to rms velocities in vdmo (s)	

 vdmo=1500.0	rms velocities corresponding to times in tdmo (m/s)	

 sdmo=1.0	DMO stretch factor; try 0.6 for typical v(z)		

 fmax=0.5/dt	maximum frequency in input traces (Hz)			

 verbose=0	=1 for diagnostic print					

 tmpdir=	if non-empty, use the value as a directory path	prefix	

		for storing temporary files; else if the CWP_TMPDIR	

		environment variable is set use	its value for the path;	

		else use tmpfile()					



 Notes:								

 Input traces should be sorted into common-offset gathers.  One common- 

 offset gather ends and another begins when the offset field of the trace

 headers changes. One common-offset gather usually is enough.		



 The cdp field of the input trace headers must be the cdp bin NUMBER, NOT

 the cdp location expressed in units of meters or feet.		



 The number of offsets to mix (noffmix) should typically equal the ratio of

 the shotpoint spacing to the cdp spacing.  This choice ensures that every

 cdp will be represented in each offset mix.  Traces in each mix will	

 contribute through DMO to other traces in adjacent cdps within that mix.



 The tdmo and vdmo arrays specify a velocity function of time that is	

 used to implement a first-order correction for depth-variable velocity.

 The times in tdmo must be monotonically increasing.			



 For each offset, the minimum time at which a non-zero sample exists is 

 used to determine a mute time.  Output samples for times earlier than this", 

 mute time will be zeroed.  Computation time may be significantly reduced

 if the input traces are zeroed (muted) for early times at large offsets.



 A term for better amplitude reconstruction was added to Hale's formulation.



 Credits: Carlos E. Theodoro (modification of Hale's SUDMOFK program)



 Technical Reference:

	C. Theodoro & K. Larner, 1998

      Extrapolation of seismic data to small offsets (CWP-276). 



	Dip-Moveout Processing - SEG Course Notes

	Dave Hale, 1988



	Bleistein, Cohen & Jaramillo, 1997

      True amplitude transformation to zero offset of data from 

      curved reflectors (CWP-262). 



 Trace header fields accessed:  ns, dt, delrt, offset, cdp.

 Trace header fields modified:  offset.



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

my $suocext			= {
	_cdpmax					=> '',
	_cdpmin					=> '',
	_dxcdp					=> '',
	_fmax					=> '',
	_noffmix					=> '',
	_offextr					=> '',
	_sdmo					=> '',
	_tdmo					=> '',
	_tmpdir					=> '',
	_vdmo					=> '',
	_verbose					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suocext->{_Step}     = 'suocext'.$suocext->{_Step};
	return ( $suocext->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suocext->{_note}     = 'suocext'.$suocext->{_note};
	return ( $suocext->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$suocext->{_cdpmax}			= '';
		$suocext->{_cdpmin}			= '';
		$suocext->{_dxcdp}			= '';
		$suocext->{_fmax}			= '';
		$suocext->{_noffmix}			= '';
		$suocext->{_offextr}			= '';
		$suocext->{_sdmo}			= '';
		$suocext->{_tdmo}			= '';
		$suocext->{_tmpdir}			= '';
		$suocext->{_vdmo}			= '';
		$suocext->{_verbose}			= '';
		$suocext->{_Step}			= '';
		$suocext->{_note}			= '';
 }


=head2 sub cdpmax 


=cut

 sub cdpmax {

	my ( $self,$cdpmax )		= @_;
	if ( $cdpmax ne $empty_string ) {

		$suocext->{_cdpmax}		= $cdpmax;
		$suocext->{_note}		= $suocext->{_note}.' cdpmax='.$suocext->{_cdpmax};
		$suocext->{_Step}		= $suocext->{_Step}.' cdpmax='.$suocext->{_cdpmax};

	} else { 
		print("suocext, cdpmax, missing cdpmax,\n");
	 }
 }


=head2 sub cdpmin 


=cut

 sub cdpmin {

	my ( $self,$cdpmin )		= @_;
	if ( $cdpmin ne $empty_string ) {

		$suocext->{_cdpmin}		= $cdpmin;
		$suocext->{_note}		= $suocext->{_note}.' cdpmin='.$suocext->{_cdpmin};
		$suocext->{_Step}		= $suocext->{_Step}.' cdpmin='.$suocext->{_cdpmin};

	} else { 
		print("suocext, cdpmin, missing cdpmin,\n");
	 }
 }


=head2 sub dxcdp 


=cut

 sub dxcdp {

	my ( $self,$dxcdp )		= @_;
	if ( $dxcdp ne $empty_string ) {

		$suocext->{_dxcdp}		= $dxcdp;
		$suocext->{_note}		= $suocext->{_note}.' dxcdp='.$suocext->{_dxcdp};
		$suocext->{_Step}		= $suocext->{_Step}.' dxcdp='.$suocext->{_dxcdp};

	} else { 
		print("suocext, dxcdp, missing dxcdp,\n");
	 }
 }


=head2 sub fmax 


=cut

 sub fmax {

	my ( $self,$fmax )		= @_;
	if ( $fmax ne $empty_string ) {

		$suocext->{_fmax}		= $fmax;
		$suocext->{_note}		= $suocext->{_note}.' fmax='.$suocext->{_fmax};
		$suocext->{_Step}		= $suocext->{_Step}.' fmax='.$suocext->{_fmax};

	} else { 
		print("suocext, fmax, missing fmax,\n");
	 }
 }


=head2 sub noffmix 


=cut

 sub noffmix {

	my ( $self,$noffmix )		= @_;
	if ( $noffmix ne $empty_string ) {

		$suocext->{_noffmix}		= $noffmix;
		$suocext->{_note}		= $suocext->{_note}.' noffmix='.$suocext->{_noffmix};
		$suocext->{_Step}		= $suocext->{_Step}.' noffmix='.$suocext->{_noffmix};

	} else { 
		print("suocext, noffmix, missing noffmix,\n");
	 }
 }


=head2 sub offextr 


=cut

 sub offextr {

	my ( $self,$offextr )		= @_;
	if ( $offextr ne $empty_string ) {

		$suocext->{_offextr}		= $offextr;
		$suocext->{_note}		= $suocext->{_note}.' offextr='.$suocext->{_offextr};
		$suocext->{_Step}		= $suocext->{_Step}.' offextr='.$suocext->{_offextr};

	} else { 
		print("suocext, offextr, missing offextr,\n");
	 }
 }


=head2 sub sdmo 


=cut

 sub sdmo {

	my ( $self,$sdmo )		= @_;
	if ( $sdmo ne $empty_string ) {

		$suocext->{_sdmo}		= $sdmo;
		$suocext->{_note}		= $suocext->{_note}.' sdmo='.$suocext->{_sdmo};
		$suocext->{_Step}		= $suocext->{_Step}.' sdmo='.$suocext->{_sdmo};

	} else { 
		print("suocext, sdmo, missing sdmo,\n");
	 }
 }


=head2 sub tdmo 


=cut

 sub tdmo {

	my ( $self,$tdmo )		= @_;
	if ( $tdmo ne $empty_string ) {

		$suocext->{_tdmo}		= $tdmo;
		$suocext->{_note}		= $suocext->{_note}.' tdmo='.$suocext->{_tdmo};
		$suocext->{_Step}		= $suocext->{_Step}.' tdmo='.$suocext->{_tdmo};

	} else { 
		print("suocext, tdmo, missing tdmo,\n");
	 }
 }


=head2 sub tmpdir 


=cut

 sub tmpdir {

	my ( $self,$tmpdir )		= @_;
	if ( $tmpdir ne $empty_string ) {

		$suocext->{_tmpdir}		= $tmpdir;
		$suocext->{_note}		= $suocext->{_note}.' tmpdir='.$suocext->{_tmpdir};
		$suocext->{_Step}		= $suocext->{_Step}.' tmpdir='.$suocext->{_tmpdir};

	} else { 
		print("suocext, tmpdir, missing tmpdir,\n");
	 }
 }


=head2 sub vdmo 


=cut

 sub vdmo {

	my ( $self,$vdmo )		= @_;
	if ( $vdmo ne $empty_string ) {

		$suocext->{_vdmo}		= $vdmo;
		$suocext->{_note}		= $suocext->{_note}.' vdmo='.$suocext->{_vdmo};
		$suocext->{_Step}		= $suocext->{_Step}.' vdmo='.$suocext->{_vdmo};

	} else { 
		print("suocext, vdmo, missing vdmo,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suocext->{_verbose}		= $verbose;
		$suocext->{_note}		= $suocext->{_note}.' verbose='.$suocext->{_verbose};
		$suocext->{_Step}		= $suocext->{_Step}.' verbose='.$suocext->{_verbose};

	} else { 
		print("suocext, verbose, missing verbose,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 10;

    return($max_index);
}
 
 
1;
