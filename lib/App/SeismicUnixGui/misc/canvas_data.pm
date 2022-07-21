package App::SeismicUnixGui::misc::canvas_data;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: canvas_data.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		February 1 2019 

 DESCRIPTION 
    
    Manage data values selected by user
    on canvas image
    Data are returned from a matrix held as a PDL file.

 BASED ON:

  

=cut

=head2 USE

	PerlTk plotting libraries
	PDL
	and PLplot libraries via PDL

=head3 NOTES
	uses pixel-centered geometries
    
=head4 Examples


=head2 CHANGES and their DATES


=cut 

=head3 Notes 
Put left-top corner (nw)image (nw)
	in NW corner of canvas (x= 0,y =0)
	canvas X co-ordinates increase Left-to-Right
	Canvas co-ordiantes increase Top-to-bottom
	
			 =	-669    at 1500 pixels seismic page width   500 pixels high
	top-left- = -496    at 1200 pixels seismic page width  500 pixels high
			 = -376		at 1000 pixels seismic page width  500 pixels high
			 =  -300    at 900 pixels seismic page width   500 pixels high		 		 
			 =  -243    at 800 pixels seismic page width   500 pixels high
			 =  -207 	at 750 pixels seismic page width   500 pixels high 
			 =  -171 	at 700 pixels seismic page width   500 pixels high 			 		 			 		 
			 =  -92     at 600 pixels seismic page width   500 pixels high
			 =  0       at 500 pixels seismic page width   500 pixels high
			 	
			 =  -470    at 1000 pixels seismic page width 250 pixels high
			 =  -414    at 900 pixels seismic page width  250 pixels high			 
			 =  -250    at 600 pixels seismic page width  250 pixels high
			 =   0      at 250 pixels seismic page width  250 pixels high

			 =	-669   at 500 pixels seismic page width  1500 pixels high

			 =   0     at 300 pixels seismic page width  300 pixels high	

=cut

=head2 privatge hash
 	with impotant key/value pairs

=cut 

my $canvas_data = {
    _BOX                       => '',
    _VIEWPORT                  => '',
    _canvas_height             => '',
    _canvas_width              => '',
    _seismic_plot_height       => '',
    _seismic_plot_width        => '',
    _seismic_plot_x_offset_pix => '',
    _seismic_plot_y_offset_pix => '',
    _time_col_num              => '',
    _trace_row_index           => '',
    _time_col_index            => '',
    _time_s                    => '',
    _trace_row_num             => '',
    _t_min_s                   => '',
    _t_max_s                   => '',
    _widget                    => '',
    _x                         => '',
    _x_min                     => '',
    _x_max                     => '',
    _x_offset                  => '',
    _x_pix                     => '',
    _y                         => '',
    _y_offset                  => '',
    _y_pix                     => '',
};

use Moose;
use PDL::Core;
use PDL::Basic;
use PDL::NiceSlice;
use App::SeismicUnixGui::misc::L_SU_global_constants;
my $get          = new L_SU_global_constants();
my $var          = $get->var();
my $empty_string = $var->{_empty_string};

#=head2 sub _get_canvas_height
#
#
#=cut
#
# sub _get_canvas_height{
#
#	my ( $self)		= @_;
#	if ( $canvas_data->{_widget} ne $empty_string ) {
#		# print("canvas_data, _get_canvas_height = $canvas_data->{_widget}\n");
#		# use Tk::Pretty;
#		my $canvas_data->{_canvas_height}	= $canvas_data->{_widget} -> cget(-height);
#		my $result 							= $canvas_data->{_canvas_height};
#		# print("canvas_data, _get_canvas_height=$result pixels\n");
#		# my $temp = $canvas_data->{_widget};
##		my @config =$temp->configure;
##		print Pretty @config;
#
#		return($result);
#
#	} else {
#		print("canvas_data, _get_canvas_height, missing canvas_data->{_widget}\n");
#		my $result = $empty_string;
#		return($result);
#	 }
# }
#
#
#=head2 sub get_canvas_width
#
#
#=cut
#
# sub _get_canvas_width{
#
#	my ( $self)		= @_;
#	if ( $canvas_data->{_widget} ne $empty_string ) {
#		$canvas_data->{_canvas_width} 	= $canvas_data->{_widget} -> cget(-width);
#		my $result 						= $canvas_data->{_canvas_width};
#		# print("canvas_data, _get_canvas_width=$result pixels\n");
#		return($result);
#
#	} else {
#		print("canvas_data, _get_canvas_width, missing canvas_data->{_x_pix}\n");
#		my $result = $empty_string;
#		return($result);
#	 }
# }
#

=head2 sub _time2col_index


=cut

sub _time2col_index {

    my ($self) = @_;

    if (   $canvas_data->{_y_value} ne $empty_string
        && $canvas_data->{_t_max_s} ne $empty_string
        && $canvas_data->{_t_min_s} ne $empty_string
        && nelem( $canvas_data->{_ampls_pdl} ) != 0 )
    {

        my $time_s     = $canvas_data->{_y_value};
        my $t_max_s    = $canvas_data->{_t_max_s};
        my $t_min_s    = $canvas_data->{_t_min_s};
        my $amplitudes = $canvas_data->{_ampls_pdl};

        my @dims_amplitudes = dims $amplitudes;

# print("canvas_data, _time2col_index, dims_amplitudes = $dims_amplitudes[0] time samples\n");
# print("canvas_data, _time2col_index, dims_amplitudes = $dims_amplitudes[1] traces\n");
        my $t_range_s        = $t_max_s - $t_min_s;
        my $num_time_samples = $dims_amplitudes[0];
        my $result =
          ( $time_s - $t_min_s ) * ( $num_time_samples - 1 ) / $t_range_s;
        my $rounded_result = sprintf( "0", $result );
        $canvas_data->{_time_col_num}   = $rounded_result;
        $canvas_data->{_time_col_index} = $rounded_result - 1;

# print("canvas_data, _time2col_index, column no. = $canvas_data->{_time_col_index}\n");
        return ();

    }
    else {
        print("canvas_data, _time2col_index missing canvas_data->{_time_s}\n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub _time2col_num


=cut

sub _time2col_num {

    my ($self) = @_;

    if (   $canvas_data->{_y_value} ne $empty_string
        && $canvas_data->{_t_max_s} ne $empty_string
        && $canvas_data->{_t_min_s} ne $empty_string
        && nelem( $canvas_data->{_ampls_pdl} ) != 0 )
    {

        my $time_s     = $canvas_data->{_y_value};
        my $t_max_s    = $canvas_data->{_t_max_s};
        my $t_min_s    = $canvas_data->{_t_min_s};
        my $amplitudes = $canvas_data->{_ampls_pdl};

        my @dims_amplitudes = dims $amplitudes;
        print(
"canvas_data, _time2col_num, dims_amplitudes = $dims_amplitudes[0] time samples\n"
        );
        print(
"canvas_data, _time2col_num, dims_amplitudes = $dims_amplitudes[1] traces\n"
        );
        my $t_range_s        = $t_max_s - $t_min_s;
        my $num_time_samples = $dims_amplitudes[0];
        my $result =
          ( $time_s - $t_min_s ) * ( $num_time_samples - 1 ) / $t_range_s;
        my $rounded_result = sprintf( "0", $result );
        $canvas_data->{_time_col_num} = $rounded_result;
        print(
"canvas_data, _time2col_num, column no. = $canvas_data->{_time_col_num}\n"
        );
        return ();

    }
    else {
        print("canvas_data, _time2col_num missing canvas_data->{_time_s}\n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub _x_pix2time 


=cut

sub _x_pix2time {

    my ($self) = @_;

    if ( $canvas_data->{_x_pix} ne $empty_string ) {

        #		my $time 				=
        #		$canvas_data->{_time_s}}	= $time;

    }
    else {
        print("canvas_data, _x_pix2time, missing canvas_data->{_x_pix}\n");
    }
}

=head2 sub _x_value


=cut

sub _x_value {

    my ($self) = @_;

    if (   $canvas_data->{_x_pix} ne $empty_string
        && $canvas_data->{_seismic_plot_x_offset_pix} ne $empty_string
        && $canvas_data->{_x_min} ne $empty_string
        && $canvas_data->{_x_max} ne $empty_string
        && $canvas_data->{_seismic_plot_width} ne $empty_string )
    {

        my $seismic_plot_x_offset_pix =
          $canvas_data->{_seismic_plot_x_offset_pix};
        my $x_pix          = $canvas_data->{_x_pix};
        my $x_min          = $canvas_data->{_x_min};
        my $x_max          = $canvas_data->{_x_max};
        my $plot_width_pix = $canvas_data->{_seismic_plot_width};

        my $x_range = $x_max - $x_min;
        my $increment_per_pix_x = $x_range / ( $plot_width_pix - 1 );
        my $result =
          $x_min +
          $increment_per_pix_x * ( $x_pix - $seismic_plot_x_offset_pix );
        my $rounded_result = sprintf( "0", $result );

        $canvas_data->{_x_value} = $rounded_result;

      # print("canvas_data, _x_value,  x_value (unrounded) 	= $result\n");
      # print("canvas_data, _x_value,  x_value (rounded) 	= $rounded_result\n");
        return ($empty_string);

    }
    else {
        print("canvas_data, _x_value, missing values \n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub _x2row_index


=cut

sub _x2row_index {

    my ($self) = @_;

    if ( $canvas_data->{_x_value} ne $empty_string ) {

        $canvas_data->{_trace_row_index} = $canvas_data->{_x_value} - 1;

    }
    else {
        print("canvas_data, _x2row_index missing x value\n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub _x2row_num


=cut

sub _x2row_num {

    my ($self) = @_;

    if ( $canvas_data->{_x_value} ne $empty_string ) {

        $canvas_data->{_trace_row_num} = $canvas_data->{_x_value};

    }
    else {
        print("canvas_data, _x2row_num missing x value\n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub _y_pix2X


=cut

sub _y_pix2X {

    my ($self) = @_;

    if ( $canvas_data->{_y_pix} ne $empty_string ) {

        #		my $X				=
        #		$canvas_data->{_x}	= $X;

    }
    else {
        print("canvas_data,_y_pix2X, missing canvas_data->{_x}\n");
    }
}

=head2 sub _y_value


=cut

sub _y_value {

    my ($self) = @_;
    if (   $canvas_data->{_y_pix} ne $empty_string
        && $canvas_data->{_seismic_plot_y_offset_pix} ne $empty_string
        && $canvas_data->{_t_min_s} ne $empty_string
        && $canvas_data->{_t_max_s} ne $empty_string
        && $canvas_data->{_seismic_plot_height} ne $empty_string )
    {

        my $seismic_plot_y_offset_pix =
          $canvas_data->{_seismic_plot_y_offset_pix};
        my $y_pix           = $canvas_data->{_y_pix};
        my $t_min_s         = $canvas_data->{_t_min_s};
        my $t_max_s         = $canvas_data->{_t_max_s};
        my $plot_height_pix = $canvas_data->{_seismic_plot_height};

        my $t_range_s = $t_max_s - $t_min_s;
        my $increment_per_pix_y = $t_range_s / ( $plot_height_pix - 1 );

        # round off trace to the nearest integer
        my $result =
          $t_min_s +
          $increment_per_pix_y * ( $y_pix - $seismic_plot_y_offset_pix );
        my $rounded_result = sprintf( "0.0000", $result );
        $canvas_data->{_y_value} = $rounded_result;

     # print("canvas_data, _y_value,  y_value (rounded) 	 = $rounded_result\n");
     # print("canvas_data, _y_value,  y_value (unrounded) = $result\n");
        return ();

    }
    else {
        print("canvas_data, _y_value, missing values\n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub get_x_value


=cut

sub get_x_value {

    my ($self) = @_;

    _x_value;

    if ( $canvas_data->{_x_value} ne $empty_string ) {

        my $result = $canvas_data->{_x_value};

        # print("canvas_data, get_x_value,  x_value (rounded) 	= $result\n");
        return ($result);

    }
    else {
        print("canvas_data, get_x_value, missing values \n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub get_y_value


=cut

sub get_y_value {

    my ($self) = @_;

    _y_value;

    if ( $canvas_data->{_y_value} ne $empty_string ) {

        my $result = $canvas_data->{_y_value};

        # print("canvas_data, get_y_value,  y_value (rounded) 	= $result\n");
        return ($result);

    }
    else {
        print("canvas_data, get_y_value, missing values \n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub get_z_value


=cut

sub get_z_value {

    my ($self) = @_;

    _x2row_index;
    _time2col_index;

    if (   ( nelem( $canvas_data->{_ampls_pdl} ) != 0 )
        && $canvas_data->{_trace_row_index} != 0
        && $canvas_data->{_time_col_index} ne $empty_string )
    {

        # print ("canvas_data, get_z_value\n");

   # my $seismic_plot_y_offset_pix	= $canvas_data->{_seismic_plot_y_offset_pix};
        my $amplitudes      = $canvas_data->{_ampls_pdl};
        my $trace_row_index = $canvas_data->{_trace_row_index};
        my $time_col_index  = $canvas_data->{_time_col_index};
        my @dims_amplitudes = dims $amplitudes;

# print("canvas_data, get_z_value, trace row_index (trace no.-1) = $trace_row_index\n");
# print("canvas_data, get_z_value, time col_index (time sample num.-1) = $time_col_index\n");
        my $result = $amplitudes ( $time_col_index, $trace_row_index );
        return ($result);

# print("canvas_data, get_z_value, dims_amplitudes = $dims_amplitudes[0] time samples\n");
# print("canvas_data, get_z_value, dims_amplitudes = $dims_amplitudes[1] traces\n");

    }
    else {
        print("canvas_data, get_z_value, missing values\n");
        my $result = $empty_string;
        return ($result);
    }
}

#=head2 sub set_BOX
#
#
#=cut
#
# sub set_BOX{
#
#	my ($self,$BOX)		= @_;
#
#	if ( $BOX ne $empty_string ) {
#
#		$canvas_data->{_BOX}	= $BOX;
#		# print("canvas_data, set_BOX = @{$canvas_data->{_BOX}}\n");
#
#	} else {
#		print("canvas_data, set_BOX, missing canvas_data->{_widget}\n");
#	}
#
#	return();
# }
#

#=head2 sub set_VIEWPORT
#
#
#=cut
#
# sub set_VIEWPORT{
#
#	my ($self,$VIEWPORT)		= @_;
#
#	if ( $VIEWPORT ne $empty_string ) {
#
#		$canvas_data->{_VIEWPORT}	= $VIEWPORT;
#		# print("canvas_data, set_VIEWPORT = @{$canvas_data->{_VIEWPORT}}\n");
#
#	} else {
#		print("canvas_data, set_VIEWPORT, missing canvas_data->{_widget}\n");
#	}
#
#	return();
# }

=head2 sub set_ampls_pdl

=cut

sub set_ampls_pdl {
    my ( $self, $ampls_pdl ) = @_;

    if ( nelem( $ampls_pdl != 0 ) ) {

        $canvas_data->{_ampls_pdl} = $ampls_pdl;

        # print("canvas_data,set_ampls_pdl: $ampls_pdl\n");
        return ();

    }
    else {
        print("canvas_data,set_ampls, missing ampls_pdl \n");
    }

}

=head2 sub set_tmax_s

=cut

sub set_t_max_s {
    my ( $self, $last_t ) = @_;

    if ( $last_t ne $empty_string ) {

        $canvas_data->{_t_max_s} = $last_t;

        # print("canvas_data,set_t_max_s: $last_t\n");
        return ();

    }
    else {
        print("canvas_data,set_t_max_s, missing last_t \n");
    }

}

=head2 sub set_t_min_s

=cut

sub set_t_min_s {
    my ( $self, $first_t ) = @_;

    if ( $first_t ne $empty_string ) {

        $canvas_data->{_t_min_s} = $first_t;

        # print("canvas_data,set_t_min_s: $first_t \n");
        return ();

    }
    else {
        print("canvas_data,set_t_min_s, missing first_t \n");
    }

}

=head2 sub set_seismic_plot_height

=cut

sub set_seismic_plot_height {
    my ( $self, $height ) = @_;

    if ( $height ne $empty_string ) {

        $canvas_data->{_seismic_plot_height} = $height;

       # print("canvas_data,set_seismic_plot_height, height= $height pixels\n");

    }
    else {
        print("canvas_data,set_seismic_plot_height, missing height \n");
    }
    return ();
}

=head2 sub set_seismic_plot_width

=cut

sub set_seismic_plot_width {
    my ( $self, $width ) = @_;

    if ( $width ne $empty_string ) {

        $canvas_data->{_seismic_plot_width} = $width;

        # print("canvas_data,set_seismic_plot_width, width= $width pixels\n");

    }
    else {
        print("canvas_data, set_seismic_plot_width , missing width \n");
    }
    return ();
}

=head2 sub set_seismic_plot_x_offset_pix

=cut

sub set_seismic_plot_x_offset_pix {
    my ( $self, $x_offset ) = @_;

    if ( $x_offset ne $empty_string ) {

        $canvas_data->{_seismic_plot_x_offset_pix} = $x_offset;

# print("canvas_data,set_seismic_plot_x_offset_pix, x_offset= $x_offset pixels\n");

    }
    else {
        print("canvas_data,set_seismic_plot_x_offset_pix, missing x_offset \n");
    }
    return ();
}

=head2 sub set_seismic_plot_y_offset_pix

=cut

sub set_seismic_plot_y_offset_pix {
    my ( $self, $y_offset ) = @_;

    if ( $y_offset ne $empty_string ) {

        $canvas_data->{_seismic_plot_y_offset_pix} = $y_offset;

# print("canvas_data,set_seismic_plot_y_offset_pix, y_offset= $y_offset pixels\n");

    }
    else {
        print(
            "canvas_data, set_seismic_plot_y_offset_pix , missing y_offset \n");
    }
    return ();
}

=head2 sub set_widget

my $var     = $immodpg->var();
=cut

sub set_widget {

    my ( $self, $widget ) = @_;
    if ( $widget ne $empty_string ) {

        $canvas_data->{_widget} = $widget;

    }
    else {
        print("canvas_data, set_widget, missing canvas_data->{_widget}\n");
    }
    return ();
}

sub set_x_max {
    my ( $self, $last_x ) = @_;

    if ( $last_x ne $empty_string ) {

        $canvas_data->{_x_max} = $last_x;

        # print("canvas_data,set_x_max: $last_x\n");
        return ();

    }
    else {
        print("canvas_data,missing last_x \n");
    }

}

=head2 sub set_x_min

=cut

sub set_x_min {
    my ( $self, $first_x ) = @_;

    if ( $first_x ne $empty_string ) {

        $canvas_data->{_x_min} = $first_x;

        # print("canvas_data,set_xmin: $first_x \n");
        return ();

    }
    else {
        print("canvas_data,missing first_x \n");
    }

}

=head2 sub set_x_pix 


=cut

sub set_x_pix {

    my ( $self, $x_pix ) = @_;
    if ( $x_pix ne $empty_string ) {

        $canvas_data->{_x_pix} = $x_pix;

        # print("canvas_data, set_x_pix, x_pix= $canvas_data->{_x_pix}\n");

    }
    else {
        print("canvas_data, set_x_pix, missing x_pix\n");
    }
}

=head2 sub set_y_pix


=cut

sub set_y_pix {

    my ( $self, $y_pix ) = @_;
    if ( $y_pix ne $empty_string ) {

        $canvas_data->{_y_pix} = $y_pix;

        # print("canvas_data, set_y_pix, y_pix=$canvas_data->{_y_pix}\n");

    }
    else {
        print("canvas_data, set_y_pix, missing canvas_data->{_y_pix}\n");
    }
}

1;
