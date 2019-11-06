package save_button_messages;

	use Moose;

	sub get {
		my ($self,$number) = @_;
		my @message;

		$message[0] = ("Warning: Needs live flow. Enter value\n");
		$message[1] = ("Warning: Needs output file name. Use SaveAs\n");

		return(\@message);
	}

1;

