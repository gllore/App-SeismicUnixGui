package suvcat;

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
 SUVCAT -  append one data set to another, with or without an 

           overlapping	region.  Data in the overlap may be     

           determined by one of several methods.               



 suvcat data1 data2 >stdout	

 

 file1=data1				

 file2=data2



 Required parameters:						

        none							



 Optional parameters for overlapping sections:			



  taplen=0    Length of overlap in integer number of           

                  samples.(Default is 0.)                      



  taptype=0    Type of taper or combination method in the	

                  overlap region.  0 - average                 

                                   1 - maximum magnitude       

                                   2 - cosine scaled           

                                   3 - summation               



 Computational Notes:						

 

 This program vertically concatenates traces from data2 onto   

 the end of the corresponding traces in data1, with a region   

 of overlap, defined by taplen.  Data in the overlapping       ", 

 region is combined by the method specified by taptype. The    

 currently available methods are:                              



     taptype=0    output is assigned the unweighted average of 

                  each point in the overlap                    

     taptype=1    output is assigned the value of the maximum  

                  absolute value of each point in the overlap  

     taptype=2    output is assigned the weighted average of   

                  each point in the overlap, where the output  

                  is the sum of cos(x) times the values on the 

                  first section, and 1-cos(x) times the values 

                  on the second section, where x is factor that

                  goes from 0 to pi/2 across the overlap. This 

                  favors the upper section in the upper part of

                  the overlap, and favors the lower section in 

                  the lower part of the overlap.               

     taptype=3    output is assigned the sum of the amplitudes 

                  at each sample in the overlap                





 Credits:

	CWP: Jack K. Cohen, Michel Dietrich (Original SUVCAT)

	     Steven D. Sheaffer (modifed to include overlap) 

 IfG Kiel: Thies Beilecke (added taptype=3)



 Trace header fields accessed:  ns

 Trace header fields modified:  ns



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

my $suvcat			= {
	_file1					=> '',
	_file2					=> '',
	_taplen					=> '',
	_taptype					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suvcat->{_Step}     = 'suvcat'.$suvcat->{_Step};
	return ( $suvcat->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suvcat->{_note}     = 'suvcat'.$suvcat->{_note};
	return ( $suvcat->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$suvcat->{_file1}			= '';
		$suvcat->{_file2}			= '';
		$suvcat->{_taplen}			= '';
		$suvcat->{_taptype}			= '';
		$suvcat->{_Step}			= '';
		$suvcat->{_note}			= '';
 }


=head2 sub file1 


=cut

 sub file1 {

	my ( $self,$file1 )		= @_;
	if ( $file1 ne $empty_string ) {

		$suvcat->{_file1}		= $file1;
		$suvcat->{_note}		= $suvcat->{_note}.' file1='.$suvcat->{_file1};
		$suvcat->{_Step}		= $suvcat->{_Step}.' file1='.$suvcat->{_file1};

	} else { 
		print("suvcat, file1, missing file1,\n");
	 }
 }


=head2 sub file2 


=cut

 sub file2 {

	my ( $self,$file2 )		= @_;
	if ( $file2 ne $empty_string ) {

		$suvcat->{_file2}		= $file2;
		$suvcat->{_note}		= $suvcat->{_note}.' file2='.$suvcat->{_file2};
		$suvcat->{_Step}		= $suvcat->{_Step}.' file2='.$suvcat->{_file2};

	} else { 
		print("suvcat, file2, missing file2,\n");
	 }
 }


=head2 sub taplen 


=cut

 sub taplen {

	my ( $self,$taplen )		= @_;
	if ( $taplen ne $empty_string ) {

		$suvcat->{_taplen}		= $taplen;
		$suvcat->{_note}		= $suvcat->{_note}.' taplen='.$suvcat->{_taplen};
		$suvcat->{_Step}		= $suvcat->{_Step}.' taplen='.$suvcat->{_taplen};

	} else { 
		print("suvcat, taplen, missing taplen,\n");
	 }
 }


=head2 sub taptype 


=cut

 sub taptype {

	my ( $self,$taptype )		= @_;
	if ( $taptype ne $empty_string ) {

		$suvcat->{_taptype}		= $taptype;
		$suvcat->{_note}		= $suvcat->{_note}.' taptype='.$suvcat->{_taptype};
		$suvcat->{_Step}		= $suvcat->{_Step}.' taptype='.$suvcat->{_taptype};

	} else { 
		print("suvcat, taptype, missing taptype,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 3;

    return($max_index);
}
 
 
1;
