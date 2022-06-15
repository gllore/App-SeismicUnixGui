package velpert;

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
 VELPERT - estimate velocity parameter perturbation from covariance 	

	 of imaged depths in common image gathers (CIGs)		



 verpert <dfile dzfile=dzfile >outfile [parameters]			



 Required Parameters:							

 dfile=			input of imaged depths in CIGs			

 dzfile=dzfile	input of dz/dv at the imaged depths in CIGs	

 outfile=		output of the estimated parameter 		

 noff=			number of offsets 				

 ncip=			number of common image gathers 			



 Optional Parameters:							

 moff=noff	number of first offsets used in velocity estimation  	



 Notes:								

 1. This program is part of Zhenyue Liu's velocity analysis technique.	

    The input dzdv values are computed using the program dzdv.		

 2. For given depths, using moff smaller than noff may avoid poor 	

    values of dz/dv at far offsets. However, a too small moff used	

    will the sensitivity of velocity error to the imaged depth.	

 3. Outfile contains three parts:					

    dlambda	correction of the velocity paramter. dlambda plus	

    		the initial parameter (used in migration) will	be	

		the updated one.					

    deviation	to measure how close imaged depths are to each other	

    		in CIGs. Old deviation corresponds to the initial	

		parameter; new deviation corresponds to the updated one.

    sensitivity  to predict how sensitive the error in the estimated	

		parameter is to an error in the measurement of imaged	

		depths.							



       error of parameter <= sensitivity * error of depth.		





 

 Author:  Zhenyue Liu, 12/29/93,  Colorado School of Mines



 Reference: 

 Liu, Z. 1995, "Migration Velocity Analysis", Ph.D. Thesis, Colorado

      School of Mines, CWP report #168.



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

my $velpert			= {
	_dfile					=> '',
	_dzfile					=> '',
	_moff					=> '',
	_ncip					=> '',
	_noff					=> '',
	_outfile					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$velpert->{_Step}     = 'velpert'.$velpert->{_Step};
	return ( $velpert->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$velpert->{_note}     = 'velpert'.$velpert->{_note};
	return ( $velpert->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$velpert->{_dfile}			= '';
		$velpert->{_dzfile}			= '';
		$velpert->{_moff}			= '';
		$velpert->{_ncip}			= '';
		$velpert->{_noff}			= '';
		$velpert->{_outfile}			= '';
		$velpert->{_Step}			= '';
		$velpert->{_note}			= '';
 }


=head2 sub dfile 


=cut

 sub dfile {

	my ( $self,$dfile )		= @_;
	if ( $dfile ne $empty_string ) {

		$velpert->{_dfile}		= $dfile;
		$velpert->{_note}		= $velpert->{_note}.' dfile='.$velpert->{_dfile};
		$velpert->{_Step}		= $velpert->{_Step}.' dfile='.$velpert->{_dfile};

	} else { 
		print("velpert, dfile, missing dfile,\n");
	 }
 }


=head2 sub dzfile 


=cut

 sub dzfile {

	my ( $self,$dzfile )		= @_;
	if ( $dzfile ne $empty_string ) {

		$velpert->{_dzfile}		= $dzfile;
		$velpert->{_note}		= $velpert->{_note}.' dzfile='.$velpert->{_dzfile};
		$velpert->{_Step}		= $velpert->{_Step}.' dzfile='.$velpert->{_dzfile};

	} else { 
		print("velpert, dzfile, missing dzfile,\n");
	 }
 }


=head2 sub moff 


=cut

 sub moff {

	my ( $self,$moff )		= @_;
	if ( $moff ne $empty_string ) {

		$velpert->{_moff}		= $moff;
		$velpert->{_note}		= $velpert->{_note}.' moff='.$velpert->{_moff};
		$velpert->{_Step}		= $velpert->{_Step}.' moff='.$velpert->{_moff};

	} else { 
		print("velpert, moff, missing moff,\n");
	 }
 }


=head2 sub ncip 


=cut

 sub ncip {

	my ( $self,$ncip )		= @_;
	if ( $ncip ne $empty_string ) {

		$velpert->{_ncip}		= $ncip;
		$velpert->{_note}		= $velpert->{_note}.' ncip='.$velpert->{_ncip};
		$velpert->{_Step}		= $velpert->{_Step}.' ncip='.$velpert->{_ncip};

	} else { 
		print("velpert, ncip, missing ncip,\n");
	 }
 }


=head2 sub noff 


=cut

 sub noff {

	my ( $self,$noff )		= @_;
	if ( $noff ne $empty_string ) {

		$velpert->{_noff}		= $noff;
		$velpert->{_note}		= $velpert->{_note}.' noff='.$velpert->{_noff};
		$velpert->{_Step}		= $velpert->{_Step}.' noff='.$velpert->{_noff};

	} else { 
		print("velpert, noff, missing noff,\n");
	 }
 }


=head2 sub outfile 


=cut

 sub outfile {

	my ( $self,$outfile )		= @_;
	if ( $outfile ne $empty_string ) {

		$velpert->{_outfile}		= $outfile;
		$velpert->{_note}		= $velpert->{_note}.' outfile='.$velpert->{_outfile};
		$velpert->{_Step}		= $velpert->{_Step}.' outfile='.$velpert->{_outfile};

	} else { 
		print("velpert, outfile, missing outfile,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 5;

    return($max_index);
}
 
 
1;
