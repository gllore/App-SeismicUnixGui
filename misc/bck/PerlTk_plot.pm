package PerlTk_plot;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PACKAGE NAME: PerlTk_plot 
 AUTHOR: 	Juan Lorenzo
 DATE: 		March 19 2018 

 DESCRIPTION 
     Plot image and graphics files 

 BASED ON:
 	Inspired by suximage and suxgraph

=cut

=head2 USE


=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut 

=head2 Notes from bash
 

=cut

 use Moose;
 use L_SU_global_constants;
 use Tk;
 use Tk::Canvas;
 use Tk::Photo;
 use Tk::PNG;
#
our $VERSION 	= 	'0.0.2';

=head2 Assign Global Variables

		instantiate packages
=cut

 	my $get						= new L_SU_global_constants();
 	my $var						= $get->var();
 	my $empty_string			= $var->{_empty_string};
 	my $us_per_s                = $var->{_us_per_s};
 

=head2 private hash containing
	imporant variables

=cut

	my $PerlTk_plot = {
		_BOX					=> '',
		_box_X0_pix				=> '',
		_box_Y0_pix				=> '',
		_canvas_width_pix		=> '',
		_canvas_height_pix		=> '',
		_canvas_min_x_m			=> '',
		_canvas_max_x_m			=> '',
		_canvas_min_trace		=> '',
		_canvas_max_trace_num	=> '',
		_ctab					=> '',		
		_dpi					=> '',
		_dx						=> '',
		_first_sample_index2plot	=> '',	
		_first_t_s4data			=> '',
		_first_x4data			=> '',				
		_first_t_s4plot			=> '',		
		_first_x4plot			=> '',
		_gui_positionNsize		=> '',	
		_inbound_base_file_name	=> '',
		_inbound_binary_format	=> '',	
		_inbound_file_path		=> '',			
		_inbound_parameter_file_name	=> '',
		_inbound_parameter_file_path	=> '',
		_inbound_suffix_type	=> '',		
		_gain					=> '',
		_last_t_s4plot			=> '',
		_last_x4plot			=> '',
		_mw_height				=> '',
		_mw_width				=> '',
		_number_of_traces		=> '',	
		_pdl					=> '',
		_pl						=> '',
		_png_data				=> '',
		_png_file				=> '',		
		_resize_x				=> 1,
		_resize_y				=> 1,
		_samples_per_trace		=> '',		
		_png_page_width			=> '',
		_png_page_height		=> '',
		_samples_per_trace		=> '',
		_sample_increment_index => '',
		_seismic_plot_height	=> '',
		_seismic_plot_width		=> '',
		_seismic_plot_x_offset_pix	=> '',
		_seismic_plot_y_offset_pix	=> '',				
		_sample_interval_ms		=> '',		
		_sample_interval_us		=> '',
		_t_max_s4data			=> '',
		_t_min_s4data			=> '',
		_t_max_s4plot			=> '',
		_t_min_s4plot			=> '',		
#		_viewport_top			=>1,
#		_viewport_left_min		=> 0,
#		_viewport_right_max		=> 1,
#		_viewport_xmin          => 0,
#		_viewport_xmax			=> 1,
#		_viewport_ymin			=> 0,
#		_viewport_ymax			=> 1,		
		_viewport_top			=> .1,
		_viewport_bottom		=> .9,
		_viewport_left_min		=> .1,
		_viewport_right_max		=> .9,
		_viewport_xmin          => .1,
		_viewport_xmax			=> .9,
		_viewport_ymin			=> .1,
		_viewport_ymax			=> .9,
		_x_increment			=> '',
		_x_increment_index		=> '',
		_x_label				=> '',
		_y_label				=> '',	
		_write_format			=> '',
		_x_max4data				=> '',
		_x_min4data				=> '',
		_x_max4plot				=> '',
		_x_min4plot				=> '',
		
	};

=head3 attributes
	
	$VIEWPORT=
		
	my ($viewport_xmin, $viewport_xmax, 
		$viewport_ymin, $viewport_ymax)		= ($viewport_top, $viewport_bottom, 
 													$viewport_left_min, $viewport_right_max);
Set the location of the plotting window on the device plotting page.
Takes a four element array ref specifying:
 
 xmin -- The coordinate of the left-hand edge of the viewport. (0 to 1)
 xmax -- The coordinate of the right-hand edge of the viewport. (0 to 1)
 ymin -- The coordinate of the bottom edge of the viewport. (0 to 1)
 ymax -- The coordinate of the top edge of the viewport. (0 to 1)
 
You will need to use this to make color keys or insets.
 
	 for seismic orientation	   
	 Left-to-right, then  top-to-bottom
	  --------->  X (left-to-right)     ---------> Y regular (rotated with ORIENTATION1)
	  |									|
	  |  SEISMIC						|
	  |									|
	  \/								\/
	 T axis down						X regular (rotated 90 deg clockise with ORIENTATION=1)
	 seismic tmin -> regular xmin
	 seismic tmax -> regular xmax
	 seismic xmin -> regular ymin
	 seismic xmin -> regular ymax
													
=cut

																							




=head3 Definition of an sustripped binary header format

C-type IBM 4-byte-Floating Point binary amplitudes


	 # anonymous list
	 my $header 	= [
        				{ Type  => 'float',
        		  		  NDims => 2, 
        		  		  Dims  => [1,2] 
        				}
    				  ];
=cut



=head3 sub _BOX

 	pixel limits of graphing
 	
=cut

sub	_BOX {
	my ($self) = @_;
	
	if ($PerlTk_plot->{_t_min_s4plot}   ne $empty_string && 
		$PerlTk_plot->{_t_max_s4plot}   ne $empty_string &&
		$PerlTk_plot->{_x_min4plot} 	ne $empty_string &&
		$PerlTk_plot->{_x_max4plot} 	ne $empty_string ) {
			
		my $t_min_s	=	$PerlTk_plot->{_t_min_s4plot};
		my $t_max_s	=	$PerlTk_plot->{_t_max_s4plot};
		my $x_min	=	$PerlTk_plot->{_x_min4plot};
		my $x_max	=	$PerlTk_plot->{_x_max4plot};	
				
		$PerlTk_plot->{_BOX}  = [	$t_min_s, $t_max_s, 
			  						$x_min, $x_max
			  					];
			  			
		# print("PerlTk_plot,_BOX: @{$PerlTk_plot->{_BOX}}\n");
		return();
		
	} else {
		print("PerlTk_plot, _BOX, missing value \n");
		return();
	}
}



=head3 sub _VIEWPORT

 	graphng box value limits
 	
=cut

sub	_VIEWPORT {
	my ($self) = @_;
	
	if ($PerlTk_plot->{_viewport_xmin}  ne $empty_string && 
		$PerlTk_plot->{_viewport_xmax}  ne $empty_string &&
		$PerlTk_plot->{_viewport_ymin} 	ne $empty_string &&
		$PerlTk_plot->{_viewport_ymax} 	ne $empty_string ) {
			
		my $viewport_xmin	=	$PerlTk_plot->{_viewport_xmin};
		my $viewport_xmax	=	$PerlTk_plot->{_viewport_xmax};
		my $viewport_ymin	=	$PerlTk_plot->{_viewport_ymin};
		my $viewport_ymax	=	$PerlTk_plot->{_viewport_ymax};	
				
		$PerlTk_plot->{_VIEWPORT}  = [	$viewport_xmin, $viewport_xmax, 
			  						$viewport_ymin, $viewport_ymax
			  						];
			  						
		my $VIEWPORT_aref 			= $PerlTk_plot->{_VIEWPORT};
			  			
		# print("PerlTk_plot,_VIEWPORT: @{$PerlTk_plot->{_VIEWPORT}}\n");
		return($VIEWPORT_aref);
		
	} else {
		print("PerlTk_plot, _VIEWPORT,missing values \n");
		return();
	}
}


=head2 sub _seismic_plot_height

=cut

sub	_seismic_plot_height {
	
	my ($self) = @_;
	
	if ($PerlTk_plot->{_png_page_width}		ne $empty_string  &&
		$PerlTk_plot->{_png_page_height}	ne $empty_string  && 
		$PerlTk_plot->{_viewport_xmin}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_xmax}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_ymin}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_ymax}   	ne $empty_string  	  ) {
					
		my $x_frac_min					= $PerlTk_plot->{_viewport_xmin};
		my $x_frac_max					= $PerlTk_plot->{_viewport_xmax};
		my $y_frac_min					= $PerlTk_plot->{_viewport_ymin};
		my $y_frac_max					= $PerlTk_plot->{_viewport_ymax};
		my $png_page_width				= $PerlTk_plot->{_png_page_width};
		my $png_page_height 			= $PerlTk_plot->{_png_page_height};		
		
		# find out which dimension is smaller
		
		if ($png_page_width <= $png_page_height) {
			
			my $seismic_plot_width      			= $png_page_width * ( 1 - ($x_frac_min + (1-$x_frac_max)) );
			my $seismic_plot_height      			=   $png_page_width/$png_page_height * $seismic_plot_width;			
			$PerlTk_plot->{_seismic_plot_height}	=	$seismic_plot_height;			
			# print("1 PerlTk_plot,_seismic_plot_height, y_offset= $seismic_plot_height\n");
			return($seismic_plot_height);		
					
		} elsif ($png_page_height < $png_page_width) {
			
			my $seismic_plot_height      			= $png_page_height * ( 1 - ($y_frac_min + (1- $y_frac_max)) );
			$PerlTk_plot->{_seismic_plot_height}	= $seismic_plot_height;	
			# print("2 PerlTk_plot,_seismic_plot_height= $seismic_plot_height\n");	
			return($seismic_plot_height);			
		
		} else {
			print("PerlTk_plot,_seismic_plot_height unexpected value \n");
		}		
		
	} else {
		print("PerlTk_plot,_seismic_plot_height missing parameters \n");
	}
	return();
}




=head2 sub _seismic_plot_width

=cut

sub	_seismic_plot_width {
	
	my ($self) = @_;
	
	if ($PerlTk_plot->{_png_page_width}		ne $empty_string  &&
		$PerlTk_plot->{_png_page_height}	ne $empty_string  && 
		$PerlTk_plot->{_viewport_xmin}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_xmax}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_ymin}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_ymax}   	ne $empty_string  	  ) {
					
		my $x_frac_min					= $PerlTk_plot->{_viewport_xmin};
		my $x_frac_max					= $PerlTk_plot->{_viewport_xmax};
		my $y_frac_min					= $PerlTk_plot->{_viewport_ymin};
		my $y_frac_max					= $PerlTk_plot->{_viewport_ymax};
		my $png_page_width				= $PerlTk_plot->{_png_page_width};
		my $png_page_height 			= $PerlTk_plot->{_png_page_height};		
		
		# find out which dimension is smaller
		
		if ($png_page_width <= $png_page_height) {
			
			my $seismic_plot_width      			= $png_page_width * ( 1 - ($x_frac_min + (1-$x_frac_max)) );		
			$PerlTk_plot->{_seismic_plot_width}		= $seismic_plot_width;			
			# print("1 PerlTk_plot,_seismic_plot_width, width= $seismic_plot_width\n");
			return($seismic_plot_width);		
					
		} elsif ($png_page_height < $png_page_width) {
			my $seismic_plot_height					= _seismic_plot_height();
			my $seismic_plot_width      			= $png_page_height/$png_page_width * $seismic_plot_height;			
			$PerlTk_plot->{_seismic_plot_width}		= $seismic_plot_width;		
			# print("2 PerlTk_plot,_seismic_plot_width, width = $seismic_plot_width\n");		
			return($seismic_plot_width);
				
		} else {
			print("PerlTk_plot,_seismic_plot_width unexpected value \n");
		}		
		
	} else {
		print("PerlTk_plot,_seismic_plot_width missing parameters \n");
	}
	return();
}


=head2 sub _seismic_plot_xy_offset

=cut

sub	_seismic_plot_xy_offset {
	
	my ($self) = @_;
	
	if ($PerlTk_plot->{_png_page_width}		ne $empty_string  &&
		$PerlTk_plot->{_png_page_height}	ne $empty_string  && 
#		$PerlTk_plot->{_canvas_width_pix}   ne $empty_string  &&
#		$PerlTk_plot->{_canvas_height_pix}	ne $empty_string  &&
		$PerlTk_plot->{_viewport_xmin}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_xmax}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_ymin}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_ymax}   	ne $empty_string  	  ) {
					
		my $x_frac_min					= $PerlTk_plot->{_viewport_xmin};
		my $x_frac_max					= $PerlTk_plot->{_viewport_xmax};
		my $y_frac_min					= $PerlTk_plot->{_viewport_ymin};
		my $y_frac_max					= $PerlTk_plot->{_viewport_ymax};
		my $png_page_width				= $PerlTk_plot->{_png_page_width};
		my $png_page_height 			= $PerlTk_plot->{_png_page_height};
#		my $canvas_height_pix			= $PerlTk_plot->{_canvas_height_pix};
#		my $canvas_width_pix			= $PerlTk_plot->{_canvas_width_pix};
		my $label_width					= 50; #pixels
		my $label_height				= 50; #pixels		
		
		# find out which dimension is smaller
		
		if ($png_page_width <= $png_page_height) {
			
			my $seismic_plot_width      			= _seismic_plot_width();# $png_page_width * ( 1 - ($x_frac_min + (1-$x_frac_max)) );
			my $seismic_plot_x_offset_pix 				= ($png_page_width - $seismic_plot_width )/2;
			$PerlTk_plot->{_seismic_plot_x_offset_pix}	= $seismic_plot_x_offset_pix;	
			# print("1 PerlTk_plot,_seismic_plot_xy_offset, x_offset= $seismic_plot_x_offset_pix\n");
			
			my $seismic_plot_height      			=   _seismic_plot_height(); #$png_page_width/$png_page_height * $seismic_plot_width;			
			my $seismic_plot_y_offset_pix 				=  ($png_page_height - $seismic_plot_height) /2;
			$PerlTk_plot->{_seismic_plot_y_offset_pix}	=	$seismic_plot_y_offset_pix;			
			# print("1 PerlTk_plot,_seismic_plot_xy_offset, y_offset= $seismic_plot_y_offset_pix\n");			
					
		} elsif ($png_page_height < $png_page_width) {
			
			my $seismic_plot_height      			= _seismic_plot_height(); #$png_page_height * ( 1 - ($y_frac_min + (1- $y_frac_max)) );
			my $seismic_plot_y_offset_pix 	 			= ($png_page_height - $seismic_plot_height)/2;
			$PerlTk_plot->{_seismic_plot_y_offset_pix}	= $seismic_plot_y_offset_pix;	
			# print("2 PerlTk_plot,_seismic_plot_x_offset_pix= $seismic_plot_y_offset_pix\n");	

			my $seismic_plot_width      			=  _seismic_plot_width();#$png_page_height/$png_page_width * $seismic_plot_height;			
			my $seismic_plot_x_offset_pix 				=  ($png_page_width - $seismic_plot_width) /2;
			$PerlTk_plot->{_seismic_plot_x_offset_pix}	=	$seismic_plot_x_offset_pix;			
			# print("2 PerlTk_plot,_seismic_plot_xy_offset, y_offset= $seismic_plot_x_offset_pix\n");
		
		} else {
			print("PerlTk_plot,_seismic_plot_x_offset_pix unexpected value \n");
		}		
		
	} else {
		print("PerlTk_plot,_seismic_plot_x_offset_pix missing parameters \n");
	}
	return();
}

=head2 sub _first_sample_index2plot

=cut


 sub _first_sample_index2plot {
	
	my ($self) = @_;
	
	if ( 
		 $PerlTk_plot->{_t_min_s4plot}			ne $empty_string &&
		 $PerlTk_plot->{_sample_interval_us}  	ne $empty_string && 
		 $PerlTk_plot->{_t_min_s4data}			ne $empty_string 
		  ) {
		
		my $t_min_s4plot 			= $PerlTk_plot->{_t_min_s4plot};
		my $t_min_s					= $PerlTk_plot->{_t_min_s4data};
		my $samples_interval_us 	= $PerlTk_plot->{_sample_interval_us};
	    my $first_sample_index2plot	= ($t_min_s4plot - $t_min_s) ; # * 1000000. / $samples_interval_us;
	    
		$PerlTk_plot->{_first_sample_index2plot} = $first_sample_index2plot;
		
		# print("PerlTk_plot,_first_sample_index2plot: $first_sample_index2plot \n");
		
	} else {
		print("PerlTk_plot,_first_sample_index2plot, missing parameters \n");
	}
	return();
	
}

=head3 sub get_VIEWPORT

 	graphng box value limits
 	
=cut

sub	get_VIEWPORT {
	my ($self) = @_;
	
	_VIEWPORT;
    
    if ($PerlTk_plot->{_VIEWPORT} ne $empty_string) { 
    							
		my $VIEWPORT_aref 			= $PerlTk_plot->{_VIEWPORT};	  			
		print("PerlTk_plot,get_VIEWPORT: @{$PerlTk_plot->{_VIEWPORT}}\n");
		return($VIEWPORT_aref);
		
	} else {
		print("PerlTk_plot, get_VIEWPORT,missing values \n");
		return();
	}
}


=head3 sub get_BOX

 	value limits of graphing box 
 	
=cut

sub	get_BOX {
	my ($self) = @_;
	
	_BOX;
	
	if ($PerlTk_plot->{_BOX}  ne $empty_string ) {
			
		my $BOX_aref = $PerlTk_plot->{_BOX};
			  			
		print("PerlTk_plot,get_BOX, BOX: @{$PerlTk_plot->{_BOX}}\n");
		return($BOX_aref);
		
	} else {
		print("PerlTk_plot,get_BOX missing BOX values\n");
		return();
	}
}


=head2 sub get_bytes_per_sample

=cut

sub	get_bytes_per_sample {
	my ($self) = @_;
	
	if ($PerlTk_plot->{_bytes_per_sample} ne $empty_string ) {
		
		my $bytes = $PerlTk_plot->{_bytes_per_sample};
		# print("PerlTk_plot,get_bytes_per_sample: $bytes \n");
		return($bytes);
		
	} else {
		print("PerlTk_plot,get_bytes_per_sample,missing bytes \n");
		return();
	}
}


#=head3 sub get_formatted_bytes
#
#=cut
#
# sub get_formatted_bytes {
# 	
#	my ($self) = @_;
#	
#	if (
#		 $PerlTk_plot->{_number_of_traces}   		ne $empty_string  &&  
#      	 $PerlTk_plot->{_samples_per_trace} ne $empty_string  &&
#      	 $PerlTk_plot->{_bytes_per_sample}	ne $empty_string     ){	
#      	 	
#      	 my $bytes = $PerlTk_plot->{_data};
#      	 	
#      	 my (@numbers) = unpack ("f", $bytes);
#      	 my $size = scalar @numbers;
#      	 # print("number samples = $size \n");
#      	 	
#	my $dimX                = $num_samples/1999;
#	my $dimY                = $num_samples/64;		
##    	print("PerlTk_plot,get_formatted_bytes, no.samples= $num_samples\n");
##    	print("PerlTk_plot,_get_formatted_bytes, dimX= $dimX, dimY= $dimY\n");
#    	
#		if ( )   {						
#			my $release				=  $PerlTk_plot->{_pdl};			
#			return($release);	
#		
#		} else {
#			print("PerlTk_plot, get_formatted_bytes, missing PerlTk_plot->{_pdl} \n");
#			return();
#	}
# }
# Main guis can not be subbed


sub	get_gui_positionNsize{
	my ($self) = @_;
	
	if ($PerlTk_plot->{_mw_width}  		ne $empty_string && 
		$PerlTk_plot->{_mw_height}  	ne $empty_string &&
		$PerlTk_plot->{_box_X0_pix} 	ne $empty_string &&
		$PerlTk_plot->{_box_Y0_pix}  	ne $empty_string ) {
			
		my $mw_width					= $PerlTk_plot->{_mw_width};
		my $mw_height					= $PerlTk_plot->{_mw_height};
		my $box_X0_pix					= $PerlTk_plot->{_box_X0_pix};
		my $box_Y0_pix					= $PerlTk_plot->{_box_Y0_pix};	
		$PerlTk_plot->{_gui_positionNsize}  = $mw_width.'x'.$mw_height.'+'.$box_X0_pix.'+'.$box_Y0_pix;
			  						
		my $gui_positionNsize 			= $PerlTk_plot->{_gui_positionNsize};
			  			
		# print("PerlTk_plot,_get_gui_positionNsize $PerlTk_plot->{_gui_positionNsize} \n");
		return($gui_positionNsize);
		
	} else {
		print("PerlTk_plot, get_gui_positionNsize,missing values \n");
		return();
	}
}


=head2 sub get_number_of_traces

=cut

sub	get_number_of_traces {
	my ($self) = @_;
	
	if ($PerlTk_plot->{_number_of_traces}  ne $empty_string ) {
		
		my $number_of_traces = $PerlTk_plot->{_number_of_traces};
		# print("PerlTk_plot,get_number_of_traces: $number_of_traces \n");
		return($number_of_traces );
		
	} else {
		print("PerlTk_plot,missing number_of_traces \n");
	}

}


=head2 sub get_sample_interval_us

=cut

sub	get_sample_interval_us {
	my ($self) = @_;
	
	if ($PerlTk_plot->{_sample_interval_us} ne $empty_string ) {
		
		my $sample_interval_us = $PerlTk_plot->{_sample_interval_us};
		# print("PerlTk_plot,get_sample_interval_us: $sample_interval_us \n");
		return($sample_interval_us);
		
	} else {
		print("PerlTk_plot,missing sample_interval_us \n");
	}

}


=head2 sub get_samples_per_trace

=cut

sub	get_samples_per_trace {
	my ($self) = @_;
	
	if ($PerlTk_plot->{_samples_per_trace}  ne $empty_string ) {
		
		my $samples_per_trace = $PerlTk_plot->{_samples_per_trace} ;
		# print("PerlTk_plot,get_samples_per_trace: $samples_per_trace\n");
		return($samples_per_trace);
		
	} else {
		print("PerlTk_plot,missing samples_per_trace\n");
	}

}



=head2 sub get_seismic_plot_height

=cut

sub	get_seismic_plot_height {
	
	my ($self) = @_;
	
	if ($PerlTk_plot->{_png_page_width}		ne $empty_string  &&
		$PerlTk_plot->{_png_page_height}	ne $empty_string  && 
		$PerlTk_plot->{_viewport_xmin}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_xmax}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_ymin}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_ymax}   	ne $empty_string  	  ) {
					
		my $x_frac_min					= $PerlTk_plot->{_viewport_xmin};
		my $x_frac_max					= $PerlTk_plot->{_viewport_xmax};
		my $y_frac_min					= $PerlTk_plot->{_viewport_ymin};
		my $y_frac_max					= $PerlTk_plot->{_viewport_ymax};
		my $png_page_width				= $PerlTk_plot->{_png_page_width};
		my $png_page_height 			= $PerlTk_plot->{_png_page_height};		
		
		# find out which dimension is smaller
		if ($png_page_width <= $png_page_height) {
			
			my $seismic_plot_width      			= $png_page_width * ( 1 - ($x_frac_min + (1-$x_frac_max)) );
			my $seismic_plot_height      			= $png_page_width/$png_page_height * $seismic_plot_width;			
			$PerlTk_plot->{_seismic_plot_height}	= $seismic_plot_height;			
			# print("1 PerlTk_plot,get_seismic_plot_height, y_offset= $seismic_plot_height\n");
			return($seismic_plot_height);		
					
		} elsif ($png_page_height < $png_page_width) {
			
			my $seismic_plot_height      			= $png_page_height * ( 1 - ($y_frac_min + (1- $y_frac_max)) );
			$PerlTk_plot->{_seismic_plot_height}	= $seismic_plot_height;	
			# print("2 PerlTk_plot,get_seismic_plot_height= $seismic_plot_height\n");	
			return($seismic_plot_height);			
		
		} else {
			print("PerlTk_plot,get_seismic_plot_height unexpected value \n");
		}		
		
	} else {
		print("PerlTk_plot,get_seismic_plot_height missing parameters \n");
	}
	return();
}




=head2 sub get_seismic_plot_width

=cut

sub	get_seismic_plot_width {
	
	my ($self) = @_;
	
	if ($PerlTk_plot->{_png_page_width}		ne $empty_string  &&
		$PerlTk_plot->{_png_page_height}	ne $empty_string  && 
		$PerlTk_plot->{_viewport_xmin}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_xmax}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_ymin}   	ne $empty_string  &&
		$PerlTk_plot->{_viewport_ymax}   	ne $empty_string  	  ) {
					
		my $x_frac_min					= $PerlTk_plot->{_viewport_xmin};
		my $x_frac_max					= $PerlTk_plot->{_viewport_xmax};
		my $y_frac_min					= $PerlTk_plot->{_viewport_ymin};
		my $y_frac_max					= $PerlTk_plot->{_viewport_ymax};
		my $png_page_width				= $PerlTk_plot->{_png_page_width};
		my $png_page_height 			= $PerlTk_plot->{_png_page_height};		
		
		# find out which dimension is smaller
		
		if ($png_page_width <= $png_page_height) {
			
			my $seismic_plot_width      			= $png_page_width * ( 1 - ($x_frac_min + (1-$x_frac_max)) );		
			$PerlTk_plot->{_seismic_plot_width}		= $seismic_plot_width;			
			# print("1 PerlTk_plot,get_seismic_plot_width, width= $seismic_plot_width\n");
			return($seismic_plot_width);		
					
		} elsif ($png_page_height < $png_page_width) {
			my $seismic_plot_height					= _seismic_plot_height();
			my $seismic_plot_width      			= $png_page_height/$png_page_width * $seismic_plot_height;			
			$PerlTk_plot->{_seismic_plot_width}		= $seismic_plot_width;		
			# print("2 PerlTk_plot,get_seismic_plot_width, width = $seismic_plot_width\n");		
			return($seismic_plot_width);
				
		} else {
			print("PerlTk_plot,get_seismic_plot_width unexpected value \n");
		}		
		
	} else {
		print("PerlTk_plot,get_seismic_plot_width missing parameters \n");
	}
	return();
}


=head2 sub get_seismic_plot_x_offset_pix

=cut

sub	get_seismic_plot_x_offset_pix {
	
	my ($self) = @_;
			
	_seismic_plot_xy_offset;	


	if ($PerlTk_plot->{_seismic_plot_x_offset_pix}  ne $empty_string ) {		

		my $seismic_plot_x_offset_pix 	= $PerlTk_plot->{_seismic_plot_x_offset_pix}; 
		
		# print("PerlTk_plot,get_seismic_plot_x_offset_pix: $seismic_plot_x_offset_pix\n");
		return($seismic_plot_x_offset_pix);
		
	} else {
		print("PerlTk_plot,get_seismic_plot_x_offset_pix missing parameters \n");
	}

}


=head2 sub get_seismic_plot_y_offset_pix

=cut

sub	get_seismic_plot_y_offset_pix {
	
	my ($self) = @_;
			
	_seismic_plot_xy_offset;	


	if ($PerlTk_plot->{_seismic_plot_y_offset_pix}  ne $empty_string ) {		

		my $seismic_plot_y_offset_pix 	= $PerlTk_plot->{_seismic_plot_y_offset_pix}; 
		
		# print("PerlTk_plot,get_seismic_plot_y_offset_pix: $seismic_plot_y_offset_pix\n");
		return($seismic_plot_y_offset_pix);
		
	} else {
		print("PerlTk_plot,get_seismic_plot_y_offset_pix missing parameters \n");
	}

}



#sub read_bytes {
#	
#	my ($self) = @_;
#	
#	if ( $PerlTk_plot->{_inbound_base_file_name} 	ne $empty_string  &&
#	 	 $PerlTk_plot->{_inbound_file_path} 		ne $empty_string  &&
#		 $PerlTk_plot->{_number_of_traces}   				ne $empty_string  &&
#      	 $PerlTk_plot->{_samples_per_trace}  		ne $empty_string  &&
#      	 $PerlTk_plot->{_bytes_per_sample}			ne $empty_string     ){
#      	 	
#    	use autodie; 	 	
#      	my $num_samples = 1;# $PerlTk_plot->{_samples_per_trace};
#      	
#     	# Open the file 
#		my $file = $PerlTk_plot->{_inbound_file_path}.$PerlTk_plot->{_inbound_base_file_name};
#	
#		# set stream to binary mode
#		open my $fh, '<:raw', $file;
# 
#		my $sample; # read buffer
#		my ($ampl, $nbytes);
#		my $Bite_size = $PerlTk_plot->{_bytes_per_sample};
#		
#		while ( ($nbytes = read $fh, $sample, $Bite_size)){
#	
##		while (<$fh>) {
##			($a) = sscanf("%d+%d %f-%s", $input);
#		 		 	
#    		# ...and unpack() them as a single float 
#        	$ampl = unpack("c", $sample);
#            # print "sample = $ampl\n";
#  			
#        }      	
#    	close $fh;
#    	print "DONE\n";
#    	$PerlTk_plot->{_data} = $ampl;
#    	
#     } else {
#     	print ("PerlTk_plot, read_bytes, missing hash values \n");
#     }
#}
#
#


=head2 sub set_ampls

=cut

sub	set_ampls {
	
	my ($self, $ampls) = @_;
	
	use PDL::Core;
	use PDL::Basic;
	use PDL::NiceSlice;
	# ne $empty_string;
	# if ($ampls ) {
		
		$PerlTk_plot->{_ampls} = $ampls;
		# print("PerlTk_plot,set_ampls: $ampls\n");
		return();
		
	#} else {
	#	print("PerlTk_plot,set_ampls, missing ampls\n");
	#}

}


=head2 sub set_base_file_name

=cut

sub	set_base_file_name {
	my ($self, $bytes) = @_;
	
	if ($bytes ne $empty_string ) {
		
		$PerlTk_plot->{_base_file_name} = $bytes;
		# print("PerlTk_plot,set_base_file_name: $bytes \n");
		return();
		
	} else {
		print("PerlTk_plot,missing bytes \n");
	}

}


=head2 sub set_box_X0_pix

=cut

sub	set_box_X0_pix {
	my ($self, $X0_pix) = @_;
	
	if ($X0_pix ne $empty_string ) {
		
		$PerlTk_plot->{_box_X0_pix} = $X0_pix;
		# print("PerlTk_plot,set_box_X0_pix: $X0_pix \n");
		return();
		
	} else {
		print("PerlTk_plot,set_box_X0_pix, missing  box_X0_pix\n");
	}

}

=head2 sub set_box_Y0_pixe

=cut

sub	set_box_Y0_pix {
	my ($self, $Y0_pix) = @_;
	
	if ($Y0_pix ne $empty_string ) {
		
		$PerlTk_plot->{_box_Y0_pix} = $Y0_pix;
		# print("PerlTk_plot,set_box_Y0_pix: $Y0_pix \n");
		return();
		
	} else {
		print("PerlTk_plot,set_box_Y0_pix, missing  box_Y0_pix\n");
	}

}


=head2 sub set_bytes_per_sample

=cut

sub	set_bytes_per_sample {
	my ($self, $bytes) = @_;
	
	if ($bytes ne $empty_string ) {
		
		$PerlTk_plot->{_bytes_per_sample} = $bytes;
		# print("PerlTk_plot,set_bytes_per_sample: $bytes \n");
		return();
		
	} else {
		print("PerlTk_plot,missing bytes \n");
	}

}


=head2 sub set_canvas_height_pix

=cut

sub	set_canvas_height_pix {
	my ($self, $height) = @_;
	
	if ($height ne $empty_string ) {
		
		$PerlTk_plot->{_canvas_height_pix} = $height;
		# print("PerlTk_plot,set_canvas_height_pix: $height \n");
		return();
		
	} else {
		print("PerlTk_plot, set_canvas_height_pix, missing height \n");
	}

}


=head2 sub set_canvas_width_pix

=cut

sub	set_canvas_width_pix {
	my ($self, $width) = @_;
	
	if ($width ne $empty_string ) {
		
		$PerlTk_plot->{_canvas_width_pix} = $width;
		# print("PerlTk_plot,set_canvas_width_pix: $width \n");
		return();
		
	} else {
		print("PerlTk_plot, set_canvas_width_pix, missing width \n");
	}

}


=head2 sub set_dx

=cut

sub	set_dx {
	my ($self, $dx) = @_;
	
	if ($dx ne $empty_string ) {
		
		$PerlTk_plot->{_dx} = $dx;
		print("PerlTk_plot,set_dx: $dx \n");
		return();
		
	} else {
		print("PerlTk_plot,missing dx \n");
	}

}

=head2 sub set_first_t_s4data

=cut

sub	set_first_t_s4data {
	my ($self, $bytes) = @_;
	
	if ($bytes ne $empty_string ) {
		
		$PerlTk_plot->{_first_t_s4data} = $bytes;
		# print("PerlTk_plot,set_first_t_s4data: $bytes \n");
		return();
		
	} else {
		print("PerlTk_plot,missing bytes \n");
	}

}
 
 
=head2 sub set_first_t_s4plot

=cut

sub	set_first_t_s4plot {
	my ($self, $bytes) = @_;
	
	if ($bytes ne $empty_string ) {
		
		$PerlTk_plot->{_first_t_s4plot} = $bytes;
		# print("PerlTk_plot,set_first_t_s4plot: $bytes \n");
		return();
		
	} else {
		print("PerlTk_plot,missing bytes \n");
	}

}


=head2 sub set_first_x4data

=cut

sub	set_first_x4data {
	my ($self, $first_x) = @_;
	
	if ($first_x ne $empty_string ) {
		
		$PerlTk_plot->{_first_x4data} = $first_x;
		# print("PerlTk_plot,set_first_x4data: $first_x \n");
		return();
		
	} else {
		print("PerlTk_plot,missing first_x \n");
	}

}
 
 
=head2 sub set_first_x4plot

=cut

sub	set_first_x4plot {
	my ($self, $first_x4plot) = @_;
	
	if ($first_x4plot ne $empty_string ) {
		
		$PerlTk_plot->{_first_x4plot} = $first_x4plot;
		print("PerlTk_plot,set_first_x4plot: $first_x4plot \n");
		return();
		
	} else {
		print("PerlTk_plot,set_first_x4plot, missing first_x4plot \n");
	}

}	


=head2 sub set_inbound_base_file_name

=cut

sub	set_inbound_base_file_name {
	my ($self, $file_name) = @_;
	
	if ($file_name ne $empty_string ) {
		
		$PerlTk_plot->{_inbound_base_file_name} = $file_name;
		# print("PerlTk_plot,set_inbound_base_file_name: $file_name \n");
		return();
		
	} else {
		print("PerlTk_plot,missing file_name \n");
	}

}


=head2 set_inbound_binary_format

=cut

sub	set_inbound_binary_format {
	my ($self, $inbound_binary_format) = @_;
	
	if ($inbound_binary_format ne $empty_string) {
		
		$PerlTk_plot->{_inbound_binary_format} = $inbound_binary_format;
		print("PerlTk_plot,set_inbound_binary_format: $inbound_binary_format\n");
		
	} else {
		print("PerlTk_plot, missing inbound_binary_format\n");
	}
	return();
}

=head2 sub set_inbound_file_path

=cut

sub	set_inbound_file_path {
	my ($self, $path) = @_;
	
	if ($path ne $empty_string ) {
		
		$PerlTk_plot->{_inbound_file_path} = $path;
		# print("PerlTk_plot,set_inbound_file_path: $path \n");
		return();
		
	} else {
		print("PerlTk_plot,missing path \n");
	}

}


=head2 sub set_inbound_parameter_file_name

=cut

sub	set_inbound_parameter_file_name {
	my ($self, $parameter_file_name) = @_;
	
	if ($parameter_file_name ne $empty_string ) {
		
		$PerlTk_plot->{_inbound_parameter_file_name} = $parameter_file_name;
		# print("PerlTk_plot,set_inbound_parameter_file_name: $parameter_file_name \n");
		return();
		
	} else {
		print("PerlTk_plot,missing parameter_file_name \n");
	}

}


=head2 sub set_inbound_parameter_file_path

=cut

sub	set_inbound_parameter_file_path {
	my ($self, $parameter_file_path) = @_;
	
	if ($parameter_file_path ne $empty_string ) {
		
		$PerlTk_plot->{_inbound_parameter_file_path} = $parameter_file_path;
		# print("PerlTk_plot,set_inbound_parameter_file_path: $parameter_file_path \n");
		return();
		
	} else {
		print("PerlTk_plot,missing parameter_file_path \n");
	}

}


=head2 sub set_inbound_suffix_type

=cut

sub	set_inbound_suffix_type {
	my ($self, $suffix_type) = @_;
	
	if ($suffix_type ne $empty_string ) {
		
		$PerlTk_plot->{_inbound_suffix_type} = $suffix_type;
		# print("PerlTk_plot,set_inbound_suffix_type: $suffix_type \n");
		return();
		
	} else {
		print("PerlTk_plot,missing suffix_type \n");
	}

}


=head2 sub set_last_t_s4plot

=cut

sub	set_last_t_s4plot {
	my ($self, $bytes) = @_;
	
	if ($bytes ne $empty_string ) {
		
		$PerlTk_plot->{_last_t_s4plot} = $bytes;
		# print("PerlTk_plot,set_last_t_s4plot: $bytes \n");
		return();
		
	} else {
		print("PerlTk_plot,missing bytes \n");
	}

} 	

 
=head2 sub set_last_x4plot

=cut

sub	set_last_x4plot {
	my ($self, $bytes) = @_;
	
	if ($bytes ne $empty_string ) {
		
		$PerlTk_plot->{_last_x4plot} = $bytes;
		# print("PerlTk_plot,set_last_x4plot: $bytes \n");
		return();
		
	} else {
		print("PerlTk_plot,missing bytes \n");
	}

}
=head2 sub set_mw_height

=cut

sub	set_mw_height {
	my ($self, $mw_height) = @_;
	
	if ($mw_height ne $empty_string ) {
		
		$PerlTk_plot->{_mw_height} = $mw_height;
		# print("PerlTk_plot,set_mw_height: $mw_height \n");
		return();
		
	} else {
		print("PerlTk_plot,missing mw_height \n");
	}

}


=head2 sub set_mw_width

=cut

sub	set_mw_width {
	my ($self, $mw_width) = @_;
	
	if ($mw_width ne $empty_string ) {
		
		$PerlTk_plot->{_mw_width} = $mw_width;
		# print("PerlTk_plot,set_mw_width: $mw_width \n");
		return();
		
	} else {
		print("PerlTk_plot,missing mw_width \n");
	}

}


=head2 sub set_number_of_traces

=cut

sub	set_number_of_traces {
	my ($self, $number_of_traces) = @_;
	
	if ($number_of_traces ne $empty_string ) {
		
		$PerlTk_plot->{_number_of_traces} = $number_of_traces;
		# print("PerlTk_plot,set_number_of_traces: $number_of_traces \n");
		return();
		
	} else {
		print("PerlTk_plot,missing number_of_traces \n");
	}
}


=head2 sub set_pdl

=cut

sub	set_pdl {
	my ($self, $pdl) = @_;
	
	if (nelem($pdl) != 0 ) {
		
		$PerlTk_plot->{_pdl} = $pdl;
		# print("PerlTk_plot,set_pdl: $pdl \n");
		return();
		
	} else {
		print("PerlTk_plot,missing pdl \n");
	}
}


=head2 sub set_pl_plot
    within a device plotting area:
    DEV 				=> 'xwin',  
    or to a file, -- se below
=cut

sub	set_pl_plot {
	my ($self) = @_;

	_VIEWPORT;
	_BOX;
	
		
	if ($PerlTk_plot->{_png_page_width}  ne $empty_string && 
		$PerlTk_plot->{_png_page_height} ne $empty_string ) {
			
		use PDL::Graphics::PLplot;
		use PDL::IO::Pic;		
		$PerlTk_plot->{_pl} = PDL::Graphics::PLplot->new (
					DEV 				=> 'png', 
					FILE				=> "test.png",
					ORIENTATION			=> 1,
					PAGESIZE 			=> [$PerlTk_plot->{_png_page_width},
										$PerlTk_plot->{_png_page_height}
										   ],
					VIEWPORT 			=> $PerlTk_plot->{_VIEWPORT},								   
					OPTS 				=> {Font => 'Italic'},
					BOX 				=> $PerlTk_plot->{_BOX},
				);	

		# print("PerlTk_plot,set_pl_plot\n");
		return();		
	} else {
		print("PerlTk_plot,set_pl_plot, missing png page dimensions\n");				
	}

}



=head2 sub set_png_page_height

=cut

sub	set_png_page_height{
	my ($self, $png_page_height) = @_;
	
	if ($png_page_height ne $empty_string ) {
		
		$PerlTk_plot->{_png_page_height} = $png_page_height;
		# print("PerlTk_plot,set_png_page_height: $png_page_height \n");
		return();
		
	} else {
		print("PerlTk_plot,missing png_page_height \n");
	}

}


=head2 sub set_png_page_width

=cut

sub	set_png_page_width{
	my ($self, $png_page_width) = @_;
	
	if ($png_page_width ne $empty_string ) {
		
		$PerlTk_plot->{_png_page_width} = $png_page_width;
		# print("PerlTk_plot,set_png_page_width: $png_page_width \n");
		return();
		
	} else {
		print("PerlTk_plot,missing png_page_width \n");
	}

}



=head2 sub set_sample_increment_index 

=cut

sub	set_sample_increment_index  {
	my ($self, $sample_increment_index) = @_;
	
	if ($sample_increment_index ne $empty_string ) {
		
		$PerlTk_plot->{_sample_increment_index } = $sample_increment_index;
		# print("PerlTk_plot,set_sample_increment_index : $sample_increment_index \n");
		return();
		
	} else {
		print("PerlTk_plot,missing sample_increment_index \n");
	}

}


=head2 sub set_sample_interval_us

=cut

sub	set_sample_interval_us {
	my ($self, $sample_interval_us) = @_;
	
	if ($sample_interval_us ne $empty_string ) {
		
		$PerlTk_plot->{_sample_interval_us} = $sample_interval_us;
		# print("PerlTk_plot,set_sample_interval_us: $sample_interval_us \n");
		return();
		
	} else {
		print("PerlTk_plot,missing sample_interval_us \n");
	}

}


=head2 sub set_samples_per_trace

=cut

sub	set_samples_per_trace {
	my ($self, $num_samples) = @_;
	
	if ($num_samples ne $empty_string ) {
		
		$PerlTk_plot->{_samples_per_trace} = $num_samples;
		# print("PerlTk_plot,set_samples_per_trace: $num_samples \n");
		return();
		
	} else {
		print("PerlTk_plot,missing num_samples \n");
	}

}


=head2 sub set_t_max_s4data

=cut

sub	set_t_max_s4data {
	my ($self, $t_max_s) = @_;
	
	if ($t_max_s ne $empty_string ) {
		
		$PerlTk_plot->{_t_max_s4data} = $t_max_s;
		# print("PerlTk_plot,set_t_max_s4data: $t_max_s \n");
		return();
		
	} else {
		print("PerlTk_plot,set_t_max_s4data, missing t_max_s \n");
	}

}


=head2 sub set_t_max_s4plot

=cut

sub	set_t_max_s4plot {
	my ($self, $t_max_s) = @_;
	
	if ($t_max_s ne $empty_string ) {
		
		$PerlTk_plot->{_t_max_s4plot} = $t_max_s;
		# print("PerlTk_plot,set_t_max_s4plot: $t_max_s \n");
		return();
		
	} else {
		print("PerlTk_plot,set_t_max_s4plot , missing t_max_s \n");
	}

}


=head2 sub set_t_min_s4data

=cut

sub	set_t_min_s4data {
	my ($self, $t_min_s) = @_;
	
	if ($t_min_s ne $empty_string ) {
		
		$PerlTk_plot->{_t_min_s4data} = $t_min_s;
		# print("PerlTk_plot,set_t_min_s4data: tmin_s= $t_min_s \n");
		return();
		
	} else {
		print("PerlTk_plot,set_t_min_s4data, missing t_min_s \n");
	}

}


=head2 sub set_t_min_s4plot

=cut

sub	set_t_min_s4plot {
	my ($self, $t_min_s) = @_;
	
	if ($t_min_s 								ne $empty_string ) {
		
		$PerlTk_plot->{_t_min_s4plot} = $t_min_s;	
		# print("PerlTk_plot,set_t_min_s4plot: t_min_s= $t_min_s \n");
		
	} else {
		print("PerlTk_plot,set_t_min_s4plot, missing t_min_s \n");
	}
	return();
}


=head2 sub set_x_increment

=cut

sub	set_x_increment {
	my ($self, $x_increment) = @_;
	
	if ($x_increment ne $empty_string ) {
		
		$PerlTk_plot->{_x_increment} = $x_increment;
		# print("PerlTk_plot,set_x_increment: $x_increment \n");
		return();
		
	} else {
		print("PerlTk_plot,missing x_increment \n");
	}

}


=head2 sub set_x_label

=cut

sub	set_x_label {
	my ($self, $x_label) = @_;
	
	if ($x_label ne $empty_string ) {
		
		$PerlTk_plot->{_x_label} = $x_label;
		# print("PerlTk_plot,set_x_label: $x_label \n");
		return();
		
	} else {
		print("PerlTk_plot,missing x_label \n");
	}

}


=head2 sub set_x_max4data

=cut

sub	set_x_max4data {
	my ($self, $x_max) = @_;
	
	if ($x_max ne $empty_string ) {
		
		$PerlTk_plot->{_x_max4data} = $x_max;
		# print("PerlTk_plot,set_x_max4data: $x_max \n");
		return();
		
	} else {
		print("PerlTk_plot, set_x_max4data, missing set_x_max4data, x_max\n");
	}

}


=head2 sub set_x_max4plot

=cut

sub	set_x_max4plot {
	my ($self, $x_max) = @_;
	
	if ($x_max ne $empty_string ) {
		
		$PerlTk_plot->{_x_max4plot} = $x_max;
		# print("PerlTk_plot,set_x_max4plot: $x_max \n");
		return();
		
	} else {
		print("PerlTk_plot, set_x_max4plot, missing set_x_max4plot, x_max\n");
	}

}



=head2 sub set_x_min4data

=cut

sub	set_x_min4data {
	my ($self, $x_min) = @_;
	
	if ($x_min ne $empty_string ) {
		
		$PerlTk_plot->{_x_min4data} = $x_min;
		# print("PerlTk_plot,set_x_min4data: $x_min \n");
		return();
		
	} else {
		print("PerlTk_plot,missing x_min \n");
	}

}


=head2 sub set_x_min4plot

=cut

sub	set_x_min4plot {
	my ($self, $x_min) = @_;
	
	if ($x_min ne $empty_string ) {
		
		$PerlTk_plot->{_x_min4plot} = $x_min;
		# print("PerlTk_plot,set_x_min4plot: $x_min \n");
		return();
		
	} else {
		print("PerlTk_plot,missing x_min \n");
	}

}

=head2 sub set_y_label

=cut

sub	set_y_label {
	my ($self, $y_label) = @_;
	
	if ($y_label ne $empty_string ) {
		
		$PerlTk_plot->{_y_label} = $y_label;
		# print("PerlTk_plot,set_y_label: $y_label \n");
		return();
		
	} else {
		print("PerlTk_plot,missing y_label \n");
	}

}





=head3 sub wiggle_png

		create matrix of time arrays
		bias/shift values each array of amplitudes so as to fit many wiggles on the same plot
		create a full wiggle plot
=cut 

 sub wiggle_png {
 	my (@self) = @_;
 	
 	if (
  		$PerlTk_plot->{_x_min4data} 			ne $empty_string  &&
 		$PerlTk_plot->{_x_max4data}				ne $empty_string  &&	
 		$PerlTk_plot->{_x_min4plot} 			ne $empty_string  &&
 		$PerlTk_plot->{_x_max4plot}				ne $empty_string  &&
		$PerlTk_plot->{_t_min_s4data}			ne $empty_string  &&
		$PerlTk_plot->{_t_max_s4plot}			ne $empty_string  &&
		$PerlTk_plot->{_t_min_s4plot}			ne $empty_string  &&
		$PerlTk_plot->{_t_max_s4data}			ne $empty_string  &&			
 		$PerlTk_plot->{_samples_per_trace} 		ne $empty_string  &&
 		$PerlTk_plot->{_sample_increment_index} ne $empty_string  &&
  		$PerlTk_plot->{_x_increment}			ne $empty_string  &&
   		$PerlTk_plot->{_x_label}				ne $empty_string  &&
   		$PerlTk_plot->{_y_label}				ne $empty_string  &&  		 		
 		nelem($PerlTk_plot->{_ampls}) 			!= 0 		
 		) {		
 	
 		use PDL::Core;
		use PDL::Basic;
		use PDL::NiceSlice;
 
 		# print ("PerlTk_plot, wiggle_png samples_per_trace $PerlTk_plot->{_samples_per_trace}\n");
 		my $pl						= $PerlTk_plot->{_pl};
		my $ampls					= $PerlTk_plot->{_ampls};
		my $x_label					= $PerlTk_plot->{_x_label};
		my $y_label					= $PerlTk_plot->{_y_label};	
		my $first_x4data			= $PerlTk_plot->{_x_min4data};
		my $first_x4plot			= $PerlTk_plot->{_x_min4plot};
		my $last_x4data				= $PerlTk_plot->{_x_max4data};
		my $last_x4plot				= $PerlTk_plot->{_x_max4plot};
		my $first_t_s4plot			= $PerlTk_plot->{_t_min_s4plot};
		my $last_t_s4plot			= $PerlTk_plot->{_t_max_s4plot};
		my $first_t_s4data			= $PerlTk_plot->{_t_min_s4data};
		my $last_t_s4data			= $PerlTk_plot->{_t_max_s4data};		
		my $sample_increment_index 	= $PerlTk_plot->{_sample_increment_index};
		my $samples_per_trace2plot	= $PerlTk_plot->{_samples_per_trace};	
		my $x_increment				= $PerlTk_plot->{_x_increment};	

		_first_sample_index2plot();
		my $first_sample_index2plot  = $PerlTk_plot->{_first_sample_index2plot};
		
		# _last_sample_index2plot();
		# my $last_sample_index2plot  = $PerlTk_plot->{_last_sample_index2plot};		
			
		my $last_sample_index2plot   = $samples_per_trace2plot -1;	
		my $first_trace_number2plot	 = $first_x4plot;		
		my $first_trace_index2plot   = $first_trace_number2plot-1;
		my $last_trace_number2plot	 = $last_x4plot;
		my $last_trace_index2plot    = $last_trace_number2plot-1;

		$first_x4plot				= $first_trace_number2plot;
		$last_x4plot				= $last_trace_number2plot;
		my $number_of_traces2plot   = 1 + ($last_trace_number2plot - $first_trace_number2plot ) / $x_increment;
	
		# print ("number_of_traces2plot $number_of_traces2plot\n");
		# create amplitude matrix
		my $amplitudes          	= slice $ampls($first_sample_index2plot:$last_sample_index2plot,
												$first_trace_index2plot:$last_trace_index2plot);
		my @dims_amplitudes  		= dims $amplitudes;
		# print("PerlTk_plot, wiggle_png, dims_amplitudes = @dims_amplitudes\n");
    	# print ("PerlTk_plot, wiggle_png, amplitudes $amplitudes\n");
    
    	# create a matrix of bias/shift values
   		my $ampl_shift				= ones($samples_per_trace2plot,$number_of_traces2plot) 
    									->ylinvals($first_x4plot,$last_x4plot);
    									  									
    	my @dims_ampl_shift 		= dims $ampl_shift;
 	 	
 		my $t2plot 					= zeros($samples_per_trace2plot,$number_of_traces2plot)
    									->xlinvals($first_t_s4plot,$last_t_s4plot);
    								
		my $amplitudes2plot 		= ($amplitudes + $ampl_shift);
		# print ("PerlTk_plot, x_label = $x_label, y_label = $y_label\n");
		
		# my $start_plot_time = time;
			# 100 plots in 5 s
		#	for (my $i=0; $i<100; $i++ ) {
			
		# TODO: plot some wiggles as black and others as another color
		$pl 					->xyplot($t2plot,
 	    							$amplitudes2plot,
 	    			 				YLAB 		=> $y_label,
 	    					 		XLAB 		=> $x_label, 
 	    					 		COLOR		=> 'BLUE',	    								
 	    						);
		#	}
		# my $end_plot_time = time;
	
		# my $total_plot_time = $end_plot_time - $start_plot_time;
		#	print("Execution time for plotting 100 xyplots= $total_plot_time s\n");			    
		# create plot
		$pl->close();
		#		 my $duration2 = time - $start2;
		#       print "Execution time: 10 xyplots= $duration2 s\n";	
 		
 		
 	} else {
 		print("PerlTk_plot, wiggle_plot values missing\n");
 		
 	}
 
 }

1;
