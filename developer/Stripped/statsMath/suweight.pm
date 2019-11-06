 package suweight;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUWEIGHT - weight traces by header parameter, such as offset		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUWEIGHT - weight traces by header parameter, such as offset		

   suweight < stdin > stdout [optional parameters]			

 Required Parameters:					   		
   <none>								

 Optional parameters:					   		
 key=offset	keyword of header field to weight traces by 		
 a=1.0		constant weighting parameter (see notes below)		
 b=.0005	variable weighting parameter (see notes below)		

... or use values of a header field for the weighting ...		

 key2=		keyword of header field to draw weights from		
 scale=.0001	scale factor to apply to header field values		

 inv=0		weight by header value			 		
 		=1 weight by inverse of header value	 		

 Notes:							 	
 This code is initially written with offset weighting in mind, but may	
 be used for other, user-specified schemes.				

 The rationale for this program is to correct for unwanted linear	
 amplitude trends with offset prior to either CMP stacking or AVO work.
 The code has to be edited should other functions of a keyword be required.

 The default form of the weighting is to multiply the amplitudes of the
 traces by a factor of:    ( a + b*keyword).				

 If key2=  header field is  set then this program uses the weighting	
 values read from that header field, instead. Note, that because most	
 header fields are integers, the scale=.0001 permits 10001 in the header
 to represent 1.0001.							

 To see the list of available keywords, type:    sukeyword  -o  <CR>	


 Credits:
 Author: CWP: John Stockwell  February 1999.
 Written for Chris Walker of UniqueStep Ltd., Bedford, U.K.
 inv option added by Garry Perratt (Geocon).

 header fields accessed: ns, keyword


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suweight		= {
		_a					=> '',
		_b					=> '',
		_inv					=> '',
		_key					=> '',
		_key2					=> '',
		_scale					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suweight->{_Step}     = 'suweight'.$suweight->{_Step};
	return ( $suweight->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suweight->{_note}     = 'suweight'.$suweight->{_note};
	return ( $suweight->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suweight->{_a}			= '';
		$suweight->{_b}			= '';
		$suweight->{_inv}			= '';
		$suweight->{_key}			= '';
		$suweight->{_key2}			= '';
		$suweight->{_scale}			= '';
		$suweight->{_Step}			= '';
		$suweight->{_note}			= '';
 }


=head2 sub a 


=cut

 sub a {

	my ( $self,$a )		= @_;
	if ( $a ne $empty_string ) {

		$suweight->{_a}		= $a;
		$suweight->{_note}		= $suweight->{_note}.' a='.$suweight->{_a};
		$suweight->{_Step}		= $suweight->{_Step}.' a='.$suweight->{_a};

	} else { 
		print("suweight, a, missing a,\n");
	 }
 }


=head2 sub b 


=cut

 sub b {

	my ( $self,$b )		= @_;
	if ( $b ne $empty_string ) {

		$suweight->{_b}		= $b;
		$suweight->{_note}		= $suweight->{_note}.' b='.$suweight->{_b};
		$suweight->{_Step}		= $suweight->{_Step}.' b='.$suweight->{_b};

	} else { 
		print("suweight, b, missing b,\n");
	 }
 }


=head2 sub inv 


=cut

 sub inv {

	my ( $self,$inv )		= @_;
	if ( $inv ne $empty_string ) {

		$suweight->{_inv}		= $inv;
		$suweight->{_note}		= $suweight->{_note}.' inv='.$suweight->{_inv};
		$suweight->{_Step}		= $suweight->{_Step}.' inv='.$suweight->{_inv};

	} else { 
		print("suweight, inv, missing inv,\n");
	 }
 }


=head2 sub key 


=cut

 sub key {

	my ( $self,$key )		= @_;
	if ( $key ne $empty_string ) {

		$suweight->{_key}		= $key;
		$suweight->{_note}		= $suweight->{_note}.' key='.$suweight->{_key};
		$suweight->{_Step}		= $suweight->{_Step}.' key='.$suweight->{_key};

	} else { 
		print("suweight, key, missing key,\n");
	 }
 }


=head2 sub key2 


=cut

 sub key2 {

	my ( $self,$key2 )		= @_;
	if ( $key2 ne $empty_string ) {

		$suweight->{_key2}		= $key2;
		$suweight->{_note}		= $suweight->{_note}.' key2='.$suweight->{_key2};
		$suweight->{_Step}		= $suweight->{_Step}.' key2='.$suweight->{_key2};

	} else { 
		print("suweight, key2, missing key2,\n");
	 }
 }


=head2 sub scale 


=cut

 sub scale {

	my ( $self,$scale )		= @_;
	if ( $scale ne $empty_string ) {

		$suweight->{_scale}		= $scale;
		$suweight->{_note}		= $suweight->{_note}.' scale='.$suweight->{_scale};
		$suweight->{_Step}		= $suweight->{_Step}.' scale='.$suweight->{_scale};

	} else { 
		print("suweight, scale, missing scale,\n");
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