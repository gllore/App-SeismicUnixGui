package color_listbox_messages;

use Moose;

sub get {
    my ( $self) = @_;
    my @message;

$message[0] = ("Warning:  You are about to overwrite a flow \n
Are you sure?

	(color_listbox_message=0)\n");
	
    return ( \@message );
}

1;