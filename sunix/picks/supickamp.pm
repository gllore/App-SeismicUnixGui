package supickamp;

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
 SUPICKAMP - pick amplitudes within user defined and resampled window	



   supickamp <stdin >stdout d2=  [optional parameters]			



 Required parameters:							

 d2=		   sampling interval for slow dimension			

			(required if key-parameter not specified)	

 Optional parameters:							

 key= 			Key header word specifying trace offset 	

 			(alternatively, specify d2,x2beg)		



 x_above=		array of lateral position values   		

 			(upper window corner)				

 t_above=		array of time values   				

 			(upper window corner)				



  ... or input via files:						

 t_xabove=		file containing time and lateral position values

 			(upper window corner)				

 t_xbelow=		file containing time and lateral position values

 			(lower window corner)				

 wl=		   	window width if t_xbelow is not specified	

			(No windowing if not specified)		 	



 dt_resamp=dt	  resampling interval within pick window	  	

			(dt has to come from trace headers)		

 tmin=0		minimum time in input trace			

 x2beg=0		first lateral position				

 format=ascii 		write ascii data to stdout			

			 =binary for binary floats to stdout		

 verbose=1 		writes complete  pick information into outpar   

			=2 writes complete pick information into outpar	

			   in tab-delimited column format		

 outpar=/dev/tty	output parameter file; contains output		

					from verbose			

 arg1=max		output (first dimension) to stdout		

 arg2=i2		output (second dimension) to stdout		

			(see notes for other options)			

 Notes: 								



 Window can be defined using						

 (1)   vectors x_above, t_above, [wl]					

 (2)   file  t_xabove, [wl]	or					

 (3)   files t_xabove, t_xbelow					



 files t_xabove, t_xbelow can be generated using xwigb's picking	

 algorithm. The lateral positions have to be monotonically increasing  

 or decreasing for both vector and file input.				

 verbose=1 or 2 writes min, max, abs[max], energy and associated times	

 tmin,tmax,tabs to outpar, together with global values. verbose=0	

 only outputs global values.						

 Acceptable arg-parameters for lateral positions are			

 (1) x2   (2) i2 = trace number					



 If key=keyword is set, then the values of x2 are taken from the header

 field represented by the keyword (for example key=offset)		

 Type	sukeyword -o   to see the complete list of SU keywords.		







 Credits:



	CWP: Andreas Rueger July 06, 1996

	MTU: David Forel,   Jan. 26, 2005  Add verbose=2 option



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

my $supickamp			= {
	_arg1					=> '',
	_arg2					=> '',
	_d2					=> '',
	_dt_resamp					=> '',
	_format					=> '',
	_i2					=> '',
	_key					=> '',
	_outpar					=> '',
	_t_above					=> '',
	_t_xabove					=> '',
	_t_xbelow					=> '',
	_tmin					=> '',
	_verbose					=> '',
	_wl					=> '',
	_x2beg					=> '',
	_x_above					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$supickamp->{_Step}     = 'supickamp'.$supickamp->{_Step};
	return ( $supickamp->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$supickamp->{_note}     = 'supickamp'.$supickamp->{_note};
	return ( $supickamp->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$supickamp->{_arg1}			= '';
		$supickamp->{_arg2}			= '';
		$supickamp->{_d2}			= '';
		$supickamp->{_dt_resamp}			= '';
		$supickamp->{_format}			= '';
		$supickamp->{_i2}			= '';
		$supickamp->{_key}			= '';
		$supickamp->{_outpar}			= '';
		$supickamp->{_t_above}			= '';
		$supickamp->{_t_xabove}			= '';
		$supickamp->{_t_xbelow}			= '';
		$supickamp->{_tmin}			= '';
		$supickamp->{_verbose}			= '';
		$supickamp->{_wl}			= '';
		$supickamp->{_x2beg}			= '';
		$supickamp->{_x_above}			= '';
		$supickamp->{_Step}			= '';
		$supickamp->{_note}			= '';
 }


=head2 sub arg1 


=cut

 sub arg1 {

	my ( $self,$arg1 )		= @_;
	if ( $arg1 ne $empty_string ) {

		$supickamp->{_arg1}		= $arg1;
		$supickamp->{_note}		= $supickamp->{_note}.' arg1='.$supickamp->{_arg1};
		$supickamp->{_Step}		= $supickamp->{_Step}.' arg1='.$supickamp->{_arg1};

	} else { 
		print("supickamp, arg1, missing arg1,\n");
	 }
 }


=head2 sub arg2 


=cut

 sub arg2 {

	my ( $self,$arg2 )		= @_;
	if ( $arg2 ne $empty_string ) {

		$supickamp->{_arg2}		= $arg2;
		$supickamp->{_note}		= $supickamp->{_note}.' arg2='.$supickamp->{_arg2};
		$supickamp->{_Step}		= $supickamp->{_Step}.' arg2='.$supickamp->{_arg2};

	} else { 
		print("supickamp, arg2, missing arg2,\n");
	 }
 }


=head2 sub d2 


=cut

 sub d2 {

	my ( $self,$d2 )		= @_;
	if ( $d2 ne $empty_string ) {

		$supickamp->{_d2}		= $d2;
		$supickamp->{_note}		= $supickamp->{_note}.' d2='.$supickamp->{_d2};
		$supickamp->{_Step}		= $supickamp->{_Step}.' d2='.$supickamp->{_d2};

	} else { 
		print("supickamp, d2, missing d2,\n");
	 }
 }


=head2 sub dt_resamp 


=cut

 sub dt_resamp {

	my ( $self,$dt_resamp )		= @_;
	if ( $dt_resamp ne $empty_string ) {

		$supickamp->{_dt_resamp}		= $dt_resamp;
		$supickamp->{_note}		= $supickamp->{_note}.' dt_resamp='.$supickamp->{_dt_resamp};
		$supickamp->{_Step}		= $supickamp->{_Step}.' dt_resamp='.$supickamp->{_dt_resamp};

	} else { 
		print("supickamp, dt_resamp, missing dt_resamp,\n");
	 }
 }


=head2 sub format 


=cut

 sub format {

	my ( $self,$format )		= @_;
	if ( $format ne $empty_string ) {

		$supickamp->{_format}		= $format;
		$supickamp->{_note}		= $supickamp->{_note}.' format='.$supickamp->{_format};
		$supickamp->{_Step}		= $supickamp->{_Step}.' format='.$supickamp->{_format};

	} else { 
		print("supickamp, format, missing format,\n");
	 }
 }


=head2 sub i2 


=cut

 sub i2 {

	my ( $self,$i2 )		= @_;
	if ( $i2 ne $empty_string ) {

		$supickamp->{_i2}		= $i2;
		$supickamp->{_note}		= $supickamp->{_note}.' i2='.$supickamp->{_i2};
		$supickamp->{_Step}		= $supickamp->{_Step}.' i2='.$supickamp->{_i2};

	} else { 
		print("supickamp, i2, missing i2,\n");
	 }
 }


=head2 sub key 


=cut

 sub key {

	my ( $self,$key )		= @_;
	if ( $key ne $empty_string ) {

		$supickamp->{_key}		= $key;
		$supickamp->{_note}		= $supickamp->{_note}.' key='.$supickamp->{_key};
		$supickamp->{_Step}		= $supickamp->{_Step}.' key='.$supickamp->{_key};

	} else { 
		print("supickamp, key, missing key,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$supickamp->{_outpar}		= $outpar;
		$supickamp->{_note}		= $supickamp->{_note}.' outpar='.$supickamp->{_outpar};
		$supickamp->{_Step}		= $supickamp->{_Step}.' outpar='.$supickamp->{_outpar};

	} else { 
		print("supickamp, outpar, missing outpar,\n");
	 }
 }


=head2 sub t_above 


=cut

 sub t_above {

	my ( $self,$t_above )		= @_;
	if ( $t_above ne $empty_string ) {

		$supickamp->{_t_above}		= $t_above;
		$supickamp->{_note}		= $supickamp->{_note}.' t_above='.$supickamp->{_t_above};
		$supickamp->{_Step}		= $supickamp->{_Step}.' t_above='.$supickamp->{_t_above};

	} else { 
		print("supickamp, t_above, missing t_above,\n");
	 }
 }


=head2 sub t_xabove 


=cut

 sub t_xabove {

	my ( $self,$t_xabove )		= @_;
	if ( $t_xabove ne $empty_string ) {

		$supickamp->{_t_xabove}		= $t_xabove;
		$supickamp->{_note}		= $supickamp->{_note}.' t_xabove='.$supickamp->{_t_xabove};
		$supickamp->{_Step}		= $supickamp->{_Step}.' t_xabove='.$supickamp->{_t_xabove};

	} else { 
		print("supickamp, t_xabove, missing t_xabove,\n");
	 }
 }


=head2 sub t_xbelow 


=cut

 sub t_xbelow {

	my ( $self,$t_xbelow )		= @_;
	if ( $t_xbelow ne $empty_string ) {

		$supickamp->{_t_xbelow}		= $t_xbelow;
		$supickamp->{_note}		= $supickamp->{_note}.' t_xbelow='.$supickamp->{_t_xbelow};
		$supickamp->{_Step}		= $supickamp->{_Step}.' t_xbelow='.$supickamp->{_t_xbelow};

	} else { 
		print("supickamp, t_xbelow, missing t_xbelow,\n");
	 }
 }


=head2 sub tmin 


=cut

 sub tmin {

	my ( $self,$tmin )		= @_;
	if ( $tmin ne $empty_string ) {

		$supickamp->{_tmin}		= $tmin;
		$supickamp->{_note}		= $supickamp->{_note}.' tmin='.$supickamp->{_tmin};
		$supickamp->{_Step}		= $supickamp->{_Step}.' tmin='.$supickamp->{_tmin};

	} else { 
		print("supickamp, tmin, missing tmin,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$supickamp->{_verbose}		= $verbose;
		$supickamp->{_note}		= $supickamp->{_note}.' verbose='.$supickamp->{_verbose};
		$supickamp->{_Step}		= $supickamp->{_Step}.' verbose='.$supickamp->{_verbose};

	} else { 
		print("supickamp, verbose, missing verbose,\n");
	 }
 }


=head2 sub wl 


=cut

 sub wl {

	my ( $self,$wl )		= @_;
	if ( $wl ne $empty_string ) {

		$supickamp->{_wl}		= $wl;
		$supickamp->{_note}		= $supickamp->{_note}.' wl='.$supickamp->{_wl};
		$supickamp->{_Step}		= $supickamp->{_Step}.' wl='.$supickamp->{_wl};

	} else { 
		print("supickamp, wl, missing wl,\n");
	 }
 }


=head2 sub x2beg 


=cut

 sub x2beg {

	my ( $self,$x2beg )		= @_;
	if ( $x2beg ne $empty_string ) {

		$supickamp->{_x2beg}		= $x2beg;
		$supickamp->{_note}		= $supickamp->{_note}.' x2beg='.$supickamp->{_x2beg};
		$supickamp->{_Step}		= $supickamp->{_Step}.' x2beg='.$supickamp->{_x2beg};

	} else { 
		print("supickamp, x2beg, missing x2beg,\n");
	 }
 }


=head2 sub x_above 


=cut

 sub x_above {

	my ( $self,$x_above )		= @_;
	if ( $x_above ne $empty_string ) {

		$supickamp->{_x_above}		= $x_above;
		$supickamp->{_note}		= $supickamp->{_note}.' x_above='.$supickamp->{_x_above};
		$supickamp->{_Step}		= $supickamp->{_Step}.' x_above='.$supickamp->{_x_above};

	} else { 
		print("supickamp, x_above, missing x_above,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 15;

    return($max_index);
}
 
 
1;
