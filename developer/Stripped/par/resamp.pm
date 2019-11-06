 package resamp;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  RESAMP - RESAMPle the 1st dimension of a 2-dimensional function f(x1,x2)
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 RESAMP - RESAMPle the 1st dimension of a 2-dimensional function f(x1,x2)

 resamp <infile >outfile [optional parameters]				

 Required Parameters:							

 Optional Parameters:							
 n1=all                 number of samples in 1st (fast) dimension	
 n2=all                 number of samples in 2nd (slow) dimension	
 d1=1.0                 sampling interval in 1st dimension		
 f1=d1                  first sample in 1st dimension			
 n1r=n1                 number of samples in 1st dimension after resampling
 d1r=d1                 sampling interval in 1st dimension after resampling
 f1r=f1                 first sample in 1st dimension after resampling	

 NOTE:  resamp currently performs NO ANTI-ALIAS FILTERING before resampling!
 Caveat: this program resamples data that are oscillatory in the fast	
    dimension only, such as seismic data with no SU headers. To resample
    other 2d data, such as velocity profiles, use "unisam" or "unisam2

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $resamp		= {
		_d1					=> '',
		_d1r					=> '',
		_f1					=> '',
		_f1r					=> '',
		_n1					=> '',
		_n1r					=> '',
		_n2					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$resamp->{_Step}     = 'resamp'.$resamp->{_Step};
	return ( $resamp->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$resamp->{_note}     = 'resamp'.$resamp->{_note};
	return ( $resamp->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$resamp->{_d1}			= '';
		$resamp->{_d1r}			= '';
		$resamp->{_f1}			= '';
		$resamp->{_f1r}			= '';
		$resamp->{_n1}			= '';
		$resamp->{_n1r}			= '';
		$resamp->{_n2}			= '';
		$resamp->{_Step}			= '';
		$resamp->{_note}			= '';
 }


=head2 sub d1 


=cut

 sub d1 {

	my ( $self,$d1 )		= @_;
	if ( $d1 ne $empty_string ) {

		$resamp->{_d1}		= $d1;
		$resamp->{_note}		= $resamp->{_note}.' d1='.$resamp->{_d1};
		$resamp->{_Step}		= $resamp->{_Step}.' d1='.$resamp->{_d1};

	} else { 
		print("resamp, d1, missing d1,\n");
	 }
 }


=head2 sub d1r 


=cut

 sub d1r {

	my ( $self,$d1r )		= @_;
	if ( $d1r ne $empty_string ) {

		$resamp->{_d1r}		= $d1r;
		$resamp->{_note}		= $resamp->{_note}.' d1r='.$resamp->{_d1r};
		$resamp->{_Step}		= $resamp->{_Step}.' d1r='.$resamp->{_d1r};

	} else { 
		print("resamp, d1r, missing d1r,\n");
	 }
 }


=head2 sub f1 


=cut

 sub f1 {

	my ( $self,$f1 )		= @_;
	if ( $f1 ne $empty_string ) {

		$resamp->{_f1}		= $f1;
		$resamp->{_note}		= $resamp->{_note}.' f1='.$resamp->{_f1};
		$resamp->{_Step}		= $resamp->{_Step}.' f1='.$resamp->{_f1};

	} else { 
		print("resamp, f1, missing f1,\n");
	 }
 }


=head2 sub f1r 


=cut

 sub f1r {

	my ( $self,$f1r )		= @_;
	if ( $f1r ne $empty_string ) {

		$resamp->{_f1r}		= $f1r;
		$resamp->{_note}		= $resamp->{_note}.' f1r='.$resamp->{_f1r};
		$resamp->{_Step}		= $resamp->{_Step}.' f1r='.$resamp->{_f1r};

	} else { 
		print("resamp, f1r, missing f1r,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$resamp->{_n1}		= $n1;
		$resamp->{_note}		= $resamp->{_note}.' n1='.$resamp->{_n1};
		$resamp->{_Step}		= $resamp->{_Step}.' n1='.$resamp->{_n1};

	} else { 
		print("resamp, n1, missing n1,\n");
	 }
 }


=head2 sub n1r 


=cut

 sub n1r {

	my ( $self,$n1r )		= @_;
	if ( $n1r ne $empty_string ) {

		$resamp->{_n1r}		= $n1r;
		$resamp->{_note}		= $resamp->{_note}.' n1r='.$resamp->{_n1r};
		$resamp->{_Step}		= $resamp->{_Step}.' n1r='.$resamp->{_n1r};

	} else { 
		print("resamp, n1r, missing n1r,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$resamp->{_n2}		= $n2;
		$resamp->{_note}		= $resamp->{_note}.' n2='.$resamp->{_n2};
		$resamp->{_Step}		= $resamp->{_Step}.' n2='.$resamp->{_n2};

	} else { 
		print("resamp, n2, missing n2,\n");
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