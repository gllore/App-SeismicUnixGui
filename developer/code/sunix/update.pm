package update;

=head1 DOCUMENTATION

=head2 SYNOPSIS

PROGRAM NAME:  update.pl							

 AUTHOR: Juan Lorenzo
 DATE:   September 4 2021 
 DESCRIPTION: minor changes to 
program_config.pm
 program_spec.pm
 and program.pm files

=head2 USE

=head3 NOTES

=head4 Examples

=head3 NOTES

 	Program group array and the directory names:
 		
$developer_sunix_categories[0]  = 'data';
$developer_sunix_categories[1]  = 'datum';
$developer_sunix_categories[2]  = 'plot';
$developer_sunix_categories[3]  = 'filter';
$developer_sunix_categories[4]  = 'header';
$developer_sunix_categories[5]  = 'inversion';
$developer_sunix_categories[6]  = 'migration';
$developer_sunix_categories[7]  = 'model';
$developer_sunix_categories[8]  = 'NMO_Vel_Stk';
$developer_sunix_categories[9]  = 'par';
$developer_sunix_categories[10] = 'picks';
$developer_sunix_categories[11] = 'shapeNcut';
$developer_sunix_categories[12] = 'shell';
$developer_sunix_categories[13] = 'statsMath';
$developer_sunix_categories[14] = 'transform';
$developer_sunix_categories[15] = 'well';
$developer_sunix_categories[16] = '';
  	
 	QUESTION 1:
Which group number do you want to use to update
for *.pm, *.config, and *_spec.pm files ?

e.g., for transforms use:
$group_number = 15

QUESTION 2:
Which program do you want to work on?

For example=
'sugetgthr';
'sugain';
'suputgthr';
'suifft';
'sufctanismod'
'vel2stiff
'unif2aniso'
'transp'
'suflip'


	my $program_name = 'suhistogram';

=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';

use L_SU_global_constants;
use sudoc;
use sunix_package;
use prog_doc2pm;

my $get         = L_SU_global_constants->new();
my $sudoc       = sudoc->new();
my $package     = sunix_package->new();
my $prog_doc2pm = prog_doc2pm->new();

my $var   = $get->var();
my $true  = $var->{_true};
my $false = $var->{_false};

my (@file_in);
my ($i);
my @file;
my ( @path_out4configs,         @path_out4developer, @path_out4specs, @path_out4sunix );
my ( @path_in4configs,          @path_in4developer,  @path_in4specs,  @path_in4sunix );
my ( @path_in4global_constants, @path_out4global_constants );
my $package_name;
my ( @config_file_in,               @config_file_out, @pm_file_in, @pm_file_out, @spec_file_in, @spec_file_out );
my ( @global_constants_file_in,     @global_constants_file_out );
my ( @config_inbound,               @config_outbound, @pm_inbound, @pm_outbound, @spec_inbound, @spec_outbound );
my ( @global_constants_inbound,     @global_constants_outbound );
my ( @line_global_constant_success, @line_terminator_success );
my $whole_aref;
my @slurp;
my @program_list;
my $max_index;
my ( $index_start_extraction, $index_end_extraction );
my $length;
my $length_of_slurp;
my $spec_replacement_success  = $false;
my $sunix_replacement_success = $false;
my $global_constant_success   = $false;
my $terminator_match_success  = $false;
my $L_SU_global_constants     = 'L_SU_global_constants';
my ( $program_name, $group_number );

my $sudoc2pm = {
	_names         => '',
	_values        => '',
	_line_contents => '',
	_program_name  => '',
	_group_number  => '',
};

=head2 sub set_program 

QUESTIONS:
Which group number do you want ?
What program do you want?

=cut

sub set_program {
	my ( $self, $program_name, $group_number ) = @_;
	print("update, set_program , group_number category=$group_number, program_name=$program_name\n");

	if (   length $program_name
		&& length $group_number ) {

		$sudoc2pm->{_program_name} = $program_name;
		$sudoc2pm->{_group_number} = $group_number;

		print("update, set_program, group_number category=$group_number, program_name=$program_name\n");

	} else {
		print("update, set_program, missing program name or group number\n");
	}

	return ();

}

sub get_changes {

	my ($self) = @_;

	if (   length $sudoc2pm->{_program_name}
		&& length $sudoc2pm->{_group_number} ) {

		$program_name = $sudoc2pm->{_program_name};
		$group_number = $sudoc2pm->{_group_number};

		$prog_doc2pm->set_group_directory($group_number);
		my @developer_sunix_category = @{ $get->developer_sunix_categories_aref() };
		my $sunix_category           = $developer_sunix_category[$group_number];

=head2 private values

=cut

		my $path_in     = $prog_doc2pm->get_path_in();
		my $list_length = $prog_doc2pm->get_list_length();

		$path_out4developer[0] = $prog_doc2pm->get_path_out4developer();

		$path_out4configs[0] = $prog_doc2pm->get_path_out4configs();
		$path_out4specs[0]   = $prog_doc2pm->get_path_out4specs();
		$path_out4sunix[0]   = $prog_doc2pm->get_path_out4sunix();

		$path_in4configs[0] = $prog_doc2pm->get_path_out4configs();
		$path_in4specs[0]   = $prog_doc2pm->get_path_out4specs();
		$path_in4sunix[0]   = $prog_doc2pm->get_path_out4sunix();

		$path_out4global_constants[0] = $prog_doc2pm->get_path_out4global_constants();
		$path_in4global_constants[0]  = $prog_doc2pm->get_path_out4global_constants();

=head2 path definitions

=cut

		$package_name                 = $program_name;
		$pm_file_out[0]               = $package_name . '.pm';
		$config_file_out[0]           = $package_name . '.config';
		$spec_file_out[0]             = $package_name . '_spec.pm';
		$global_constants_file_out[0] = $L_SU_global_constants . '.pm';

		$pm_file_in[0]               = $package_name . '.pm';
		$config_file_in[0]           = $package_name . '.config';
		$spec_file_in[0]             = $package_name . '_spec.pm';
		$global_constants_file_in[0] = $L_SU_global_constants . '.pm';

		$pm_inbound[0]               = $path_in4sunix[0] . '/' . $pm_file_in[0];
		$config_inbound[0]           = $path_in4configs[0] . '/' . $config_file_in[0];
		$spec_inbound[0]             = $path_in4specs[0] . '/' . $spec_file_in[0];
		$global_constants_inbound[0] = $path_in4global_constants[0] . '/' . $global_constants_file_in[0];

		$pm_outbound[0]               = $path_out4sunix[0] . '/' . $package_name . '.pm';
		$config_outbound[0]           = $path_out4configs[0] . '/' . $package_name . '.config';
		$spec_outbound[0]             = $path_out4specs[0] . '/' . $package_name . '_spec.pm';
		$global_constants_outbound[0] = $path_out4global_constants[0] . '/' . $global_constants_file_in[0];

		#$global_constants_outbound[1] = $path_out4global_constants[0] . '/' . $global_constants_file_in[0].'_2';

=head2 QUESTION 3:
Handled Automatically from here on
What max_index value do you want to insert?
Read number of lines in the 
program_config.pm file

=cut

		open( FILE, "< $config_inbound[0]" ) or die "can't open $config_inbound[0]: $!";
		$length_of_slurp++ while <FILE>;

		# $count now holds the number of lines read
		print("number of lines read = $length_of_slurp \n");
		$max_index = $length_of_slurp - 1;

		my $spec_string_to_find     = 'my \$max_index = # Insert a number here';
		my $spec_replacement_string = (" my \$max_index           = $max_index;");

		my $sunix_string_to_find     = 'my \$max_index = 36;';
		my $sunix_replacement_string = ("\tmy \$max_index = $max_index;");

		#print("For program_spec.pm files, working on replacement of \n$spec_string_to_find\n with \n\t$spec_replacement_string \n");

		my $global_constants_string_to_find = ("my \@sunix_$sunix_category\_programs");
		my $terminator_to_find              = '\);';

		#print("For program_sunix.pm files, working on replacement of \n$sunix_string_to_find\n with \n\t$sunix_replacement_string \n");

		#print("update,path_out: $path_out4developer\n");
		#my @program_name = @{ $prog_doc2pm->get_program_aref() };
		#for ( my $i = 0; $i < $list_length; $i++ ) {
##print("update,program_name, num=$i, program_name=$program_name[$i]\n");
		#print("update,program_name, selected_program_name=$program_name, \n");

=head2 Updating spec_files

=cut

		if (   length $package_name
			&& ( -e $spec_inbound[0] )
			&& ( -e $spec_outbound[0] ) ) {

			print("update, I am in group=$group_number \n");
			print("update, I am working on package =$package_name \n");
			print("update, updating $spec_file_out[0]in $path_out4specs[0]\n");

=head2 Read in package file (
 "program"_spec.pm)

=cut

			$sudoc->set_file_in_sref( \$spec_file_in[0] );
			$sudoc->set_perl_path_in( $path_in4specs[0] );

			# slurp the whole file
			$sudoc->whole();
			my $whole_aref = $sudoc->get_whole();

			my $length_of_slurp = scalar @{$whole_aref};

			#	print("update.pl,num_lines= $length_of_slurp\n");
			#	for ( my $i = 0; $i < $length_of_slurp; $i++ ) {
			#		print("update,All sunix documentation @{$whole_aref}[$i]\n");
			#	}

			my @slurp = @{$whole_aref};

			for ( my $i = 0; $i < $length_of_slurp; $i++ ) {

				#		print("update,All sunix documentation $slurp[$i]\n");

				my $string = $slurp[$i];

				#        print("update, string to search:$slurp[$i]\n");

				if ( $string =~ /$spec_string_to_find/ ) {

					print("a spec success\n");

					$slurp[$i] = $spec_replacement_string;

					#			print("update, \n $slurp[$i]\n");

					$spec_replacement_success = $true;
					$slurp[$i] = $spec_replacement_string;
				}

			}

			if ($spec_replacement_success) {

				#	Write out the corrected file
				#	print("writing out to  $spec_outbound[0]\n");

				open( OUT, ">$spec_outbound[0]" ) or die("File  $spec_outbound[0] not found");

				for ( my $i = 0; $i < $length_of_slurp; $i++ ) {

					#				print ("$slurp[$i]\n");
					print OUT $slurp[$i] . "\n";

				}
				close(OUT);

			} else {
				print("update, spec string replacement unsuccessful\n");
			}
			#
		} else {
			print "update: a \"spec\" file is missing!\n";
		}    # for a selected program name in the group

=head2 Updating sunix.pm files

=cut

		if (   length $package_name
			&& ( -e $pm_outbound[0] )
			&& ( -e $pm_inbound[0] ) ) {

			#	print("update, I am in group=$group_number \n");
			#	print("update, I am working on package =$package_name \n");
			#	print("update, updating $pm_file_out[0] in $path_out4sunix[0]\n");

=head2 Read in package file (
 "program".pm)

=cut

			$sudoc->set_file_in_sref( \$pm_file_in[0] );
			$sudoc->set_perl_path_in( $path_in4sunix[0] );

			# slurp the whole file
			$sudoc->whole();
			my $whole_aref = $sudoc->get_whole();

			my $length_of_slurp = scalar @{$whole_aref};

			#		print("update.pl,num_lines= $length_of_slurp\n");
			#		for ( my $i = 0; $i < $length_of_slurp; $i++ ) {
			#			print("update,All sunix documentation @{$whole_aref}[$i]\n");
			#	}

			my @slurp = @{$whole_aref};

			for ( my $i = 0; $i < $length_of_slurp; $i++ ) {

				#		print ("string to find:$sunix_string_to_find\n");
				my $string = $slurp[$i];

				#        print("update, string to search:$slurp[$i]\n");

				if ( $string =~ /$sunix_string_to_find/ ) {

					#			print("a success\n");
					$sunix_replacement_success = $true;
					$slurp[$i] = $sunix_replacement_string;

				}

			}

			if ($sunix_replacement_success) {

				#	Write out the corrected file
				#		print("writing out to  $pm_outbound[0]\n");

				open( OUT, ">$pm_outbound[0]" ) or die("File  $pm_outbound[0] not found");

				for ( my $i = 0; $i < $length_of_slurp; $i++ ) {

					#			print("$slurp[$i]\n");
					print OUT $slurp[$i] . "\n";

				}
				close(OUT);

			} else {
				print("update, sunix string replacement unsuccessful\n");
			}

		} else {
			print "update: an sunix file is missing!\n";
		}    # for a selected program name in the group

=head2 update L_SU_global_constants

=cut

		if (   length $package_name
			&& ( -e $global_constants_inbound[0] )
			&& ( -e $global_constants_outbound[0] ) ) {

			#	print("update, I am in group=$group_number \n");
			#	print("update, I am working on package =$package_name \n");
			print("update, updating  $global_constants_file_in[0] in $path_out4global_constants[0]\n");

=head2 Read in file 
( L_SU_global_constants.pm )

=cut

			$sudoc->set_file_in_sref( \$global_constants_file_in[0] );
			$sudoc->set_perl_path_in( $path_in4global_constants[0] );

			# slurp the whole file
			$sudoc->whole();
			$whole_aref      = $sudoc->get_whole();
			@slurp           = @{$whole_aref};
			$length_of_slurp = scalar @{$whole_aref};

			#	print("update.pl,num_lines= $length_of_slurp\n");
			#	for ( my $i = 0; $i < $length_of_slurp; $i++ ) {
			#
			#		#		print("update,All sunix documentation @{$whole_aref}[$i]\n");
			#	}

			#	print("global_constants_string_to_find=$global_constants_string_to_find\n");
			my @line_success;

			my $count_global_constant = 0;
			my $count_terminator      = 0;

			# find the  starting expression
			for ( my $i = 0; $i < $length_of_slurp; $i++ ) {

				# print("update,$slurp[$i]\n");
				my $string = $slurp[$i];

				#        print("update, string to search:$slurp[$i]\n");

				if ( $string =~ /$global_constants_string_to_find/ ) {

					#			print("a success in finding a global constant\n");
					$line_global_constant_success[$count_global_constant] = $i;
					$count_global_constant++;

					#			print("update, \n $slurp[$i]\n");
					$global_constant_success = $true;

				}

				# find the tail expression ")"
				if ( $string =~ /$terminator_to_find/ ) {

					#	print("a success in finding a terminator\n");
					$line_terminator_success[$count_terminator] = $i;
					$count_terminator++;
					$terminator_match_success = $true;
				}

			}

			my $length_line_terminator_success = scalar @line_terminator_success;

			#	print("length_line_terminator_success = $length_line_terminator_success\n");
			my $length_line_global_constant_success = scalar @line_global_constant_success;

			#	print("length_line_global_constant_success= $length_line_global_constant_success\n");

			# find difference between start (one) and the tail ")"
			#  expressions (many)
			if (   $global_constant_success
				&& $terminator_match_success
				&& $count_global_constant == 1 ) {

				my @differences;
				my $minimum = 1000000;    # very large number
				my $index_of_minimum;
				for ( my $i = 0; $i < $length_line_terminator_success; $i++ ) {

					$differences[$i]
						= $line_terminator_success[$i] - $line_global_constant_success[0];

					#			print("update, differences = $differences[$i]\n");

				}

				for ( my $i = 0; $i < $length_line_terminator_success; $i++ ) {

					if ( $differences[$i] >= 0 ) {

						if ( $differences[$i] < $minimum ) {

							$minimum          = $differences[$i];
							$index_of_minimum = $i;

							#					print("update, minimum = $differences[$i]\n");
							#					print("update, index_of_minimum = $index_of_minimum\n");

						}
					}

				}

				my $first_index_of_item = $line_global_constant_success[0];
				my $last_index_of_item  = $first_index_of_item + $minimum;

				#		print("update,  first_index_of_item= $first_index_of_item\n");
				#		print("update,  last_index_of_item= $last_index_of_item\n");

				#		for (my $i=$first_index_of_item; $i <= $last_index_of_item; $i++) {
				#			print("update,  sought-after lines= $slurp[$i]\n");
				#		}

				# extract the lines betwene the starting and
				#  ending expressions
				$index_start_extraction = $first_index_of_item + 1;
				$index_end_extraction   = $last_index_of_item - 1;
				@program_list           = @slurp[ $index_start_extraction .. $index_end_extraction ];

				#		print("update,  program_list= @program_list\n");
				#		print( @slurp[$index_start_extraction ..$index_end_extraction]);

			} else {
				print("sudoc2pm, unexpected values \n");
			}

			# remove the inverted commas around the list terms
			$length = scalar @program_list;

			for ( my $i = 0; $i < $length; $i++ ) {

				# remove last ""
				$program_list[$i] =~ s/",//g;

				#remove white space and first "
				$program_list[$i] =~ s/\s"//;

				#   		print("update,  item #$i in program_list=....$program_list[$i]\n");

			}

			# add a program name to the end
			push @program_list, $program_name;

			#	print("2. update,  program_list= @program_list\n");

			# sort alphabetically
			@program_list = sort(@program_list);

			#	print("3. update,  program_list= @program_list\n");

			# add commas and inverted commas again
			$length = scalar @program_list;
			for ( my $i = 0; $i < $length; $i++ ) {

				# remove last ""
				$program_list[$i] = '"' . $program_list[$i] . '",';

				#remove white space and first "
				$program_list[$i] =~ s/\s"//;

				# remove any remaining ""
				$program_list[$i] =~ s/"//;
				print("4. update,  item #$i in program_list=....$program_list[$i]\n");

				# put a tab and " at ths tart of each line"
				$program_list[$i] = "\t\"" . $program_list[$i];

			}

			# prevent duplicates
			my @unique = ();
			my %seen   = ();

			foreach my $elem (@program_list) {
				next if $seen{$elem}++;
				push @unique, $elem;
			}
			my @new_program_list = @unique;

			#	print("5 update,  program_list=@program_list\n");

			# put new array back into the slurp
			# 1. split slurp into 2 arrays
			# head array
			my @slurp_b4_extraction = @slurp[ 0 .. ( $index_start_extraction - 1 ) ];

			#tail array
			my @slurp_after_extraction = @slurp[ ( $index_end_extraction + 1 ) .. $length_of_slurp ];

			#	print("5.1 update,  slurp_b4_extraction: @slurp_b4_extraction\n");

			# add torso to head
			push @slurp_b4_extraction, @new_program_list;
			my @digested_slurp = @slurp_b4_extraction;

			#	print("5.2 update,  digested_slurp: @digested_slurp\n");

			# add tail to (torso+head)
			push @digested_slurp, @slurp_after_extraction;

			#	print("5.3 update,  digested_slurp: @digested_slurp\n");

			#	Write out the corrected file
			#	print("writing out to  $global_constants_outbound[0] n");
			my $length_digested_slurp = scalar @digested_slurp;

			open( OUT, ">$global_constants_outbound[0] " ) or die("File  $global_constants_outbound[0] not found");
			for ( my $i = 0; $i < ($length_digested_slurp); $i++ ) {

				if ( $digested_slurp[$i] ne "\t" ) {

					#			print(" update,  $digested_slurp[$i]\n");
					print OUT $digested_slurp[$i] . "\n";
				}

			}
			close(OUT);
			print(" update,  wrote out a new $global_constants_file_out[0]\n");

		} else {
			print "update: a global constants file is missing!\n";
		}    # for a selected global constants file

	} else {
		print("update, missing program name or group number\n");
	}

	return ();

}

1;
