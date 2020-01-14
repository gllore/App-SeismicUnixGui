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

=head2 list:

 an empty list array 

=cut

my (@list);

=head2 sucat:
is a hash of important variables

=cut

my $sucat = {
	_first_file_number_in => '',
	_inbound_directory    => '',
	_outbound_directory   => '',
	_last_file_number_in  => '',
	_list_aref            => '',
	_list_directory       => '',
	_number_of_files_in   => '',
	_input_suffix         => '',
	_data_type            => '',
	_output_file_name     => '',
	_velan_data           => '',
	_Step                 => ''
};

=head2 sub clear:

 clean hash of its values

=cut

sub clear {
	my ($self) = @_;
	$sucat->{_first_file_number_in} = '';
	$sucat->{_inbound_directory}    = '';
	$sucat->{_outbound_directory}   = '';
	$sucat->{_last_file_number_in}  = '';
	$sucat->{_list_array}           = '';
	$sucat->{_list_directory}       = '';
	$sucat->{_data_type}            = '';
	$sucat->{_number_of_files_in}   = '';
	$sucat->{_input_suffix}         = '';
	$sucat->{_output_file_name}     = '';
	$sucat->{_Step}                 = '';
}

=head2 _get_data_type

=cut

sub _get_data_type {
	my ($self) = @_;

	if (    $sucat->{_list_directory} ne $empty_string
		and $sucat->{_list} ne $empty_string )
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

		my $inbound_list = $sucat->{_list_directory} . '/' . $sucat->{_list};

		my ( $array_ref, $num_cdps ) = $read->cols_1p($inbound_list);

		for ( my $i = 0; $i < $num_cdps; $i++ ) {

			my $file_name = @$array_ref[$i];


			if ( $file_name =~ m/$itop_mute/ 
				or $file_name =~ m/$ibot_mute/ ) {

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
		print("sucat,_get_data_type,missing list and its directory\n");

	}
}

=head2 sub _set_data_type

 set_data_type can be mute,velan,su,txt ore empty

=cut

sub _set_data_type {
	my ($data_type)= @_;
	
	if ($data_type ne $empty_string) {
		
		$sucat->{_data_type} = $data_type;
		# print("set_data_type, data_type = $sucat->{_data_type}\n");
		
	} else {
		# print("set_data_type, no data_type NADA\n");
	}

}

=head2 sub data_type

 data_type can be mute,velan,su,txt

=cut

sub data_type {
	my ($self) = @_;

	if (    $sucat->{_list_directory} ne $empty_string
		and $sucat->{_list} ne $empty_string )
	{

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

		my $data_type = _get_data_type();
		_set_data_type($data_type);
	    # rint("sucat, data_type, data_type=---$data_type---\n\n");

		if ( $data_type ne $empty_string ) {
			
			my $inbound_list =
				$sucat->{_list_directory} . '/' . $sucat->{_list};
			my ( $ref_array, $num_cdps ) = $read->cols_1p($inbound_list);

			my $DIR_OUT = $sucat->{_list_directory};

			# print("sucat,data_type,num_cdps: $num_cdps\n");

=head2

 read a list of file names
 read contents of each file in the list
 into arrays
 each line of the list contains:
 
  cdp number as well as an 

  cdp number as well as an 
 indicator of what file the velocity picks are in
 
=cut

			for (
				my $file_number = 0, my $line = 0;
				$file_number < $num_cdps;
				$file_number++, $line++
				)
			{
				my $file_name_complete = @$ref_array[$file_number];
				my $inbound =
					$sucat->{_list_directory} . '/' . $file_name_complete;

				my $cdp_name = @$ref_array[$file_number];

				# print("reading cdp: $cdp_name\n");
				$cdp_name =~ s/[^0-9]*//g;
				$cdp[$file_number] = $cdp_name;

				# print("sucat,data_type,reading cdp: $cdp[$file_number]\n");

				# for one cdp at a time
				( $values_aref, $ValuesPerRow_aref ) =
					manage_files_by::read_par( \$inbound );

				# print("sucat,data_type,ValuesPerRow : @$ValuesPerRow_aref\n");

=head2 place contents of each file in the list
 into an array

=cut

				$result_t[$line] = @$values_aref[0];
				$result_v[$line] = @$values_aref[1];

				# print("sucat,data_type,t: $result_t[$line]\n");
				# print("sucat,data_type,v: $result_v[$line]\n");

			}    # end repeat over all velan files

			# print("writing outbound .cdp\n");
			# print("writing outbound @cdp\n");
			manage_files_by::write_cdp( \@cdp, $DIR_OUT );

			if ( $data_type eq 'velan' ) {

				manage_files_by::write_tnmo_vnmo( \@cdp, \@result_t, \@result_v,
					$DIR_OUT );

			}
			elsif ( $data_type  eq 'mute' ) {

				manage_files_by::write_tmute_xmute( \@cdp, \@result_t,
					\@result_v, $DIR_OUT );
			}
			else {
				print(
					"sucat, data_type, unrecognized data_type, data_type can be mute or velan\n"
				);
			}

		}
		else {
			print("sucat,data_type. Data types are not all only mute or velan.
Ignore special formats. Using simple cat.\n\n");
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
	print(
		"\@value, the second scalar is something 'real' you put in, i.e., @value\n\n"
	);
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

=head2 sub list:

 for list directory name

=cut

sub list {
	my ( $variable, $list ) = @_;

	if ( $list ne $empty_string ) {
		$sucat->{_list} = $list;
	}
	else {
		# print("sucat,list: NADA\n");
	}

}

#=head2 sub _list_aref
#
# list array
#
#=cut
#
#sub _list_aref {
#	my ($list_aref) = @_;
#
#	if ( $list_aref ne $empty_string ) {
#		$sucat->{_list_aref} = $list_aref;
#	}
#	else {
#		# print("sucat,list_aref: NADA\n");
#	}
#
#	# print("sucat, list_aref, list=---@$list_aref--\n");
#	$sucat->{_number_of_files_in} = scalar @$list_aref;
#
#	#	print(
#	#		"sucat, _list_aref, number_of_files_in=$sucat->{_number_of_files_in}\n\n"
#	#	);
#}

=head2 sub list_directory:

 for list directory name

=cut

sub list_directory {
	my ( $variable, $list_directory ) = @_;

	if ( $list_directory ne $empty_string ) {
		$sucat->{_list_directory} = $list_directory;
	}
	else {
		# print("sucat,list_directory: NADA\n");
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

=head2 sub set_ist_aref

 list array

=cut

sub set_list_aref {
	my ( $variable, $list_aref ) = @_;

	if ( $list_aref ne $empty_string ) {
		$sucat->{_list_aref} = $list_aref;
	}
	else {
		# print("sucat,set_list_aref: NADA\n");
	}

	# print("sucat, list_aref, list=---@$list_aref--\n");
	$sucat->{_number_of_files_in} = scalar @$list_aref;

  #print(
  #	"sucat, set_list_aref, number_of_files_in=$sucat->{_number_of_files_in}\n\n"
  #);
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

	# CASE 1: there is a list
	if ( $sucat->{_list_aref} ne $empty_string ) {

		$sucat->{_Step} = ' cat ';

		# CASE 1A- without data type
		if ( $sucat->{_data_type} eq $empty_string ) {

			# print(" list is $sucat->{_Step}\n\n");

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
					$sucat->{_Step} =
						  $sucat->{_Step}
						. $sucat->{_inbound_directory} . '/'
						. @{ $sucat->{_list_aref} }[$i] . ' \\'
						. $newline;

				}
				else {
					print("sucat,Step, unexpected input_suffix \n");
				}

				# print("i=$i\n\n");
				# print(" list_directory is $sucat->{_list_directory}\n\n");
				# print(" 1. list is $sucat->{_Step}\n");
			}
		}    # end CASE 1A no data type

		# CASE 1B: data_type does exist
		elsif ( $sucat->{_data_type} ne $empty_string ) {

			if ( $sucat->{_data_type} eq 'velan' ) {

				$sucat->{_Step} =
					  $sucat->{_Step}
					. $sucat->{_inbound_directory} . '/' . '.cdp '
					. $sucat->{_inbound_directory} . '/' . '.tv' . '\\'
					. $newline;

		  # print("sucat,Step, case of velan,sucat->{_Step}=$sucat->{_Step}\n");

			}
			elsif ( $sucat->{_data_type} eq 'mute' ) {

				$sucat->{_Step} =
					  $sucat->{_Step}
					. $sucat->{_inbound_directory} . '/' . '.cdp '
					. $sucat->{_inbound_directory} . '/' . '.tx ' . '\\'
					. $newline;

			}
			else {
				print(" list sucat,Step,unexpected data_type\n\n");
			}
		}
		else {
			print(" list sucat,Step,unexpected situation \n\n");
		}
	}    #END CASE 1: with list

	# CASE 2: there is no list
	elsif ( $sucat->{_list_aref} eq $empty_string ) {
		$sucat->{_Step} = ' cat ';

		# print(" 2. sucat,Step, list is $sucat->{_Step}\n\n");

		# CASE 2A: the nos. increase monotonically
		if ( $sucat->{_first_file_number_in} <= $sucat->{_last_file_number_in} )
		{
			for (
				my $file = $sucat->{_first_file_number_in};
				$file <= $sucat->{_last_file_number_in};
				$file++
				)
			{

				# CASE 2A-1 there is an input suffix specified by user
				if ( $sucat->{_input_suffix} ne $empty_string ) {

					$sucat->{_Step} =
						  $sucat->{_Step} . ' '
						. $sucat->{_inbound_directory} . '/'
						. $file . '.'
						. $sucat->{_input_suffix};

				}

				# CASE 2A-2 there is not input suffix specified by user
				elsif ( $sucat->{_input_suffix} eq $empty_string ) {
					$sucat->{_Step} =
						  $sucat->{_Step} . ' '
						. $sucat->{_inbound_directory} . '/'
						. $file;
				}
				else {
					print(" sucat,Step, unexpected input, growing numbers\n");
				}

			}    # end for loop
		}

		# CASE 2B: nos. decrease monotonically
		elsif (
			$sucat->{_first_file_number_in} > $sucat->{_last_file_number_in} )
		{
			print("2. sucat, Step, reverse order assumed\n");

			for (
				my $file = $sucat->{_first_file_number_in};
				$file >= $sucat->{_last_file_number_in};
				$file = ( $file - 1 )
				)
			{

				# CASE 2B-1  there is an input suffix specified by user
				if ( $sucat->{_input_suffix} ne $empty_string ) {

					$sucat->{_Step} =
						  $sucat->{_Step} . ' '
						. $sucat->{_inbound_directory} . '/'
						. $file
						. $sucat->{_input_suffix};
					print("2A-1 sucat,Step,file=$file\n");
				}

				# CASE 2A-2 there is not input suffix specified by user
				elsif ( $sucat->{_input_suffix} eq $empty_string ) {
					$sucat->{_Step} =
						  $sucat->{_Step} . ' '
						. $sucat->{_inbound_directory} . '/'
						. $file;
					print("2A-2 sucat,Step,file=$file\n");

				}
				else {
					print(
						"sucat,Step, unexpected input suffix, decreasing number, case 2A\n"
					);
				}

			}    # end for loop

		}
		else {
			print(
				"sucat,Step,case 2B nos. neither increase nor decrease monotnically\n"
			);
		}
	}
	else {
		print("sucat,Step, unexpected list CASES 1 and 2\n");
	}

	return $sucat->{_Step};
}

#=head2 sub get_max_index
# does not have its own config file
#max index = number of input variables -1
#
#=cut
#
#sub get_max_index {
#	my ($self) = @_;
#
#	# only file_name : index=6
#	my $max_index = 6;
#
#	return ($max_index);
#}

1;
