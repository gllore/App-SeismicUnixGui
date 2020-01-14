package run_button_messages;

use Moose;

sub get {
    my ( $self, $number ) = @_;
    my @message;

    $message[0] = (
        "Warning: File not saved. First Save Tool, then Run   (run_message=0)\n"
    );
    $message[1] = (
"Warning: File not saved. Save flow, then Run. OR File/SaveAs, then Run   (run_message=1)\n"
    );
    return ( \@message );
}

1;

