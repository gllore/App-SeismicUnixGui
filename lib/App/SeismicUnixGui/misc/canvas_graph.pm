package App::SeismicUnixGui::misc::canvas_graph;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: canvas_graph.pm
 AUTHOR: 	Juan Lorenzo
 DATE: 		February 1 2019 

 DESCRIPTION 
    
    Manage graph properties in the canvas,
    such as X,Y pixel values

 BASED ON:

  

=cut

=head2 USE

	PerlTk plotting libraries
	PDL
	and PLplot libraries via PDL

=head3 NOTES

    
=head4 Examples


=head2 CHANGES and their DATES


=cut 

=head2 Notes 

=cut

use Moose;
use App::SeismicUnixGui::misc::L_SU_global_constants;
my $get          = new L_SU_global_constants();
my $var          = $get->var();
my $empty_string = $var->{_empty_string};

=head2 privatge hash

 	with impotant key/value pairs

=cut 

my $canvas_graph = {
    _button_released => '',
    _x_pix           => '',
    _widget          => '',
    _y_pix           => '',

};

=head2 sub _get_canvas_height


=cut

sub _get_canvas_height {

    my ($self) = @_;
    if ( $canvas_graph->{_x_pix} ne $empty_string ) {
        my $x_pix = $canvas_graph->{_x_pix};
        _x_pix2time();
        my $result = $canvas_graph->{_x_pix};
        return ($result);

    }
    else {
        print(
            "canvas_graph, _get_canvas_height, missing canvas_graph->{_x_pix}\n"
        );
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub _get_canvas_width


=cut

sub _get_canvas_width {

    my ($self) = @_;
    if ( $canvas_graph->{_x_pix} ne $empty_string ) {
        my $x_pix = $canvas_graph->{_x_pix};
        _x_pix2time();
        my $result = $canvas_graph->{_x_pix};
        return ($result);

    }
    else {
        print(
            "canvas_graph, _get_canvas_width, missing canvas_graph->{_x_pix}\n"
        );
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub get_x_pix 


=cut

sub _get_x_pix {

    my ($self) = @_;

    if ( $canvas_graph->{_widget} ne $empty_string ) {

        my $canvas = $canvas_graph->{_widget};
        my $event  = $canvas->XEvent();
        my $x_pix  = $event->x;

        # print ("canvas_graph, _get_x_pix) = $x_pix\n");
        my $result = $x_pix;
        return ($result);

    }
    else {
        print("canvas_graph, _get_x_pix, missing x_pix\n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub _get_y_pix


=cut

sub _get_y_pix {

    my ( $self, $y_pix ) = @_;

    if ( $canvas_graph->{_widget} ne $empty_string ) {

        my $canvas = $canvas_graph->{_widget};
        my $event  = $canvas->XEvent();
        my $y_pix  = $event->y;

        # print ("canvas_graph, _get_y_pix = $y_pix\n");
        my $result = $y_pix;
        return ($result);

    }
    else {
        print("canvas_graph, _get_y_pix, missing canvas_graph->{_y_pix}\n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub get_x_pix 


=cut

sub get_x_pix {

    my ($self) = @_;

    if ( $canvas_graph->{_widget} ne $empty_string ) {

        my $canvas = $canvas_graph->{_widget};
        my $event  = $canvas->XEvent();
        my $x_pix  = $event->x;

        # print ("print_xy,x_pix) = $x_pix\n");
        my $result = $x_pix;
        return ($result);

    }
    else {
        print("canvas_graph, get_x_pix, missing x_pix\n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub get_xy_pix_in_motion 
	get X,Y coordinates for points on canvas
	selected by a single <MB-1>
	$button_relase must be true for motion binding
	to stay in effect

=cut

sub get_xy_pix_in_motion {

    my ($empty) = @_;

    if ( $canvas_graph->{_widget} ne $empty_string
        && !( $canvas_graph->{_button_released} ) )
    {

        my $x_pix_in_motion = _get_x_pix;
        my $y_pix_in_motion = _get_y_pix;
        my @result          = ( $x_pix_in_motion, $y_pix_in_motion );

# print("canvas_graph, get_xy_pix_in_motion, canvas xpix=$x_pix_in_motion, ypix=$y_pix_in_motion\n");
        return ( \@result );

    }
    elsif ($canvas_graph->{_widget} ne $empty_string
        && $canvas_graph->{_button_released} )
    {
        # print("canvas_graph, get_xy_pix_in_motion, button released\n");

        $canvas_graph->{_widget}->break;

    }
    else {
        print("canvas_graph, get_xy_pix_in_motion, missing paramters\n");
    }
}    # end of sub get_xy_pix_motion

=head2 sub get_y_pix


=cut

sub get_y_pix {

    my ( $self, $y_pix ) = @_;

    if ( $canvas_graph->{_widget} ne $empty_string ) {

        my $canvas = $canvas_graph->{_widget};
        my $event  = $canvas->XEvent();
        my $y_pix  = $event->y;

        # print ("print_xy, y_pix) = $y_pix\n");
        my $result = $y_pix;
        return ($result);

    }
    else {
        print("canvas_graph, get_y_pix, missing canvas_graph->{_y_pix}\n");
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub set_button_pressed


=cut

sub set_button_pressed {

    my ( $self, $button_pressed ) = @_;
    if ( $button_pressed ne $empty_string ) {

        $canvas_graph->{_button_pressed} = $button_pressed;
        return ();

    }
    else {
        print(
"canvas_graph, set_button_released, missing canvas_graph->{_button_released}\n"
        );
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub set_button_released


=cut

sub set_button_released {

    my ( $self, $button_released ) = @_;
    if ( $button_released ne $empty_string ) {

        $canvas_graph->{_button_released} = $button_released;
        return ();

    }
    else {
        print(
"canvas_graph, set_button_released, missing canvas_graph->{_button_released}\n"
        );
        my $result = $empty_string;
        return ($result);
    }
}

=head2 sub set_widget


=cut

sub set_widget {

    my ( $self, $widget ) = @_;
    if ( $widget ne $empty_string ) {

        $canvas_graph->{_widget} = $widget;
        my $result = $widget;
        return ($result);

    }
    else {
        print("canvas_graph, set_widget, missing canvas_graph->{_widget}\n");
        my $result = $empty_string;
        return ($result);
    }
}

1;
