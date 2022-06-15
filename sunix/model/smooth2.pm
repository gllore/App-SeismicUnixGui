package smooth2;

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
 SMOOTH2 --- SMOOTH a uniformly sampled 2d array of data, within a user-

		defined window, via a damped least squares technique	



 smooth2 < stdin n1= n2= [optional parameters ] > stdout		



 Required Parameters:							

 n1=			number of samples in the 1st (fast) dimension	

 n2=			number of samples in the 2nd (slow) dimension	



 Optional Parameters:							

 r1=0			smoothing parameter in the 1 direction		

 r2=0			smoothing parameter in the 2 direction		

 win=0,n1,0,n2		array for window range				

 rw=0			smoothing parameter for window function		

 efile=                 =efilename if set write relative error(x1) to	

				efilename				



 Notes:								

 Larger r1 and r2 result in a smoother data. Recommended ranges of r1 	", 

 and r2 are from 1 to 20.						



 The file verror gives the relative error between the original velocity 

 and the smoothed one, as a function of depth. If the error is		

 between 0.01 and 0.1, the smoothing parameters are suitable. Otherwise,

 consider increasing or decreasing the smoothing parameter values.	



 Smoothing can be implemented in a selected window. The range of 1st   

 dimension for window is from win[0] to win[1]; the range of 2nd   	

 dimension is from win[2] to win[3]. 					



 Smoothing the window function (i.e. blurring the edges of the window)	

 may be done by setting a nonzero value for rw, otherwise the edges	

 of the window will be sharp.						







	Credits: 

		CWP: Zhen-yue Liu,

			adapted for par/main by John Stockwell 1 Oct 92

		Windowing feature added by Zliu on 16 Nov 1992



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

my $smooth2			= {
	_efile					=> '',
	_n1					=> '',
	_n2					=> '',
	_r1					=> '',
	_r2					=> '',
	_rw					=> '',
	_win					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$smooth2->{_Step}     = 'smooth2'.$smooth2->{_Step};
	return ( $smooth2->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$smooth2->{_note}     = 'smooth2'.$smooth2->{_note};
	return ( $smooth2->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$smooth2->{_efile}			= '';
		$smooth2->{_n1}			= '';
		$smooth2->{_n2}			= '';
		$smooth2->{_r1}			= '';
		$smooth2->{_r2}			= '';
		$smooth2->{_rw}			= '';
		$smooth2->{_win}			= '';
		$smooth2->{_Step}			= '';
		$smooth2->{_note}			= '';
 }


=head2 sub efile 


=cut

 sub efile {

	my ( $self,$efile )		= @_;
	if ( $efile ne $empty_string ) {

		$smooth2->{_efile}		= $efile;
		$smooth2->{_note}		= $smooth2->{_note}.' efile='.$smooth2->{_efile};
		$smooth2->{_Step}		= $smooth2->{_Step}.' efile='.$smooth2->{_efile};

	} else { 
		print("smooth2, efile, missing efile,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$smooth2->{_n1}		= $n1;
		$smooth2->{_note}		= $smooth2->{_note}.' n1='.$smooth2->{_n1};
		$smooth2->{_Step}		= $smooth2->{_Step}.' n1='.$smooth2->{_n1};

	} else { 
		print("smooth2, n1, missing n1,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$smooth2->{_n2}		= $n2;
		$smooth2->{_note}		= $smooth2->{_note}.' n2='.$smooth2->{_n2};
		$smooth2->{_Step}		= $smooth2->{_Step}.' n2='.$smooth2->{_n2};

	} else { 
		print("smooth2, n2, missing n2,\n");
	 }
 }


=head2 sub r1 


=cut

 sub r1 {

	my ( $self,$r1 )		= @_;
	if ( $r1 ne $empty_string ) {

		$smooth2->{_r1}		= $r1;
		$smooth2->{_note}		= $smooth2->{_note}.' r1='.$smooth2->{_r1};
		$smooth2->{_Step}		= $smooth2->{_Step}.' r1='.$smooth2->{_r1};

	} else { 
		print("smooth2, r1, missing r1,\n");
	 }
 }


=head2 sub r2 


=cut

 sub r2 {

	my ( $self,$r2 )		= @_;
	if ( $r2 ne $empty_string ) {

		$smooth2->{_r2}		= $r2;
		$smooth2->{_note}		= $smooth2->{_note}.' r2='.$smooth2->{_r2};
		$smooth2->{_Step}		= $smooth2->{_Step}.' r2='.$smooth2->{_r2};

	} else { 
		print("smooth2, r2, missing r2,\n");
	 }
 }


=head2 sub rw 


=cut

 sub rw {

	my ( $self,$rw )		= @_;
	if ( $rw ne $empty_string ) {

		$smooth2->{_rw}		= $rw;
		$smooth2->{_note}		= $smooth2->{_note}.' rw='.$smooth2->{_rw};
		$smooth2->{_Step}		= $smooth2->{_Step}.' rw='.$smooth2->{_rw};

	} else { 
		print("smooth2, rw, missing rw,\n");
	 }
 }


=head2 sub win 


=cut

 sub win {

	my ( $self,$win )		= @_;
	if ( $win ne $empty_string ) {

		$smooth2->{_win}		= $win;
		$smooth2->{_note}		= $smooth2->{_note}.' win='.$smooth2->{_win};
		$smooth2->{_Step}		= $smooth2->{_Step}.' win='.$smooth2->{_win};

	} else { 
		print("smooth2, win, missing win,\n");
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
