 package sxplot;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SXPLOT - X Window plot a triangulated sloth function s(x1,x2)		
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SXPLOT - X Window plot a triangulated sloth function s(x1,x2)		

 sxplot <modelfile [optional parameters]				

 Optional Parameters:							
 edgecolor=cyan         color to draw fixed edges			
 tricolor=yellow        color to draw non-fixed edges of triangles	
	 =none		non-fixed edges of triangles are not shown      
 bclip=minimum sloth    sloth value corresponding to black		
 wclip=maximum sloth    sloth value corresponding to white		
 x1beg=x1min            value at which x1 axis begins			
 x1end=x1max            value at which x1 axis ends			
 x2beg=x2min            value at which x2 axis begins			
 x2end=x2max            value at which x2 axis ends			
 cmap=gray              gray, hue, or default colormaps may be specified

 Optional resource parameters (defaults taken from resource database):	
 width=                 width in pixels of window			
 height=                height in pixels of window			
 nTic1=                 number of tics per numbered tic on axis 1	
 grid1=                 grid lines on axis 1 - none, dot, dash, or solid
 label1=                label on axis 1				
 nTic2=                 number of tics per numbered tic on axis 2	
 grid2=                 grid lines on axis 2 - none, dot, dash, or solid
 label2=                label on axis 2				
 labelFont=             font name for axes labels			
 title=                 title of plot					
 titleFont=             font name for title				
 titleColor=            color for title				
 axesColor=             color for axes					
 gridColor=             color for grid lines				
 style=                 normal (axis 1 horizontal, axis 2 vertical) or	
                       seismic (axis 1 vertical, axis 2 horizontal)	



 AUTHOR:  Dave Hale, Colorado School of Mines, 05/17/91

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sxplot		= {
		_axesColor					=> '',
		_bclip					=> '',
		_cmap					=> '',
		_edgecolor					=> '',
		_grid1					=> '',
		_grid2					=> '',
		_gridColor					=> '',
		_height					=> '',
		_label1					=> '',
		_label2					=> '',
		_labelFont					=> '',
		_nTic1					=> '',
		_nTic2					=> '',
		_style					=> '',
		_title					=> '',
		_titleColor					=> '',
		_titleFont					=> '',
		_tricolor					=> '',
		_wclip					=> '',
		_width					=> '',
		_x1beg					=> '',
		_x1end					=> '',
		_x2beg					=> '',
		_x2end					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sxplot->{_Step}     = 'sxplot'.$sxplot->{_Step};
	return ( $sxplot->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sxplot->{_note}     = 'sxplot'.$sxplot->{_note};
	return ( $sxplot->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sxplot->{_axesColor}			= '';
		$sxplot->{_bclip}			= '';
		$sxplot->{_cmap}			= '';
		$sxplot->{_edgecolor}			= '';
		$sxplot->{_grid1}			= '';
		$sxplot->{_grid2}			= '';
		$sxplot->{_gridColor}			= '';
		$sxplot->{_height}			= '';
		$sxplot->{_label1}			= '';
		$sxplot->{_label2}			= '';
		$sxplot->{_labelFont}			= '';
		$sxplot->{_nTic1}			= '';
		$sxplot->{_nTic2}			= '';
		$sxplot->{_style}			= '';
		$sxplot->{_title}			= '';
		$sxplot->{_titleColor}			= '';
		$sxplot->{_titleFont}			= '';
		$sxplot->{_tricolor}			= '';
		$sxplot->{_wclip}			= '';
		$sxplot->{_width}			= '';
		$sxplot->{_x1beg}			= '';
		$sxplot->{_x1end}			= '';
		$sxplot->{_x2beg}			= '';
		$sxplot->{_x2end}			= '';
		$sxplot->{_Step}			= '';
		$sxplot->{_note}			= '';
 }


=head2 sub axesColor 


=cut

 sub axesColor {

	my ( $self,$axesColor )		= @_;
	if ( $axesColor ne $empty_string ) {

		$sxplot->{_axesColor}		= $axesColor;
		$sxplot->{_note}		= $sxplot->{_note}.' axesColor='.$sxplot->{_axesColor};
		$sxplot->{_Step}		= $sxplot->{_Step}.' axesColor='.$sxplot->{_axesColor};

	} else { 
		print("sxplot, axesColor, missing axesColor,\n");
	 }
 }


=head2 sub bclip 


=cut

 sub bclip {

	my ( $self,$bclip )		= @_;
	if ( $bclip ne $empty_string ) {

		$sxplot->{_bclip}		= $bclip;
		$sxplot->{_note}		= $sxplot->{_note}.' bclip='.$sxplot->{_bclip};
		$sxplot->{_Step}		= $sxplot->{_Step}.' bclip='.$sxplot->{_bclip};

	} else { 
		print("sxplot, bclip, missing bclip,\n");
	 }
 }


=head2 sub cmap 


=cut

 sub cmap {

	my ( $self,$cmap )		= @_;
	if ( $cmap ne $empty_string ) {

		$sxplot->{_cmap}		= $cmap;
		$sxplot->{_note}		= $sxplot->{_note}.' cmap='.$sxplot->{_cmap};
		$sxplot->{_Step}		= $sxplot->{_Step}.' cmap='.$sxplot->{_cmap};

	} else { 
		print("sxplot, cmap, missing cmap,\n");
	 }
 }


=head2 sub edgecolor 


=cut

 sub edgecolor {

	my ( $self,$edgecolor )		= @_;
	if ( $edgecolor ne $empty_string ) {

		$sxplot->{_edgecolor}		= $edgecolor;
		$sxplot->{_note}		= $sxplot->{_note}.' edgecolor='.$sxplot->{_edgecolor};
		$sxplot->{_Step}		= $sxplot->{_Step}.' edgecolor='.$sxplot->{_edgecolor};

	} else { 
		print("sxplot, edgecolor, missing edgecolor,\n");
	 }
 }


=head2 sub grid1 


=cut

 sub grid1 {

	my ( $self,$grid1 )		= @_;
	if ( $grid1 ne $empty_string ) {

		$sxplot->{_grid1}		= $grid1;
		$sxplot->{_note}		= $sxplot->{_note}.' grid1='.$sxplot->{_grid1};
		$sxplot->{_Step}		= $sxplot->{_Step}.' grid1='.$sxplot->{_grid1};

	} else { 
		print("sxplot, grid1, missing grid1,\n");
	 }
 }


=head2 sub grid2 


=cut

 sub grid2 {

	my ( $self,$grid2 )		= @_;
	if ( $grid2 ne $empty_string ) {

		$sxplot->{_grid2}		= $grid2;
		$sxplot->{_note}		= $sxplot->{_note}.' grid2='.$sxplot->{_grid2};
		$sxplot->{_Step}		= $sxplot->{_Step}.' grid2='.$sxplot->{_grid2};

	} else { 
		print("sxplot, grid2, missing grid2,\n");
	 }
 }


=head2 sub gridColor 


=cut

 sub gridColor {

	my ( $self,$gridColor )		= @_;
	if ( $gridColor ne $empty_string ) {

		$sxplot->{_gridColor}		= $gridColor;
		$sxplot->{_note}		= $sxplot->{_note}.' gridColor='.$sxplot->{_gridColor};
		$sxplot->{_Step}		= $sxplot->{_Step}.' gridColor='.$sxplot->{_gridColor};

	} else { 
		print("sxplot, gridColor, missing gridColor,\n");
	 }
 }


=head2 sub height 


=cut

 sub height {

	my ( $self,$height )		= @_;
	if ( $height ne $empty_string ) {

		$sxplot->{_height}		= $height;
		$sxplot->{_note}		= $sxplot->{_note}.' height='.$sxplot->{_height};
		$sxplot->{_Step}		= $sxplot->{_Step}.' height='.$sxplot->{_height};

	} else { 
		print("sxplot, height, missing height,\n");
	 }
 }


=head2 sub label1 


=cut

 sub label1 {

	my ( $self,$label1 )		= @_;
	if ( $label1 ne $empty_string ) {

		$sxplot->{_label1}		= $label1;
		$sxplot->{_note}		= $sxplot->{_note}.' label1='.$sxplot->{_label1};
		$sxplot->{_Step}		= $sxplot->{_Step}.' label1='.$sxplot->{_label1};

	} else { 
		print("sxplot, label1, missing label1,\n");
	 }
 }


=head2 sub label2 


=cut

 sub label2 {

	my ( $self,$label2 )		= @_;
	if ( $label2 ne $empty_string ) {

		$sxplot->{_label2}		= $label2;
		$sxplot->{_note}		= $sxplot->{_note}.' label2='.$sxplot->{_label2};
		$sxplot->{_Step}		= $sxplot->{_Step}.' label2='.$sxplot->{_label2};

	} else { 
		print("sxplot, label2, missing label2,\n");
	 }
 }


=head2 sub labelFont 


=cut

 sub labelFont {

	my ( $self,$labelFont )		= @_;
	if ( $labelFont ne $empty_string ) {

		$sxplot->{_labelFont}		= $labelFont;
		$sxplot->{_note}		= $sxplot->{_note}.' labelFont='.$sxplot->{_labelFont};
		$sxplot->{_Step}		= $sxplot->{_Step}.' labelFont='.$sxplot->{_labelFont};

	} else { 
		print("sxplot, labelFont, missing labelFont,\n");
	 }
 }


=head2 sub nTic1 


=cut

 sub nTic1 {

	my ( $self,$nTic1 )		= @_;
	if ( $nTic1 ne $empty_string ) {

		$sxplot->{_nTic1}		= $nTic1;
		$sxplot->{_note}		= $sxplot->{_note}.' nTic1='.$sxplot->{_nTic1};
		$sxplot->{_Step}		= $sxplot->{_Step}.' nTic1='.$sxplot->{_nTic1};

	} else { 
		print("sxplot, nTic1, missing nTic1,\n");
	 }
 }


=head2 sub nTic2 


=cut

 sub nTic2 {

	my ( $self,$nTic2 )		= @_;
	if ( $nTic2 ne $empty_string ) {

		$sxplot->{_nTic2}		= $nTic2;
		$sxplot->{_note}		= $sxplot->{_note}.' nTic2='.$sxplot->{_nTic2};
		$sxplot->{_Step}		= $sxplot->{_Step}.' nTic2='.$sxplot->{_nTic2};

	} else { 
		print("sxplot, nTic2, missing nTic2,\n");
	 }
 }


=head2 sub style 


=cut

 sub style {

	my ( $self,$style )		= @_;
	if ( $style ne $empty_string ) {

		$sxplot->{_style}		= $style;
		$sxplot->{_note}		= $sxplot->{_note}.' style='.$sxplot->{_style};
		$sxplot->{_Step}		= $sxplot->{_Step}.' style='.$sxplot->{_style};

	} else { 
		print("sxplot, style, missing style,\n");
	 }
 }


=head2 sub title 


=cut

 sub title {

	my ( $self,$title )		= @_;
	if ( $title ne $empty_string ) {

		$sxplot->{_title}		= $title;
		$sxplot->{_note}		= $sxplot->{_note}.' title='.$sxplot->{_title};
		$sxplot->{_Step}		= $sxplot->{_Step}.' title='.$sxplot->{_title};

	} else { 
		print("sxplot, title, missing title,\n");
	 }
 }


=head2 sub titleColor 


=cut

 sub titleColor {

	my ( $self,$titleColor )		= @_;
	if ( $titleColor ne $empty_string ) {

		$sxplot->{_titleColor}		= $titleColor;
		$sxplot->{_note}		= $sxplot->{_note}.' titleColor='.$sxplot->{_titleColor};
		$sxplot->{_Step}		= $sxplot->{_Step}.' titleColor='.$sxplot->{_titleColor};

	} else { 
		print("sxplot, titleColor, missing titleColor,\n");
	 }
 }


=head2 sub titleFont 


=cut

 sub titleFont {

	my ( $self,$titleFont )		= @_;
	if ( $titleFont ne $empty_string ) {

		$sxplot->{_titleFont}		= $titleFont;
		$sxplot->{_note}		= $sxplot->{_note}.' titleFont='.$sxplot->{_titleFont};
		$sxplot->{_Step}		= $sxplot->{_Step}.' titleFont='.$sxplot->{_titleFont};

	} else { 
		print("sxplot, titleFont, missing titleFont,\n");
	 }
 }


=head2 sub tricolor 


=cut

 sub tricolor {

	my ( $self,$tricolor )		= @_;
	if ( $tricolor ne $empty_string ) {

		$sxplot->{_tricolor}		= $tricolor;
		$sxplot->{_note}		= $sxplot->{_note}.' tricolor='.$sxplot->{_tricolor};
		$sxplot->{_Step}		= $sxplot->{_Step}.' tricolor='.$sxplot->{_tricolor};

	} else { 
		print("sxplot, tricolor, missing tricolor,\n");
	 }
 }


=head2 sub wclip 


=cut

 sub wclip {

	my ( $self,$wclip )		= @_;
	if ( $wclip ne $empty_string ) {

		$sxplot->{_wclip}		= $wclip;
		$sxplot->{_note}		= $sxplot->{_note}.' wclip='.$sxplot->{_wclip};
		$sxplot->{_Step}		= $sxplot->{_Step}.' wclip='.$sxplot->{_wclip};

	} else { 
		print("sxplot, wclip, missing wclip,\n");
	 }
 }


=head2 sub width 


=cut

 sub width {

	my ( $self,$width )		= @_;
	if ( $width ne $empty_string ) {

		$sxplot->{_width}		= $width;
		$sxplot->{_note}		= $sxplot->{_note}.' width='.$sxplot->{_width};
		$sxplot->{_Step}		= $sxplot->{_Step}.' width='.$sxplot->{_width};

	} else { 
		print("sxplot, width, missing width,\n");
	 }
 }


=head2 sub x1beg 


=cut

 sub x1beg {

	my ( $self,$x1beg )		= @_;
	if ( $x1beg ne $empty_string ) {

		$sxplot->{_x1beg}		= $x1beg;
		$sxplot->{_note}		= $sxplot->{_note}.' x1beg='.$sxplot->{_x1beg};
		$sxplot->{_Step}		= $sxplot->{_Step}.' x1beg='.$sxplot->{_x1beg};

	} else { 
		print("sxplot, x1beg, missing x1beg,\n");
	 }
 }


=head2 sub x1end 


=cut

 sub x1end {

	my ( $self,$x1end )		= @_;
	if ( $x1end ne $empty_string ) {

		$sxplot->{_x1end}		= $x1end;
		$sxplot->{_note}		= $sxplot->{_note}.' x1end='.$sxplot->{_x1end};
		$sxplot->{_Step}		= $sxplot->{_Step}.' x1end='.$sxplot->{_x1end};

	} else { 
		print("sxplot, x1end, missing x1end,\n");
	 }
 }


=head2 sub x2beg 


=cut

 sub x2beg {

	my ( $self,$x2beg )		= @_;
	if ( $x2beg ne $empty_string ) {

		$sxplot->{_x2beg}		= $x2beg;
		$sxplot->{_note}		= $sxplot->{_note}.' x2beg='.$sxplot->{_x2beg};
		$sxplot->{_Step}		= $sxplot->{_Step}.' x2beg='.$sxplot->{_x2beg};

	} else { 
		print("sxplot, x2beg, missing x2beg,\n");
	 }
 }


=head2 sub x2end 


=cut

 sub x2end {

	my ( $self,$x2end )		= @_;
	if ( $x2end ne $empty_string ) {

		$sxplot->{_x2end}		= $x2end;
		$sxplot->{_note}		= $sxplot->{_note}.' x2end='.$sxplot->{_x2end};
		$sxplot->{_Step}		= $sxplot->{_Step}.' x2end='.$sxplot->{_x2end};

	} else { 
		print("sxplot, x2end, missing x2end,\n");
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