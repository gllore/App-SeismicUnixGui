package surefcon;

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
 SUREFCON -  Convolution of user-supplied Forward and Reverse		

		refraction shots using XY trace offset in reverse shot	



	surefcon <forshot sufile=revshot  xy=trace offseted  >stdout	



 Required parameters:						 	

 sufile=	file containing SU trace to use as reverse shot		

 xy=		Number of traces offseted from the 1st trace in sufile	



 Optional parameters:						 	

 none								 	



 Trace header fields accessed: ns					

 Trace header fields modified: ns					



 Notes:								

 This code implements the Refraction Convolution Section (RCS)	method	

 of generalized reciprocal refraction traveltime analysis developed by 

 Derecke Palmer and Leoni Jones.					



 The time sampling interval on the output traces is half of that on the

 traces in the input files.		  	



 Example:								



	 surefcon <DATA sufile=DATA xy=1 | ...				



 Here, the su data file, "DATA", convolved the nth trace by		

 (n+xy)th trace in the same file					







 Credits: (based on suconv)

	CWP: Jack K. Cohen, Michel Dietrich

	UNSW: D. Palmer, K.T. LEE

  CAVEATS: no space-variable or time-variable capacity.

	The more than one trace allowed in sufile is the

	beginning of a hook to handle the spatially variant case.



 Trace header fields accessed: ns

 Trace header fields modified: ns

 Notes:

 This code implements the refraction convolution 

 section (RCS) method

 method described in:



 Palmer, D, 2001a, Imaging refractors with the convolution section,

           Geophysics 66, 1582-1589.

 Palmer, D, 2001b, Resolving refractor ambiguities with amplitudes,

           Geophysics 66, 1590-1593.



 Exploration Geophysics (2005) 36, 18­25

 Butsuri-Tansa (Vol. 58, No.1)

 Mulli-Tamsa (Vol. 8,

    A simple approach to refraction statics with the 

 Generalized Main Reciprocal Method and the Refraction 

 Convolution Section Heading

        by Derecke Palmer  Leonie Jones





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

my $surefcon			= {
	_sufile					=> '',
	_xy					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$surefcon->{_Step}     = 'surefcon'.$surefcon->{_Step};
	return ( $surefcon->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$surefcon->{_note}     = 'surefcon'.$surefcon->{_note};
	return ( $surefcon->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$surefcon->{_sufile}			= '';
		$surefcon->{_xy}			= '';
		$surefcon->{_Step}			= '';
		$surefcon->{_note}			= '';
 }


=head2 sub sufile 


=cut

 sub sufile {

	my ( $self,$sufile )		= @_;
	if ( $sufile ne $empty_string ) {

		$surefcon->{_sufile}		= $sufile;
		$surefcon->{_note}		= $surefcon->{_note}.' sufile='.$surefcon->{_sufile};
		$surefcon->{_Step}		= $surefcon->{_Step}.' sufile='.$surefcon->{_sufile};

	} else { 
		print("surefcon, sufile, missing sufile,\n");
	 }
 }


=head2 sub xy 


=cut

 sub xy {

	my ( $self,$xy )		= @_;
	if ( $xy ne $empty_string ) {

		$surefcon->{_xy}		= $xy;
		$surefcon->{_note}		= $surefcon->{_note}.' xy='.$surefcon->{_xy};
		$surefcon->{_Step}		= $surefcon->{_Step}.' xy='.$surefcon->{_xy};

	} else { 
		print("surefcon, xy, missing xy,\n");
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
