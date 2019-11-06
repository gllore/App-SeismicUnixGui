 package suunpack2;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUUNPACK2 - unpack segy trace data from shorts to floats	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUUNPACK2 - unpack segy trace data from shorts to floats	

    suunpack2 <packed_file >unpacked_file			

 suunpack2 is the approximate inverse of supack2		


 Credits:
	CWP: Jack K. Cohen, Shuki Ronen, Brian Sumner

 Revised:  7/4/95 Stewart A. Levin  Mobil
          Changed decoding to parallel 2 byte encoding of supack2

 Caveats:
	This program is for single site use with supack2.  See the
	supack2 header comments.

 Notes:
	ungpow and unscale are defined in segy.h
	trid = SHORTPACK is defined in su.h and segy.h

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


	my $suunpack2		= {
		_trid					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suunpack2->{_Step}     = 'suunpack2'.$suunpack2->{_Step};
	return ( $suunpack2->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suunpack2->{_note}     = 'suunpack2'.$suunpack2->{_note};
	return ( $suunpack2->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suunpack2->{_trid}			= '';
		$suunpack2->{_Step}			= '';
		$suunpack2->{_note}			= '';
 }


=head2 sub trid 


=cut

 sub trid {

	my ( $self,$trid )		= @_;
	if ( $trid ne $empty_string ) {

		$suunpack2->{_trid}		= $trid;
		$suunpack2->{_note}		= $suunpack2->{_note}.' trid='.$suunpack2->{_trid};
		$suunpack2->{_Step}		= $suunpack2->{_Step}.' trid='.$suunpack2->{_trid};

	} else { 
		print("suunpack2, trid, missing trid,\n");
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