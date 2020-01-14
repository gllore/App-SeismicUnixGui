 package transp3d;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  TRANSP3D - TRANSPose an n1 by n2 by n3 element matrix			
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 TRANSP3D - TRANSPose an n1 by n2 by n3 element matrix			

 transp3d <infile >outfile n1= n2= [optional parameters]		

 Required Parameters:							
 n1		number of elements in 1st (fast) dimension of matrix	
 n2		number of elements in 2nd (middle) dimension of matrix	

 Optional Parameters:							
 n3=all	number of elements in 3rd (slow) dimension of matrix	
 perm=231		desired output axis ordering		   	
 nbpe=sizeof(float)	number of bytes per matrix element		
 scratchdir=/tmp	directory for scratch files			
 scratchstem=foo	stem prefix for scratch file names		
 verbose=0		=1 for diagnostic information			

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $transp3d		= {
		_n1					=> '',
		_n3					=> '',
		_nbpe					=> '',
		_perm					=> '',
		_scratchdir					=> '',
		_scratchstem					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$transp3d->{_Step}     = 'transp3d'.$transp3d->{_Step};
	return ( $transp3d->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$transp3d->{_note}     = 'transp3d'.$transp3d->{_note};
	return ( $transp3d->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$transp3d->{_n1}			= '';
		$transp3d->{_n3}			= '';
		$transp3d->{_nbpe}			= '';
		$transp3d->{_perm}			= '';
		$transp3d->{_scratchdir}			= '';
		$transp3d->{_scratchstem}			= '';
		$transp3d->{_verbose}			= '';
		$transp3d->{_Step}			= '';
		$transp3d->{_note}			= '';
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$transp3d->{_n1}		= $n1;
		$transp3d->{_note}		= $transp3d->{_note}.' n1='.$transp3d->{_n1};
		$transp3d->{_Step}		= $transp3d->{_Step}.' n1='.$transp3d->{_n1};

	} else { 
		print("transp3d, n1, missing n1,\n");
	 }
 }


=head2 sub n3 


=cut

 sub n3 {

	my ( $self,$n3 )		= @_;
	if ( $n3 ne $empty_string ) {

		$transp3d->{_n3}		= $n3;
		$transp3d->{_note}		= $transp3d->{_note}.' n3='.$transp3d->{_n3};
		$transp3d->{_Step}		= $transp3d->{_Step}.' n3='.$transp3d->{_n3};

	} else { 
		print("transp3d, n3, missing n3,\n");
	 }
 }


=head2 sub nbpe 


=cut

 sub nbpe {

	my ( $self,$nbpe )		= @_;
	if ( $nbpe ne $empty_string ) {

		$transp3d->{_nbpe}		= $nbpe;
		$transp3d->{_note}		= $transp3d->{_note}.' nbpe='.$transp3d->{_nbpe};
		$transp3d->{_Step}		= $transp3d->{_Step}.' nbpe='.$transp3d->{_nbpe};

	} else { 
		print("transp3d, nbpe, missing nbpe,\n");
	 }
 }


=head2 sub perm 


=cut

 sub perm {

	my ( $self,$perm )		= @_;
	if ( $perm ne $empty_string ) {

		$transp3d->{_perm}		= $perm;
		$transp3d->{_note}		= $transp3d->{_note}.' perm='.$transp3d->{_perm};
		$transp3d->{_Step}		= $transp3d->{_Step}.' perm='.$transp3d->{_perm};

	} else { 
		print("transp3d, perm, missing perm,\n");
	 }
 }


=head2 sub scratchdir 


=cut

 sub scratchdir {

	my ( $self,$scratchdir )		= @_;
	if ( $scratchdir ne $empty_string ) {

		$transp3d->{_scratchdir}		= $scratchdir;
		$transp3d->{_note}		= $transp3d->{_note}.' scratchdir='.$transp3d->{_scratchdir};
		$transp3d->{_Step}		= $transp3d->{_Step}.' scratchdir='.$transp3d->{_scratchdir};

	} else { 
		print("transp3d, scratchdir, missing scratchdir,\n");
	 }
 }


=head2 sub scratchstem 


=cut

 sub scratchstem {

	my ( $self,$scratchstem )		= @_;
	if ( $scratchstem ne $empty_string ) {

		$transp3d->{_scratchstem}		= $scratchstem;
		$transp3d->{_note}		= $transp3d->{_note}.' scratchstem='.$transp3d->{_scratchstem};
		$transp3d->{_Step}		= $transp3d->{_Step}.' scratchstem='.$transp3d->{_scratchstem};

	} else { 
		print("transp3d, scratchstem, missing scratchstem,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$transp3d->{_verbose}		= $verbose;
		$transp3d->{_note}		= $transp3d->{_note}.' verbose='.$transp3d->{_verbose};
		$transp3d->{_Step}		= $transp3d->{_Step}.' verbose='.$transp3d->{_verbose};

	} else { 
		print("transp3d, verbose, missing verbose,\n");
	 }
 }


=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut
 
  sub get_max_index {
 	my ($self) = @_;
	# only file_name : index=36
 	my $max_index = 36;
	
 	return($max_index);
 }
 
 
1; 