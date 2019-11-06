 package z2xyz;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  Z2XYZ - convert binary floats representing Z-values to ascii	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 Z2XYZ - convert binary floats representing Z-values to ascii	
 	   form in X Y Z ordered triples			

    z2xyz <stdin >stdout 					

 Required parameters:						
 n1=		number of floats in 1st (fast) dimension	

 Optional parameters:						

 outpar=/dev/tty		 output parameter file		

 Notes: This program is useful for converting panels of float	
 data (representing evenly spaced z values) to the x y z	
 ordered triples required for certain 3D plotting packages.	

 Example of NXplot3d usage on a NeXT:				
 suplane | sufilter | z2xyz n1=64 > junk.ascii			

 Now open junk.ascii as a mesh data file with NXplot3d.	
 (NXplot3d is a NeXTStep-only utility for viewing 3d data sets	


 Credits:
	CWP: John Stockwell based on "b2a" by Jack Cohen


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $z2xyz		= {
		_n1					=> '',
		_outpar					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$z2xyz->{_Step}     = 'z2xyz'.$z2xyz->{_Step};
	return ( $z2xyz->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$z2xyz->{_note}     = 'z2xyz'.$z2xyz->{_note};
	return ( $z2xyz->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$z2xyz->{_n1}			= '';
		$z2xyz->{_outpar}			= '';
		$z2xyz->{_Step}			= '';
		$z2xyz->{_note}			= '';
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$z2xyz->{_n1}		= $n1;
		$z2xyz->{_note}		= $z2xyz->{_note}.' n1='.$z2xyz->{_n1};
		$z2xyz->{_Step}		= $z2xyz->{_Step}.' n1='.$z2xyz->{_n1};

	} else { 
		print("z2xyz, n1, missing n1,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$z2xyz->{_outpar}		= $outpar;
		$z2xyz->{_note}		= $z2xyz->{_note}.' outpar='.$z2xyz->{_outpar};
		$z2xyz->{_Step}		= $z2xyz->{_Step}.' outpar='.$z2xyz->{_outpar};

	} else { 
		print("z2xyz, outpar, missing outpar,\n");
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