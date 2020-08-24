package immodpg_messages;

use Moose;

sub get {
    my ( $self, $number ) = @_;
    my @message;

    $message[0] = ("Warning:   (immodpg_message=0)\n");

    return ( \@message );
}

1;

