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

my $color_listbox = {
	_flow_listbox_occupancy_aref => '',
	_vacant_listbox_aref         => '',
};

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

use L_SU_global_constants;

=head2 Instantiation

=cut

my $get = L_SU_global_constants->new();

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
my $flow_listbox_color_start        = $color_start;
my $future_flow_listbox_color_start = $color_start;

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

my $vacant_listbox_aref    = _default_vacant_listbox_aref();
my $occupied_list_box_aref = _default_occupied_listbox_aref();

=head2 Declare attributes

=cut

has 'flow_listbox_color' => (
	default   => $flow_listbox_color_start,
	is        => 'rw',
	isa       => 'Str',
	reader    => 'get_flow_listbox_color',
	writer    => 'set_flow_listbox_color',
	predicate => 'has_flow_listbox_color',
	trigger   => \&_update_flow_listbox_color,
);

has 'flow_listbox_future_occupancy_aref' => (
	default   => \&_default_future_occupied_listbox_aref,
	is        => 'ro',
	isa       => 'ArrayRef',
	reader    => 'get_flow_listbox_future_occupancy_aref',
	writer    => 'set_flow_listbox_future_occupancy_aref',
	predicate => 'has_flow_listbox_future_occupancy_aref',
	trigger   => \&_update_flow_listbox_future_occupancy_aref,
);

has 'flow_listbox_occupancy_aref' => (
	default => \&_default_occupied_listbox_aref,
	is      => 'ro',
	isa     => 'ArrayRef',
	reader  => 'get_flow_listbox_occupancy_aref',

	#	writer    => 'set_flow_listbox_occupancy_aref',
	predicate => 'has_flow_listbox_occupancy_aref',

	#	trigger   => \&_update_flow_listbox_occupancy_aref,
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
	default => \&_default_vacant_listbox_aref,
	is      => 'ro',
	isa     => 'ArrayRef',
	reader  => 'get_flow_listbox_vacancy_aref',

	#	writer    => 'set_flow_listbox_vacancy_aref',
	predicate => 'has_flow_listbox_vacancy_aref',

	#	trigger   => \&_update_flow_listbox_vacancy_aref ,
);

has 'future_flow_listbox_color' => (
	default   => $future_flow_listbox_color_start,
	is        => 'rw',
	isa       => 'Str',
	reader    => 'get_future_flow_listbox_color',
	writer    => 'set_future_flow_listbox_color',
	predicate => 'has_future_flow_listbox_color',
	trigger   => \&_update_future_flow_listbox_color,
);

=head2 sub _update_flow_listbox_color

Mark the listbox color in use

=cut

sub _update_flow_listbox_color {

	my ( $color_listbox, $new_current_flow_listbox_color, $new_prior_flow_listbox_color ) = @_;

	my $ans = $color_listbox->get_flow_listbox_color();

	#	print("color_listbox, _update_flow_listbox_color  internally color is $ans \n");

	if ( length $new_current_flow_listbox_color ) {

		if (   $new_current_flow_listbox_color eq 'grey'
			or $new_current_flow_listbox_color eq '' ) {

			$color_listbox->{_is_flow_listbox_grey_w} = $true;
			_update_flow_listbox_occupancyNvacancy_aref($color_listbox);
			_update_flow_listbox_vacancy_color($color_listbox);

			# print("1. L_SU,_set_flow_listbox, color:$color \n");

		} elsif ( $new_current_flow_listbox_color eq 'pink' ) {

			$color_listbox->{_is_flow_listbox_pink_w} = $true;
			_update_flow_listbox_occupancyNvacancy_aref($color_listbox);
			_update_flow_listbox_vacancy_color($color_listbox);

			# print("L_SU,_set_flow_listbox, color:$color\n");

		} elsif ( $new_current_flow_listbox_color eq 'green' ) {

			# print("L_SU,_set_flow_listbox, color:$color\n");
			$color_listbox->{_is_flow_listbox_green_w} = $true;
			_update_flow_listbox_occupancyNvacancy_aref($color_listbox);
			_update_flow_listbox_vacancy_color($color_listbox);
		} elsif ( $new_current_flow_listbox_color eq 'blue' ) {

			# print("L_SU,_set_flow_listbox, color:$color\n");
			$color_listbox->{_is_flow_listbox_blue_w} = $true;
			_update_flow_listbox_occupancyNvacancy_aref($color_listbox);
			_update_flow_listbox_vacancy_color($color_listbox);
		} else {
			print("color_listbox,_set_flow_listbox, missing color \n");
		}

		return ();
	}
}

=head2 sub _update_flow_listbox_occupancyNvacancy_aref

Mark the listbox color in use

=cut

sub _update_flow_listbox_occupancyNvacancy_aref {

	#	my ( $color_listbox, $new_current_flow_listbox_occupancy_aref, $new_prior_flow_listbox_occupancy_aref ) = @_;
	my ($color_listbox) = @_;

	my @occupied_listbox = @{ $color_listbox->get_flow_listbox_occupancy_aref() };
	my @vacant_listbox   = @{ $color_listbox->get_flow_listbox_vacancy_aref() };

	if (@occupied_listbox) {

		if (   $color_listbox->get_flow_listbox_color() eq 'grey'
			or $color_listbox->get_flow_listbox_color() eq '' ) {

			$occupied_listbox[0] = $true;
			$vacant_listbox[0]   = $false;

			#	print("1. L_SU,_set_flow_listbox, color:$color \n");

		} elsif ( $color_listbox->get_flow_listbox_color() eq 'pink' ) {

			$occupied_listbox[1] = $true;
			$vacant_listbox[1]   = $false;

			# print("L_SU,_set_flow_listbox, color:$color\n");

		} elsif ( $color_listbox->get_flow_listbox_color() eq 'green' ) {

			# print("L_SU,_set_flow_listbox, color:$color\n");
			$occupied_listbox[2] = $true;
			$vacant_listbox[2]   = $false;

		} elsif ( $color_listbox->get_flow_listbox_color() eq 'blue' ) {

			# print("L_SU,_set_flow_listbox, color:$color\n");
			$occupied_listbox[3] = $true;
			$vacant_listbox[3]   = $false;

			# CASE perl flow selection when none of the listboxes are occupied
			# default to gray listbox
		} elsif ( $color_listbox->get_flow_listbox_color() eq 'neutral' ) {

			$occupied_listbox[0] = $true;
			$vacant_listbox[0]   = $false;

		} else {
			print("color_listbox,_update_flow_listbox_occupancyNvacancy_aref,:bad flow color \n");
		}

		$color_listbox->{flow_listbox_occupancy_aref} = \@occupied_listbox;
		$color_listbox->{flow_listbox_vacancy_aref}   = \@vacant_listbox;

		#		my @ans = @{ $color_listbox->get_flow_listbox_occupancy_aref };
		#		print("color_listbox->flow_listbox_occupancy_aref=...@ans...\n");
		#
		#		@ans = @{ $color_listbox->get_flow_listbox_vacancy_aref };
		#		print("color_listbox->flow_listbox_vacancy_aref=...@ans...\n");

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

		} elsif ( $occupied_listbox[1] == $false ) {

			$color = 'pink';

		} elsif ( $occupied_listbox[2] == $false ) {

			$color = 'green';

		} elsif ( $occupied_listbox[3] == $false ) {

			my $color = 'blue';
#			print("color_listbox, _update_flow_listbox_vacancy_color  =  $color \n");
#			print("color_listbox, _update_flow_listbox_vacancy_color, occupied_listboxes: @occupied_listbox\n");

		} else {

			# print("color_listbox, _update_flow_listbox_vacancy_color, All boxes are empty\n");
			$color = 'grey';

			#	print("color_listbox, _update_flow_listbox_vacancy_color,default listbox opened =  $color \n");
		}

	} else {
		print("color_listbox, _update_flow_listbox_vacancy_color, unexpected error\n");
		$color = 'grey';
	}
	
	$color_listbox->{flow_listbox_vacancy_color} = $color;
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

Mark the future listbox color in use
mark next available color listbox vacant
Give preference to the future listbox

=cut

sub _update_future_flow_listbox_color {

	my ( $color_listbox, $new_current_future_flow_listbox_color, $new_prior_future_flow_listbox_color ) = @_;

	#	print(
	#		"color_listbox,_update_future_flow_listbox_color,new_current_future_flow_listbox_color=$new_current_future_flow_listbox_color, new_prior_future_flow_listbox_color=$new_prior_future_flow_listbox_color\n"
	#	);
	if ( $new_current_future_flow_listbox_color eq 'grey' ) {

		$color_listbox->{_is_future_flow_listbox_grey}  = $true;
		$color_listbox->{_is_future_flow_listbox_pink}  = $false;
		$color_listbox->{_is_future_flow_listbox_green} = $false;
		$color_listbox->{_is_future_flow_listbox_blue}  = $false;
		my $color = 'grey';
		$color_listbox->{future_flow_listbox_color}    = $color;
		$color_listbox->{_is_future_flow_listbox_grey} = $false;    #clean

		# print("L_SU,_update_future_flow_listbox_color, color:$color \n");

	} elsif ( $new_current_future_flow_listbox_color eq 'pink' ) {

		$color_listbox->{_is_future_flow_listbox_grey}  = $false;
		$color_listbox->{_is_future_flow_listbox_pink}  = $true;
		$color_listbox->{_is_future_flow_listbox_green} = $false;
		$color_listbox->{_is_future_flow_listbox_blue}  = $false;
		my $color = 'pink';
		$color_listbox->{future_flow_listbox_color}    = $color;
		$color_listbox->{_is_future_flow_listbox_pink} = $false;    #clean
			# print("L_SU,_update_future_flow_listbox_color, color:$color\n");

	} elsif ( $new_current_future_flow_listbox_color eq 'green' ) {

		# print("L_SU,_update_future_flow_listbox_color, color:$color\n");
		$color_listbox->{_is_future_flow_listbox_grey}  = $false;
		$color_listbox->{_is_future_flow_listbox_pink}  = $false;
		$color_listbox->{_is_future_flow_listbox_green} = $true;
		$color_listbox->{_is_future_flow_listbox_blue}  = $false;
		my $color = 'green';
		$color_listbox->{future_flow_listbox_color}     = $color;
		$color_listbox->{_is_future_flow_listbox_green} = $false;    #clean

	} elsif ( $new_current_future_flow_listbox_color eq 'blue' ) {

		# print("L_SU,_update_future_flow_listbox_color, color:$color\n");
		$color_listbox->{_is_future_flow_listbox_grey}  = $false;
		$color_listbox->{_is_future_flow_listbox_pink}  = $false;
		$color_listbox->{_is_future_flow_listbox_green} = $false;
		$color_listbox->{_is_future_flow_listbox_blue}  = $true;
		my $color = 'blue';
		$color_listbox->{future_flow_listbox_color}    = $color;
		$color_listbox->{_is_future_flow_listbox_blue} = $false;     #clean

	} else {
		print("L_SU,_update_future_flow_listbox_color, missing color \n");
	}

	#	my @vacancy   = @{ $color_listbox->get_flow_listbox_vacancy_aref() };
	#	my @occupancy = @{ $color_listbox->get_flow_listbox_occupancy_aref() };
	#
	#	my $occupied   = $true;
	#	my $unoccupied = $false;
	#
	#	my $ans= $color_listbox->get_flow_listbox_color() ;
	#	print("color_listbox, _update_future_flow_listbox_color internally color is $ans \n");
	#	print("color_listbox, _update_future_flow_listbox_color future color is $new_current_future_flow_listbox_color\n");
	#
	#	if ( length $new_current_future_flow_listbox_color ) {
	#
	#		if (   $new_current_future_flow_listbox_color eq ''
	#			or $new_current_future_flow_listbox_color eq 'grey' ) {
	#
	#			if ( $vacancy[0] eq $true ) {
	#				print(" 1. color_listbox, _update_future_flow_listbox_color, grey listbox is free to use\n");
	#				$color_listbox->set_flow_listbox_vacancy_color('grey');
	#
	#			} elsif ( $vacancy[0] eq $false ) {
	#
	#				print(
	#					" 2. color_listbox, _update_future_flow_listbox_color, Warning: grey listbox is already occupied\n"
	#				);
	#
	#				if ( $occupancy[0] eq $true ) {
	#
	#					print(
	#						" 2. color_listbox, _update_future_flow_listbox_color, Warning: grey listbox is already occupied\n"
	#					);
	#
	#				} else {
	#					print(" 2. color_listbox, _update_future_flow_listbox_color, grey listbox CAN BE occupied\n");
	#				}
	#
	#			} else {
	#				print("color_listbox, _update_future_flow_listbox_color, unexpected values\n");
	#			}
	#
	#			# print("1. L_SU,_set_flow_listbox, color:$color \n");
	#
	#		} elsif ( $new_current_future_flow_listbox_color eq 'pink' ) {
	#			if ( $vacancy[1] eq $true ) {
	#				print(" 1. color_listbox, _update_future_flow_listbox_color, pink listbox is free to use\n");
	#				$color_listbox->set_flow_listbox_vacancy_color('pink');
	#
	#			} elsif ( $vacancy[1] eq $false ) {
	#
	#				print(
	#					" 2. color_listbox, _update_future_flow_listbox_color, Warning: pink listbox is already occupied\n"
	#				);
	#
	#				if ( $occupancy[1] eq $true ) {
	#
	#					print(
	#						" 2. color_listbox, _update_future_flow_listbox_color, Warning: pink listbox is already occupied\n"
	#					);
	#
	#				} else {
	#					print(" 2. color_listbox, _update_future_flow_listbox_color, pink listbox CAN BE occupied\n");
	#				}
	#
	#			} else {
	#				print("color_listbox, _update_future_flow_listbox_color, unexpected values\n");
	#			}
	#
	#			# print("L_SU,_set_flow_listbox, color:$color\n");
	#
	#		} elsif ( $new_current_future_flow_listbox_color eq 'green' ) {
	#			if ( $vacancy[2] eq $true ) {
	#				print(" 1. color_listbox, _update_future_flow_listbox_color, grey listbox is free to use\n");
	#				$color_listbox->set_flow_listbox_vacancy_color('green');
	#
	#			} elsif ( $vacancy[2] eq $false ) {
	#
	#				print(
	#					" 2. color_listbox, _update_future_flow_listbox_color, Warning: green listbox is already occupied\n"
	#				);
	#
	#				if ( $occupancy[2] eq $true ) {
	#
	#					print(
	#						" 2. color_listbox, _update_future_flow_listbox_color, Warning: green listbox is already occupied\n"
	#					);
	#
	#				} else {
	#					print(" 2. color_listbox, _update_future_flow_listbox_color, grey listbox CAN BE occupied\n");
	#				}
	#
	#			} else {
	#				print("color_listbox, _update_future_flow_listbox_color, unexpected values\n");
	#			}
	#
	#			# print("L_SU,_set_flow_listbox, color:$color\n");
	#
	#		} elsif ( $new_current_future_flow_listbox_color eq 'blue' ) {
	#			if ( $vacancy[3] eq $true ) {
	#				print(" 1. color_listbox, _update_future_flow_listbox_color, blue listbox is free to use\n");
	#				$color_listbox->set_flow_listbox_vacancy_color('blue');
	#
	#			} elsif ( $vacancy[3] eq $false ) {
	#
	#				print(
	#					" 2. color_listbox, _update_future_flow_listbox_color, Warning: grey listbox is already occupied\n"
	#				);
	#
	#				if ( $occupancy[3] eq $true ) {
	#
	#					print(
	#						" 2. color_listbox, _update_future_flow_listbox_color, Warning: blue listbox is already occupied\n"
	#					);
	#
	#				} else {
	#					print(" 2. color_listbox, _update_future_flow_listbox_color, blue listbox CAN BE occupied\n");
	#				}
	#
	#			} else {
	#				print("color_listbox, _update_future_flow_listbox_color, unexpected values\n");
	#			}
	#
	#			# print("L_SU,_set_flow_listbox, color:$color\n");
	#
	#		} else {
	#			print("color_listbox,_set_flow_listbox, missing color \n");
	#		}

	return ();

	#	}
}

=head2 sub _update_flow_listbox_future_occupancy_aref

Mark the next listbox color to use

=cut

sub _update_flow_listbox_future_occupancy_aref {

	#	my ( ( $color_listbox, $new_current_listbox_future_occupancy_aref, $new_prior_flow_listbox_occupancy_aref ) ) = @_;
	#
	#	my $result;
	#	my @array;
	#
	#	my $array_ref = _default_future_occupied_listbox_aref
	#	my @array      = \@array_ref;
	#	my $length = scalar @array;
	#
	#	$color_listbox->get_flow_listbox
	#    $color_listbox->{flow_listbox_future_occupancy_aref} = \@array;
	return ();
}

__PACKAGE__->meta->make_immutable;
1;
