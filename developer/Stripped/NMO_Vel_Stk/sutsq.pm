 package sutsq;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUTSQ -- time axis time-squared stretch of seismic traces	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUTSQ -- time axis time-squared stretch of seismic traces	

 sutsq [optional parameters] <stdin >stdout 			

 Required parameters:						
	none				 			

 Optional parameters:						
       tmin= .1*nt*dt  minimum time sample of interest		
                       (only needed for forward transform)	
       dt= .004       output sample rate			
                       (only needed for inverse transform)	
       flag= 1        1=forward transform: time to time squared
                     -1=inverse transform: time squared to time

 Note: The output of the forward transform always starts with	
 time squared equal to zero.  'tmin' is used to avoid aliasing	
 the early times.
	


 Caveats:
 	Amplitudes are not well preserved.

 Trace header fields accessed: ns, dt
 Trace header fields modified: ns, dt

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sutsq		= {
		_1					=> '',
		_dt					=> '',
		_flag					=> '',
		_tmin					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sutsq->{_Step}     = 'sutsq'.$sutsq->{_Step};
	return ( $sutsq->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sutsq->{_note}     = 'sutsq'.$sutsq->{_note};
	return ( $sutsq->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sutsq->{_1}			= '';
		$sutsq->{_dt}			= '';
		$sutsq->{_flag}			= '';
		$sutsq->{_tmin}			= '';
		$sutsq->{_Step}			= '';
		$sutsq->{_note}			= '';
 }


=head2 sub 1 


=cut

 sub 1 {

	my ( $self,$1 )		= @_;
	if ( $1 ne $empty_string ) {

		$sutsq->{_1}		= $1;
		$sutsq->{_note}		= $sutsq->{_note}.' 1='.$sutsq->{_1};
		$sutsq->{_Step}		= $sutsq->{_Step}.' 1='.$sutsq->{_1};

	} else { 
		print("sutsq, 1, missing 1,\n");
	 }
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$sutsq->{_dt}		= $dt;
		$sutsq->{_note}		= $sutsq->{_note}.' dt='.$sutsq->{_dt};
		$sutsq->{_Step}		= $sutsq->{_Step}.' dt='.$sutsq->{_dt};

	} else { 
		print("sutsq, dt, missing dt,\n");
	 }
 }


=head2 sub flag 


=cut

 sub flag {

	my ( $self,$flag )		= @_;
	if ( $flag ne $empty_string ) {

		$sutsq->{_flag}		= $flag;
		$sutsq->{_note}		= $sutsq->{_note}.' flag='.$sutsq->{_flag};
		$sutsq->{_Step}		= $sutsq->{_Step}.' flag='.$sutsq->{_flag};

	} else { 
		print("sutsq, flag, missing flag,\n");
	 }
 }


=head2 sub tmin 


=cut

 sub tmin {

	my ( $self,$tmin )		= @_;
	if ( $tmin ne $empty_string ) {

		$sutsq->{_tmin}		= $tmin;
		$sutsq->{_note}		= $sutsq->{_note}.' tmin='.$sutsq->{_tmin};
		$sutsq->{_Step}		= $sutsq->{_Step}.' tmin='.$sutsq->{_tmin};

	} else { 
		print("sutsq, tmin, missing tmin,\n");
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