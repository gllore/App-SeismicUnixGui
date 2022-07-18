
=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PACKAGE NAME: L_su_plot
 AUTHOR: 	Juan Lorenzo
 DATE: 		February 27 2019 

 DESCRIPTION:  
    
   GUI to plot and view a seismic unix file

=cut

=head2 USE

=over

=item

Data file name to plot is read from an external configuration file.

=item

Mode of operation is read from an external configuration file

=back
	
=cut

=head2 NOTES

L_su_plot uses pixel-centered geometries.

canvas_data (values on image) and canvas-graph (image properties) and
PerlTk (plotting) libraries

PLplot libraries come via PDL
and PDL manages data in matrix form

_su_release invokes _rectangle_window to plot zoomed image
	
=cut	

=head4 Examples

=cut

=head2 CHANGES and their DATES


=cut 

use Moose;
use PDL::Core;
use PDL::Basic;
use PDL::NiceSlice;
use PerlTk_plot;
use App::SeismicUnixGui::misc::L_SU_global_constants;
use Tk;
use Tk::Canvas;
use Tk::Photo;
use Tk::PNG;

use pdl_su;
use suinfo;

use canvas_graph;
use canvas_data;

my $get          = new L_SU_global_constants();
my $canvas_data  = new canvas_data();
my $canvas_graph = new canvas_graph();

my $var          = $get->var();
my $empty_string = $var->{_empty_string};
my $us_per_s     = $var->{_us_per_s};
my $true         = $var->{_true};
my $false        = $var->{_false};

our $VERSION = '0.0.3';

=head2 Instantiate modules

pdl_su and PerlTk_plot

=cut

my $pdl_su      = pdl_su->new();
my $suinfo      = suinfo->new();
my $PerlTk_plot = new PerlTk_plot();

=head2 Data section

Get data and its parameters via a 
pdl str

Private hash contains
imporant variables: 33 keys

=cut

my $L_su_plot = {
    _BOX                         => '',
    _DATA_BOUNDS                 => '',
    _PLOT_BOUNDS                 => '',
    _VIEWPORT                    => '',
    _ampls                       => '',
    _canvas_height_pix           => '',
    _canvas_width_pix            => '',
    _dpi                         => '',
    _dx                          => '',
    _first_t_s4data              => '',
    _first_t_s4plot              => '',
    _first_x4data                => '',
    _first_x4plot                => '',
    _gui_positionNsize           => '',
    _png_original_id_num         => '',
    _inbound_base_file_name      => '',
    _inbound_parameter_file_name => '',
    _inbound_parameter_file_path => '',
    _inbound_suffix_type         => '',
    _is_mouse_in_motion          => $false,
    _is_canvas_set               => '',
    _is_button_down              => $false,
    _is_button_up                => $true,
    _gain                        => '',
    _last_t_s4data               => '',
    _last_x4plot                 => '',
    _mw_height                   => '',
    _mw_width                    => '',
    _number_of_traces            => '',
    _operation_mode              => '',
    _samples_per_trace           => '',
    _png_page_width              => '',
    _png_page_height             => '',
    _rectangle_id_num            => '',
    _sample_increment_index      => '',
    _seismic_plot_height         => '',
    _seismic_plot_width          => '',
    _seismic_plot_x_offset_pix   => '',
    _seismic_plot_y_offset_pix   => '',
    _sample_interval_ms          => '',
    _sample_interval_us          => '',
    _x_increment                 => '',
    _x_pix                       => '',
    _y_pix                       => '',
    _x_pix_in_motion             => '',
    _x_pix_press                 => '',
    _x_pix_release               => '',
    _y_pix_in_motion             => '',
    _y_pix_press                 => '',
    _y_pix_release               => '',
};

my $button_released = $false;
my $button_pressed  = $false;

=head2 User input parameters

read from a configuration file

=cut 

my $inbound_base_file_name = '13_clean';
my $inbound_suffix_type    = 'su';

# print ("$inbound_base_file_name\n");

my $box_X0_pix = 1000;
my $box_Y0_pix = 00;

my $operation_mode = 'select_trace4later_removal';
_set_operation_mode($operation_mode);

# Recommended box to be a square
my $png_page_height = 800;  # this is seismic page height but canvas & mw width
my $png_page_width  = 1000; # this is seismic page width  but canvas & mw height

my $ylabel      = 'Traces';
my $xlabel      = 'Time (s)';
my $png_working = 'test.png';

$suinfo->clear();
$suinfo->set_inbound_base_file_name($inbound_base_file_name);
$suinfo->set_type('time');
$suinfo->set_unit('second');
$suinfo->set_first();
$suinfo->set_last();
my $first_t_s4data = $suinfo->get_first();
my $last_t_s4data  = $suinfo->get_last();

#	print("first time-s = $first_t_s4data s \n");
#	print("last time -s = $last_t_s4data s \n");

$suinfo->clear();
$suinfo->set_inbound_base_file_name($inbound_base_file_name);
$suinfo->set_first();
$suinfo->set_type('tracl');
my $first_tracl = $suinfo->get_first();

# print("Lsu_plot, first_tracl:$first_tracl \n");

$suinfo->clear();
$suinfo->set_inbound_base_file_name($inbound_base_file_name);
$suinfo->set_last();
$suinfo->set_type('tracl');
my $last_tracl = $suinfo->get_last();

# print("Lsu_plot, first_tracl:$last_tracl \n");

# from data set at first
my $first_x4data = $first_tracl;
my $last_x4data  = $last_tracl;

# from user	at least initially
# my $t_index_increment   		= 1;
my $x_increment = 1;

# my $x_index_increment			= 1;
my $sample_increment_index = 1;

=head2 Initialize variable values

to plot all the selected data
 
=cut

my $first_t_s4plot = $first_t_s4data;
my $last_t_s4plot  = $last_t_s4data;

my $first_x4plot = $first_x4data;
my $last_x4plot  = $last_x4data;

my $mw_width  = $png_page_width;
my $mw_height = $png_page_height;

my $canvas_width_pix  = $png_page_width;
my $canvas_height_pix = $png_page_height;

=head2 Copy local values 

into private keys

=cut

$L_su_plot->{_canvas_width_pix}       = $canvas_width_pix;
$L_su_plot->{_canvas_height_pix}      = $canvas_height_pix;
$L_su_plot->{_first_t_s4data}         = $first_t_s4data;
$L_su_plot->{_first_t_s4plot}         = $first_t_s4plot;
$L_su_plot->{_first_x4data}           = $first_x4data;
$L_su_plot->{_first_x4plot}           = $first_x4plot;
$L_su_plot->{_inbound_base_file_name} = $inbound_base_file_name;
$L_su_plot->{_inbound_suffix_type}    = $inbound_suffix_type;
$L_su_plot->{_last_t_s4data}          = $last_t_s4data;
$L_su_plot->{_last_t_s4plot}          = $last_t_s4plot;
$L_su_plot->{_last_x4data}            = $last_x4data;
$L_su_plot->{_last_x4plot}            = $last_x4plot;
$L_su_plot->{_mw_width}               = $mw_width;
$L_su_plot->{_mw_height}              = $mw_height;
$L_su_plot->{_x_increment}            = $x_increment;
$L_su_plot->{_sample_increment_index} = $sample_increment_index;

# in order to estimate seismic plot offset of top-left corner
$L_su_plot->{_png_page_height} = $png_page_height;
$L_su_plot->{_png_page_width}  = $png_page_width;
$L_su_plot->{_xlabel}          = $xlabel;
$L_su_plot->{_ylabel}          = $ylabel;

# in order to set the correct seismic graph size
$PerlTk_plot->set_box_X0_pix($box_X0_pix);
$PerlTk_plot->set_box_Y0_pix($box_Y0_pix);
$PerlTk_plot->set_canvas_width_pix($canvas_width_pix);
$PerlTk_plot->set_canvas_height_pix($canvas_height_pix);
$PerlTk_plot->set_mw_width($mw_width);
$PerlTk_plot->set_mw_height($mw_height);
$PerlTk_plot->set_t_min_s4data($first_t_s4data);
$PerlTk_plot->set_t_min_s4plot($first_t_s4plot);
$PerlTk_plot->set_t_max_s4data($last_t_s4data);
$PerlTk_plot->set_t_max_s4plot($last_t_s4plot);
$PerlTk_plot->set_x_min4data($first_x4data);
$PerlTk_plot->set_x_min4plot($first_x4plot);
$PerlTk_plot->set_x_max4data($last_x4data);
$PerlTk_plot->set_x_max4plot($last_x4plot);

$PerlTk_plot->set_x_label($xlabel);
$PerlTk_plot->set_y_label($ylabel);

# set the correct offset of top-left-corner of graph within the plotting page
$PerlTk_plot->set_png_page_height($png_page_height);
$PerlTk_plot->set_png_page_width($png_page_width);

$L_su_plot->{_seismic_plot_x_offset_pix} =
  $PerlTk_plot->get_seismic_plot_x_offset_pix;
$L_su_plot->{_seismic_plot_y_offset_pix} =
  $PerlTk_plot->get_seismic_plot_y_offset_pix;
$L_su_plot->{_seismic_plot_height} = $PerlTk_plot->get_seismic_plot_height();
$L_su_plot->{_seismic_plot_width}  = $PerlTk_plot->get_seismic_plot_width();

# needed to set the correct proportions on the seismic plotting page
$L_su_plot->{_gui_positionNsize} = $PerlTk_plot->get_gui_positionNsize();

my $seismic_plot_height       = $L_su_plot->{_seismic_plot_height};
my $seismic_plot_width        = $L_su_plot->{_seismic_plot_width};
my $seismic_plot_x_offset_pix = $L_su_plot->{_seismic_plot_x_offset_pix};
my $seismic_plot_y_offset_pix = $L_su_plot->{_seismic_plot_y_offset_pix};
my $gui_positionNsize         = $L_su_plot->{_gui_positionNsize};

=head3 Read values from pdl data structure

=cut

$pdl_su->set_inbound_base_file_name($inbound_base_file_name);
$pdl_su->set_inbound_suffix_type($inbound_suffix_type);
my $ampls              = $pdl_su->get_pdl();
my $samples_per_trace  = $pdl_su->get_samples_per_trace();
my $number_of_traces   = $pdl_su->get_number_of_traces();
my $sample_interval_us = $pdl_su->get_sample_interval_us();
my @dims_pdl           = dims $ampls;

$L_su_plot->{_samples_per_trace}  = $samples_per_trace;
$L_su_plot->{_number_of_traces}   = $number_of_traces;
$L_su_plot->{_sample_interval_us} = $sample_interval_us;
$L_su_plot->{_ampls}              = $ampls;

# print("L_su_plot, ampls pdl dimensions: $dims_pdl[0] by $dims_pdl[1]\n");

=head2 Prepare and plot 
all the selected data at once

=cut

$PerlTk_plot->set_sample_interval_us($sample_interval_us);
$PerlTk_plot->set_sample_increment_index($sample_increment_index);
$PerlTk_plot->set_x_increment($x_increment);
$PerlTk_plot->set_samples_per_trace($samples_per_trace);
$PerlTk_plot->set_number_of_traces($number_of_traces);
$PerlTk_plot->set_ampls($ampls);
$PerlTk_plot->set_pl_plot;
$PerlTk_plot->wiggle_png;

=head2 Plotting section

    Set plotting parameters and
    plot the data the first time

=cut

if (   $L_su_plot->{_gui_positionNsize} ne $empty_string
    && $L_su_plot->{_canvas_height_pix} ne $empty_string
    && $L_su_plot->{_canvas_width_pix} ne $empty_string )
{

    my $gui_positionNsize = $L_su_plot->{_gui_positionNsize};
    my $canvas_height_pix = $L_su_plot->{_canvas_height_pix};
    my $canvas_width_pix  = $L_su_plot->{_canvas_width_pix};

=head2 Build GUI 


=cut  

    my $mw = new MainWindow;
    $mw->optionAdd( "*font", $var->{_my_arial} );

    #$mw	->optionAdd	("*borderWidth", $var->{_one_pixel});
    $mw->title( $var->{_l_suplot_title} );
    $mw->geometry($gui_positionNsize);
    $mw->resizable( 1, 1 );    # not resizable in either width or height

=head3 mw contains a canvas

=cut

    my $canvas = $mw->Canvas(
        -height => $canvas_height_pix,
        -width  => $canvas_width_pix,
    );

    # Geometry Management
    $canvas->pack(
        -fill   => 'both',
        -expand => 1,
    );

=head3 Png image 

is read as a photo 

=cut																									

    my $png_original = $canvas->Photo(
        -file   => $png_working,
        -format => 'png',
        -height => 0,
    );

=heads Png image

Display in canvas

=cut 

    my $top_left_x = 0;    # $seismic_plot_x_offset_pix;
    my $top_left_y = 0;    # $seismic_plot_y_offset_pix

    # my $image_id_num	= '';
    my $image_id_num = $canvas->createImage(
        0, $top_left_y,
        -anchor => 'nw',
        -image  => $png_original
    );

    $L_su_plot->{_png_original_id_num} = $image_id_num;

=head3  png_id_num

Initialize

=cut

    $L_su_plot->{_png_id_num} = $image_id_num;

    # bind MB's to make a rubberband box
    $canvas->CanvasBind( "<ButtonPress-1>", [ \&_xy_pix_press, $canvas ], );

    $canvas->CanvasBind( "<Button-1><Motion>", [ \&_xy_pix_in_motion, $canvas ],
    );

    $canvas->CanvasBind( "<Double-Button-1>", [ \&_original_png, $canvas ], );

    $canvas->CanvasBind( "<ButtonRelease-1>", [ \&_xy_pix_release, $canvas ], );

    MainLoop();

=head2 sub _get_operation_mode

e.g., picking a trace (turns blue)
e.g., selecting amplitudes at a point
	
=cut

    sub _get_operation_mode {
        my ($self) = @_;

        if ( defined $L_su_plot->{_operation_mode}
            && $L_su_plot->{_operation_mode} ne $empty_string )
        {

            my $result = $L_su_plot->{_operation_mode};
            return ($result);

        }
        else {
            print("L_su_plot, set_operation_mode, missing value\n");
            return ();
        }

        return (0);
    }

=head2 sub _operation_mode

e.g., picking a trace (turns blue)
e.g., selecting amplitudes at a point
	
=cut 

    sub _operation_director {

        my ($self) = @_;

        $operation_mode = _get_operation_mode();

        # print("_operation_director mode = $operation_mode\n");

        if ( $operation_mode eq 'select_trace4later_removal' ) {

=head3 
delete old plots ???? necessary
=cut 

            if ( defined $L_su_plot->{_png_id_num} ) {

                print(
"L_su_plot, _operation_director,  L_su_plot->{_png_id_num} = $L_su_plot->{_png_id_num}\n"
                );
                my $png_id_num = $L_su_plot->{_png_id_num};

                # $canvas->break($png_id_num);

            }
            else {
                print("L_su_plot, _operation_director, missing _png_id_num\n");
            }

# get traces previously selected for later removal
# set traces for later removal
# set those traces that are selected for removal a second time
# to be eleimiated from the list of traces to be removed.
# set highlighting color for removal (red)
# get traces that dwill not be affected
# highlight a traces for future removal or return it to its normal state (black)

        }
        else {
            print("_operation_director bad option for the operation mode\n");
        }

    }

=head2 sub _original_png

=cut

    sub _original_png {

        my ($canvas) = @_;

        # print("L_su_plot,original_png, canvas= $canvas\n");

        if (   $canvas ne $empty_string
            && $L_su_plot->{_png_original_id_num} ne $empty_string )
        {

            my $old_png_original_id_num = $L_su_plot->{_png_original_id_num};
            $canvas->delete($old_png_original_id_num);

            my $new_png_id_num = $canvas->createImage(
                0, $top_left_y,
                -anchor => 'nw',
                -image  => $png_original
            );

            $L_su_plot->{_png_id_num} = $new_png_id_num;

            # print("L_su_plot, _original_png, draw original first plot \n");
            # print("L_su_plot, _original_png, coords: @{$png_original}\n");

        }
        else {
            print("L_su_plot, _original_png, missing parameters\n");
        }

    }

=head2 sub _rectangle_in_motion

Properties of rectangle while mouse moves in canvas

=cut

    sub _rectangle_in_motion {

        my ($self) = @_;

        if (   $canvas ne $empty_string
            && $L_su_plot->{_is_button_down}
            && $L_su_plot->{_is_mouse_in_motion} )
        {

            my $x_start_rectangle = $L_su_plot->{_x_pix_press};
            my $y_start_rectangle = $L_su_plot->{_y_pix_press};
            my $x_end_rectangle   = $L_su_plot->{_x_pix_in_motion};
            my $y_end_rectangle   = $L_su_plot->{_y_pix_in_motion};

            my $rectangle_in_motion = [
                $x_start_rectangle, $y_start_rectangle,
                $x_end_rectangle,   $y_end_rectangle
            ];

            my $old_id = $L_su_plot->{_rectangle_id_num};

            # first time rectangle
            if ( $old_id eq $empty_string ) {
                my $new_id = $canvas->createRectangle($rectangle_in_motion);
                $L_su_plot->{_rectangle_id_num} = $new_id;

  # print("L_su_plot, _rectangle_in_motion, draw a rectangle\n");
  # print("L_su_plot, _rectangle_in_motion, coords: @{$rectangle_in_motion}\n");

                # rectangles thereafter ...
            }
            elsif ( $old_id ne $empty_string ) {
                $canvas->delete($old_id);
                my $new_id = $canvas->createRectangle($rectangle_in_motion);

                # print("L_su_plot, _rectangle_in_motion, delete old id\n");
                $L_su_plot->{_rectangle_id_num} = $new_id;

            }
            else {
                print(
"L_su_plot, _rectangle_in_motion, unexpected  old_id = $old_id\n"
                );
            }

        }
        else {
            print("L_su_plot, _rectangle_in_motion, missing parameters\n");
        }

    }

=head2 sub rectangle_window

Draw

=cut

    sub _rectangle_window {

        my ($self) = @_;

        if (   $canvas ne $empty_string
            && nelem( $L_su_plot->{_ampls} ) != 0
            && $L_su_plot->{_number_of_traces} ne $empty_string
            && $L_su_plot->{_x_increment} ne $empty_string
            && $L_su_plot->{_x_pix_press} ne $empty_string
            && $L_su_plot->{_y_pix_press} ne $empty_string
            && $L_su_plot->{_x_pix_release} ne $empty_string
            && $L_su_plot->{_y_pix_release} ne $empty_string
            && $L_su_plot->{_sample_interval_us} ne $empty_string
            && $L_su_plot->{_sample_increment_index} ne $empty_string
            && $L_su_plot->{_samples_per_trace} ne $empty_string )
        {

            my $ampls                  = $L_su_plot->{_ampls};
            my $number_of_traces       = $L_su_plot->{_number_of_traces};
            my $x_increment            = $L_su_plot->{_x_increment};
            my $x_pix_press            = $L_su_plot->{_x_pix_press};
            my $y_pix_press            = $L_su_plot->{_y_pix_press};
            my $x_pix_release          = $L_su_plot->{_x_pix_release};
            my $y_pix_release          = $L_su_plot->{_y_pix_release};
            my $sample_interval_us     = $L_su_plot->{_sample_interval_us};
            my $sample_increment_index = $L_su_plot->{_sample_increment_index};
            my $samples_per_trace      = $L_su_plot->{_samples_per_trace};

            # Change imported coordinates of rectangles
            _set_canvas_data();
            _set_x_pix($x_pix_press);
            _set_y_pix($y_pix_press);
            my $y_start_rectangle = _get_time_s();
            my $x_start_rectangle = ( _get_trace_number() - 1 );

            _set_x_pix($x_pix_release);
            _set_y_pix($y_pix_release);
            my $x_end_rectangle = ( _get_trace_number() + 1 );
            my $y_end_rectangle = _get_time_s();

            print(
"L_su_plot,rectangle_window, x_start_rectangle = $x_start_rectangle\n"
            );
            print(
"L_su_plot,rectangle_window, y_start_rectangle = $y_start_rectangle\n"
            );
            print(
"L_su_plot,rectangle_window, x_end_rectangle = $x_end_rectangle\n"
            );
            print(
"L_su_plot,rectangle_window, y_end_rectangle = $y_end_rectangle\n"
            );

            #my $x_start_rectangle		= 2;# 32; trace number
            #my $y_start_rectangle 		= 0.1;# time (s)
            #my $x_end_rectangle 		= 7;# 64. trace number
            # my $y_end_rectangle 		= 20.1;# 1.999; time (S)

            my $rectangle_window = [
                $x_start_rectangle, $y_start_rectangle,
                $x_end_rectangle,   $y_end_rectangle
            ];

            # time (s) and trace number before assigning to the following
            $PerlTk_plot->set_t_min_s4plot($y_start_rectangle);
            $PerlTk_plot->set_t_max_s4plot($y_end_rectangle);
            $PerlTk_plot->set_x_min4plot($x_start_rectangle);
            $PerlTk_plot->set_x_max4plot($x_end_rectangle);

    # following 7 lines are repetitive but useful for encapsulation
    #		$PerlTk_plot			->set_sample_interval_us($sample_interval_us);
    #	    $PerlTk_plot			->set_sample_increment_index($sample_increment_index );
    #	    $PerlTk_plot			->set_x_increment($x_increment);
    #	    $PerlTk_plot			->set_samples_per_trace($samples_per_trace);
    #	    $PerlTk_plot			->set_number_of_traces($number_of_traces);
    #	    $PerlTk_plot			->set_ampls($ampls);

            $PerlTk_plot->set_pl_plot;

            my $png_id_num = $L_su_plot->{_png_id_num};
            $canvas->delete($png_id_num);

            $PerlTk_plot->wiggle_png;

            # create a new photo from the file
            my $photo = $canvas->Photo(
                -file   => $png_working,
                -format => 'png',
                -height => 0,
            );

            $canvas->createImage(
                0, $top_left_y,
                -anchor => 'nw',
                -image  => $photo
            );

            # destroy $photo just in case?
        }
        else {
            print("L_su_plot, _rectangle_window, missing parameters\n");
        }

    }

=head2 sub _set_operation_mode

e.g., picking a trace (turns blue)
e.g., selecting amplitudes at a point
	
=cut 

    sub _set_operation_mode {
        my ($operation_mode) = @_;

        # print("L_su_plot,_set_operation_mode = $operation_mode\n");

        if ( defined $operation_mode
            && $operation_mode ne $empty_string )
        {

            $L_su_plot->{_operation_mode} = $operation_mode;

        }
        else {
            print("L_su_plot, set_operation_mode, missing value\n");
            return ();
        }

    }

=head2 sub _get_ampl

Wiggle amplitude

=cut

    sub _get_ampl {

        my ($self) = @_;

        if (   defined $L_su_plot->{_x_pix}
            && defined $L_su_plot->{_y_pix}
            && $L_su_plot->{_x_pix} ne $empty_string
            && $L_su_plot->{_y_pix} ne $empty_string
            && $L_su_plot->{_is_canvas_set} )
        {

            $canvas_data->set_x_pix( $L_su_plot->{_x_pix} );
            $canvas_data->set_y_pix( $L_su_plot->{_y_pix} );

            my $result = $canvas_data->get_z_value();

            print("L_su_plot, _get_ampl, amplitude = $result\n");
            return ($result);

        }
        else {
            print("L_su_plot, _get_ampl, missing parameters\n");
        }

    }

=head2 sub _get_time_s

Time (s) value of point

=cut

    sub _get_time_s {

        my ($self) = @_;

        if (
               defined $L_su_plot->{_y_pix}
            && $L_su_plot->{_y_pix} ne $empty_string
            && $L_su_plot->{_is_canvas_set}

          )
        {

            $canvas_data->set_y_pix( $L_su_plot->{_y_pix} );
            my $result = $canvas_data->get_y_value();
            print("L_su_plot, _get_time_s, time (s) = $result\n");
            return ($result);

        }
        else {
            print("L_su_plot, _get_time_s, missing paramters\n");
        }
    }

=head2 sub _get_trace_number

Trace number of a point

=cut

    sub _get_trace_number {

        my ($self) = @_;

        if (   defined $L_su_plot->{_x_pix}
            && $L_su_plot->{_x_pix} ne $empty_string
            && $L_su_plot->{_is_canvas_set} )
        {

            $canvas_data->set_x_pix( $L_su_plot->{_x_pix} );

            my $result = $canvas_data->get_x_value();
            print("L_su_plot, _get_trace_number , trace no. = $result \n");
            return ($result);

        }
        else {
            print("L_su_plot, _get_time_s, missing paramters\n");
        }
    }

=head2 _set_x_pix

=cut

    sub _set_x_pix {

        my ($x_pix) = @_;

        if ( $x_pix ne $empty_string ) {

            $L_su_plot->{_x_pix} = $x_pix;

        }
        else {
            print("L_su_plot, _set_x_pix , missing paramter\n");
        }
    }

=head2 _set_y_pix

=cut

    sub _set_y_pix {

        my ($y_pix) = @_;

        if ( $y_pix ne $empty_string ) {

            $L_su_plot->{_y_pix} = $y_pix;

        }
        else {
            print("L_su_plot, _set_y_pix , missing paramter\n");
        }
    }

=head2 sub _set_canvas_data

	get X,Y and Z coordinates for points on canvas
	selected by a single <MB-1> while pressing down

=cut

    sub _set_canvas_data {

        my ($self) = @_;

        if (   defined $L_su_plot->{_seismic_plot_x_offset_pix}
            && defined $L_su_plot->{_seismic_plot_y_offset_pix}
            && defined $L_su_plot->{_seismic_plot_width}
            && defined $L_su_plot->{_seismic_plot_height}
            && defined $L_su_plot->{_last_t_s4data}
            && defined $L_su_plot->{_first_t_s4data}
            && defined $L_su_plot->{_last_x4data}
            && defined $L_su_plot->{_first_x4data}
            && defined $L_su_plot->{_ampls} )
        {

            $canvas_data->set_seismic_plot_x_offset_pix(
                $L_su_plot->{_seismic_plot_x_offset_pix} );
            $canvas_data->set_seismic_plot_y_offset_pix(
                $L_su_plot->{_seismic_plot_y_offset_pix} );
            $canvas_data->set_seismic_plot_width(
                $L_su_plot->{_seismic_plot_width} );
            $canvas_data->set_seismic_plot_height(
                $L_su_plot->{_seismic_plot_height} );
            $canvas_data->set_t_max_s( $L_su_plot->{_last_t_s4data} );
            $canvas_data->set_t_min_s( $L_su_plot->{_first_t_s4data} );
            $canvas_data->set_x_max( $L_su_plot->{_last_x4data} );
            $canvas_data->set_x_min( $L_su_plot->{_first_x4data} );
            $canvas_data->set_ampls_pdl( $L_su_plot->{_ampls} );

            print("L_su_plot, _set_canvas_data \n");
            $L_su_plot->{_is_canvas_set} = $true;
            return ();

        }
        else {
            print("L_su_plot, _set_canvas_data, missing paramters\n");
        }
    }

=head2 sub _xy_pix_in_motion 

Get X,Y coordinates for points on canvas
selected by a single <MB-1>
$button_relase must be true for motion binding
to stay in effect

=cut

    sub _xy_pix_in_motion {

        my ($canvas) = @_;

        if ( $canvas ne $empty_string ) {
            $canvas_graph->set_widget($canvas);
            $canvas_graph->set_button_released( $L_su_plot->{_is_button_up} );
            my $xy_ref = $canvas_graph->get_xy_pix_in_motion();
            $L_su_plot->{_x_pix_in_motion}    = @$xy_ref[0];
            $L_su_plot->{_y_pix_in_motion}    = @$xy_ref[1];
            $L_su_plot->{_is_mouse_in_motion} = $true;

# print ("L_su_plot, _xy_pix_in_motion, x_pix_in_motion =$L_su_plot->{_x_pix_in_motion} y_pix_in_motion=$L_su_plot->{_y_pix_in_motion}\n");
            _rectangle_in_motion;

        }
        else {
            print("L_su_plot, _xy_pix_in_motion, missing canvas widget\n");
        }
    }

=head2 sub _xy_pix_press

Get X,Y coordinates for points on canvas
selected by a single <MB-1>

=cut

    sub _xy_pix_press {

        my ($canvas) = @_;
        if ( $canvas ne $empty_string ) {

            $canvas_graph->set_widget($canvas);
            my $x_pix_press = $canvas_graph->get_x_pix;
            my $y_pix_press = $canvas_graph->get_y_pix;

            $L_su_plot->{_is_button_down} = $true;
            $L_su_plot->{_is_button_up}   = $false;

            $canvas_graph->set_button_pressed( $L_su_plot->{_is_button_down} );
            $canvas_graph->set_button_released( $L_su_plot->{_is_button_up} );

# print("L_su_plot, _xy_pix_press, canvas xpix_press=$x_pix_press, ypix_press=$y_pix_press\n");

            $L_su_plot->{_x_pix_press} = $x_pix_press;
            $L_su_plot->{_y_pix_press} = $y_pix_press;

            # _operation_director();

        }
        else {
            print("L_su_plot, get_xy_pix, missing paramters\n");
        }
    }    # end of sub _xy_pix_press

=head2 sub _xy_pix_release

Get X,Y coordinates for points on canvas
selected by a single <MB-1>
at end of mouse motion
while rubber-banding a window for later magnification

=cut

    sub _xy_pix_release {

        my ($canvas) = @_;

        if (   $canvas ne $empty_string && $L_su_plot->{_is_button_down}
            or $L_su_plot->{_is_mouse_in_motion} )
        {

            $L_su_plot->{_is_button_down} = $false;
            $L_su_plot->{_is_button_up}   = $true;

            $canvas_graph->set_widget($canvas);
            my $x_pix_release = $canvas_graph->get_x_pix;
            my $y_pix_release = $canvas_graph->get_y_pix;
            $L_su_plot->{_x_pix_release} = $x_pix_release;
            $L_su_plot->{_y_pix_release} = $y_pix_release;

# print("L_su_plot, _xy_pix_release, canvas xpix=$x_pix_release , ypix=$y_pix_release \n");

            if ( $L_su_plot->{_is_mouse_in_motion} ) {

                my $x_pix_in_motion = $L_su_plot->{_x_pix_in_motion};
                my $y_pix_in_motion = $L_su_plot->{_y_pix_in_motion};

                $canvas_graph->set_button_pressed(
                    $L_su_plot->{_is_button_down} );
                $canvas_graph->set_button_released(
                    $L_su_plot->{_is_button_up} );

# print("L_su_plot, _xy_pix_release, mouse in motion, canvas xpix=$x_pix_release , ypix=$y_pix_release \n");
                if (   $x_pix_release == $x_pix_in_motion
                    && $y_pix_release == $y_pix_in_motion )
                {

=head3 Zoomed Image

Plot
	
=cut			

                    _rectangle_window();

                    # print("L_su_plot, _xy_pix_release, replot \n");
                    # clear out x,y pixel values in motion
                    $L_su_plot->{_x_pix_in_motion} = '';
                    $L_su_plot->{_y_pix_in_motion} = '';
                    $L_su_plot->{_x_pix_release}   = '';
                    $L_su_plot->{_y_pix_release}   = '';

                }
                else {
# print("L_su_plot, _xy_pix_release, last x or y coordinate in motion ne button release x,y \n");
                    $canvas->break;
                }

                $L_su_plot->{_is_mouse_in_motion} = $false;

            }
            else {
                &_xyz_release($canvas);

           # print("L_su_plot, _xy_pix_release, mouse is not in motion NADA\n");
            }

        }
        else {
            # print("L_su_plot, _xy_pix_release, missing parameters, NADA\n");
        }
    }    # end of sub _xy_pix_release

=head2 sub _xyz_release

Get X,Y and Z coordinates for points on canvas
selected by a single <MB-1> while pressing down

=cut

    sub _xyz_release {

        my ($canvas) = @_;

        if ( $canvas ne $empty_string ) {
            $canvas_graph->set_widget($canvas);
            my $x_pix = $canvas_graph->get_x_pix;
            my $y_pix = $canvas_graph->get_y_pix;

            # print("L_su_plot, _xyz_release, canvas widget= $canvas\n");
            # $canvas_data	-> set_widget($canvas);
            $canvas_data->set_x_pix($x_pix);
            $canvas_data->set_y_pix($y_pix);
            $canvas_data->set_seismic_plot_x_offset_pix(
                $seismic_plot_x_offset_pix);
            $canvas_data->set_seismic_plot_y_offset_pix(
                $seismic_plot_y_offset_pix);
            $canvas_data->set_seismic_plot_width($seismic_plot_width);
            $canvas_data->set_seismic_plot_height($seismic_plot_height);
            $canvas_data->set_t_max_s($last_t_s4data);
            $canvas_data->set_t_min_s($first_t_s4data);
            $canvas_data->set_x_max($last_x4data);
            $canvas_data->set_x_min($first_x4data);
            $canvas_data->set_ampls_pdl($ampls);

            my $x_value = $canvas_data->get_x_value();
            my $y_value = $canvas_data->get_y_value();
            my $z_value = $canvas_data->get_z_value();

            print(
"L_su_plot, _xyz_release, MB1 up \n trace no. = $x_value, time (s) = $y_value, amplitude = $z_value\n"
            );

        }
        else {
            print("L_su_plot, _xyz_release, missing paramters\n");
        }
    }    # end of sub _xyz_release

    # sub wiggle_hilight {
    # 	# PerlTk_plot->set_wiggle_hilight
    # 	# store wiggle number
    #
    # }
    #

    #  sub wiggle_normal {
    # 	# PerlTk_plot->set_wiggle_normal
    # 	# remove wiggle number from storage
    # }
    #
    # sub rubberband{
    #
    # }
    #
    #
    # sub zoom_in{
    #
    # }
    #
    #  sub zoom_out{
    #
    # }
    #
    #
    #  sub pan_left{
    #
    # }
    #
    #   sub pan_right{
    #
    #  }
    # from the start of this module
}
else {
    print("L_su_plot.pl, missing parameters\n");
}
