 package prplot;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  PRPLOT - PRinter PLOT of 1-D arrays f(x1) from a 2-D function f(x1,x2)
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 PRPLOT - PRinter PLOT of 1-D arrays f(x1) from a 2-D function f(x1,x2)

 prplot <infile >outfile [optional parameters]				

 Optional Parameters:							
 n1=all                 number of samples in 1st dimension		
 d1=1.0                 sampling interval in 1st dimension		
 f1=d1                  first sample in 1st dimension			
 n2=all                 number of samples in 2nd dimension		
 d2=1.0                 sampling interval in 2nd dimension		
 f2=d2                  first sample in 2nd dimension			
 label2=Trace           label for 2nd dimension			

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $prplot		= {
		_d1					=> '',
		_d2					=> '',
		_f1					=> '',
		_f2					=> '',
		_label2					=> '',
		_n1					=> '',
		_n2					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$prplot->{_Step}     = 'prplot'.$prplot->{_Step};
	return ( $prplot->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$prplot->{_note}     = 'prplot'.$prplot->{_note};
	return ( $prplot->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$prplot->{_d1}			= '';
		$prplot->{_d2}			= '';
		$prplot->{_f1}			= '';
		$prplot->{_f2}			= '';
		$prplot->{_label2}			= '';
		$prplot->{_n1}			= '';
		$prplot->{_n2}			= '';
		$prplot->{_Step}			= '';
		$prplot->{_note}			= '';
 }


=head2 sub d1 


=cut

 sub d1 {

	my ( $self,$d1 )		= @_;
	if ( $d1 ne $empty_string ) {

		$prplot->{_d1}		= $d1;
		$prplot->{_note}		= $prplot->{_note}.' d1='.$prplot->{_d1};
		$prplot->{_Step}		= $prplot->{_Step}.' d1='.$prplot->{_d1};

	} else { 
		print("prplot, d1, missing d1,\n");
	 }
 }


=head2 sub d2 


=cut

 sub d2 {

	my ( $self,$d2 )		= @_;
	if ( $d2 ne $empty_string ) {

		$prplot->{_d2}		= $d2;
		$prplot->{_note}		= $prplot->{_note}.' d2='.$prplot->{_d2};
		$prplot->{_Step}		= $prplot->{_Step}.' d2='.$prplot->{_d2};

	} else { 
		print("prplot, d2, missing d2,\n");
	 }
 }


=head2 sub f1 


=cut

 sub f1 {

	my ( $self,$f1 )		= @_;
	if ( $f1 ne $empty_string ) {

		$prplot->{_f1}		= $f1;
		$prplot->{_note}		= $prplot->{_note}.' f1='.$prplot->{_f1};
		$prplot->{_Step}		= $prplot->{_Step}.' f1='.$prplot->{_f1};

	} else { 
		print("prplot, f1, missing f1,\n");
	 }
 }


=head2 sub f2 


=cut

 sub f2 {

	my ( $self,$f2 )		= @_;
	if ( $f2 ne $empty_string ) {

		$prplot->{_f2}		= $f2;
		$prplot->{_note}		= $prplot->{_note}.' f2='.$prplot->{_f2};
		$prplot->{_Step}		= $prplot->{_Step}.' f2='.$prplot->{_f2};

	} else { 
		print("prplot, f2, missing f2,\n");
	 }
 }


=head2 sub label2 


=cut

 sub label2 {

	my ( $self,$label2 )		= @_;
	if ( $label2 ne $empty_string ) {

		$prplot->{_label2}		= $label2;
		$prplot->{_note}		= $prplot->{_note}.' label2='.$prplot->{_label2};
		$prplot->{_Step}		= $prplot->{_Step}.' label2='.$prplot->{_label2};

	} else { 
		print("prplot, label2, missing label2,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$prplot->{_n1}		= $n1;
		$prplot->{_note}		= $prplot->{_note}.' n1='.$prplot->{_n1};
		$prplot->{_Step}		= $prplot->{_Step}.' n1='.$prplot->{_n1};

	} else { 
		print("prplot, n1, missing n1,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$prplot->{_n2}		= $n2;
		$prplot->{_note}		= $prplot->{_note}.' n2='.$prplot->{_n2};
		$prplot->{_Step}		= $prplot->{_Step}.' n2='.$prplot->{_n2};

	} else { 
		print("prplot, n2, missing n2,\n");
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