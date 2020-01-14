 package suacor;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUACOR - auto-correlation						
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUACOR - auto-correlation						

 suacor <stdin >stdout [optional parms]				

 Optional Parameters:							
 ntout=101	odd number of time samples output			
 norm=1	if non-zero, normalize maximum absolute output to 1	
 sym=1		if non-zero, produce a symmetric output from		
			lag -(ntout-1)/2 to lag +(ntout-1)/2		

 Credits:
	CWP: Dave Hale

 Trace header fields accessed:  ns
 Trace header fields modified:  ns and delrt

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suacor		= {
		_norm					=> '',
		_ntout					=> '',
		_sym					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suacor->{_Step}     = 'suacor'.$suacor->{_Step};
	return ( $suacor->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suacor->{_note}     = 'suacor'.$suacor->{_note};
	return ( $suacor->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suacor->{_norm}			= '';
		$suacor->{_ntout}			= '';
		$suacor->{_sym}			= '';
		$suacor->{_Step}			= '';
		$suacor->{_note}			= '';
 }


=head2 sub norm 


=cut

 sub norm {

	my ( $self,$norm )		= @_;
	if ( $norm ne $empty_string ) {

		$suacor->{_norm}		= $norm;
		$suacor->{_note}		= $suacor->{_note}.' norm='.$suacor->{_norm};
		$suacor->{_Step}		= $suacor->{_Step}.' norm='.$suacor->{_norm};

	} else { 
		print("suacor, norm, missing norm,\n");
	 }
 }


=head2 sub ntout 


=cut

 sub ntout {

	my ( $self,$ntout )		= @_;
	if ( $ntout ne $empty_string ) {

		$suacor->{_ntout}		= $ntout;
		$suacor->{_note}		= $suacor->{_note}.' ntout='.$suacor->{_ntout};
		$suacor->{_Step}		= $suacor->{_Step}.' ntout='.$suacor->{_ntout};

	} else { 
		print("suacor, ntout, missing ntout,\n");
	 }
 }


=head2 sub sym 


=cut

 sub sym {

	my ( $self,$sym )		= @_;
	if ( $sym ne $empty_string ) {

		$suacor->{_sym}		= $sym;
		$suacor->{_note}		= $suacor->{_note}.' sym='.$suacor->{_sym};
		$suacor->{_Step}		= $suacor->{_Step}.' sym='.$suacor->{_sym};

	} else { 
		print("suacor, sym, missing sym,\n");
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