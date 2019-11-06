 package suspeck1k2;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUSPECK1K2 - 2D (K1,K2) Fourier SPECtrum of (x1,x2) data set		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUSPECK1K2 - 2D (K1,K2) Fourier SPECtrum of (x1,x2) data set		

 suspeck1k2 <infile >outfile [optional parameters]			

 Optional parameters:							

 d1=from header(d1) or 1.0	spatial sampling interval in first (fast)
				   dimension				
 d2=from header(d2) or 1.0	spatial sampling interval in second	
				 (slow)  dimension			

 verbose=0		verbose = 1 echoes information			

 tmpdir= 	 	if non-empty, use the value as a directory path
		 	prefix for storing temporary files; else if the
	         	the CWP_TMPDIR environment variable is set use	
	         	its value for the path; else use tmpfile()	

 Notes:								
 Because the data are assumed to be purely spatial (i.e. non-seismic), 
 the data are assumed to have trace id (30), corresponding to (z,x) data

 To facilitate further processing, the sampling intervals in wavenumber
 as well as the first frequency (0) and the first wavenumber are set in
 the output header (as respectively d1, d2, f1, f2).			

 The relation: w = 2 pi F is well known for frequency, but there	
 doesn't seem to be a commonly used letter corresponding to F for the	
 spatial conjugate transform variables.  We use K1 and K2 for this.	
 More specifically we assume a phase:					
		-i(k1 x1 + k2 x2) = -2 pi i(K1 x1 + K2 x2).		
 and K1, K2 define our respective wavenumbers.				


 Credits:
     CWP: John Stockwell, 26 April 1995, based on original code by
          Dave Hale and Jack Cohen	

 Trace header fields accessed: ns, d1, d2, trid
 Trace header fields modified: tracl, ns, dt, trid, d1, f1, d2, f2

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suspeck1k2		= {
		_d1					=> '',
		_d2					=> '',
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

	$suspeck1k2->{_Step}     = 'suspeck1k2'.$suspeck1k2->{_Step};
	return ( $suspeck1k2->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suspeck1k2->{_note}     = 'suspeck1k2'.$suspeck1k2->{_note};
	return ( $suspeck1k2->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suspeck1k2->{_d1}			= '';
		$suspeck1k2->{_d2}			= '';
		$suspeck1k2->{_tmpdir}			= '';
		$suspeck1k2->{_verbose}			= '';
		$suspeck1k2->{_w}			= '';
		$suspeck1k2->{_Step}			= '';
		$suspeck1k2->{_note}			= '';
 }


=head2 sub d1 


=cut

 sub d1 {

	my ( $self,$d1 )		= @_;
	if ( $d1 ne $empty_string ) {

		$suspeck1k2->{_d1}		= $d1;
		$suspeck1k2->{_note}		= $suspeck1k2->{_note}.' d1='.$suspeck1k2->{_d1};
		$suspeck1k2->{_Step}		= $suspeck1k2->{_Step}.' d1='.$suspeck1k2->{_d1};

	} else { 
		print("suspeck1k2, d1, missing d1,\n");
	 }
 }


=head2 sub d2 


=cut

 sub d2 {

	my ( $self,$d2 )		= @_;
	if ( $d2 ne $empty_string ) {

		$suspeck1k2->{_d2}		= $d2;
		$suspeck1k2->{_note}		= $suspeck1k2->{_note}.' d2='.$suspeck1k2->{_d2};
		$suspeck1k2->{_Step}		= $suspeck1k2->{_Step}.' d2='.$suspeck1k2->{_d2};

	} else { 
		print("suspeck1k2, d2, missing d2,\n");
	 }
 }


=head2 sub tmpdir 


=cut

 sub tmpdir {

	my ( $self,$tmpdir )		= @_;
	if ( $tmpdir ne $empty_string ) {

		$suspeck1k2->{_tmpdir}		= $tmpdir;
		$suspeck1k2->{_note}		= $suspeck1k2->{_note}.' tmpdir='.$suspeck1k2->{_tmpdir};
		$suspeck1k2->{_Step}		= $suspeck1k2->{_Step}.' tmpdir='.$suspeck1k2->{_tmpdir};

	} else { 
		print("suspeck1k2, tmpdir, missing tmpdir,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suspeck1k2->{_verbose}		= $verbose;
		$suspeck1k2->{_note}		= $suspeck1k2->{_note}.' verbose='.$suspeck1k2->{_verbose};
		$suspeck1k2->{_Step}		= $suspeck1k2->{_Step}.' verbose='.$suspeck1k2->{_verbose};

	} else { 
		print("suspeck1k2, verbose, missing verbose,\n");
	 }
 }


=head2 sub w 


=cut

 sub w {

	my ( $self,$w )		= @_;
	if ( $w ne $empty_string ) {

		$suspeck1k2->{_w}		= $w;
		$suspeck1k2->{_note}		= $suspeck1k2->{_note}.' w='.$suspeck1k2->{_w};
		$suspeck1k2->{_Step}		= $suspeck1k2->{_Step}.' w='.$suspeck1k2->{_w};

	} else { 
		print("suspeck1k2, w, missing w,\n");
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