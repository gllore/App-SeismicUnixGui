package control;
use Moose;

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: control.pm 
 AUTHOR: 	Juan Lorenzo
 DATE: 		V 0.0.2 Oct 3 2018 

 DESCRIPTION 
     

 BASED ON:
 Version 0.0.1 made in early 2018


=cut

=head2 USE

=head3 NOTES

=head4 Examples

=head3 

=head2 CHANGES and their DATES

    Version 0.0.2 
    allows 'no' as well as the parameter values in the Project configuration files
    
=cut  

our $VERSION = '0.0.2';

use L_SU_global_constants;
my $get                     = new L_SU_global_constants();
my $alias_superflow_names_h = $get->alias_superflow_names_h();
my $var                     = $get->var();
my $empty_string            = $var->{_empty_string};

my $no  = $var->{_no};
my $yes = $var->{_yes};

=head2 private hash control


=cut

my $control = {
	_file_name                  => '',
	_file_name_sref             => '',
	_first_name                 => '',
	_first_name_string          => '',
	_first_name_w_single_quotes => '',
	_infected_string            => '',
	_stringWcommas              => '',
	_stringWback_slash          => '',
};

=head2 sub _get_no_quotes

 remove starting and ending single and double quotes
 An entering zero exits as a zero

=cut

sub _get_no_quotes {

	my ($entry_value) = @_;

	if ( defined $entry_value ) {    # =0 case is OK

		if ( $entry_value ne $empty_string ) {

			my $exit_value;

			# print("control,_get_no_quotes, entry_value = $entry_value\n");

			# 1. remove double quotes if they exist
			#  anywhere in the line
			$entry_value =~ tr/"//d;

			# 2. remove extra single quotes if they exist at the start of the string
			$entry_value =~ s/^'//;

			# 3. remove extra single quotes if they exist at the end of the string
			$entry_value =~ s/'$//;
			$exit_value = $entry_value;

			# print("control,_get_no_quotes, result: $exit_value\n");
			return ($exit_value);

		} else {

			# print("control,_get_no_quotes, equals $empty_string\n");
			return ($empty_string);
		}

	} else {

		# print("control,_get_no_quotes, undefined value\n");
		return ($empty_string);
	}

}

=head2 sub _get_string_or_number

=cut

sub _get_string_or_number {

	my ($entry_value) = @_;

	# print("control,_get_string_or_number, entry_value = $entry_value \n");
	if ( $entry_value ne $empty_string ) {
		use Scalar::Util qw(looks_like_number);

		# determine whether we have a string or a number
		my $fmt = 0;
		$fmt = looks_like_number($entry_value);

		if ($fmt) {

			# print("control, _get_string_or_number,$entry_value looks like a number , NADA\n");
			# do nothing
			my $exit_value_as_number = $entry_value;
			return ($exit_value_as_number);

		} else {

			# print("control, _get_string_or_number, exit_value does not look like a number \n");
			my $exit_value_as_string = '\'' . $entry_value . '\'';

			# print ("control, get_string_or_number,  value into a string: $exit_value_as_string\n");
			return ($exit_value_as_string);
		}

	} else {
		#
		# print("control,_get_string_or_number, missing entry_value or empty\n");
		return ($empty_string);
	}

	# print("control,_get_string_or_number, missed loop entry_value = $entry_value \n");
}

=head2 sub commas

    Replace commas in strings
    needed by Seismic Unix

=cut

sub commas {
	my ( $self, $sref_entry_value ) = @_;
	my $freq_string;

	# print("-1.control,freq,old ref value is $sref_entry_value-\n");
	# print("0.control,freq, old value is $$sref_entry_value-\n");
	if ( ref($$sref_entry_value) eq "ARRAY" ) {
		$freq_string = join( ",", @{$$sref_entry_value} );
		$freq_string = '\'' . $freq_string . '\'';

		# print("1.control,freq,value is $freq_string-\n");
	}
	if ( ref($sref_entry_value) eq "SCALAR" ) {
		$freq_string = $$sref_entry_value;

		# print("4.control,freq,value is $$sref_entry_value-\n");
	}
	return ($freq_string);
}

=head2 sub commify
place commas between list elements

=cut

sub commify {
	my ( $self, $array_ref ) = @_;

	if ( $array_ref ne $empty_string ) {

		my @array = @$array_ref;

		my $aa = join ',', @array;

		# print $aa."\n";
		return ($aa);

	} else {
		print("control, commify, unexpected array reference\n");
		return ();
	}

}

=head2 sub empty_string
 test for interpreted arrays that should be 
 
 if defined(empty scalar) is found, nothing is done

 $sref_entry_value should be scalar reference 
 i/p scalar reference

 DB 
 $$sref_entry_value = 'nu';

 package control replaces commas in strings
 needed by Seismic Unix

=cut

sub empty_string {
	my ( $self, $sref_entry_value ) = @_;
	my $null_scalar;    # has nothing
	print("1.control,empty_string,entry value =----$$sref_entry_value----\n");

	if ( ref($$sref_entry_value) eq "ARRAY" ) {
		$$sref_entry_value = '';
		print("1.control,empty_string,new value is $$sref_entry_value-\n");

	} elsif ( $$sref_entry_value eq 'nu' ) {

		$$sref_entry_value = $null_scalar;
		print("4.control,empty_string,='nu',new value =----$$sref_entry_value----\n");

	} elsif ( !defined($$sref_entry_value) ) {

		$$sref_entry_value = $null_scalar;
		print("5.control,empty_string,undefined,new value =----$$sref_entry_value----\n");
	}
	return ($$sref_entry_value);

}

=head2 sub empty_directory

=cut

sub empty_directory {
	my ( $self, $sref_entry_value ) = @_;

	my $null_scalar = '/';    # contains nothing

	if ($sref_entry_value) {

		if ( ref($$sref_entry_value) eq "ARRAY" ) {    # should not agree because we have a scalar reference instead
			$$sref_entry_value = '';

			# print("1.control,array with empty_string,new value is $$sref_entry_value-\n");

		} elsif ( ref($$sref_entry_value) eq "SCALAR" ) {    # is a scalar

			if ( $$sref_entry_value eq '' ) {
				$$sref_entry_value = $null_scalar;

				# print("1.control,scalar with empty_string,new value is now $$sref_entry_value-\n");
			} else {

				# leave the value unchanged;
			}

		} else {

			#print("4.control,empty_directory, neither array or scalar... ??? \n");
		}

	} else {

		print("control,empty_directory,missing scalar reference to entry value \n");

	}
	return ($$sref_entry_value);
}

=head2 sub get_back_slashBgone

    Remove backslash in string
    needed by Seismic Unix

=cut

sub get_back_slashBgone {
	my ($self) = @_;

	if ( $control->{_stringWback_slash} ne $empty_string ) {

		my $stringWback_slash;

		# print("control,get_back_slashBgone, control->{_stringWback_slash}: $control->{_stringWback_slash}\n");
		$stringWback_slash = $control->{_stringWback_slash};
		$stringWback_slash =~ s/\\//g;

		# print("control,get_back_slashBgone, stringWback_slash}: $stringWback_slash\n");
		return ($stringWback_slash);

	} else {
		print("control,get_back_slashBgone, error: need to set stringWbackslash first\n");
	}

}

=head2 sub get_commas2space

    Replace commas in strings
    needed by Seismic Unix

=cut

sub get_commas2space {
	my ($self) = @_;

	if ( $control->{_stringWcommas} ne $empty_string ) {

		my $stringWcommas;

		# print("control,get_commas2space, control->{_stringWcommas}: $control->{_stringWcommas}\n");
		$stringWcommas = $control->{_stringWcommas};
		$stringWcommas =~ s/\,/\ /g;

		# print("control,get_commas2space, stringWcommas}: $stringWcommas\n");
		return ($stringWcommas);

	} else {
		print("control,get_stringWcommas, error: need to set stringWcommas first\n");
	}

}

=head2 get_first_name

	must run set_first_name first

=cut

sub get_first_name {
	my ($self) = @_;
	my $first_name;
	$first_name = $control->{_first_name};
	return ($first_name);
}

=head2 get_max_index

	get (maximum number of parameters -1)
	instantiate specific spec files on the fly
	obtain max index from the corresponding spec file

	make sure to use the proper alias in order to locate
	the spec file

=cut

sub get_max_index {
	my ( $self, $program_name ) = @_;
	my $max_index;

	my $alias_program_name = $alias_superflow_names_h->{$program_name};

	if ( length($alias_program_name) ) {

		# print(" control, get_max_index,alias_superflow_names_h:\n");
		# print("alias for $program_name is $alias_superflow_names_h->{$program_name}\n");
		$program_name = $alias_program_name;    # only for superflows

	} else {

		# do nothing for simple sunix-type programs
	}

	if ($program_name) {

		my $module_spec    = $program_name . '_spec';
		my $module_spec_pm = $program_name . '_spec.pm';

		require $module_spec_pm;

		# print ("control,get_max_index, require $module_spec_pm\n");

		# INSTANTIATE
		my $package = $module_spec->new;

		#print ("control,get_max_index, instantiate $module_spec\n");

		my $specs = $package->variables();

		# print("control,get_max_index,first_of_2,$specs->{_is_first_of_2}\n");

		$max_index = $specs->{_max_index};

		# print (" control,get_max_index, max index = $max_index\n");
	}
	return ($max_index);
}

=head2 sub get_no _quotes

 remove starting and ending single and double quotes

=cut

sub get_no_quotes {

	my ( $self, $entry_value ) = @_;

	if ( defined $entry_value ) {    # =0 case is OK

		if ( length $entry_value ) {# must not be of zero length

			my $exit_value;

			# print("control,no_quotes, entry_value = $entry_value\n");

			# 1. remove double quotes if they exist
			#  anywhere in the line
			$entry_value =~ tr/"//d;

			# 2. remove extra single quotes if they exist at the start of the string
			$entry_value =~ s/^'//;

			# 3. remove extra single quotes if they exist at the end of the string
			$entry_value =~ s/'$//;

			# print("after removing only a last single quote: $x\n ");

			$exit_value = $entry_value;

			return ($exit_value);

		} else {
			# print("control,get_no_quotes, missing entry_value or empty\n");
			return ($empty_string);
		}

	} else {

		# print("control,get_no_quotes, undefined entry_value NADA\n");
		return ();
	}

}

=head2 sub get_no_quotes4array

 remove starting and ending single and double quotes

=cut

sub get_no_quotes4array {

	my ( $self, $array_ref ) = @_;

	if ($array_ref) {

		my $exit_array_ref;

		my @array  = @{$array_ref};
		my $length = scalar @array;

		for ( my $i = 0; $i < $length; $i++ ) {

			# print("control, get_no_quotes4array,entry value is $array[$i] \n");
			$array[$i] = _get_no_quotes( $array[$i] );

			# print("control, get_no_quotes4array,exit value  is $array[$i] \n");
		}

		$exit_array_ref = \@array;

		return ($exit_array_ref);

	} else {
		print("control, get_no_quotes4array, bad array reference\n");
		return ();
	}
}

=head2 sub get_string_or_number

=cut

sub get_string_or_number {

	my ( $self, $entry_value ) = @_;

	if ( defined($entry_value) ) {

		if ( $entry_value ne $empty_string ) {
			use Scalar::Util qw(looks_like_number);

			# print ("control, get_string_or_number, entry_value: $entry_value\n");
			# determine whether we have a string or a number
			my $fmt = 0;
			$fmt = looks_like_number($entry_value);

			if ($fmt) {

				# print("control, get_string_or_number,$entry_value looks like a number \n");
				# do nothing
				my $exit_value_as_number = $entry_value;
				return ($exit_value_as_number);

			} else {
				# print("control, get_string_or_number, exit_value does not look like a number \n");
				my $exit_value_as_string = '\'' . $entry_value . '\'';

				# print ("control, get_string_or_number,  value into a string: $exit_value_as_string\n");
				return ($exit_value_as_string);
			}
		} else {

			# print("control,get_string_or_number, missing entry_value or empty\n");
			return ($empty_string);
		}

	} else {    # empty string becomes: ''
				# print("control,get_string_or_number, undefined entry value NADA \n");
		my $exit_value_as_empty_string = '\'' . '\'';

		# print ("control, get_string_or_number,  value into a string: $exit_value_as_empty_string\n");
		return ($exit_value_as_empty_string);
	}
}

=head2 sub get_string_or_number4array

=cut

sub get_string_or_number4array {

	my ( $self, $array_ref ) = @_;

	if ($array_ref) {
		use Scalar::Util qw(looks_like_number);

		my $exit_array_ref;
		my @array  = @{$array_ref};
		my $length = scalar @array;

		for ( my $i = 0; $i < $length; $i++ ) {
			$array[$i] = _get_string_or_number( $array[$i] );
		}

		$exit_array_ref = \@array;

		return ($exit_array_ref);

	} else {
		print("control, get_string_or_number4array, bad array reference\n");
		return ();
	}
}

=head2 get_suffix

=cut

sub get_suffix {

	my ($self) = @_;
	my $suffix;
	$suffix = $control->{_suffix};
	return ($suffix);
}

=head2 sub get_new_file_name


=cut

sub get_new_file_name {
	my ($self) = @_;
	my ( $file_name, $suffix, $first_name );

	$first_name = $control->{_first_name};

	if ( $control->{_suffix} eq 'su' ) {
		$file_name = $first_name;
	}

	if ( $control->{_suffix} eq 'config' ) {
		$file_name = $first_name;
	}

	return ($file_name);
}

=head sub get_ticksBgone

 remove ALL ticks from a name

=cut

sub get_ticksBgone {
	my ($self) = @_;
	my $working_string;
	if ( $control->{_infected_string} ) {

		# print("control,get_ticksBgone, infected_string $control->{_infected_string}\n");
		$working_string = $control->{_infected_string};
		$working_string =~ s/\'//g;

		# print("control,get_ticksBgone, disinfected string: $working_string\n");
		return ($working_string);

	} else {
		print("control,get_ticksBgone, error: need to set the infected string first\n");
	}
}

=head2 sub w_quotes

	add single quotes

=cut 

sub get_w_single_quotes {
	my ($self) = @_;

	my $first_name_string = $control->{_first_name_string};

	# print("-1.control,w_single_quotes, value is: $first_name_string\n");

	if ($first_name_string) {

		my $first_name_w_single_quotes;

		#for complex names, in addition to plain letters
		$first_name_w_single_quotes = ("'$first_name_string'");
		return ($first_name_w_single_quotes);

	} else {
		print("4.control,w_single_quotes, missing first_name-string\n");
		return ();
	}
}

=head2 ors

	remove logical ors and use only the label
	in front of the or to write out to 
	the perl script

=cut

sub ors {
	my ( $self, $label ) = @_;
	my @label;
	$label[0] = $label;

	# susbtitute spaces with empties
	# print("1. control, $label\n");
	$label =~ s/^\s+|\s+$//g;

	# print("2. control,--$label--\n");

	# find if there are logical ors
	if ( $label =~ m/\|/ ) {

		# print("3. control, $label\n");

		# split label by logical ors
		# only produce the first item
		@label = split( /\|/, $label );

		# print("4. control, $label[0]\n");
	}

	# print("5. control,ors,label=$label[0]\n");
	$label = $label[0];
	return ($label);
}

=head2 sub remove_su_suffix

  For a  scalar reference  remove the .su extension
  For a scalar also remove the .su extension
  For an  array reference do nothig 
	returns a non-empty string if EXPR is a reference, the empty string otherwise. 
	If EXPR is not specified, $_ will be used. The value returned depends on the 
	type of thing the reference is a reference to.

# || ref($$sref_entry_value)  or ref($$sref_entry_value)crashes program
 TODO: if may not properly catch all variations of the input
 currently works for file_name_strings like '1.su' Nov 17 2017

=cut 

sub remove_su_suffix4sref {
	my ($self) = @_;

	my $first_name_sref = $control->{_file_name_sref};
	my $first_name_string;

	# print("-1.control,remove_su_suffix4sref, value is: $$first_name_sref\n");

	if ( ref($first_name_sref) ) {

		# print("-2. ref_entry_value is a reference-\n");
		if ( ref($first_name_sref) eq "ARRAY" ) {    # do nothing
			print("0.control,remove_su_suffix4sref,file_name: is ARRAY-\n");

		} elsif ( ref($first_name_sref) eq "SCALAR" ) {

			# print("2.control,remove_su_suffix4sref: is SCALAR -\n");

			$first_name_string = $$first_name_sref;
			$first_name_string =~ s{\.[^.]+$}{};

			# print("4.control,remove_su_suffix4sref,old ref value is now $first_name_string-\n");

			$control->{_first_name_string} = $first_name_string;
			return ();

		}
	} else {    # not a reference
		print("3.control,remove_su_suffix4sref,missing reference\n");
		return ();

		#		$first_name_string 	= $$sref_entry_value;
		#	    $first_name_string 	=~ s{\.[^.]+$}{};
		#	    $first_name_string   = "'".$first_name_string."'"; #for complex names, in addition to plain letters
	}
}

=head2 sub set_back_slashBgome

    remove back_slash in a string
    needed by Seismic Unix

=cut

sub set_back_slashBgone {
	my ( $self, $stringWback_slash ) = @_;

	# print("control,set_back_slashBgome, stringWback_slash: $stringWback_slash\n");

	if ( $stringWback_slash ne $empty_string ) {

		$control->{_stringWback_slash} = $stringWback_slash;

		# print("control,set_back_slashBgome, : $stringWback_slash\n");
	}
	return ();
}

=head2 sub set_commas2space

    Replace commas in strings
    needed by Seismic Unix

=cut

sub set_commas2space {
	my ( $self, $stringWcommas ) = @_;

	# print("control,set_commas2space, stringWcommas: $stringWcommas\n");

	if ( $stringWcommas ne $empty_string ) {

		$control->{_stringWcommas} = $stringWcommas;

		# print("control,set_commas2space, : $stringWcommas\n");
	}
	return ();
}

=head2 set_empty_str2logic

=cut

sub set_empty_str2logic {

	my ( $self, $string ) = @_;
	my $logic = -1;

	if ($string) {
		print("control,set_empty_str2logic: string = $string\n");
		if ( $string eq 'yes' ) { $logic = 1; }

	} else {    # error check
		$logic = 0;
		print("control,set_empty_str2logic,empty string, logic= $logic\n");
	}
	print("control,set_empty_str2logic: logic = $logic\n");
	return ($logic);
}

=head2 set_file_name


=cut

sub set_file_name {
	my ( $self, $file_name_sref ) = @_;

	if ($file_name_sref) {
		$control->{_file_name} = $$file_name_sref;

		# print("control,file_name, $control->{_file_name}\n");
	}

	return ();
}

=head2 set_file_name_sref


=cut

sub set_file_name_sref {
	my ( $self, $file_name_sref ) = @_;

	if ($file_name_sref) {
		$control->{_file_name_sref} = $file_name_sref;

		# print("control,file_name, $control->{_file_name_sref}\n");
	}

	return ();
}

=head2 set_first_name

=cut

sub set_first_name {

	my ($self) = @_;
	my ( $first_name, $suffix, $file_name );

	# split by the escaped period
	$file_name = $control->{_file_name};
	( $first_name, $suffix ) = split( /\./, $file_name );
	$control->{_first_name} = $first_name;

	# print("control,set_first_name,is: $control->{_first_name}\n");
	return ();
}

=head sub set_infection

=cut

sub set_infection {
	my ( $self, $infected_string ) = @_;

	# print("control,set_infection, infected_string: $infected_string\n");

	if ($infected_string) {
		$control->{_infected_string} = $infected_string;

		# print("control,set_infection, infected_string: $infected_string\n");
	}
	return ();
}

=head2 set_logic

	only used in Project.pm

=cut

sub set_str2logic {

	my ( $self, $string ) = @_;
	my $logic = -1;

	if ( defined $string ) {

		# remove a single  quote from the string if it is  exists
		# e.g. 'no' becomes no, or 'yes' becomes yes , all of which are strings.
		# However, no can be compared to $no but the original string can not
		# Also yes can be compared to $yes, but 'yes' is not the same as $yes, which does not contain the single quotes
		$string =~ s/\'//;
		$string =~ s/\'//;

		# print("0. control,set_str2logic: string = $string\n");
		# if ($string == $no) { print(" 1. string = $no \n"); };
		# if ($string eq $no) { print(" 2. string = $no \n"); };

		if ($string) {

			# print("3. control,set_str2logic: string = $string\n");

			if ( $string eq $yes || $string eq $no ) {

				if ( $string eq $no )  { $logic = 0; }
				if ( $string eq $yes ) { $logic = 1; }

				# print("4. control,set_str2logic: string = $string\n");

			} else {    # error check
						# print("control,set_str2logic,change parameter value string in gui to either yes or no\n");
						# print("Did you forget to list an expected variable ?\n");
						# print("control,set_str2logic: string = $string\n");
			}

			# print("control,set_str2logic: logic = $logic\n");
			return ($logic);

		} else {

			# print("5. control,set_str2logic,missing string\n");
		}

	} else {

		#print("3. control,set_str2logic: string is not defined NADA\n");
	}
}

=head2 set_suffix

=cut

sub set_suffix {

	my ($self) = @_;
	my ( $first_name, $suffix, $file_name );

	# print("control,file_name,is: $control->{_file_name}\n");
	# split by the escaped period
	$file_name = $control->{_file_name};
	( $first_name, $suffix ) = split( /\./, $file_name );
	$control->{_first_name} = $first_name;

	# print("control,first_name,is: $first_name\n");
	# print("control,suffix,is: $suffix\n");

	if ( !($suffix) ) {
		$suffix = '';
	}

	if ( $suffix eq '' ) {

		# print("1. control,set_suffix,is: empty\n");
		$control->{_suffix} = '';

	} elsif ( $suffix eq 'su' ) {
		$control->{_suffix} = 'su';

		# print("control,set_suffix,is: $control->{_suffix}\n");

	} elsif ( $suffix eq 'config' ) {
		$control->{_suffix} = 'config';

		# print("control,set_suffix,is: $control->{_suffix}\n");

	} elsif ( $suffix eq 'pl' ) {
		$control->{_suffix} = 'pl';

		# print("control,set_suffix,is: $control->{_suffix}\n");

	} elsif ( $suffix eq 'txt' ) {
		$control->{_suffix} = 'txt';

		# print("control,set_suffix,is: $control->{_suffix}\n");

	} else {
		$control->{_suffix} = '';

		# print("2. control,set_suffix, suffix:$suffix is empty\n");
	}
}

=head2 sub su_data_name

  For a  scalar reference  remove the .su extension
  For a scalar also remove the .su extension
  For an  array reference do nothig 
	returns a non-empty string if EXPR is a reference, the empty string otherwise. 
	If EXPR is not specified, $_ will be used. The value returned depends on the 
	type of thing the reference is a reference to.
DB 

# ref($$sref_entry_value)  or ref($$sref_entry_value)crashes program
 TODO: if may not properly catch all variations of the input
 but currently works for file_name_strings like '1.su' Nov 17 2017

=cut 

sub su_data_name {
	my ( $self, $sref_entry_value ) = @_;

	# print("-1.control,su_data_name, value is:--$$sref_entry_value--\n");

	if (
		defined $sref_entry_value
		&& length $$sref_entry_value    # must not be of zero length
	) {

		my $first_name_string = $sref_entry_value;

		# print("-2.control,su_data_name, value is:--$$first_name_string--\n");
		if ( ref($sref_entry_value) ) {

			# print("-2. ref_entry_value is a reference-\n");
			if ( ref($$sref_entry_value) eq "ARRAY" ) {    # do nothing
														   # print("0.control,su_data_name,file_name: is ARRAY-\n");

			} elsif ( ref($sref_entry_value) eq "SCALAR" ) {

				# print("2.control,file_name: is SCALAR -\n");
				$first_name_string = $$sref_entry_value;
				$first_name_string =~ s{\.[^.]+$}{};

				# print("1.control,su_data_name,value comes from a reference scalar $first_name_string-\n");
			}
		} else {    # not a reference
			# print("3.control,su_data_name,entry_value=$sref_entry_value\n");
			$first_name_string = $$sref_entry_value;
			$first_name_string =~ s{\.[^.]+$}{};
			$first_name_string = "'" . $first_name_string . "'";    #for complex names, in addition to plain letters
		}

		# print("4.control,su_data_name,old ref value is now--$first_name_string--\n");
		$control->{_first_name_string} = $first_name_string;
		return ($first_name_string);

	} else{		
		print("5. control,su_data_name, unexpected or missing value--\n");		
		return($empty_string);
	}

}

=head2 sub freq

 i/p scalar reference
 o/p nothing

 test for empty scalars 

 $sref_entry_value can  be either scalar reference 
  or array reference
  An array reference is flattened and returned with commas
  A scalar reference is returned unchanged, essentially;
  the string already has commas.

DB 

=cut 

1;

