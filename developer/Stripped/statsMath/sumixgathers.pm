 package sumixgathers;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUMIXGATHERS - mix two gathers					
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUMIXGATHERS - mix two gathers					

 sumixgathers file1 file2 > stdout [optional parameters]		

 Required Parameters:							
 ntr=tr.ntr	if ntr header field is not set, then ntr is mandatory	

 Optional Parameters: none						

 Notes: Both files have to be sorted by offset				
 Mixes two gathers keeping only the traces of the first file		
 if the offset is the same. The purpose is to substitute only		
 traces non existing in file1 by traces interpolated store in file2. 	", 

 Example. If file1 is original data file and file 2 is obtained by	
 resampling with Radon transform, then the output contains original  	
 traces with gaps filled						



 Credits:
	Daniel Trad. UBC
 Trace header fields accessed: ns, dt, ntr
 Copyright (c) University of British Columbia, 1999.
 All rights reserved.


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sumixgathers		= {
		_ntr					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sumixgathers->{_Step}     = 'sumixgathers'.$sumixgathers->{_Step};
	return ( $sumixgathers->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sumixgathers->{_note}     = 'sumixgathers'.$sumixgathers->{_note};
	return ( $sumixgathers->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sumixgathers->{_ntr}			= '';
		$sumixgathers->{_Step}			= '';
		$sumixgathers->{_note}			= '';
 }


=head2 sub ntr 


=cut

 sub ntr {

	my ( $self,$ntr )		= @_;
	if ( $ntr ne $empty_string ) {

		$sumixgathers->{_ntr}		= $ntr;
		$sumixgathers->{_note}		= $sumixgathers->{_note}.' ntr='.$sumixgathers->{_ntr};
		$sumixgathers->{_Step}		= $sumixgathers->{_Step}.' ntr='.$sumixgathers->{_ntr};

	} else { 
		print("sumixgathers, ntr, missing ntr,\n");
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