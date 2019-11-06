 package suilog;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUILOG -- time axis inverse log-stretch of seismic traces	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUILOG -- time axis inverse log-stretch of seismic traces	

 suilog nt= ntmin=  <stdin >stdout 				

 Required parameters:						
 	nt= 	nt output from sulog prog			
 	ntmin= 	ntmin output from sulog prog			
 	dt= 	dt output from sulog prog			
 Optional parameters:						
 	none							

 NOTE:  Parameters needed by suilog to reconstruct the 	
	original data may be input via a parameter file.	

 EXAMPLE PROCESSING SEQUENCE:					
 		sulog outpar=logpar <data1 >data2		
 		suilog par=logpar <data2 >data3			

 	where logpar is the parameter file			


 
 Credits:
	CWP: Shuki Ronen, Chris Liner

 Caveats:
 	amplitudes are not well preserved

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


	my $suilog		= {
		_dt					=> '',
		_nt					=> '',
		_ntmin					=> '',
		_outpar					=> '',
		_par					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suilog->{_Step}     = 'suilog'.$suilog->{_Step};
	return ( $suilog->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suilog->{_note}     = 'suilog'.$suilog->{_note};
	return ( $suilog->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suilog->{_dt}			= '';
		$suilog->{_nt}			= '';
		$suilog->{_ntmin}			= '';
		$suilog->{_outpar}			= '';
		$suilog->{_par}			= '';
		$suilog->{_Step}			= '';
		$suilog->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$suilog->{_dt}		= $dt;
		$suilog->{_note}		= $suilog->{_note}.' dt='.$suilog->{_dt};
		$suilog->{_Step}		= $suilog->{_Step}.' dt='.$suilog->{_dt};

	} else { 
		print("suilog, dt, missing dt,\n");
	 }
 }


=head2 sub nt 


=cut

 sub nt {

	my ( $self,$nt )		= @_;
	if ( $nt ne $empty_string ) {

		$suilog->{_nt}		= $nt;
		$suilog->{_note}		= $suilog->{_note}.' nt='.$suilog->{_nt};
		$suilog->{_Step}		= $suilog->{_Step}.' nt='.$suilog->{_nt};

	} else { 
		print("suilog, nt, missing nt,\n");
	 }
 }


=head2 sub ntmin 


=cut

 sub ntmin {

	my ( $self,$ntmin )		= @_;
	if ( $ntmin ne $empty_string ) {

		$suilog->{_ntmin}		= $ntmin;
		$suilog->{_note}		= $suilog->{_note}.' ntmin='.$suilog->{_ntmin};
		$suilog->{_Step}		= $suilog->{_Step}.' ntmin='.$suilog->{_ntmin};

	} else { 
		print("suilog, ntmin, missing ntmin,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$suilog->{_outpar}		= $outpar;
		$suilog->{_note}		= $suilog->{_note}.' outpar='.$suilog->{_outpar};
		$suilog->{_Step}		= $suilog->{_Step}.' outpar='.$suilog->{_outpar};

	} else { 
		print("suilog, outpar, missing outpar,\n");
	 }
 }


=head2 sub par 


=cut

 sub par {

	my ( $self,$par )		= @_;
	if ( $par ne $empty_string ) {

		$suilog->{_par}		= $par;
		$suilog->{_note}		= $suilog->{_note}.' par='.$suilog->{_par};
		$suilog->{_Step}		= $suilog->{_Step}.' par='.$suilog->{_par};

	} else { 
		print("suilog, par, missing par,\n");
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