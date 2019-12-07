package sucat;
use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS

 PROGRAM NAME: sucat
 AUTHOR: Juan Lorenzo
 DATE: May 25 2016
 DESCRIPTION concatenate a list of files
 Version .0.0.1
         0.0.2 June 23 2016
 Variable suffix changed to input_suffix 
 Notes: 
 Package name is the same as the file name
 Moose is a package that allows an object-oriented
 syntax to organizing your programs
 
 0.0.2 allows externallist of file to concatentate
 and alternative i/p and o/p directories 11/8/19

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
       $sucat->first_file_number('1000');
       $sucat->last_file_number('1001');
       $sucat->number_of_files('2');
       $sucat->Step();
=cut

=head2 newline:

 is a special character

=cut

my $newline = '
';

=head2 sucat:

 is a hash of important variables

=cut

=head2 list:

 an empty list array 

=cut

my (@list);

my $sucat = {
	_first_file_number              => '',
	_alternative_inbound_directory  => '',
	_alternative_outbound_directory => '',
	_last_file_number               => '',
	_list_array                     => '',
	_list_directory                 => '',
	_number_of_files                => '',
	_input_suffix                   => '',
	_name_prefix                    => '',
	_name_extension                 => '',
	_output_file_name               => '',
	_Step                           => ''
};

=head2 sub clear:

 clean hash of its values

=cut

sub clear {
	$sucat->{_first_file_number}              = '';
	$sucat->{_alternative_inbound_directory}  = '';
	$sucat->{_alternative_outbound_directory} = '';
	$sucat->{_last_file_number}               = '';
	$sucat->{_list_array}                     = '';
	$sucat->{_list_directory}                 = '';
	$sucat->{_number_of_files}                = '';
	$sucat->{_input_suffix}                   = '';
	$sucat->{_name_prefix}                    = '',
		$sucat->{_name_extension}             = '',
		$sucat->{_output_file_name}           = '',
		$sucat->{_Step}                       = '';
}

=head2 sub test:

 example of how to use a class method

=cut

sub test {
	my ( $test, @value ) = @_;
	print(
		"\$test or the first_file_number scalar  'holds' a  HASH $test 
 that represents the name of the  
 subroutine you are trying to use and all its needed components\n"
	);
	print(
		"\@value, the second scalar is something 'real' you put in, i.e., @value\n\n"
	);
}

=head2 sub first_file_number:

 for first_file_number numerical file name

=cut

sub first_file_number {
	my ( $variable, $first_file_number ) = @_;
	$sucat->{_first_file_number} = $first_file_number
		if defined($first_file_number);
	return ();
}

=head2 sub alternative_inbound_directory:

 for inbound directory name

=cut

sub alternative_inbound_directory {
	my ( $variable, $alternative_inbound_directory ) = @_;
	$sucat->{_alternative_inbound_directory} = $alternative_inbound_directory
		if defined($alternative_inbound_directory);
	return ();
}

=head2 sub alternative_outbound_directory:

 for inbound directory name

=cut

sub alternative_outbound_directory {
	my ( $variable, $alternative_outbound_directory ) = @_;
	$sucat->{_alternative_outbound_directory} = $alternative_outbound_directory
		if defined($alternative_outbound_directory);
	return ();
}

=head2 sub last_file_number:

 for first_file_number numerical file name 

=cut

sub last_file_number {
	my ( $variable, $last_file_number ) = @_;
	$sucat->{_last_file_number} = $last_file_number
		if defined($last_file_number);

	#	print("last_file_number is $sucat->{_last_file_number}  \n\n");
	return ();
}

=head2 sub list

 list array

=cut

sub list {
	my ( $variable, $sref_list ) = @_;
	$sucat->{_list} = $sref_list if defined($sref_list);

	print("$$sref_list\n\n");

	print("sucat,list is $sucat->{_list}\n\n");
	return ();
}

=head2 sub list_array

 list array

=cut

sub list_array {
	my ( $variable, $ref_list ) = @_;
	$sucat->{_list_array} = $ref_list if defined($ref_list);

	#print("@$ref_list[2]\n\n");
	$sucat->{_number_of_files} = scalar @$ref_list;

	#print("number_of_files is $sucat->{_number_of_files}\n\n");
	return ();

}

=head2 sub list_directory:

 for list directory name

=cut

sub list_directory {
	my ( $variable, $list_directory ) = @_;
	$sucat->{_list_directory} = $list_directory if defined($list_directory);
	return ();
}

=head2 sub last_file_number:

 for first_file_number numerical file name 

=cut

=head2 sub number_of_files:

 for number of files to concatenate

=cut

sub number_of_files {
	my ( $variable, $number_of_files ) = @_;
	$sucat->{_number_of_files} = $number_of_files if defined($number_of_files);
	return ();
}

=head2 sub input_suffix 

 use after dot for all names

=cut

sub input_suffix {
	my ( $variable, $input_suffix ) = @_;
	$sucat->{_input_suffix} = $input_suffix if defined($input_suffix);
	return ();
}

=head2 sub name_extension 

 use after dot for all names

=cut

sub name_extension {
	my ( $variable, $name_extension ) = @_;
	$sucat->{_name_extension} = $name_extension if defined($name_extension);
	return ();
}

=head2 sub name_prefix 

 use after dot for all names

=cut

sub name_prefix {
	my ( $variable, $name_prefix ) = @_;
	$sucat->{_name_prefix} = $name_prefix if defined($name_prefix);
	return ();
}

=head2 subroutine Step  

 builds array to concatenate
 first_file_number line output contacts program name
 successive lines
 final output name is provided by user name
 add new file names

=cut

sub Step {

	$sucat->{_Step} = ' cat ';
	my $file;

	if ( $sucat->{_list_array} ) {
		for ( my $i = 1; $i < $sucat->{_number_of_files}; $i++ ) {

			#print("i=$i\n\n");
			#print(" list_directory is $sucat->{_list_directory}\n\n");
			$sucat->{_Step} =
				  $sucat->{_Step}
				. $sucat->{_alternative_inbound_directory} . '/'
				. $sucat->{_list_array}[$i]
				. $sucat->{_input_suffix} . ' \\'
				. $newline;

			#print(" list is $sucat->{_Step}\n\n");
		}
	}
	elsif ( $sucat->{_first_file_number} < $sucat->{_last_file_number} ) {
		for (
			my $file = $sucat->{_first_file_number};
			$file <= $sucat->{_last_file_number};
			$file++
			)
		{
			$sucat->{_Step} =
				  $sucat->{_Step} . ' '
				. $sucat->{_alternative_inbound_directory} . '/'
				. $file
				. $sucat->{_input_suffix};
		}
	}
	elsif ( $sucat->{_first_file_number} > $sucat->{_last_file_number} ) {
		print("sucat, Step, reverse order assumed\n");
		for (
			my $file = $sucat->{_first_file_number};
			$file >= $sucat->{_last_file_number};
			$file = ( $file - 1 )
			)
		{
			$sucat->{_Step} =
				  $sucat->{_Step} . ' '
				. $sucat->{_alternative_inbound_directory} . '/'
				. $file
				. $sucat->{_input_suffix};
			print("sucat,Step,file=$file\n");
		}
	}
	return $sucat->{_Step};
}

=head2 sub get_max_index

max index = number of input variables -1

=cut

sub get_max_index {
	my ($self) = @_;

	# only file_name : index=6
	my $max_index = 6;

	return ($max_index);
}

1;
