package App::SeismicUnixGui::messages::null_messages;

use Moose;

sub get {
    my ( $self ) = @_;
    my @message;

    $message[0] = ("\n");

    return ( \@message );
}

1;
