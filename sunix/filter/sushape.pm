package sushape;

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
 SUSHAPE - Wiener shaping filter					



  sushape <stdin >stdout  [optional parameters]			



 Required parameters:							

 w=		vector of input wavelet to be shaped or ...		

 ...or ... 								

 wfile=        ... file containing input wavelet in SU (SEGY trace) format

 d=		vector of desired output wavelet or ...			

 ...or ... 								

 dfile=        ... file containing desired output wavelet in SU format	

 dt=tr.dt		if tr.dt is not set in header, then dt is mandatory



 Optional parameters:							

 nshape=trace		length of shaping filter			

 pnoise=0.001		relative additive noise level			

 showshaper=0		=1 to show shaping filter 			



 verbose=0		silent; =1 chatty				



Notes:									



 Example of commandline input wavelets: 				

sushape < indata  w=0,-.1,.1,... d=0,-.1,1,.1,... > shaped_data	



sushape < indata  wfile=inputwavelet.su dfile=desire.su > shaped_data	



 To get the shaping filters into an ascii file:			

 ... | sushape ... showwshaper=1 2>file | ...   (sh or ksh)		

 (... | sushape ... showshaper=1 | ...) >&file  (csh)			





 Credits:

	CWP: Jack Cohen

	CWP: John Stockwell, added wfile and dfile  options



 Trace header fields accessed: ns, dt

 Trace header fields modified: none





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

my $sushape			= {
	_d					=> '',
	_dfile					=> '',
	_dt					=> '',
	_nshape					=> '',
	_pnoise					=> '',
	_showshaper					=> '',
	_showwshaper					=> '',
	_verbose					=> '',
	_w					=> '',
	_wfile					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sushape->{_Step}     = 'sushape'.$sushape->{_Step};
	return ( $sushape->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sushape->{_note}     = 'sushape'.$sushape->{_note};
	return ( $sushape->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sushape->{_d}			= '';
		$sushape->{_dfile}			= '';
		$sushape->{_dt}			= '';
		$sushape->{_nshape}			= '';
		$sushape->{_pnoise}			= '';
		$sushape->{_showshaper}			= '';
		$sushape->{_showwshaper}			= '';
		$sushape->{_verbose}			= '';
		$sushape->{_w}			= '';
		$sushape->{_wfile}			= '';
		$sushape->{_Step}			= '';
		$sushape->{_note}			= '';
 }


=head2 sub d 


=cut

 sub d {

	my ( $self,$d )		= @_;
	if ( $d ne $empty_string ) {

		$sushape->{_d}		= $d;
		$sushape->{_note}		= $sushape->{_note}.' d='.$sushape->{_d};
		$sushape->{_Step}		= $sushape->{_Step}.' d='.$sushape->{_d};

	} else { 
		print("sushape, d, missing d,\n");
	 }
 }


=head2 sub dfile 


=cut

 sub dfile {

	my ( $self,$dfile )		= @_;
	if ( $dfile ne $empty_string ) {

		$sushape->{_dfile}		= $dfile;
		$sushape->{_note}		= $sushape->{_note}.' dfile='.$sushape->{_dfile};
		$sushape->{_Step}		= $sushape->{_Step}.' dfile='.$sushape->{_dfile};

	} else { 
		print("sushape, dfile, missing dfile,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$sushape->{_dt}		= $dt;
		$sushape->{_note}		= $sushape->{_note}.' dt='.$sushape->{_dt};
		$sushape->{_Step}		= $sushape->{_Step}.' dt='.$sushape->{_dt};

	} else { 
		print("sushape, dt, missing dt,\n");
	 }
 }


=head2 sub nshape 


=cut

 sub nshape {

	my ( $self,$nshape )		= @_;
	if ( $nshape ne $empty_string ) {

		$sushape->{_nshape}		= $nshape;
		$sushape->{_note}		= $sushape->{_note}.' nshape='.$sushape->{_nshape};
		$sushape->{_Step}		= $sushape->{_Step}.' nshape='.$sushape->{_nshape};

	} else { 
		print("sushape, nshape, missing nshape,\n");
	 }
 }


=head2 sub pnoise 


=cut

 sub pnoise {

	my ( $self,$pnoise )		= @_;
	if ( $pnoise ne $empty_string ) {

		$sushape->{_pnoise}		= $pnoise;
		$sushape->{_note}		= $sushape->{_note}.' pnoise='.$sushape->{_pnoise};
		$sushape->{_Step}		= $sushape->{_Step}.' pnoise='.$sushape->{_pnoise};

	} else { 
		print("sushape, pnoise, missing pnoise,\n");
	 }
 }


=head2 sub showshaper 


=cut

 sub showshaper {

	my ( $self,$showshaper )		= @_;
	if ( $showshaper ne $empty_string ) {

		$sushape->{_showshaper}		= $showshaper;
		$sushape->{_note}		= $sushape->{_note}.' showshaper='.$sushape->{_showshaper};
		$sushape->{_Step}		= $sushape->{_Step}.' showshaper='.$sushape->{_showshaper};

	} else { 
		print("sushape, showshaper, missing showshaper,\n");
	 }
 }


=head2 sub showwshaper 


=cut

 sub showwshaper {

	my ( $self,$showwshaper )		= @_;
	if ( $showwshaper ne $empty_string ) {

		$sushape->{_showwshaper}		= $showwshaper;
		$sushape->{_note}		= $sushape->{_note}.' showwshaper='.$sushape->{_showwshaper};
		$sushape->{_Step}		= $sushape->{_Step}.' showwshaper='.$sushape->{_showwshaper};

	} else { 
		print("sushape, showwshaper, missing showwshaper,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$sushape->{_verbose}		= $verbose;
		$sushape->{_note}		= $sushape->{_note}.' verbose='.$sushape->{_verbose};
		$sushape->{_Step}		= $sushape->{_Step}.' verbose='.$sushape->{_verbose};

	} else { 
		print("sushape, verbose, missing verbose,\n");
	 }
 }


=head2 sub w 


=cut

 sub w {

	my ( $self,$w )		= @_;
	if ( $w ne $empty_string ) {

		$sushape->{_w}		= $w;
		$sushape->{_note}		= $sushape->{_note}.' w='.$sushape->{_w};
		$sushape->{_Step}		= $sushape->{_Step}.' w='.$sushape->{_w};

	} else { 
		print("sushape, w, missing w,\n");
	 }
 }


=head2 sub wfile 


=cut

 sub wfile {

	my ( $self,$wfile )		= @_;
	if ( $wfile ne $empty_string ) {

		$sushape->{_wfile}		= $wfile;
		$sushape->{_note}		= $sushape->{_note}.' wfile='.$sushape->{_wfile};
		$sushape->{_Step}		= $sushape->{_Step}.' wfile='.$sushape->{_wfile};

	} else { 
		print("sushape, wfile, missing wfile,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 9;

    return($max_index);
}
 
 
1;
