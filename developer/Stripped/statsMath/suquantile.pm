 package suquantile;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUQUANTILE - display some quantiles or ranks of a data set            
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUQUANTILE - display some quantiles or ranks of a data set            

 suquantile <stdin >stdout [optional parameters]			

 Required parameters:                                                  
       none (no-op)                                                    

 Optional parameters:                                                  
	panel=1		flag; 0 = do trace by trace (vs. whole data set)
	quantiles=1	flag; 0 = give ranks instead of quantiles	
 	verbose=0	verbose = 1 echoes information			

 	tmpdir= 	 if non-empty, use the value as a directory path
			 prefix for storing temporary files; else if the
		         the CWP_TMPDIR environment variable is set use	
		         its value for the path; else use tmpfile()	


 Credits:
      CWP: Jack K. Cohen


 Trace header fields accessed: ns, tracl, mark

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suquantile		= {
		_panel					=> '',
		_quantiles					=> '',
		_tmpdir					=> '',
		_verbose					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suquantile->{_Step}     = 'suquantile'.$suquantile->{_Step};
	return ( $suquantile->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suquantile->{_note}     = 'suquantile'.$suquantile->{_note};
	return ( $suquantile->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suquantile->{_panel}			= '';
		$suquantile->{_quantiles}			= '';
		$suquantile->{_tmpdir}			= '';
		$suquantile->{_verbose}			= '';
		$suquantile->{_Step}			= '';
		$suquantile->{_note}			= '';
 }


=head2 sub panel 


=cut

 sub panel {

	my ( $self,$panel )		= @_;
	if ( $panel ne $empty_string ) {

		$suquantile->{_panel}		= $panel;
		$suquantile->{_note}		= $suquantile->{_note}.' panel='.$suquantile->{_panel};
		$suquantile->{_Step}		= $suquantile->{_Step}.' panel='.$suquantile->{_panel};

	} else { 
		print("suquantile, panel, missing panel,\n");
	 }
 }


=head2 sub quantiles 


=cut

 sub quantiles {

	my ( $self,$quantiles )		= @_;
	if ( $quantiles ne $empty_string ) {

		$suquantile->{_quantiles}		= $quantiles;
		$suquantile->{_note}		= $suquantile->{_note}.' quantiles='.$suquantile->{_quantiles};
		$suquantile->{_Step}		= $suquantile->{_Step}.' quantiles='.$suquantile->{_quantiles};

	} else { 
		print("suquantile, quantiles, missing quantiles,\n");
	 }
 }


=head2 sub tmpdir 


=cut

 sub tmpdir {

	my ( $self,$tmpdir )		= @_;
	if ( $tmpdir ne $empty_string ) {

		$suquantile->{_tmpdir}		= $tmpdir;
		$suquantile->{_note}		= $suquantile->{_note}.' tmpdir='.$suquantile->{_tmpdir};
		$suquantile->{_Step}		= $suquantile->{_Step}.' tmpdir='.$suquantile->{_tmpdir};

	} else { 
		print("suquantile, tmpdir, missing tmpdir,\n");
	 }
 }


=head2 sub verbose 


=cut

 sub verbose {

	my ( $self,$verbose )		= @_;
	if ( $verbose ne $empty_string ) {

		$suquantile->{_verbose}		= $verbose;
		$suquantile->{_note}		= $suquantile->{_note}.' verbose='.$suquantile->{_verbose};
		$suquantile->{_Step}		= $suquantile->{_Step}.' verbose='.$suquantile->{_verbose};

	} else { 
		print("suquantile, verbose, missing verbose,\n");
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