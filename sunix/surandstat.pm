 package surandstat;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SURANDSTAT - Add RANDom time shifts STATIC errors to seismic traces	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SURANDSTAT - Add RANDom time shifts STATIC errors to seismic traces	

     surandstat <stdin >stdout  [optional parameters]	 		

 Required parameters:							
	none								
 Optional Parameters:							
 	seed=from_clock    	random number seed (integer)            
	max=tr.dt 		maximum random time shift (ms)		
	scale=1.0		scale factor for shifts			


 Credits:
	U Houston: Chris Liner c. 2009


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $surandstat		= {
		_max					=> '',
		_scale					=> '',
		_seed					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$surandstat->{_Step}     = 'surandstat'.$surandstat->{_Step};
	return ( $surandstat->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$surandstat->{_note}     = 'surandstat'.$surandstat->{_note};
	return ( $surandstat->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$surandstat->{_max}			= '';
		$surandstat->{_scale}			= '';
		$surandstat->{_seed}			= '';
		$surandstat->{_Step}			= '';
		$surandstat->{_note}			= '';
 }


=head2 sub max 


=cut

 sub max {

	my ( $self,$max )		= @_;
	if ( $max ne $empty_string ) {

		$surandstat->{_max}		= $max;
		$surandstat->{_note}		= $surandstat->{_note}.' max='.$surandstat->{_max};
		$surandstat->{_Step}		= $surandstat->{_Step}.' max='.$surandstat->{_max};

	} else { 
		print("surandstat, max, missing max,\n");
	 }
 }


=head2 sub scale 


=cut

 sub scale {

	my ( $self,$scale )		= @_;
	if ( $scale ne $empty_string ) {

		$surandstat->{_scale}		= $scale;
		$surandstat->{_note}		= $surandstat->{_note}.' scale='.$surandstat->{_scale};
		$surandstat->{_Step}		= $surandstat->{_Step}.' scale='.$surandstat->{_scale};

	} else { 
		print("surandstat, scale, missing scale,\n");
	 }
 }


=head2 sub seed 


=cut

 sub seed {

	my ( $self,$seed )		= @_;
	if ( $seed ne $empty_string ) {

		$surandstat->{_seed}		= $seed;
		$surandstat->{_note}		= $surandstat->{_note}.' seed='.$surandstat->{_seed};
		$surandstat->{_Step}		= $surandstat->{_Step}.' seed='.$surandstat->{_seed};

	} else { 
		print("surandstat, seed, missing seed,\n");
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