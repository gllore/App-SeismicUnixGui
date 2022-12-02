package App::SeismicUnixGui::misc::Point;
use Moose;
use Carp;

has 'x' => ( isa => 'Num', is => 'rw' );
has 'y' => ( isa => 'Num', is => 'rw' );

sub clear {
    my ($self) = shift;
    $self->x(0);
    $self->y(0);
}

sub set_to {
    @_ == 3 or croak "Bad number of arguments";
    my ($self) = shift;
    my ( $x, $y ) = @_;
    $self->x($x);
    $self->y($y);
}
