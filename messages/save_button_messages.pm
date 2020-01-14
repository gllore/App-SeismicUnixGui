package save_button_messages;

use Moose;

sub get {
    my ( $self, $number ) = @_;
    my @message;

    $message[0] = (
"Warning:  Flow is unchanged. Activate flow by clicking inside parameter box  (save_button_message=0)\n"
    );
    $message[1] = (
"Warning:  Needs output file name. Use File/SaveAs. (save_button_message=1)\n"
    );

    return ( \@message );
}

1;

