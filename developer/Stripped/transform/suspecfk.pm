 package suspecfk;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUSPECFK - F-K Fourier SPECtrum of data set			
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUSPECFK - F-K Fourier SPECtrum of data set			

 suspecfk <infile >outfile [optional parameters]		

 Optional parameters:						

 dt=from header		time sampling interval		
 dx=from header(d2) or 1.0	spatial sampling interval	

 verbose=0	verbose = 1 echoes information			

 tmpdir= 	 if non-empty, use the value as a directory path
		 prefix for storing temporary files; else if the
	         the CWP_TMPDIR environment variable is set use	
	         its value for the path; else use tmpfile()	

 Note: To facilitate further processing, the sampling intervals
       in frequency and wavenumber as well as the first	
	frequency (0) and the first wavenumber are set in the	
	output header (as respectively d1, d2, f1, f2).		

 Note: The relation: w = 2 pi F is well known, but there	
	doesn't	seem to be a commonly used letter corresponding	
	to F for the spatial conjugate transform variable.  We	
	use K for this.  More specifically we assume a phase:	
		i(w t - k x) = 2 pi i(F t - K x).		
	and F, K define our notion of frequency, wavenumber.	


 Credits:

	CWP: Dave (algorithm), Jack (reformatting for SU)

 Trace header fields accessed: ns, dt, d2
 Trace header fields modified: tracl, ns, dt, trid, d1, f1, d2, f2

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suspecfk		= {
		_dt					=> '',
		_dx					=> '',
		_tmpdir					=> '',
		_verbose					=> '',
		_w					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suspecfk->{_Step}     = 'suspecfk'.$suspecfk->{_Step};
	return ( $suspecfk->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suspecfk->{_note}     = 'suspecfk'.$suspecfk->{_note};
	return ( $suspecfk->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suspecfk->{_dt}			= '';
		$suspecfk->{_dx}			= '';
		$suspecfk->{_tmpdir}			= '';
		$suspecfk->{_verbose}			= '';
		$suspecfk->{_w}			= '';
		$suspecfk->{_Step}			= '';
		$suspecfk->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$suspecfk->{_dt}		= $dt;
		$suspecfk->{_note}		= $suspecfk->{_note}.' dt='.$suspecfk->{_dt};
		$suspecfk->{_Step}		= $suspecfk->{_Step}.' dt='.$suspecfk->{_dt};

	} else { 
		print("suspecfk, dt, missing dt,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$suspecfk->{_dx}		= $dx;
		$suspecfk->{_note}		= $suspecfk->{_note}.' dx='.$suspecfk->{_dx};
		$suspecfk->{_Step}		= $suspecfk->{_Step}.' dx='.$suspecfk->{_dx};

	} else { 
		print("suspecfk, dx, missing dx,\n");
	 }
 }


=head2 sub tmpdir 


=cut

 sub tmpdir {

	my ( $self,$tmpdir )		= @_;
	if ( $tmpdir ne $empty_string ) {

		$suspecfk->{_tmpdir}		= $tmpdir;
		$suspecfk->{_note}		= $suspecfk->{_note}.' tmpdir='.$suspecfk->{_tmpdir};
		$suspecfk->{_Step}		= $suspecfk->{_Step}.' tmpdir='.$suspecfk->{_tmpdir};

	} else { 
		print("suspecfk, tmpdir, missing tmpdir,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suspecfk->{_verbose}		= $verbose;
		$suspecfk->{_note}		= $suspecfk->{_note}.' verbose='.$suspecfk->{_verbose};
		$suspecfk->{_Step}		= $suspecfk->{_Step}.' verbose='.$suspecfk->{_verbose};

	} else { 
		print("suspecfk, verbose, missing verbose,\n");
	 }
 }


=head2 sub w 


=cut

 sub w {

	my ( $self,$w )		= @_;
	if ( $w ne $empty_string ) {

		$suspecfk->{_w}		= $w;
		$suspecfk->{_note}		= $suspecfk->{_note}.' w='.$suspecfk->{_w};
		$suspecfk->{_Step}		= $suspecfk->{_Step}.' w='.$suspecfk->{_w};

	} else { 
		print("suspecfk, w, missing w,\n");
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