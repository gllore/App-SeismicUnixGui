 package sultt;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SULTT - trace by trace, sample by sample, rotation of shear wave data 
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SULTT - trace by trace, sample by sample, rotation of shear wave data 
	  volumes using the Linear Transform Technique of Li & Crampin  
	  (1993)							

 sultt inS11=file1 inS22=file2 inS12=file3 inS21=file4 [optional       
 parameters]                                                           

 optional parameters:							

 mode		determines what the linear transform will compute 	
			mode=1, computes asymmetry indexes		
 			mode=2, computes Polarization and main       	
				reflectivity series.			
			mode=3, same as above, but using eigenvalues    

 		mode=3 is more robust estimation for Polarization angle 
		than mode=2. In both cases the reflectivity series is   
		computed in the same way. mode=1 outputs two other data 
		volumes, each containing the asymmetry parameters theta,
		and gamma. The other two modes only output an extra da- 
		ta volume, the instant polarization alpha		

 outSij	defines the names of the output seismic data files,     
		i and j equal either 1 or 2				

 alpha, gamma	name for optional output volumes: instanteneous polarity
 theta		, alpha; theta, for angle misalignment between source   
		and receiver; gamma, the medium asymmetric response     
		coefficient						

 wl		running window acting on traces (in samples)		

 ntraces	number of traces to be average for each location	

 CAVEAT								

 Naming convention for off-diagonal volumes:				
 S12 - Inline source, Xline receiver					
 S21 - Xline source, Inline receiver					

 the running will always have an odd number of samples, despite the    
 input length.								


 Credits:
	CWP/RCP: Rodrigo Felicio Fuck
      Code based on algorithms presented in Li & Crampin (1993) and 
	Li & MacBeth (1997)


	Li, X.Y., and Crampin, S., 1993, Linear-transform techniques for 
		processing shear-wave anisotropy in four-component
		seismic data, Geophysics, 58, 240-256.
	Li, X.Y., and MacBeth, C., 1997, Data-Matrix asymmetry and polar-
		ization changes from multicomponent surface seismics 

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sultt		= {
		_inS11					=> '',
		_mode					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sultt->{_Step}     = 'sultt'.$sultt->{_Step};
	return ( $sultt->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sultt->{_note}     = 'sultt'.$sultt->{_note};
	return ( $sultt->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sultt->{_inS11}			= '';
		$sultt->{_mode}			= '';
		$sultt->{_Step}			= '';
		$sultt->{_note}			= '';
 }


=head2 sub inS11 


=cut

 sub inS11 {

	my ( $self,$inS11 )		= @_;
	if ( $inS11 ne $empty_string ) {

		$sultt->{_inS11}		= $inS11;
		$sultt->{_note}		= $sultt->{_note}.' inS11='.$sultt->{_inS11};
		$sultt->{_Step}		= $sultt->{_Step}.' inS11='.$sultt->{_inS11};

	} else { 
		print("sultt, inS11, missing inS11,\n");
	 }
 }


=head2 sub mode 


=cut

 sub mode {

	my ( $self,$mode )		= @_;
	if ( $mode ne $empty_string ) {

		$sultt->{_mode}		= $mode;
		$sultt->{_note}		= $sultt->{_note}.' mode='.$sultt->{_mode};
		$sultt->{_Step}		= $sultt->{_Step}.' mode='.$sultt->{_mode};

	} else { 
		print("sultt, mode, missing mode,\n");
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