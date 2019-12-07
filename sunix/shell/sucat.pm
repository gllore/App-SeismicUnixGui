package sucat;
use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS

 PROGRAM NAME: sucat
 AUTHOR: Juan Lorenzo
 DATE: May 25 2016
 DESCRIPTION concatenate a list of files
 Version 1
         1.01 June 23 2016
 Variable suffix changed to input_suffix 
 Notes: 
 Package name is the same as the file name
 Moose is a package that allows an object-oriented
 syntax to organizing your programs

=cut

=head2 USAGE 1 (todo)

 To cat an array of trace numbers
 Example
       $sucat->tracl(\@array);
       $sucat->Steps()

=head2 USAGE 2

   To cat a defined range of numerically-named
files

 Example:
       $sucat->first_file_number_in('1000');
       $sucat->last_file_number_in('1001');
       $sucat->number_of_files_in('2');
       $sucat->Step();
=cut

=head2 import packages

=cut

use L_SU_global_constants;

=head2 instatntiate new variables

=cut

my $get = new L_SU_global_constants();

=head2 declare local variables

=cut

my $var = $get->var();

my $empty_string = $var->{_empty_string};

#my $false        = $var->{_false};
#my $true         = $var->{_true};

=head2 newline:

 is a special character

=cut

my $newline = '
';

=head2 sucat:
is a hash of important variables

=cut

my $sucat = {
	_first_file_number_in           => '',
	_alternative_inbound_directory  => '',
	_alternative_outbound_directory => '',
	_inbound_directory              => '',
	_outbound_directory             => '',
	_last_file_number_in            => '',
	_list_aref                      => '',
	_list_directory                 => '',
	_list_name                      => '',
	_number_of_files_in             => '',
	_input_suffix                   => '',
	_data_type                      => '',
	_output_file_name               => '',
	_velan_data                     => '',
	_Step                           => ''
};

=head2 sub clear:

 clean hash of its values

=cut

sub clear {
	my ($self) = @_;
	$sucat->{_first_file_number_in}           = '';
	$sucat->{_alternative_inbound_directory}  = '';
	$sucat->{_alternative_outbound_directory} = '';
	$sucat->{_inbound_directory}              = '';
	$sucat->{_outbound_directory}             = '';
	$sucat->{_last_file_number_in}            = '';
	$sucat->{_list_array}                     = '';
	$sucat->{_list_directory}                 = '';
	$sucat->{_list_name}                      = '';
	$sucat->{_data_type}                      = '';
	$sucat->{_number_of_files_in}             = '';
	$sucat->{_input_suffix}                   = '';
	$sucat->{_output_file_name}               = '';
	$sucat->{_Step}                           = '';
}

=head2 _get_data_type

=cut

sub _get_data_type {
	my ($self) = @_;

	if (    $sucat->{_list_directory} ne $empty_string
		and $sucat->{_list_name} ne $empty_string )
	{

		use readfiles;
		use SeismicUnix qw($itop_mute $ibot_mute $ivpicks_sorted_par_);

		my $velan = $ivpicks_sorted_par_;

=head2 instantiate packages

=cut

		my $read = readfiles->new();

=head2 declare local variables

=cut

		my @data_type;
		my $data_type;

		my $inbound_list = $sucat->{_list_directory} . '/' . $sucat->{_list_name};

		my ( $array_ref, $num_cdps ) = $read->cols_1p($inbound_list);

		for ( my $i = 0; $i < $num_cdps; $i++ ) {

			my $file_name = @$array_ref[$i];

			if (   $file_name =~ m/$itop_mute/
				or $file_name =~ m/$ibot_mute/ )
			{

				$data_type[$i] = 'mute';

				# print("success, matched mute\n");

			}

			elsif ( $file_name =~ m/$ivpicks_sorted_par_/ ) {

				# print("success, matched velan\n");
				$data_type[$i] = 'velan';

			}
			else {
				$data_type[$i] = $empty_string;
			}
		}

		# all data types must be the same
		for ( my $i = 1; $i < $num_cdps; $i++ ) {

			if ( $data_type[0] eq $data_type[$i] ) {

				# print("ok. NADA\n");
				$data_type = $data_type[0];

			}
			elsif ( $data_type[0] ne $data_type[$i] ) {

				$data_type = $empty_string;

				# print("failed\n");
			}
			else {
				print("sucat,_get_data_type_unexpected result\n");
			}
		}

		my $result = $data_type;
		return ($result);

	}
	else {
		# print("sucat,_get_data_type,missing list and its directory\n");
		return ($empty_string);

	}
}

=header2 sub _get_inbound_directory
Pre-defined i /p and o/p directories will be overridden by 
user i / p and o / p values from the gui

=cut

sub _get_inbound_directory {
	my ($self) = @_;

=head2 import packages

=cut

	use Sucat_spec;

=head2 instantiate packages

=cut

	my $Sucat_spec           = new Sucat_spec;
	my $Sucat_spec_variables = $Sucat_spec->variables();

=head2 Declare variables 

    in local memory space
    Establish default variables using a *_spec file
	which WILL be overridden later,
	#deprecate in future?

=cut	

	my $DATA_DIR_IN       = $Sucat_spec_variables->{_DATA_DIR_IN};
	my $inbound_directory = $DATA_DIR_IN;

=head2 Based on the file names in the list
if a data_type can be determined,
then inbound and outbound directories will be set
by sucat.pm

=cut

	$inbound_directory = _get_DIR_IN();

	# print("sucat,_get_inbound_directory based on a list or not:---$inbound_directory--\n");

	if ( $sucat->{_alternative_inbound_directory} ne $empty_string ) {

		# CASE 1A: new inbound directory replaces default
		$inbound_directory = $sucat->{_alternative_inbound_directory};

	}
	elsif ( $sucat->{_alternative_inbound_directory} eq $empty_string ) {

		# $inbound_directory $DATA_DIR_IN

	}
	else {
		print("Sucat.pl, unexpected alternative_inbound_directory  \n");
	}

	my $result = $inbound_directory;
	return ($result);

}    # end

=head2 sub _set_data_type

 set_data_type can be mute,velan,su,txt ore empty

=cut

sub _set_data_type {
	my ($data_type) = @_;

	if ( $data_type ne $empty_string ) {

		$sucat->{_data_type} = $data_type;

		# print("set_data_type, data_type = $sucat->{_data_type}\n");

	}
	else {
		# print("set_data_type, no data_type NADA\n");
	}

}

sub _get_DIR_IN {
	my ($self) = @_;

=head2 import packages

=cut

	use Sucat_spec;

=head2 instantiate packages

=cut

	my $Sucat_spec           = new Sucat_spec;
	my $Sucat_spec_variables = $Sucat_spec->variables();

=head2 Declare variables 

    in local memory space
    Establish default variables using a *_spec file
	which WILL be overridden later,
	#deprecate in future?

=cut	

	my $DATA_DIR_IN      = $Sucat_spec_variables->{_DATA_DIR_IN};

	if ($sucat->{_list_directory} ne $empty_string    # never, normally
		and $sucat->{_list_name} ne $empty_string
		)
	{
		# CASE 1: read a list of file names
		# from which to infer input directory

		print("sucat,_get_DIR_IN,sucat->{_list_directory}: $sucat->{_list_directory}\n");

		my $data_type = _get_data_type();

		if (   $data_type eq 'mute'
			or $data_type eq 'velan' )
		{
			# TODO can be changed
			my $DIR_IN = $sucat->{_list_directory};
			my $result = $DIR_IN;
			return ($result);

		}
		else {
			print("sucat,_get_DIR_IN,FORGOTTEN new data type\n");
		}
	}
	elsif (
		$sucat->{_list_directory} eq $empty_string    # never, normally
		or $sucat->{_list_name} eq $empty_string
		)
	{
		# CASE 2A: use the user-input suffix
		# to infer input directory

		if ( $sucat->{_input_suffix} eq 'su' ) {

			my $result = $DATA_DIR_IN;
			return ($result);

		}
		elsif ( $sucat->{_input_suffix} eq $empty_string ) {

			# CASE 2B user forgot to put a suffix in
			my $DIR_IN = $sucat->{_list_directory};    #start here
			my $result = $DIR_IN;
			return ($result);

		}
		else {
			print("1. sucat,_get_DIR_IN, unexpected values\n");
		}    # real issue

	}

	else {
		print("2. sucat,get_DIR_IN, unexpected result\n");
		return ();
	}

}

sub _get_DIR_OUT {
	my ($self) = @_;

=head2 import packages

=cut

	use Sucat_spec;

=head2 instantiate packages

=cut

	my $Sucat_spec           = new Sucat_spec;
	my $Sucat_spec_variables = $Sucat_spec->variables();

=head2 Declare variables 

    in local memory space
    Establish default variables using a *_spec file
	which WILL be overridden later,
	#deprecate in future?

=cut	

	my $DATA_DIR_OUT       = $Sucat_spec_variables->{_DATA_DIR_OUT};

	if ($sucat->{_list_directory} ne $empty_string    # never, normally
		and $sucat->{_list_name} ne $empty_string
		)
	{
	# CASE 1: read a list of file names
	# from which to infer output directory

		my $data_type = _get_data_type();

		if (   $data_type eq 'mute'
			or $data_type eq 'velan' )
		{
			# TODO can be changed
			my $DIR_OUT = $sucat->{_list_directory};
			my $result  = $DIR_OUT;
			return ($result);

		}
		else {
			print("sucat,_get_DIR_OUT,FORGOTTEN new data type\n");
		}
	}
	elsif ($sucat->{_list_directory} eq $empty_string
		or $sucat->{_list_name} eq $empty_string )
	{
		# CASE 2A: use the user-input suffix
		# to infer input directory

		# print("sucat_get_DIR_OUT,sucat->{_input_suffix}: $sucat->{_input_suffix}\n");		
		if ( $sucat->{_input_suffix} eq 'su' ) {
			
			my $result = $DATA_DIR_OUT;
			return ($result);

		}
		elsif ( $sucat->{_input_suffix} eq $empty_string ) {

			# CASE 2B user forgot to put a suffix in the gui
			my $DIR_OUT = $sucat->{_list_directory};    #start here
			my $result = $DIR_OUT;
			return ($result);
		}
		else {
			print("1. sucat,_get_DIR_OUT, unexpected values\n");
		}

	}
	else {
		print("2. sucat,_get_DIR_OUT, unexpected values\n");
	}

}

=head2 sub alternative_inbound_directory

=cut

sub alternative_inbound_directory {
	my ( $self, $alternative_inbound_directory ) = @_;

	if ( $alternative_inbound_directory ne $empty_string ) {

		$sucat->{_alternative_inbound_directory} = $alternative_inbound_directory;
	}
	elsif ( $alternative_inbound_directory eq $empty_string ) {

		$sucat->{_alternative_inbound_directory} = $empty_string;
	}
	else {
		print("sucat,alternative_inbound_directory unexpected\n");

	}
	return ();
}

=head2 sub alternative_outbound_directory

=cut

sub alternative_outbound_directory {

	my ( $self, $alternative_outbound_directory ) = @_;

	if ( $alternative_outbound_directory ne $empty_string ) {

		$sucat->{_alternative_inbound_directory} = $alternative_outbound_directory;

	}
	elsif ( $alternative_outbound_directory eq $empty_string ) {

		$sucat->{_alternative_outbound_directory} = $empty_string;

	}
	else {
		print("sucat,alternative_outbound_directory un expected\n");

	}
	return ();
}

=head2 sub data_type

 data_type can be mute,velan,su,txt

=cut

sub data_type {
	my ($self) = @_;

	if (    $sucat->{_list_directory} ne $empty_string
		and $sucat->{_list_name} ne $empty_string )
	{
		# print("sucat,data_type NADA\n");
		# my $ans = $sucat->{_list_directory};
		# print("sucat,sucat->{_list_directory}:$ans\n");
		# $ans = $sucat->{_list_name};
		# print("sucat,sucat->{_list_name}:$ans\n");

=head2 bring in packages

=cut

		use readfiles;
		use manage_files_by;
		use control;

=head2 instantiate packages

=cut

		my $read    = readfiles->new();
		my $control = control->new();

=head2 Declare local variables

=cut		

		my $par_file;
		my ( @result_t, @result_v );
		my @cdp;
		my ( $values_aref, $ValuesPerRow_aref );
		my $rows;
		my ( $DIR_OUT, $DIR_IN );

=head2 Generate a data_type

=cut

		my $data_type = _get_data_type();
		_set_data_type($data_type);

		# print("sucat, data_type, data_type=---$data_type---\n\n");

		if ( $data_type ne $empty_string ) {

			$DIR_OUT = _get_DIR_OUT();
			$DIR_IN  = _get_DIR_IN();

			my $inbound_list = $DIR_IN . '/' . $sucat->{_list_name};
			my ( $ref_array, $num_cdps ) = $read->cols_1p($inbound_list);

			print("sucat,data_type,num_cdps: $num_cdps\n");

=head2

 read a list of file names
 read contents of each file in the list
 into arrays
 each line of the list contains:
 
  cdp number as well as an 

  cdp number as well as an 
 indicator of what file the velocity picks are in
 
=cut

			for ( my $file_number = 0, my $line = 0; $file_number < $num_cdps; $file_number++, $line++ ) {
				my $file_name_complete = @$ref_array[$file_number];
				my $inbound            = $DIR_IN . '/' . $file_name_complete;

				my $cdp_name = @$ref_array[$file_number];

				# print("reading cdp: $cdp_name\n");
				$cdp_name =~ s/[^0-9]*//g;
				$cdp[$file_number] = $cdp_name;

				# print("sucat,data_type,reading cdp: $cdp[$file_number]\n");

				# for one cdp at a time
				( $values_aref, $ValuesPerRow_aref ) = manage_files_by::read_par( \$inbound );

				# print("sucat,data_type,ValuesPerRow : @$ValuesPerRow_aref\n");

=head2 place contents of each file in the list
 into an array

=cut

				$result_t[$line] = @$values_aref[0];
				$result_v[$line] = @$values_aref[1];

				# print("sucat,data_type,t: $result_t[$line]\n");
				# print("sucat,data_type,v: $result_v[$line]\n");

			}    # end repeat over all velan files

			# print("writing outbound $DIR_OUT/.cdp\n");
			# print("writing outbound @cdp\n");

			manage_files_by::write_cdp( \@cdp, $DIR_OUT );

			if ( $data_type eq 'velan' ) {

				manage_files_by::write_tnmo_vnmo( \@cdp, \@result_t, \@result_v, $DIR_OUT );

			}
			elsif ( $data_type eq 'mute' ) {

				manage_files_by::write_tmute_xmute( \@cdp, \@result_t, \@result_v, $DIR_OUT );
			}
			else {
				print("sucat, data_type, unrecognized data_type, data_type can be mute or velan\n");
			}

		}
		else {
			print(
				"sucat,data_type. Data types are not all only mute or velan.
Ignore special formats. Using simple cat.\n\n"
			);
		}
	}
}

=head2 sub test:

 example of how to use a class method

=cut

sub test {
	my ( $test, @value ) = @_;
	print(
		"\$test or the first_file_number_in scalar  'holds' a  HASH $test 
 that represents the name of the  
 subroutine you are trying to use and all its needed components\n"
	);
	print("\@value, the second scalar is something 'real' you put in, i.e., @value\n\n");
}

=head2 sub first_file_number_in:

 for first_file_number_in numerical file name

=cut

sub first_file_number_in {
	my ( $variable, $first_file_number_in ) = @_;
	if ( $first_file_number_in ne $empty_string ) {
		$sucat->{_first_file_number_in} = $first_file_number_in;
	}
	else {
		# print("sucat,first_file_number_in: NADA\n");
	}

	#	print(
	#		"sucat, first_file_number_in, first_file_number_in=---$sucat->{_first_file_number_in}---\n\n"
	#	);
}

=header2 sub get_outbound_directory
Pre-defined i /p and o/p directories will be overridden by user i / p and o / p values from the gui

=cut

sub get_outbound_directory {
	my ($self) = @_;

	my ( $inbound_directory, $outbound_driectory );

=head2 Based on the file names in the list
if a data_type can be determined,
then the outbound directory will be set
by sucat.pm

=cut

	my $outbound_directory = _get_DIR_OUT();

	# print("sucat,get_outbound_directory based on a list or not:---$outbound_directory--\n");

	if ( $sucat->{_alternative_outbound_directory} ne $empty_string ) {

		# CASE 1A: new outbound directory replaces default
		$outbound_directory = $sucat->{_alternative_outbound_directory};

	}
	elsif ( $sucat->{_alternative_outbound_directory} eq $empty_string ) {

		# $outbound_directory is the default

	}
	else {
		print("Sucat.pl, unexpected alternative_outbound_directory  \n");
	}

	my $result = $outbound_directory;
	return ($result);

}    # end

=head2 sub inbound_directory:

 for inbound directory name

=cut

sub inbound_directory {
	my ( $variable, $inbound_directory ) = @_;

	if ( $inbound_directory ne $empty_string ) {
		$sucat->{_inbound_directory} = $inbound_directory;
	}
	else {
		# print("sucat,inbound_directory: NADA\n");
	}

}

=head2 sub input_name_extension 

 use after names and numbers
 
 e.g., cdp_100_input_name_extension.su

=cut

sub input_name_extension {
	my ( $variable, $input_name_extension ) = @_;

	if ( $input_name_extension ne $empty_string ) {
		$sucat->{_input_name_extension} = $input_name_extension;
	}
	else {
		# print("sucat,input_name_extension: NADA\n");
	}

}

=head2 sub input_name_prefix 

 use before names and numbers
 input_prefix_100.su

=cut

sub input_name_prefix {
	my ( $variable, $input_name_prefix ) = @_;

	if ( $input_name_prefix ne $empty_string ) {
		$sucat->{_input_name_prefix} = $input_name_prefix;
	}
	else {
		# print("sucat,input_input_name_prefix: NADA\n");
	}
}

=head2 sub input_suffix 

 use after dot for all names
 e.g., .su

=cut

sub input_suffix {
	my ( $variable, $input_suffix ) = @_;

	if ( $input_suffix ne $empty_string ) {
		$sucat->{_input_suffix} = $input_suffix;
		# print("sucat,input_suffix: $sucat->{_input_suffix}\n");
	}
	else {
		# print("sucat,input_suffix: NADA\n");
	}

}

=head2 sub last_file_number_in:

 for last_file_number_in numerical file name 

=cut

sub last_file_number_in {
	my ( $variable, $last_file_number_in ) = @_;

	if ( $last_file_number_in ne $empty_string ) {
		$sucat->{_last_file_number_in} = $last_file_number_in;
	}
	else {
		# print("sucat,last_file_number_in: NADA\n");
	}

	#	print(
	#		"sucat,last_file_number_in, last_file_number_in: $sucat->{_last_file_number_in}  \n\n"
	#	);
}

=head2 sub list_directory:

 for list directory name

=cut

sub list_directory {
	my ( $self, $list_directory ) = @_;

	if ( $list_directory ne $empty_string ) {
		$sucat->{_list_directory} = $list_directory;

		# print("sucat,list_directory: $sucat->{_list_directory}\n");
	}
	else {
		print("sucat,list_directory: NADA\n");
	}

}

=head2 sub list_name:

 for list directory name

=cut

sub list_name {
	my ( $variable, $list_name ) = @_;

	if ( $list_name ne $empty_string ) {
		$sucat->{_list_name} = $list_name;
	}
	else {
		# print("sucat,list_name: NADA\n");
	}

}

=head2 sub number_of_files_in:

 for number_of_files_in

=cut

=head2 sub number_of_files_in:

 for number of files to concatenate

=cut

sub number_of_files_in {
	my ( $variable, $number_of_files_in ) = @_;

	if ( $number_of_files_in ne $empty_string ) {
		$sucat->{_number_of_files_in} = $number_of_files_in;
	}
	else {
		# print("sucat,number_of_files_in: NADA\n");
	}

}

=head2 sub outbound_directory:

 for outbound directory name

=cut

sub outbound_directory {
	my ( $variable, $outbound_directory ) = @_;

	if ( $outbound_directory ne $empty_string ) {
		$sucat->{_outbound_directory} = $outbound_directory;
	}
	else {
		# print("sucat,outbound_directory: NADA\n");
	}

}

=head2 sub output_file_name:

 for number of files to concatenate

=cut

sub output_file_name {
	my ( $variable, $output_file_name ) = @_;

	if ( $output_file_name ne $empty_string ) {
		$sucat->{_output_file_name} = $output_file_name;
	}
	else {
		# print("sucat,output_file_name: NADA\n");
	}

}

=head2 sub set_list_aref

 list array reference

=cut

sub set_list_aref {
	my ( $variable, $list_aref ) = @_;

	if ( $list_aref ne $empty_string ) {
		$sucat->{_list_aref} = $list_aref;
	}
	else {
		# print("sucat,set_list_aref: NADA\n");
	}

	# print("sucat, set_list_aref, list=---@$list_aref--\n");
	$sucat->{_number_of_files_in} = scalar @$list_aref;

	# print("sucat, set_list_aref, number_of_files_in=$sucat->{_number_of_files_in}\n\n");
}

=head2 subroutine Step  

 builds array to concatenate
 first_file_number_in line output contacts program name
 successive lines
 final output name is provided by user name
 add new file names

=cut

sub Step {

	my $file;

	my $inbound_directory = _get_inbound_directory();

	# CASE 1: there is a list
	if ( $sucat->{_list_aref} ne $empty_string ) {

		$sucat->{_Step} = 'cat ';

		# CASE 1A- without data type -- when a file list is not used
		if ( $sucat->{_data_type} eq $empty_string ) {

			print(" CASE 1A list is---$sucat->{_Step}not used---\n\n");

			for ( my $i = 0; $i < $sucat->{_number_of_files_in}; $i++ ) {

				# CASE 1A-1 : there is an input sufffix specified by user
				if ( $sucat->{_input_suffix} ne $empty_string ) {
					print(
						"Warning: Incorrect settings. Either use \n
\t 1) use a list without values for first 6 parameters. Include the output\n
\t name. The alternative directories are optional.\n
\t That is, a list can only be used when the values of the prior\n
\t 6 parameters are blank\n
\t 2)Do not use a list. Instead include values for at least the first 3 \n
\t parameters and up to and including values for all the remaining parameters,\n
\t except the list\n"
					);
				}

				# CASE 1A-2 : there is no input sufffix specified by user
				elsif ( $sucat->{_input_suffix} eq $empty_string ) {

					print(" CASE 1A-2 : there is no input sufffix specified by user \n\n");
					$sucat->{_Step} = $sucat->{_Step} . ' ' . $inbound_directory . '/' . @{ $sucat->{_list_aref} }[$i] . ' \\' . $newline;

				}
				else {
					print("sucat,Step, unexpected input_suffix \n");
				}

				# print("i=$i\n\n");
				# print(" list_directory is $sucat->{_list_directory}\n\n");
				# print(" 1. list is $sucat->{_Step}\n");
			}
		}    # end CASE 1A no data type

		# CASE 1B: data_type exists
		elsif ( $sucat->{_data_type} ne $empty_string ) {

			my $DIR_IN = _get_DIR_IN();

			if ( $sucat->{_data_type} eq 'velan' ) {

				print(" CASE 1B-1 : data_type exists \n\n");
				$sucat->{_Step} = $sucat->{_Step} . $DIR_IN . '/' . '.cdp ' . $DIR_IN . '/' . '.tv' . '\\' . $newline;

				# print("sucat,Step, case of velan,sucat->{_Step}=$sucat->{_Step}\n");

			}
			elsif ( $sucat->{_data_type} eq 'mute' ) {

				print(" CASE 1B-2 : data_type exists \n\n");
				$sucat->{_Step} = $sucat->{_Step} . $DIR_IN . '/' . '.cdp ' . $DIR_IN . '/' . '.tx' . '\\' . $newline;

			}
			else {
				print(" sucat,Step,unexpected data_type\n\n");
			}
		}
		else {
			print(" sucat,Step,unexpected situation \n\n");
		}
	}    #END CASE 1: with list

	# CASE 2: there is no list
	elsif ( $sucat->{_list_aref} eq $empty_string ) {
		$sucat->{_Step} = 'cat ';

		# print(" CASE 2A. sucat, Step---$sucat->{_Step}---\n\n");

		# CASE 2A: the nos. increase monotonically
		if ( $sucat->{_first_file_number_in} <= $sucat->{_last_file_number_in} ) {
			for ( my $file = $sucat->{_first_file_number_in}; $file <= $sucat->{_last_file_number_in}; $file++ ) {

				# CASE 2A-1 there is an input suffix specified by user
				if ( $sucat->{_input_suffix} ne $empty_string ) {

					# print(" CASE 2A-1. sucat,Step,\n\n");
					$sucat->{_Step} = $sucat->{_Step} . ' ' . $inbound_directory . '/' . $file . '.' . $sucat->{_input_suffix};

				}

				# CASE 2A-2 there is not input suffix specified by user
				elsif ( $sucat->{_input_suffix} eq $empty_string ) {

					# print(" CASE 2A-2. sucat,Step,\n\n");
					$sucat->{_Step} = $sucat->{_Step} . ' ' . $inbound_directory . '/' . $file;
				}
				else {
					print(" sucat,Step, unexpected input, growing numbers\n");
				}

			}    # end for loop
		}

		# CASE 2B: nos. decrease monotonically
		elsif ( $sucat->{_first_file_number_in} > $sucat->{_last_file_number_in} ) {

			# print("CASE 2B. sucat, Step, reverse order assumed\n");

			for ( my $file = $sucat->{_first_file_number_in}; $file >= $sucat->{_last_file_number_in}; $file = ( $file - 1 ) ) {

				# CASE 2B-1  there is an input suffix specified by user
				if ( $sucat->{_input_suffix} ne $empty_string ) {

					$sucat->{_Step} = $sucat->{_Step} . ' ' . $inbound_directory . '/' . $file . $sucat->{_input_suffix};

					# print("2B-1 sucat,Step,file=$file\n");
				}

				# CASE 2A-2 there is not input suffix specified by user
				elsif ( $sucat->{_input_suffix} eq $empty_string ) {
					$sucat->{_Step} = $sucat->{_Step} . ' ' . $inbound_directory . '/' . $file;

					#print("CASE 2A-2 sucat,Step,file=$file\n");

				}
				else {
					print("sucat,Step, unexpected input suffix, decreasing number, case 2A\n");
				}

			}    # end for loop

		}
		else {
			print("sucat,Step,case 2B nos. neither increase nor decrease monotnically\n");
		}
	}
	else {
		print("sucat,Step, unexpected list CASES 1 and 2\n");
	}

	# print $sucat->{_Step};
	return $sucat->{_Step};
}

1;
