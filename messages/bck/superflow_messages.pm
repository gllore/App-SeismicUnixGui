package superflow_messages;

use Moose;

sub get {
    my ( $self, $number ) = @_;
    my @message;

    $message[0] = (
"Warning: No Project exists. Go back and create one using Project Selector (superflow_messages = 0)\n"
    );

    $message[1] = (
"Warning: Not a simple flow. Try using \'Save\' for Tools. (superflow_messages = 1 )\n"
    );

    return ( \@message );
}

1;
