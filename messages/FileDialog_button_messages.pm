package FileDialog_button_messages;

use Moose;

sub get {
    my ( $self) = @_;
    my @message;

    $message[0] = (
"Warning: No changes. Click any: 'Values'. (FileDialog_button_messages = 0)\n"
    );

    $message[1] = (
"Warning: Not a simple flow. Try using \'Save\' for Tools. (FileDialog_button_messages = 1 )\n"
    );

    return ( \@message );
}

1;
