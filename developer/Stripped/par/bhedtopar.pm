 package bhedtopar;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  BHEDTOPAR - convert a Binary tape HEaDer file to PAR file format	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 BHEDTOPAR - convert a Binary tape HEaDer file to PAR file format	

     bhedtopar < stdin outpar=parfile					

 Required parameter:							
 	none								
 Optional parameters:							
	swap=0 			=1 to swap bytes			
 	outpar=/dev/tty		=parfile  name of output param file	

 Notes: 								
 This program dumps the contents of a SEGY binary tape header file, as 
 would be produced by segyread and segyhdrs to a file in "parfile" format.
 A "parfile" is an ASCII file containing entries of the form param=value.
 Here "param" is the keyword for the binary tape header field and	
 "value" is the value of that field. The parfile may be edited as	
 any ASCII file. The edited parfile may then be made into a new binary tape 
 header file via the program    setbhed.				

 See    sudoc  setbhed   for examples					


 Credits:

	CWP: John Stockwell  11 Nov 1994

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $bhedtopar		= {
		_outpar					=> '',
		_param					=> '',
		_swap					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$bhedtopar->{_Step}     = 'bhedtopar'.$bhedtopar->{_Step};
	return ( $bhedtopar->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$bhedtopar->{_note}     = 'bhedtopar'.$bhedtopar->{_note};
	return ( $bhedtopar->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$bhedtopar->{_outpar}			= '';
		$bhedtopar->{_param}			= '';
		$bhedtopar->{_swap}			= '';
		$bhedtopar->{_Step}			= '';
		$bhedtopar->{_note}			= '';
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$bhedtopar->{_outpar}		= $outpar;
		$bhedtopar->{_note}		= $bhedtopar->{_note}.' outpar='.$bhedtopar->{_outpar};
		$bhedtopar->{_Step}		= $bhedtopar->{_Step}.' outpar='.$bhedtopar->{_outpar};

	} else { 
		print("bhedtopar, outpar, missing outpar,\n");
	 }
 }


=head2 sub param 


=cut

 sub param {

	my ( $self,$param )		= @_;
	if ( $param ne $empty_string ) {

		$bhedtopar->{_param}		= $param;
		$bhedtopar->{_note}		= $bhedtopar->{_note}.' param='.$bhedtopar->{_param};
		$bhedtopar->{_Step}		= $bhedtopar->{_Step}.' param='.$bhedtopar->{_param};

	} else { 
		print("bhedtopar, param, missing param,\n");
	 }
 }


=head2 sub swap 


=cut

 sub swap {

	my ( $self,$swap )		= @_;
	if ( $swap ne $empty_string ) {

		$bhedtopar->{_swap}		= $swap;
		$bhedtopar->{_note}		= $bhedtopar->{_note}.' swap='.$bhedtopar->{_swap};
		$bhedtopar->{_Step}		= $bhedtopar->{_Step}.' swap='.$bhedtopar->{_swap};

	} else { 
		print("bhedtopar, swap, missing swap,\n");
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