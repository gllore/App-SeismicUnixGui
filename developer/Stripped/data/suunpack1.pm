 package suunpack1;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME: SUUNPACK1 - unpack segy trace data from chars to floats	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

SUUNPACK1 - unpack segy trace data from chars to floats	

    suunpack1 <packed_file >unpacked_file			

suunpack1 is the approximate inverse of supack1		


 Credits:
	CWP: Jack K. Cohen, Shuki Ronen, Brian Sumner

 Caveats:
	This program is for single site use with supack1.  See the
	supack1 header comments.

 Notes:
	ungpow and unscale are defined in segy.h
	trid = CHARPACK is defined in su.h and segy.h


 Trace header fields accessed: ns, trid, ungpow, unscale
 Trace header fields modified:     trid, ungpow, unscale

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suunpack1		= {
		_trid					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suunpack1->{_Step}     = 'suunpack1'.$suunpack1->{_Step};
	return ( $suunpack1->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suunpack1->{_note}     = 'suunpack1'.$suunpack1->{_note};
	return ( $suunpack1->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suunpack1->{_trid}			= '';
		$suunpack1->{_Step}			= '';
		$suunpack1->{_note}			= '';
 }


=head2 sub trid 


=cut

 sub trid {

	my ( $self,$trid )		= @_;
	if ( $trid ne $empty_string ) {

		$suunpack1->{_trid}		= $trid;
		$suunpack1->{_note}		= $suunpack1->{_note}.' trid='.$suunpack1->{_trid};
		$suunpack1->{_Step}		= $suunpack1->{_Step}.' trid='.$suunpack1->{_trid};

	} else { 
		print("suunpack1, trid, missing trid,\n");
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