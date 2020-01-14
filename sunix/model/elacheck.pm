 package elacheck;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  ELACHECK - get elastic coefficients of model  	   		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 ELACHECK - get elastic coefficients of model  	   		

 elacheck file= (required modelfile)					

 ____ interactive program _____________                                




 AUTHOR:: Andreas Rueger, Colorado School of Mines, 01/20/94
 get stiffness information for anisotropic model (interactive)


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $elacheck		= {
		_file					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$elacheck->{_Step}     = 'elacheck'.$elacheck->{_Step};
	return ( $elacheck->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$elacheck->{_note}     = 'elacheck'.$elacheck->{_note};
	return ( $elacheck->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$elacheck->{_file}			= '';
		$elacheck->{_Step}			= '';
		$elacheck->{_note}			= '';
 }


=head2 sub file 


=cut

 sub file {

	my ( $self,$file )		= @_;
	if ( $file ne $empty_string ) {

		$elacheck->{_file}		= $file;
		$elacheck->{_note}		= $elacheck->{_note}.' file='.$elacheck->{_file};
		$elacheck->{_Step}		= $elacheck->{_Step}.' file='.$elacheck->{_file};

	} else { 
		print("elacheck, file, missing file,\n");
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