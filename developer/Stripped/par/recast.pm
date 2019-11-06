 package recast;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  RECAST - RECAST data type (convert from one data type to another)	
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 RECAST - RECAST data type (convert from one data type to another)	

 recast <stdin [optional parameters]  >stdout 				

 Required parameters:							
 	none								

 Optional parameters:							
 in=float	input type	(float)					
 		=double		(double)				
 		=int		(int)					
 		=char		(char)					
		=uchar		(unsigned char)				
 		=short		(short)					
 		=long		(long)					
 		=ulong		(unsigned long)				

 out=double	output type	(double)				
 		=float		(float)					
 		=int		(int)					
 		=char		(char)					
 		=uchar		(unsigned char)				
 		=short		(short)					
 		=long		(long)					
 		=ulong		(unsigned long)				

 outpar=/dev/tty	output parameter file, contains the		
				number of values (n1=)			
 			other choices for outpar are: /dev/tty,		
 			/dev/stderr, or a name of a disk file		

 Notes: Converting bigger types to smaller is hazardous. For float	
	 or double conversions to integer types, the results are 	
	 rounded to the nearest integer.				


 Credits:

	CWP: John Stockwell, Jack K. Cohen


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $recast		= {
		_in					=> '',
		_n1					=> '',
		_out					=> '',
		_outpar					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$recast->{_Step}     = 'recast'.$recast->{_Step};
	return ( $recast->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$recast->{_note}     = 'recast'.$recast->{_note};
	return ( $recast->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$recast->{_in}			= '';
		$recast->{_n1}			= '';
		$recast->{_out}			= '';
		$recast->{_outpar}			= '';
		$recast->{_Step}			= '';
		$recast->{_note}			= '';
 }


=head2 sub in 


=cut

 sub in {

	my ( $self,$in )		= @_;
	if ( $in ne $empty_string ) {

		$recast->{_in}		= $in;
		$recast->{_note}		= $recast->{_note}.' in='.$recast->{_in};
		$recast->{_Step}		= $recast->{_Step}.' in='.$recast->{_in};

	} else { 
		print("recast, in, missing in,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$recast->{_n1}		= $n1;
		$recast->{_note}		= $recast->{_note}.' n1='.$recast->{_n1};
		$recast->{_Step}		= $recast->{_Step}.' n1='.$recast->{_n1};

	} else { 
		print("recast, n1, missing n1,\n");
	 }
 }


=head2 sub out 


=cut

 sub out {

	my ( $self,$out )		= @_;
	if ( $out ne $empty_string ) {

		$recast->{_out}		= $out;
		$recast->{_note}		= $recast->{_note}.' out='.$recast->{_out};
		$recast->{_Step}		= $recast->{_Step}.' out='.$recast->{_out};

	} else { 
		print("recast, out, missing out,\n");
	 }
 }


=head2 sub outpar 


=cut

 sub outpar {

	my ( $self,$outpar )		= @_;
	if ( $outpar ne $empty_string ) {

		$recast->{_outpar}		= $outpar;
		$recast->{_note}		= $recast->{_note}.' outpar='.$recast->{_outpar};
		$recast->{_Step}		= $recast->{_Step}.' outpar='.$recast->{_outpar};

	} else { 
		print("recast, outpar, missing outpar,\n");
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