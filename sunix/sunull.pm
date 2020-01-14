 package sunull;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUNULL - create null (all zeroes) traces	 		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUNULL - create null (all zeroes) traces	 		

 sunull nt=   [optional parameters] >outdata			

 Required parameter						
 	nt=		number of samples per trace		

 Optional parameters						
 	ntr=5		number of null traces to create		
 	dt=0.004	time sampling interval			

 Rationale: It is sometimes useful to insert null traces	
	 between "panels" in a shell loop.			

 See also: sukill, sumute, suzero				


 Credits:
	CWP: Jack K. Cohen

 Trace header fields set: ns, dt, tracl

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sunull		= {
		_dt					=> '',
		_nt					=> '',
		_ntr					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sunull->{_Step}     = 'sunull'.$sunull->{_Step};
	return ( $sunull->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sunull->{_note}     = 'sunull'.$sunull->{_note};
	return ( $sunull->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sunull->{_dt}			= '';
		$sunull->{_nt}			= '';
		$sunull->{_ntr}			= '';
		$sunull->{_Step}			= '';
		$sunull->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$sunull->{_dt}		= $dt;
		$sunull->{_note}		= $sunull->{_note}.' dt='.$sunull->{_dt};
		$sunull->{_Step}		= $sunull->{_Step}.' dt='.$sunull->{_dt};

	} else { 
		print("sunull, dt, missing dt,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$sunull->{_nt}		= $nt;
		$sunull->{_note}		= $sunull->{_note}.' nt='.$sunull->{_nt};
		$sunull->{_Step}		= $sunull->{_Step}.' nt='.$sunull->{_nt};

	} else { 
		print("sunull, nt, missing nt,\n");
	 }
 }


=head2 sub ntr 


=cut

 sub ntr {

	my ( $self,$ntr )		= @_;
	if ( $ntr ne $empty_string ) {

		$sunull->{_ntr}		= $ntr;
		$sunull->{_note}		= $sunull->{_note}.' ntr='.$sunull->{_ntr};
		$sunull->{_Step}		= $sunull->{_Step}.' ntr='.$sunull->{_ntr};

	} else { 
		print("sunull, ntr, missing ntr,\n");
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