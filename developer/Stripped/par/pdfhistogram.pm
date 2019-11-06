 package pdfhistogram;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  PDFHISTOGRAM - generate a HISTOGRAM of the Probability Density function
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 PDFHISTOGRAM - generate a HISTOGRAM of the Probability Density function

  pdfhistogram < stdin > sdtout [Required params] (Optional params)	

 Required parameters: 							
 ix=		column containing X variable				
 iy=		column containing Y variable 				
 min_x=	minimum X bin						
 max_x=	maximum X bin						
 min_y=	minimum Y bin						
 max_y=	maximum Y bin						
 logx=0	=1 use logarithmic scale for X axis			
 logy=0	=1 use logarithmic scale for Y axis			
 norm=	selected normalization type 					
		sqrt	- bin / sqrt( xnct*ycnt) 			
		avg_cnt	- 0.5* bin / (xcnt + ycnt) 			
		avg_sum	- (bin / xcnt + bin / ycnt ) / 2 		
		xcnt	- bin / xcnt 					
		ycnt	- bin / ycnt 					
		log	- log(bin) 					
		total	- bin / total 					
 Optional parameters: 							
  nx=100	- number of X bins					
  ny=100	- number of Y bins 					
  ir=	- column containing reject variable 				
  rmin=	- reject values below rmin 				
  rmax=	- reject values above rmax 				
		NOTE: only one, rmin or rmax, may be used 		
 Notes:								
 PDFHISTOGRAM creates a 2D histogram representing the probability density
 function of the input data. The output is in the form of a binary array
 that can then be plotted via ximage.					
 Commandline options allow selecting any of several normalizations	
 to apply to the distributions.					


 Credits:
  Reginald H. Beardsley	rhb@acm.org
	Copyright 2006 Exploration Software Consultants Inc.

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $pdfhistogram		= {
		_ir					=> '',
		_ix					=> '',
		_iy					=> '',
		_logx					=> '',
		_logy					=> '',
		_max_x					=> '',
		_max_y					=> '',
		_min_x					=> '',
		_min_y					=> '',
		_norm					=> '',
		_nx					=> '',
		_ny					=> '',
		_rmax					=> '',
		_rmin					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$pdfhistogram->{_Step}     = 'pdfhistogram'.$pdfhistogram->{_Step};
	return ( $pdfhistogram->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$pdfhistogram->{_note}     = 'pdfhistogram'.$pdfhistogram->{_note};
	return ( $pdfhistogram->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$pdfhistogram->{_ir}			= '';
		$pdfhistogram->{_ix}			= '';
		$pdfhistogram->{_iy}			= '';
		$pdfhistogram->{_logx}			= '';
		$pdfhistogram->{_logy}			= '';
		$pdfhistogram->{_max_x}			= '';
		$pdfhistogram->{_max_y}			= '';
		$pdfhistogram->{_min_x}			= '';
		$pdfhistogram->{_min_y}			= '';
		$pdfhistogram->{_norm}			= '';
		$pdfhistogram->{_nx}			= '';
		$pdfhistogram->{_ny}			= '';
		$pdfhistogram->{_rmax}			= '';
		$pdfhistogram->{_rmin}			= '';
		$pdfhistogram->{_Step}			= '';
		$pdfhistogram->{_note}			= '';
 }


=head2 sub ir 


=cut

 sub ir {

	my ( $self,$ir )		= @_;
	if ( $ir ne $empty_string ) {

		$pdfhistogram->{_ir}		= $ir;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' ir='.$pdfhistogram->{_ir};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' ir='.$pdfhistogram->{_ir};

	} else { 
		print("pdfhistogram, ir, missing ir,\n");
	 }
 }


=head2 sub ix 


=cut

 sub ix {

	my ( $self,$ix )		= @_;
	if ( $ix ne $empty_string ) {

		$pdfhistogram->{_ix}		= $ix;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' ix='.$pdfhistogram->{_ix};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' ix='.$pdfhistogram->{_ix};

	} else { 
		print("pdfhistogram, ix, missing ix,\n");
	 }
 }


=head2 sub iy 


=cut

 sub iy {

	my ( $self,$iy )		= @_;
	if ( $iy ne $empty_string ) {

		$pdfhistogram->{_iy}		= $iy;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' iy='.$pdfhistogram->{_iy};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' iy='.$pdfhistogram->{_iy};

	} else { 
		print("pdfhistogram, iy, missing iy,\n");
	 }
 }


=head2 sub logx 


=cut

 sub logx {

	my ( $self,$logx )		= @_;
	if ( $logx ne $empty_string ) {

		$pdfhistogram->{_logx}		= $logx;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' logx='.$pdfhistogram->{_logx};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' logx='.$pdfhistogram->{_logx};

	} else { 
		print("pdfhistogram, logx, missing logx,\n");
	 }
 }


=head2 sub logy 


=cut

 sub logy {

	my ( $self,$logy )		= @_;
	if ( $logy ne $empty_string ) {

		$pdfhistogram->{_logy}		= $logy;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' logy='.$pdfhistogram->{_logy};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' logy='.$pdfhistogram->{_logy};

	} else { 
		print("pdfhistogram, logy, missing logy,\n");
	 }
 }


=head2 sub max_x 


=cut

 sub max_x {

	my ( $self,$max_x )		= @_;
	if ( $max_x ne $empty_string ) {

		$pdfhistogram->{_max_x}		= $max_x;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' max_x='.$pdfhistogram->{_max_x};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' max_x='.$pdfhistogram->{_max_x};

	} else { 
		print("pdfhistogram, max_x, missing max_x,\n");
	 }
 }


=head2 sub max_y 


=cut

 sub max_y {

	my ( $self,$max_y )		= @_;
	if ( $max_y ne $empty_string ) {

		$pdfhistogram->{_max_y}		= $max_y;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' max_y='.$pdfhistogram->{_max_y};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' max_y='.$pdfhistogram->{_max_y};

	} else { 
		print("pdfhistogram, max_y, missing max_y,\n");
	 }
 }


=head2 sub min_x 


=cut

 sub min_x {

	my ( $self,$min_x )		= @_;
	if ( $min_x ne $empty_string ) {

		$pdfhistogram->{_min_x}		= $min_x;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' min_x='.$pdfhistogram->{_min_x};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' min_x='.$pdfhistogram->{_min_x};

	} else { 
		print("pdfhistogram, min_x, missing min_x,\n");
	 }
 }


=head2 sub min_y 


=cut

 sub min_y {

	my ( $self,$min_y )		= @_;
	if ( $min_y ne $empty_string ) {

		$pdfhistogram->{_min_y}		= $min_y;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' min_y='.$pdfhistogram->{_min_y};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' min_y='.$pdfhistogram->{_min_y};

	} else { 
		print("pdfhistogram, min_y, missing min_y,\n");
	 }
 }


=head2 sub norm 


=cut

 sub norm {

	my ( $self,$norm )		= @_;
	if ( $norm ne $empty_string ) {

		$pdfhistogram->{_norm}		= $norm;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' norm='.$pdfhistogram->{_norm};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' norm='.$pdfhistogram->{_norm};

	} else { 
		print("pdfhistogram, norm, missing norm,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$pdfhistogram->{_nx}		= $nx;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' nx='.$pdfhistogram->{_nx};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' nx='.$pdfhistogram->{_nx};

	} else { 
		print("pdfhistogram, nx, missing nx,\n");
	 }
 }


=head2 sub ny 


=cut

 sub ny {

	my ( $self,$ny )		= @_;
	if ( $ny ne $empty_string ) {

		$pdfhistogram->{_ny}		= $ny;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' ny='.$pdfhistogram->{_ny};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' ny='.$pdfhistogram->{_ny};

	} else { 
		print("pdfhistogram, ny, missing ny,\n");
	 }
 }


=head2 sub rmax 


=cut

 sub rmax {

	my ( $self,$rmax )		= @_;
	if ( $rmax ne $empty_string ) {

		$pdfhistogram->{_rmax}		= $rmax;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' rmax='.$pdfhistogram->{_rmax};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' rmax='.$pdfhistogram->{_rmax};

	} else { 
		print("pdfhistogram, rmax, missing rmax,\n");
	 }
 }


=head2 sub rmin 


=cut

 sub rmin {

	my ( $self,$rmin )		= @_;
	if ( $rmin ne $empty_string ) {

		$pdfhistogram->{_rmin}		= $rmin;
		$pdfhistogram->{_note}		= $pdfhistogram->{_note}.' rmin='.$pdfhistogram->{_rmin};
		$pdfhistogram->{_Step}		= $pdfhistogram->{_Step}.' rmin='.$pdfhistogram->{_rmin};

	} else { 
		print("pdfhistogram, rmin, missing rmin,\n");
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