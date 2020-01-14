 package segbread;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SEGBREAD - read an SEG-B tape						
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SEGBREAD - read an SEG-B tape						

 segbread > stdout tape=						


 Required parameters:							
	tape=	   input tape device					
 Optional parameters:							

	ns=		number of samples.This overrides the number	
			that is obtained from the file header		 
			Usefull for variable trace length		

	auxf=0		1 output auxiliary channels			
	ntro=0		Number of traces per record.This overrides the	
			computed value (usefull for some DFS-V		
			instruments) if specified.			

 ONLY READS DISK SEGB FILES! I tested it on files created by		
 TransMedia Technologies Calgary Alberta, Canada			
 In their format each data block is preceded by an eight byte header	
 2  unsigned 32 bit IBM format integer.				
 First number is the block number, second is the length of block given	
 in bytes.								
  (This program is largely untested. Testing reports on SEG B data	
 and improvements to the code 									

 
 Credits: Balasz Nemeth, Potash Corporation Saskatechwan
 given to CWP in 2008
 Based on SEGDREAD by Stew Levin of Landmark Graphics and others.

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $segbread		= {
		_auxf					=> '',
		_ns					=> '',
		_ntro					=> '',
		_tape					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$segbread->{_Step}     = 'segbread'.$segbread->{_Step};
	return ( $segbread->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$segbread->{_note}     = 'segbread'.$segbread->{_note};
	return ( $segbread->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$segbread->{_auxf}			= '';
		$segbread->{_ns}			= '';
		$segbread->{_ntro}			= '';
		$segbread->{_tape}			= '';
		$segbread->{_Step}			= '';
		$segbread->{_note}			= '';
 }


=head2 sub auxf 


=cut

 sub auxf {

	my ( $self,$auxf )		= @_;
	if ( $auxf ne $empty_string ) {

		$segbread->{_auxf}		= $auxf;
		$segbread->{_note}		= $segbread->{_note}.' auxf='.$segbread->{_auxf};
		$segbread->{_Step}		= $segbread->{_Step}.' auxf='.$segbread->{_auxf};

	} else { 
		print("segbread, auxf, missing auxf,\n");
	 }
 }


=head2 sub ns 


=cut

 sub ns {

	my ( $self,$ns )		= @_;
	if ( $ns ne $empty_string ) {

		$segbread->{_ns}		= $ns;
		$segbread->{_note}		= $segbread->{_note}.' ns='.$segbread->{_ns};
		$segbread->{_Step}		= $segbread->{_Step}.' ns='.$segbread->{_ns};

	} else { 
		print("segbread, ns, missing ns,\n");
	 }
 }


=head2 sub ntro 


=cut

 sub ntro {

	my ( $self,$ntro )		= @_;
	if ( $ntro ne $empty_string ) {

		$segbread->{_ntro}		= $ntro;
		$segbread->{_note}		= $segbread->{_note}.' ntro='.$segbread->{_ntro};
		$segbread->{_Step}		= $segbread->{_Step}.' ntro='.$segbread->{_ntro};

	} else { 
		print("segbread, ntro, missing ntro,\n");
	 }
 }


=head2 sub tape 


=cut

 sub tape {

	my ( $self,$tape )		= @_;
	if ( $tape ne $empty_string ) {

		$segbread->{_tape}		= $tape;
		$segbread->{_note}		= $segbread->{_note}.' tape='.$segbread->{_tape};
		$segbread->{_Step}		= $segbread->{_Step}.' tape='.$segbread->{_tape};

	} else { 
		print("segbread, tape, missing tape,\n");
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