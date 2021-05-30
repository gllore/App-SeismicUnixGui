package color_listbox;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PERL PROGRAM NAME: color_listbox 
 AUTHOR: 	Juan Lorenzo
 DATE: 		December 19, 2020


 DESCRIPTION 
     Basic class with color_listbox attributes

 BASED ON:


=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head2 CHANGES and their DATES

=cut 

=head2 Notes from bash
 
=cut 

use Moose;
use namespace::autoclean;    # best-practices hygiene
our $VERSION = '0.0.1';

=head2 Import modules

=cut

extends 'gui_history' => { -version => 0.0.2 };
use L_SU_global_constants;

=head2 Instantiation

=cut

my $get         = L_SU_global_constants->new();
my $gui_history = gui_history->new();

=head2 Declare Special Variables

=cut

my $var          = $get->var();
my $on           = $var->{_on};
my $true         = $var->{_true};
my $false        = $var->{_false};
my $empty_string = $var->{_empty_string};

=head2 Defaults

=cut

my $color_start                     = 'grey';
my $occupied_start                  = $false;
my $future_occupied_start           = $false;
my $vacant_start                    = $true;
my $future_vacancy_start            = $false;
my $flow_listbox_color_start        = $color_start;
my $flow_listbox_color2check_start  = $color_start;
my $future_flow_listbox_color_start = $color_start;
my $yes                             = $var->{_yes};
my $no                              = $var->{_no};
my $dialog_box_ok_default           = $no;
my $dialog_box_cancel_default       = $no;
my $dialog_box_click_default        = $no;
my $my_dialog_box_click_start        = $no;
my $my_dialog_cancel_click_start    = $no;
my $my_dialog_ok_click_start        = $no;


# initialization only
# must be populated fromt he outside via set_hash_ref
my $color_listbox_href = $gui_history->get_defaults();

=head2 private anonymous array

=cut

my $color_listbox = {
	_is_flow_listbox_color_available => '',
	_is_flow_listbox_blue_w       => '',
	_is_flow_listbox_green_w      => '',
	_is_flow_listbox_grey_w       => '',
	_is_flow_listbox_pink_w       => '',
	_is_future_flow_listbox_blue  => '',
	_is_future_flow_listbox_color => '',
	_is_future_flow_listbox_green => '',
	_is_future_flow_listbox_grey  => '',
	_is_future_flow_listbox_pink  => '',
	_my_dialog_cancel_click       => $dialog_box_cancel_default,
	_my_dialog_box_click          => $dialog_box_click_default,
	_my_dialog_ok_click => $dialog_box_ok_default,
	_this_package            => '',
};

sub BUILD {
	my ($this_package_address) = @_;
	
	$color_listbox->{_this_package} = $this_package_address;
	
}

#print("2. color_listbox, color_listbox->{_my_dialog_box_click}=$color_listbox->{_my_dialog_box_click}\n");

=head2 private anonymous hashes 
containing history

=cut

=head2 initialize arrays

=cut

=head2 sub default_future_occupied_listbox_aref

Initialize array of future occupied-flow-listbox-array
indicators that indicate which listbox will next be
used

=cut

sub _default_future_occupied_listbox_aref {

	my ($self) = @_;

	my @future_occupied_listbox = (
		$future_occupied_start,
		$future_occupied_start,
		$future_occupied_start,
		$future_occupied_start
	);

	my $flow_listbox_future_occupancy_aref = \@future_occupied_listbox;
	return ($flow_listbox_future_occupancy_aref);

}

=head2 sub default_occupied_listbox_aref

Initialize array of occupied-flow-listbox-array
indicators

=cut

sub _default_occupied_listbox_aref {

	my ($self) = @_;

	my @occupied_listbox = (
		$occupied_start,
		$occupied_start,
		$occupied_start,
		$occupied_start
	);

	my $flow_listbox_occupancy_aref = \@occupied_listbox;
	return ($flow_listbox_occupancy_aref);

}

=head2 sub default_future_vacancy_listbox_aref

Initialize array of future vacant-flow-listbox-array
indicators that indicate which listbox will next be
used

=cut

sub _default_future_vacancy_listbox_aref {

	my ($self) = @_;

	my @future_vacancy_listbox = (
		$future_vacancy_start,
		$future_vacancy_start,
		$future_vacancy_start,
		$future_vacancy_start
	);

	my $flow_listbox_future_vacancy_aref = \@future_vacancy_listbox;
	return ($flow_listbox_future_vacancy_aref);

}

=head2 sub _default_vacant_listbox_aref

Initialize array of empty-flow-listbox-array
indicators

=cut

sub _default_vacant_listbox_aref {

	my ($self) = @_;

	my @vacant_listbox = (
		$vacant_start,
		$vacant_start,
		$vacant_start,
		$vacant_start
	);

	my $flow_listbox_vacancy_aref = \@vacant_listbox;
	return ($flow_listbox_vacancy_aref);

}

=head2 Declare attributes

=cut

has 'flow_listbox_color2check' => (
	default => $flow_listbox_color2check_start,
	is      => 'rw',
	isa     => 'Str',
	writer  => 'set_flow_listbox_color2check',
	trigger => \&_flow_listbox_color2check,
);

has 'flow_listbox_color' => (
	default   => $flow_listbox_color_start,
	is        => 'rw',
	isa       => 'Str',
	reader    => 'get_flow_listbox_color',
	writer    => 'set_flow_listbox_color',
	predicate => 'has_flow_listbox_color',
	trigger   => \&_update_flow_listbox_color,
);

has 'flow_listbox_future_occupancyNvacancy_aref' => (
	default   => \&_default_future_occupied_listbox_aref,
	is        => 'ro',
	isa       => 'ArrayRef',
	reader    => 'get_flow_listbox_future_occupancyNvacancy_aref',
	writer    => 'set_flow_listbox_future_occupancyNvacancy_aref',
	predicate => 'has_flow_listbox_future_occupancyNvacancy_aref',
	trigger   => \&_update_flow_listbox_future_occupancyNvacancy_aref,
);

has 'flow_listbox_occupancy_aref' => (
	default   => \&_default_occupied_listbox_aref,
	is        => 'ro',
	isa       => 'ArrayRef',
	reader    => 'get_flow_listbox_occupancy_aref',
	writer    => 'set_flow_listbox_occupancy_aref',
	predicate => 'has_flow_listbox_occupancy_aref',
	# trigger method is not in use
);


has 'flow_listbox_vacancy_color' => (
	default   => $color_start,
	is        => 'ro',
	isa       => 'Str',
	reader    => 'get_flow_listbox_vacancy_color',
	writer    => 'set_flow_listbox_vacancy_color',
	predicate => 'has_flow_listbox_vacancy_color',

);

has 'flow_listbox_vacancy_aref' => (
	default   => \&_default_vacant_listbox_aref,
	is        => 'ro',
	isa       => 'ArrayRef',
	reader    => 'get_flow_listbox_vacancy_aref',
	predicate => 'has_flow_listbox_vacancy_aref',
	# trigger method is not in use
);

has 'future_flow_listbox_color' => (
	default => $future_flow_listbox_color_start,
	is      => 'rw',
	isa     => 'Str',
	reader  => 'get_future_flow_listbox_color',
	writer  => 'set_future_flow_listbox_color',
	trigger => \&_update_future_flow_listbox_color,
);
has my_dialog_cancel_click => (
	default => $my_dialog_cancel_click_start,
	is      => 'rw',
	isa     => 'Str',
	reader  => 'get_my_dialog_cancel_click',
	writer  => 'set_my_dialog_cancel_click',
	trigger => \&_update_my_dialog_cancel_click,
);
has my_dialog_ok_click => (
	default => $my_dialog_ok_click_start,
	is      => 'rw',
	isa     => 'Str',
	reader  => 'get_my_dialog_ok_click',
	writer  => 'set_my_dialog_ok_click',
#	trigger => \&_update_my_dialog_ok_click,
);

has my_dialog_box_click => (
	default => $my_dialog_box_click_start,
	is      => 'rw',
	isa     => 'Str',
	reader  => 'get_my_dialog_box_click',
	writer  => 'set_my_dialog_box_click',
);

=head2  sub _flow_listbox_color2check

=cut

sub _flow_listbox_color2check {
	my ( $color_listbox, $new_current_flow_listbox_color2check, $new_prior_flow_listbox_color2check ) = @_;

	my $check = $new_current_flow_listbox_color2check;

	#	print("color_listbox, _flow_listbox_color2check, check=$check\n");

	if (   length $check
		&& length $color_listbox
		&& length $color_listbox->get_flow_listbox_occupancy_aref()
		&& length $color_listbox->get_flow_listbox_vacancy_aref() ) {

		my @occupied_listbox = @{ $color_listbox->get_flow_listbox_occupancy_aref() };
		my @vacant_listbox   = @{ $color_listbox->get_flow_listbox_vacancy_aref() };

		#		print(" color_listbox,_flow_listbox_color2check,occupied_listbox=@occupied_listbox \n");
		#		print(" color_listbox,_flow_listbox_color2check,vacant_listbox=@vacant_listbox \n");

		if (   $check eq 'grey'
			&& $occupied_listbox[0] == $false
			&& $vacant_listbox[0] == $true ) {

			#						print("color_listbox, _flow_listbox_color2check, grey flow box is empty\n");
			#			print(
			#				"color_listbox, _flow_listbox_color2check, occupied_listbox=$occupied_listbox[0], vacant_listbox=$vacant_listbox[0]\n"
			#			);
			#			print(
			#				"color_listbox, _flow_listbox_color2check, color_listbox->{_is_flow_listbox_color_available}=$color_listbox->{_is_flow_listbox_color_available}\n"
			#			);
			$color_listbox->{_is_flow_listbox_color_available} = $true;

		} elsif ( $check eq 'pink'
			&& $occupied_listbox[1] == $false
			&& $vacant_listbox[1] == $true ) {

			#						print("color_listbox, _flow_listbox_color2check, pink flow box is empty\n");
			#			print(
			#				"color_listbox, _flow_listbox_color2check, occupied_listbox=$occupied_listbox[1], vacant_listbox=$vacant_listbox[1]\n"
			#			);
			$color_listbox->{_is_flow_listbox_color_available} = $true;

			#			print("color_listbox, _flow_listbox_color2check,color_listbox->{_is_flow_listbox_color_available}=$color_listbox->{_is_flow_listbox_color_available}\n");

			#			print(
			#				"color_listbox, _flow_listbox_color2check, color_listbox->{_is_flow_listbox_color_available}=$color_listbox->{_is_flow_listbox_color_available}\n"
			#			);

		} elsif ( $check eq 'green'
			&& $occupied_listbox[2] == $false
			&& $vacant_listbox[2] == $true ) {

			#						print("color_listbox, _flow_listbox_color2check, green flow box is empty\n");
			#			print(
			#				"color_listbox, _flow_listbox_color2check, occupied_listbox=$occupied_listbox[2], vacant_listbox=$vacant_listbox[2]\n"
			#			);
			$color_listbox->{_is_flow_listbox_color_available} = $true;

		} elsif ( $check eq 'blue'
			&& $occupied_listbox[3] == $false
			&& $vacant_listbox[3] == $true ) {

			#						print("color_listbox, _flow_listbox_color2check, blue flow box is empty\n");
			#			print(
			#				"color_listbox, _flow_listbox_color2check, occupied_listbox=$occupied_listbox[3], vacant_listbox=$vacant_listbox[3]\n"
			#			);
			$color_listbox->{_is_flow_listbox_color_available} = $true;

		} else {

			#			print("color_listbox, _flow_listbox_color2check, no flow box is available\n");
			$color_listbox->{_is_flow_listbox_color_available} = $false;

			#			print(
			#				"color_listbox, _flow_listbox_color2check, color_listbox->{_is_flow_listbox_color_available}=$color_listbox->{_is_flow_listbox_color_available}\n"
			#			);
		}

		my $result = $color_listbox->{_is_flow_listbox_color_available};
		&_set_flow_listbox_color_available($result);

		#		print("color_listbox, _flow_listbox_color2check, result =$result\n");
		return ();

	} else {

		# ans= NOT free
		print("color_listbox, colored box is already occupied\n");

		#NADA
	}
	return ();
}

=head2 sub _get_message_box_ok_click

=cut

sub _get_message_box_ok_click {

	my ($self) = @_;
	my $message_box_ok_click = $color_listbox->{_message_box_ok_click};

	#	print("color_listbox, _get_message_box_ok_click ,color_listbox->{_message_box_ok_click}\n");
	return ($message_box_ok_click);

}

=head2 sub _get_my_dialog_cancel_click

=cut

sub _get_my_dialog_cancel_click {
	my ($self) = @_;

	my $cancel_click = $color_listbox->{_my_dialog_cancel_click};
	return ($cancel_click);
}

=head2 sub _get_my_dialog_box_click

=cut

sub _get_my_dialog_box_click {
	my ($self) = @_;

	my $response = $color_listbox->{_my_dialog_box_click};

	#	print("color_listbox,_get_my_dialog_box_click, color_listbox->{_my_dialog_box_click} = $color_listbox->{_my_dialog_box_click}\n");
	return ($response);

}

=head2 sub _get_my_dialog_ok_click

=cut

sub _get_my_dialog_ok_click {
	my ($self) = @_;

	my $response = $color_listbox->{_my_dialog_ok_click};

	#	print("color_listbox,_get_my_dialog_ok_click, color_listbox->{_my_dialog_ok_click} = $color_listbox->{_my_dialog_ok_click}\n");
	return ($response);

}

=head2 sub _hide_dialog_box

=cut

sub _hide_dialog_box {
	my ($self) = @_;

	my $my_dialog_box = $color_listbox_href->{_my_dialog_box_w};
	$my_dialog_box->grabRelease;
	$my_dialog_box->withdraw;
}

=head2 sub _set_flow_listbox_color_available

Mark the listbox color in use

=cut

sub _set_flow_listbox_color_available {

	my ($ans) = @_;

	if ( length $ans ) {

		$color_listbox->{_is_flow_listbox_color_available} = $ans;

		#		print("color_listbox, _set_flow_listbox_color_available=\$color_listbox->{_is_flow_listbox_color_available}\n");

	} else {
		print("color_listbox, _set_flow_listbox_color_available, unexpected result\n");
	}

	return ();
}

=head2 sub _set_message_box_ok_click

=cut

sub _set_message_box_ok_click {
	my ($self) = @_;

	$color_listbox->{_message_box_ok_click} = $yes;

	#	print("color_listbox,_set_message_box_ok_click ,color_listbox->{_message_box_ok_click} = $yes \n");
}

=head2 sub _set_my_dialog_box_click

=cut

sub _set_my_dialog_box_click {
	my ($ans) = @_;
    my $self = shift;
	$color_listbox->{_my_dialog_box_click} = $ans;
	$color_listbox->{_this_package}->set_my_dialog_box_click($ans);
	#	print("color_listbox,_set_my_dialog_box_click ,color_listbox->{_my_dialog_box_click} = $ans \n");
}

=head2 sub _set_my_dialog_ok_click

=cut

sub _set_my_dialog_ok_click {
	my ($ans) = @_;

	$color_listbox->{_my_dialog_ok_click} = $ans;
	($color_listbox->{_this_package})->set_my_dialog_ok_click($ans);

	#	print("color_listbox,_set_my_dialog_ok_click ,color_listbox->{_my_dialog_ok_click} = $ans \n");
}

=head2 sub _set_my_dialog_cancel_click

=cut

sub _set_my_dialog_cancel_click {
	my ($ans) = @_;

	$color_listbox->{_my_dialog_cancel_click} = $ans;
	($color_listbox->{_this_package})->set_my_dialog_cancel_click($ans);
	#	print("color_listbox,_set_message_box_cancel_click ,color_listbox->{_my_dialog_cancel_click} = $ans \n");
}

=head2 sub _set_shared_wait1

=cut

sub _set_shared_wait1 {

	my ($self) = @_;

	#	my $ok_click = &_get_my_dialog_ok_click();

	&_set_my_dialog_ok_click('yes');
	&_set_my_dialog_box_click('yes');

	my $ok_click = &_get_my_dialog_ok_click();

	#	print("ok,=$ok_click\n");

	my $my_dialog_box = $color_listbox_href->{_my_dialog_box_w};

	#	my $ok_button  = $color_listbox_href->{_my_dialog_ok_button};
	#	print("color_list_set_shared_wait,ok_click=$ok_click \n");
	&_hide_dialog_box($my_dialog_box);

	return ();
}

=head2 sub _set_shared_wait2

=cut

sub _set_shared_wait2 {

	my ($self) = @_;

	&_set_my_dialog_cancel_click('yes');
	&_set_my_dialog_box_click('yes');

	my $cancel_click  = &_get_my_dialog_cancel_click();
	my $my_dialog_box = $color_listbox_href->{_my_dialog_box_w};
#	print("color_listbox_set_shared_wait2,cancel_click=$cancel_click \n");
	&_hide_dialog_box($my_dialog_box);

	return ();
}


=head2 sub _update_flow_listbox_color

Mark the listbox color in use

=cut

sub _update_flow_listbox_color {

	my ( $color_listbox, $new_current_flow_listbox_color, $new_prior_flow_listbox_color ) = @_;

	if ( length $new_current_flow_listbox_color ) {

		if (   $new_current_flow_listbox_color eq 'grey'
			or $new_current_flow_listbox_color eq '' ) {

			$color_listbox->{_is_flow_listbox_grey_w} = $true;
			_update_flow_listbox_occupancyNvacancy_aref($color_listbox);
			_update_flow_listbox_vacancy_color($color_listbox);

			#			print("1. color_listbox, _update_flow_listbox_color\n");

		} elsif ( $new_current_flow_listbox_color eq 'pink' ) {

			$color_listbox->{_is_flow_listbox_pink_w} = $true;
			_update_flow_listbox_occupancyNvacancy_aref($color_listbox);
			_update_flow_listbox_vacancy_color($color_listbox);

			#			print("2. color_listbox, _update_flow_listbox_color\n");

		} elsif ( $new_current_flow_listbox_color eq 'green' ) {

			#			print("3. color_listbox, _update_flow_listbox_color\n");
			$color_listbox->{_is_flow_listbox_green_w} = $true;
			_update_flow_listbox_occupancyNvacancy_aref($color_listbox);
			_update_flow_listbox_vacancy_color($color_listbox);

		} elsif ( $new_current_flow_listbox_color eq 'blue' ) {

			#			print("4. color_listbox, _update_flow_listbox_color\n");
			$color_listbox->{_is_flow_listbox_blue_w} = $true;
			_update_flow_listbox_occupancyNvacancy_aref($color_listbox);
			_update_flow_listbox_vacancy_color($color_listbox);

		} else {
			print("color_listbox,_set_flow_listbox, missing color \n");
		}
	}
	return ();
}

=head2 sub _update_flow_listbox_future_occupancyNvacancy_aref

Update which listboxes (colors)  are in use (occupancy)
and which are not (vacancies)

=cut

sub _update_flow_listbox_future_occupancyNvacancy_aref {

	my (
		$color_listbox, $new_current_flow_listbox_future_occupancy_aref,
		$new_prior_flow_listbox_future_occupancy_aref
	) = @_;

	my @vacant_listbox;

	$color_listbox->{flow_listbox_occupancy_aref} = $new_current_flow_listbox_future_occupancy_aref;
	@vacant_listbox = @{ $color_listbox->get_flow_listbox_vacancy_aref() };
	my $length = scalar @vacant_listbox;

	if (@vacant_listbox) {

		for ( my $i = 0; $i < $length; $i++ ) {

			$vacant_listbox[$i] = abs( @{$new_current_flow_listbox_future_occupancy_aref}[$i] - 1 );

		}

		_update_flow_listbox_vacancy_color($color_listbox);

		#		print("color_listbox,_update_flow_listbox_future_occupancyNvacancy_aref vacant_listbox=@vacant_listbox\n");
		#	    print("color_listbox,_update_flow_listbox_future_occupancyNvacancy_aref vacant_listbox, new_current_flow_listbox_future_occupancy_aref =@{$new_current_flow_listbox_future_occupancy_aref}\n");

	} else {
		print("color_listbox,_update_flow_listbox_occupancyNvacancy_aref, missing vacant listbox,\n");
	}

	return ();

}

=head2 sub _update_flow_listbox_occupancyNvacancy_aref

=cut

sub _update_flow_listbox_occupancyNvacancy_aref {

	my ($color_listbox) = @_;

	#	print("1. color_listbox,_update_flow_listbox_occupancyNvacancy_aref\n");
	my @occupied_listbox = @{ $color_listbox->get_flow_listbox_occupancy_aref() };
	my @vacant_listbox   = @{ $color_listbox->get_flow_listbox_vacancy_aref() };

	if (@occupied_listbox) {

		if (   $color_listbox->get_flow_listbox_color() eq 'grey'
			or $color_listbox->get_flow_listbox_color() eq '' ) {

			$occupied_listbox[0] = $true;
			$vacant_listbox[0]   = $false;

			#			print("1. color_listbox,_update_flow_listbox_occupancyNvacancy_aref color:\n");

		} elsif ( $color_listbox->get_flow_listbox_color() eq 'pink' ) {

			$occupied_listbox[1] = $true;
			$vacant_listbox[1]   = $false;

			#			print("2. color_listbox,_update_flow_listbox_occupancyNvacancy_aref color:\n");

		} elsif ( $color_listbox->get_flow_listbox_color() eq 'green' ) {

			#			print("3. color_listbox,_update_flow_listbox_occupancyNvacancy_aref color:\n");
			$occupied_listbox[2] = $true;
			$vacant_listbox[2]   = $false;

		} elsif ( $color_listbox->get_flow_listbox_color() eq 'blue' ) {

			# print("L_SU,_set_flow_listbox, color:$color\n");
			$occupied_listbox[3] = $true;
			$vacant_listbox[3]   = $false;

		} elsif ( $color_listbox->get_flow_listbox_color() eq 'neutral' ) {

			# CASE perl flow selection when none of the listboxes are occupied
			# default to grey listbox
			$occupied_listbox[0] = $true;
			$vacant_listbox[0]   = $false;

		} else {
			print("color_listbox,_update_flow_listbox_occupancyNvacancy_aref,:bad flow color \n");
		}

		$color_listbox->{flow_listbox_occupancy_aref} = \@occupied_listbox;
		$color_listbox->{flow_listbox_vacancy_aref}   = \@vacant_listbox;

		#		my @ans = @{ $color_listbox->get_flow_listbox_occupancy_aref };
		#		print("color_listbox,_update_flow_listbox_occupancyNvacancy_aref,color_listbox->flow_listbox_occupancy_aref=...@ans...\n");
		#		@ans = @{ $color_listbox->get_flow_listbox_vacancy_aref };
		#		print("color_listbox,_update_flow_listbox_occupancyNvacancy_aref,color_listbox->flow_listbox_vacancy_aref=...@ans...\n");

	} else {
		print("color_listbox,_update_flow_listbox_occupancyNvacancy_aref, missing flow color, NADA\n");
	}

	return ();

}

=head2 sub _update_flow_listbox_vacancy_color 

Mark the next vacant color

=cut

sub _update_flow_listbox_vacancy_color {

	my ($color_listbox) = @_;
	my $color;

	if ($color_listbox) {

		my @occupied_listbox = @{ $color_listbox->{flow_listbox_occupancy_aref} };
		my @vacant_listbox   = @{ $color_listbox->{flow_listbox_vacancy_aref} };

		if ( $occupied_listbox[0] == $false ) {

			$color = 'grey';

			#			print("color_listbox, _update_flow_listbox_vacancy_color, color=$color\n");

		} elsif ( $occupied_listbox[1] == $false ) {

			$color = 'pink';

			#			print("color_listbox, _update_flow_listbox_vacancy_color, color=$color\n");

		} elsif ( $occupied_listbox[2] == $false ) {

			$color = 'green';

			#			print("color_listbox, _update_flow_listbox_vacancy_color, color=$color\n");

		} elsif ( $occupied_listbox[3] == $false ) {

			$color = 'blue';

			#			print("color_listbox, _update_flow_listbox_vacancy_color, color=$color\n");

		} else {

			#			print("color_listbox, _update_flow_listbox_vacancy_color, All boxes are empty\n");
			$color = 'grey';

			#			print("color_listbox, _update_flow_listbox_vacancy_color,default listbox opened =  $color \n");
		}

	} else {

		#		print("color_listbox, _update_flow_listbox_vacancy_color, unexpected error\n");
		$color = 'grey';

		#		print("color_listbox, _update_flow_listbox_vacancy_color, color=$color\n");
	}

	$color_listbox->{flow_listbox_vacancy_color} = $color;

	#	 print("color_listbox, _update_flow_listbox_vacancy_color , next vacant color =  $color \n");

	return ();
}

=head2 sub _update_flow_listbox_vacancy_aref 

Mark the listbox color in use

=cut

sub _update_flow_listbox_vacancy_aref {

	my ( $color_listbox, $new_current_flow_listbox_vacancy_aref, $new_prior_flow_listbox_vacancy_aref ) = @_;

	#		print("trigger on  vacancy\n");

	if ( length $new_current_flow_listbox_vacancy_aref ) {

		my $occupied_listbox_aref = $color_listbox->get_flow_listbox_occupancy_aref();
		my $vacant_listbox_aref   = $color_listbox->get_flow_listbox_vacancy_aref();

		my @occupied_listbox = @{$occupied_listbox_aref};
		my @vacant_listbox   = @{$vacant_listbox_aref};

		print("1. _update_flow_listbox_vacancy_aref , occupied_listbox=@occupied_listbox\n");
		print("2. _update_flow_listbox_vacancy_aref , vacant_listbox= @vacant_listbox \n");

		if (   $new_current_flow_listbox_vacancy_aref eq 'grey'
			or $new_current_flow_listbox_vacancy_aref eq '' ) {

			$occupied_listbox[0] = $true;
			$vacant_listbox[0]   = $false;

			#			print("1. L_SU,_set_flow_listbox, color:$color \n");

		} elsif ( $new_current_flow_listbox_vacancy_aref eq 'pink' ) {

			$occupied_listbox[1] = $true;
			$vacant_listbox[1]   = $false;

			# print("L_SU,_set_flow_listbox, color:$color\n");

		} elsif ( $new_current_flow_listbox_vacancy_aref eq 'green' ) {

			# print("L_SU,_set_flow_listbox, color:$color\n");
			$occupied_listbox[2] = $true;
			$vacant_listbox[2]   = $false;

		} elsif ( $new_current_flow_listbox_vacancy_aref eq 'blue' ) {

			# print("L_SU,_set_flow_listbox, color:$color\n");
			$occupied_listbox[3] = $true;
			$vacant_listbox[3]   = $false;

			# CASE perl flow selection when none of the listboxes are occupied
			# default to gray listbox
		} elsif ( $new_current_flow_listbox_vacancy_aref eq 'neutral' ) {

			$occupied_listbox[0] = $true;

		} else {
			print("color_listbox,_update_flow_listbox_vacancy_aref ,:bad flow color \n");
		}

		$color_listbox->set_flow_listbox_occupancy_aref( \@occupied_listbox );
		my @ans = @{ $color_listbox->get_flow_listbox_occupancy_aref };
		print("3.color_listbox,_update_flow_listbox_vacancy_aref , color_listbox->flow_listbox_occupied @ans \n");

		$color_listbox->set_flow_listbox_vacancy_aref( \@vacant_listbox );
		my @ans2 = @{ $color_listbox->get_flow_listbox_vacancy_aref };
		print("4. .color_listbox,_update_flow_listbox_vacancy_aref ,color_listbox->flow_listbox_vacancy= @ans2 \n");

	} else {
		print("color_listbox,_update_flow_listbox_vacancy_aref , missing flow color, NADA\n");
	}

	return ();

}

=head2 sub _update_future_flow_listbox_color

Mark the future listbox color to use
Mark next available color listbox vacant
Give preference to the future listbox

=cut

sub _update_future_flow_listbox_color {

	my ( $color_listbox, $new_current_future_flow_listbox_color, $new_prior_future_flow_listbox_color ) = @_;

	#	print( "color_listbox,_update_future_flow_listbox_color,new_current_future_flow_listbox_color=$new_current_future_flow_listbox_color, new_prior_future_flow_listbox_color=$new_prior_future_flow_listbox_color\n" );

	my $color;

	if ( $new_current_future_flow_listbox_color eq 'grey' ) {

		$color_listbox->{_is_future_flow_listbox_grey}  = $true;
		$color_listbox->{_is_future_flow_listbox_pink}  = $false;
		$color_listbox->{_is_future_flow_listbox_green} = $false;
		$color_listbox->{_is_future_flow_listbox_blue}  = $false;
		$color                                          = 'grey';
		$color_listbox->{future_flow_listbox_color}     = $color;
		$color_listbox->{_is_future_flow_listbox_grey}  = $false;    #clean

		#		print("1. color_listbox,_update_future_flow_listbox_color, color:$color \n");

	} elsif ( $new_current_future_flow_listbox_color eq 'pink' ) {

		$color_listbox->{_is_future_flow_listbox_grey}  = $false;
		$color_listbox->{_is_future_flow_listbox_pink}  = $true;
		$color_listbox->{_is_future_flow_listbox_green} = $false;
		$color_listbox->{_is_future_flow_listbox_blue}  = $false;
		$color                                          = 'pink';
		$color_listbox->{future_flow_listbox_color}     = $color;
		$color_listbox->{_is_future_flow_listbox_pink}  = $false;    #clean

		#		print("2. color_listbox,_update_future_flow_listbox_color, color:$color\n");

	} elsif ( $new_current_future_flow_listbox_color eq 'green' ) {

		#		print("3. color_listbox,_update_future_flow_listbox_color, color: green\n");
		$color_listbox->{_is_future_flow_listbox_grey}  = $false;
		$color_listbox->{_is_future_flow_listbox_pink}  = $false;
		$color_listbox->{_is_future_flow_listbox_green} = $true;
		$color_listbox->{_is_future_flow_listbox_blue}  = $false;
		$color                                          = 'green';
		$color_listbox->{future_flow_listbox_color}     = $color;
		$color_listbox->{_is_future_flow_listbox_green} = $false;    #clean

	} elsif ( $new_current_future_flow_listbox_color eq 'blue' ) {

		#		print("4. color_listbox,_update_future_flow_listbox_color, color:blue\n");
		$color_listbox->{_is_future_flow_listbox_grey}  = $false;
		$color_listbox->{_is_future_flow_listbox_pink}  = $false;
		$color_listbox->{_is_future_flow_listbox_green} = $false;
		$color_listbox->{_is_future_flow_listbox_blue}  = $true;
		$color                                          = 'blue';
		$color_listbox->{future_flow_listbox_color}     = $color;
		$color_listbox->{_is_future_flow_listbox_blue}  = $false;    #clean

	} else {
		print("color_listbox,_update_future_flow_listbox_color, missing color \n");
	}

	return ();
}

=head2 sub _update_my_dialog_ok_click

Get the user's answer to 
my dialog is yes or no

=cut

sub _update_my_dialog_ok_click {

	my ( $self, $new_current_my_dialog_ok_click, $new_prior_my_dialog_ok_click ) = @_;

#	print("color_listbox, _update_my_dialog_ok_click,new_prior_my_dialog_ok_click=$new_prior_my_dialog_ok_click\n");
#	print("color_listbox, _update_my_dialog_ok_click,new_current_my_dialog_ok_click=$new_current_my_dialog_ok_click\n");

	if ( length $new_current_my_dialog_ok_click ) {
		$color_listbox->{_my_dialog_ok_click} = $my_dialog_ok_click_start;

	} else {
		print("color_listbox,update_my_dialog_ok_click, unexpected values \n");
	}
	return ();
}

=head2 sub _update_my_dialog_cancel_click

Get the user's answer to 
my dialog is yes or no

=cut

sub _update_my_dialog_cancel_click {

	my ( $self, $new_current_my_dialog_cancel_click, $new_prior_my_dialog_cancel_click ) = @_;

#	print("color_listbox, _update_my_dialog_cancel_click,new_prior_my_dialog_cancel_click=$new_prior_my_dialog_cancel_click\n"
#	);
#	print("color_listbox, _update_my_dialog_cancel_click,new_current_my_dialog_cancel_click=$new_current_my_dialog_cancel_click\n"
#	);

#	print("color_listbox, update_my_dialog_cancel_click\n");

	if ( length( $color_listbox->{_my_dialog_cancel_click} ) ) {

		$color_listbox->{_my_dialog_cancel_click} = $my_dialog_cancel_click_start;

	} else {
		print("color_listbox,get_my_dialog_cancel, unexpected values \n");
	}
	return ();
}

=head2 sub initialize_my_dialogs
Create widgets that show messages
Show warnings or errors in a message box
Message box is defined in main where it is
also made invisible (withdraw)
Here we turn on the message box (deiconify, raise)
The message does not release the program
until OK or CANCEL is clicked and wait variable changes from yes 
to no.
Widgets belong to the MainWindow that is created
first in L_SUVx.x.pl

=cut

sub initialize_my_dialogs {

	my ( $self, $ok_button, $label, $cancel_button, $top_level ) = @_;

	if (   length $ok_button
		&& length $label
		&& $cancel_button
		&& $top_level ) {

		$ok_button->configure(
			-command => [ \&_set_shared_wait1 ],
		);

		$cancel_button->configure(
			-command => [ \&_set_shared_wait2 ],
		);

	} else {
		print("color_listbox, initialize_my_dialogs, missing widgets \n");
	}
	return ();
}

=head2 sub initialize_messages
Create widgets that show messages
Show warnings or errors in a message box
Message box is defined in main where it is
also made invisible (withdraw)
Here we turn on the message box (deiconify, raise)
The message does not release the program
until OK is clicked and wait variable changes from no
to yes.
Widgets belong to the MainWindow that is created
first in L_SUVx.x.pl

=cut

sub initialize_messages {

	my ($self) = @_;

	my $wait = 'no';

	$color_listbox_href->{_message_ok_button}->configure(
		-command => sub {
			print("color_listbox,initialize_messages1. wait = $wait\n");
			&_set_message_box_ok_click();
			$wait = &_get_message_box_ok_click();
			print("color_listbox, initialize_messages, 3. wait = $wait\n");
			print("color_listbox,i nitialize_messages, 4. wait = $wait\n");
			$color_listbox_href->{_message_box_w}->grabRelease;
			$color_listbox_href->{_message_box_w}->withdraw;
		},
	);

	# stop code until user EITHER clicks ok () or cancel and
	# variable changes
	# Otherwise, upper class program races ahead
	# initializes fine, but is first implemented next time
	( $color_listbox_href->{_message_box_w} )->waitVariable( \$wait );

	return ();
}

=head2 sub is_flow_listbox_color2check
Check wether a listbox of a certain color
is already occupied

=cut

sub is_flow_listbox_color2check {
	my ($self) = @_;

	#	print("color_listbox, is_flow_listbox_color2check, color_listbox->{_is_flow_listbox_color_available}=$color_listbox->{_is_flow_listbox_color_available}\n"
	#	);

	if ( length $color_listbox->{_is_flow_listbox_color_available} ) {

		my $response = $color_listbox->{_is_flow_listbox_color_available};
		return ($response);

	} else {

		#		print(
		#			"color_listbox, is_flow_listbox_color2check, color_listbox->{_is_flow_listbox_color_available}=$color_listbox->{_is_flow_listbox_color_available}\n"
		#		);
		print("color_listbox, is_flow_listbox_color2check, unexpected result\n");
		return ();
	}
}

sub is_vacant_listbox {

	my ( $self, $color ) = @_;

#	print("1 color_listbox, is_vacant_listbox, currently, color to test for occupation=  $color \n");

	my @vacant_listbox = @{ $self->get_flow_listbox_vacancy_aref() };

	if ( scalar(@vacant_listbox) ) {
		if (   $vacant_listbox[0] == $false
			&& $color eq 'grey' ) {

#		    print("1 color_listbox, is_vacant_listbox, grey is already occupied \n");
			return ($false);

		} elsif ( $vacant_listbox[1] == $false
			&& $color eq 'pink' ) {

			#            print("1 color_listbox, is_vacant_listbox, pink  is already occupied \n");
			return ($false);

		} elsif ( $vacant_listbox[2] == $false
			&& $color eq 'green' ) {

			#            print("1 color_listbox, is_vacant_listbox, green is already occupied \n");
			return ($false);

		} elsif ( $vacant_listbox[3] == $false
			&& $color eq 'blue' ) {

			#            print("1 color_listbox, is_vacant_listbox, blue  is already occupied \n");
			return ($false);

		} else {

			#			print("color_listbox, _is_vacant_listbox, $color listbox seems vacant\n");
			return ($true);
		}

	} else {
		print("color_listbox, _is_vacant_listbox, difficult to say\n");
		return ();
	}
}

=head2 sub messages
Show warnings or errors in a message box
Message box is defined in main where it is
also made invisible (withdraw)
Here we turn on the message box (deiconify, raise)
The message does not release the program
until OK is clicked and wait variable changes from no 
to yes.

=cut

sub messages {

	my ( $self, $run_name, $number ) = @_;

	use message_director;
	my $run_name_message = message_director->new();
	my $message          = $run_name_message->color_listbox($number);

	my $message_box   = $color_listbox_href->{_message_box_w};
	my $message_label = $color_listbox_href->{_message_label_w};

	$message_box->title($run_name);

	$message_label->configure(
		-textvariable => \$message,
	);

	$message_box->deiconify();
	$message_box->raise();

	return ();
}

=head2 sub my_dialogs
Show warnings or errors in a message box
Message box is defined in main where it is
also made invisible (withdraw)
Here we turn on the message box (deiconify, raise)
The message does not release the program
until OK or CANCEL is clicked and wait variable changes from yes 
to no.

=cut

sub my_dialogs {

	my ( $self, $run_name, $number ) = @_;

	use message_director;
	my $run_name_message = message_director->new();
	my $message          = $run_name_message->color_listbox($number);

	my $my_dialog_box   = $color_listbox_href->{_my_dialog_box_w};
	my $ok_button       = $color_listbox_href->{_my_dialog_ok_button};
	my $my_dialog_label = $color_listbox_href->{_my_dialog_label_w};

	#	print("color_listbox,my_dialogs, my_dialog_box=$my_dialog_box\n");

	$my_dialog_box->title($run_name);

	$my_dialog_label->configure(
		-textvariable => \$message,
	);

	my $click = &_get_my_dialog_box_click();

	#	print("1. color_listbox, my_dialogs, shared wait start = $click\n");

	$my_dialog_box->deiconify();
	$my_dialog_box->raise();
	$my_dialog_box->grab();

	#    $my_dialog_box->grabGlobal();
	$click = &_get_my_dialog_box_click();

	#	print("1. color_listbox, my_dialogs, shared wait start = $click\n");
	#	print("1A. color_listbox, my_dialogs, shared wait start = $color_listbox->{_my_dialog_box_click}\n");

	$ok_button->waitVariable( \$color_listbox->{_my_dialog_box_click} );

	my $ans_cancel = _get_my_dialog_cancel_click();
	my $ans_ok     = _get_my_dialog_ok_click();

	#	print("cancel_wait = $ans_cancel\n");
	#	print("ok_wait = $ans_ok\n");
	# print("3. run, made it past\n");

	return ();
}

=head2 sub set_hash_ref
	
	Imports external hash into a local
	hash via gui_history module
	hash
	Note that color_listbox_href is not altered
	A private hash (color_listbox) is available for truly private variables
 	
=cut

sub set_hash_ref {
	my ( $self, $hash_ref ) = @_;

	$gui_history->set_defaults($hash_ref);
	$color_listbox_href = $gui_history->get_defaults();

	return ();
}

__PACKAGE__->meta->make_immutable;
1;
