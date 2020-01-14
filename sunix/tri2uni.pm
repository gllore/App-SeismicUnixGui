 package tri2uni;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  TRI2UNI - convert a TRIangulated model to UNIformly sampled model	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 TRI2UNI - convert a TRIangulated model to UNIformly sampled model	

 tri2uni <triangfile >uniformfile n2= n1= [optional parameters]	

 Required Parameters:							
 n1=                     number of samples in the first (fast) dimension
 n2=                     number of samples in the second dimension	

 Optional Parameters:							
 d1=1.0                 sampling interval in first (fast) dimension	
 d2=1.0                 sampling interval in second dimension		
 f1=0.0                 first value in dimension 1 sampled		
 f2=0.0                 first value in dimension 2 sampled		

 Note:									
 The triangulated/uniformly-sampled quantity is assumed to be sloth=1/v^2



 AUTHOR:  Dave Hale, Colorado School of Mines, 04/23/91


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $tri2uni		= {
		_d1					=> '',
		_d2					=> '',
		_f1					=> '',
		_f2					=> '',
		_n1					=> '',
		_n2					=> '',
		_sloth					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$tri2uni->{_Step}     = 'tri2uni'.$tri2uni->{_Step};
	return ( $tri2uni->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$tri2uni->{_note}     = 'tri2uni'.$tri2uni->{_note};
	return ( $tri2uni->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$tri2uni->{_d1}			= '';
		$tri2uni->{_d2}			= '';
		$tri2uni->{_f1}			= '';
		$tri2uni->{_f2}			= '';
		$tri2uni->{_n1}			= '';
		$tri2uni->{_n2}			= '';
		$tri2uni->{_sloth}			= '';
		$tri2uni->{_Step}			= '';
		$tri2uni->{_note}			= '';
 }


=head2 sub d1 


=cut

 sub d1 {

	my ( $self,$d1 )		= @_;
	if ( $d1 ne $empty_string ) {

		$tri2uni->{_d1}		= $d1;
		$tri2uni->{_note}		= $tri2uni->{_note}.' d1='.$tri2uni->{_d1};
		$tri2uni->{_Step}		= $tri2uni->{_Step}.' d1='.$tri2uni->{_d1};

	} else { 
		print("tri2uni, d1, missing d1,\n");
	 }
 }


=head2 sub d2 


=cut

 sub d2 {

	my ( $self,$d2 )		= @_;
	if ( $d2 ne $empty_string ) {

		$tri2uni->{_d2}		= $d2;
		$tri2uni->{_note}		= $tri2uni->{_note}.' d2='.$tri2uni->{_d2};
		$tri2uni->{_Step}		= $tri2uni->{_Step}.' d2='.$tri2uni->{_d2};

	} else { 
		print("tri2uni, d2, missing d2,\n");
	 }
 }


=head2 sub f1 


=cut

 sub f1 {

	my ( $self,$f1 )		= @_;
	if ( $f1 ne $empty_string ) {

		$tri2uni->{_f1}		= $f1;
		$tri2uni->{_note}		= $tri2uni->{_note}.' f1='.$tri2uni->{_f1};
		$tri2uni->{_Step}		= $tri2uni->{_Step}.' f1='.$tri2uni->{_f1};

	} else { 
		print("tri2uni, f1, missing f1,\n");
	 }
 }


=head2 sub f2 


=cut

 sub f2 {

	my ( $self,$f2 )		= @_;
	if ( $f2 ne $empty_string ) {

		$tri2uni->{_f2}		= $f2;
		$tri2uni->{_note}		= $tri2uni->{_note}.' f2='.$tri2uni->{_f2};
		$tri2uni->{_Step}		= $tri2uni->{_Step}.' f2='.$tri2uni->{_f2};

	} else { 
		print("tri2uni, f2, missing f2,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$tri2uni->{_n1}		= $n1;
		$tri2uni->{_note}		= $tri2uni->{_note}.' n1='.$tri2uni->{_n1};
		$tri2uni->{_Step}		= $tri2uni->{_Step}.' n1='.$tri2uni->{_n1};

	} else { 
		print("tri2uni, n1, missing n1,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$tri2uni->{_n2}		= $n2;
		$tri2uni->{_note}		= $tri2uni->{_note}.' n2='.$tri2uni->{_n2};
		$tri2uni->{_Step}		= $tri2uni->{_Step}.' n2='.$tri2uni->{_n2};

	} else { 
		print("tri2uni, n2, missing n2,\n");
	 }
 }


=head2 sub sloth 


=cut

 sub sloth {

	my ( $self,$sloth )		= @_;
	if ( $sloth ne $empty_string ) {

		$tri2uni->{_sloth}		= $sloth;
		$tri2uni->{_note}		= $tri2uni->{_note}.' sloth='.$tri2uni->{_sloth};
		$tri2uni->{_Step}		= $tri2uni->{_Step}.' sloth='.$tri2uni->{_sloth};

	} else { 
		print("tri2uni, sloth, missing sloth,\n");
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