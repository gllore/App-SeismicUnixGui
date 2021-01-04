package manage_files_by2;

use Moose;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 
 Contains methods/subroutines/functions to operate on directories

 PROGRAM NAME: manage_files_by  classIVA 
 AUTHOR: Juan Lorenzo
 DATE:   V 1. March 3 2008
 V 2 May 27 2014
         
 DESCRIPTION: 
 modified from
 manage_files_by 
 to stricts requirements using Moose
 manage_files_by  class

 =head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 NOTES  

=head4 CHANGES and their DATES


=cut

=pod

 head3= sub does_file_exist
 returns a 1 if the file does exist
 and returns a 0 if the file does not

=cut

=head2 Private anonymous hash 
sharable by methods

=cut

my $manage_files_by2 = {
	_directory => ' ',
};

=head2 sub set_directory

=cut

sub set_directory {

	my ( $self, $dir ) = @_;

	if ( length($dir) ) {

		$manage_files_by2->{_directory} = $dir;

		#		print("manage_files_by2, set_directory, dir=$manage_files_by2->{_directory} \n");

	} else {
		print("manage_fiels_by2, set_directory, missing value\n");
	}

	return ();
}

=head2 sub clear_empty_files

=cut

sub clear_empty_files {

	my ($self) = @_;

	if ( length( $manage_files_by2->{_directory} ) ) {
		
		my $dir = $manage_files_by2->{_directory};

		my ( @size,      @file_name, @inode );
		my ( $i,         $junk,      $cmd_file_name, $num_file_names );
		my ( $cmd_inode, $cmd_size,  $index_node_number );
			  #		print("manage_files_by2, clear_empty_files, dir=$manage_files_by2->{_directory} \n");

#		print("\n manage_files_by2, clear_empty_files in dir=$dir\n");
		chomp $dir;
		
		$cmd_file_name  = "ls -1 $dir";
		$cmd_size       = "ls -s1 $dir";
		$cmd_inode      = "ls -i1 $dir";
		@file_name      = `$cmd_file_name`;
		@size           = `$cmd_size`;
		@inode          = `$cmd_inode`;
		$num_file_names = scalar @file_name;

		for ( my $i = 0; $i < $num_file_names; $i++ ) {
			chomp $file_name[$i];
			chomp $inode[$i];

			$inode[$i] =~ s/^\s+//g;    # trim spaces at start
			( $inode[$i], $junk ) = split( / /, $inode[$i] );
			
			$file_name[$i] =~ s/^\s+//g;    # trim spaces at start
			( $file_name[$i], $junk ) = split( / /, $file_name[$i] );
		}

		for ( my $i = 1; $i <= $num_file_names; $i++ ) {

			chomp $size[$i];
			$size[$i] =~ s/^\s+//g;     # trim spaces at start
			( $size[$i], $junk ) = split( / /, $size[$i] );

		}

		for ( my $i = 0, my $j = 1; $i < $num_file_names; $i++, $j++ ) {
			
			my $test = (-d $dir.'/'.$file_name[$i] );
			if ( $size[$j] == 0 &&
				not ($test) ) {
						my $ans = ($test );
						
#				print("CASE of not a directory and file =0\n");				
#				print("CASE name inode size = $file_name[$i] $inode[$i] $size[$j]\n");
				
				$index_node_number = $inode[$i];
				my $flow = (
					"cd $dir
								find . -inum $index_node_number -exec rm {} \\;"
				);

				#		    print $flow;
				system $flow;

			} else {

				#			print("immodpg,clean_trash,size>0,line=$i, NADA\n");
			}
		}

	} else {

	}

	return ();
}

=head2 sub does_file_exist

=cut

sub does_file_exist {

	my ( $does_file_exist, $ref_file ) = @_;

	$does_file_exist->{ref_file} = $$ref_file if defined($ref_file);

	# print("manage_files_by2,does_file_exist,file name is, $$ref_file\n");

	# default situation is to have a file non-existent
	my $answer = 0;

	# -e returns 1 or ''
	# verified by JL
	# print("plain file for test is $$ref_file\n\n");
	if ( -f $does_file_exist->{ref_file} ) {

		# print  ("manage_files_by2,does_file_exist,file existence verified\n\n") ;
		$answer = 1;
	}

	#	answer=1 if existent and =0 if non-existent
	# verified by JL
	return ($answer);
}

sub does_file_exist_sref {

	my ($ref_file) = @_;

	if ($ref_file) {

		my $file = $$ref_file;

		# print("manage_files_by2,does_file_exist_sref,file name is, $$ref_file\n");

		# default situation is to have a file non-existent
		my $answer = 0;

		# -e returns 1 or ''
		# verified by JL
		# print("file for exist test is $$ref_file\n\n");
		# actually dies it exist and is it a plain file!!
		if ( -f $file ) {

			# print  ("file existence verified\n\n") ;
			$answer = 1;
		}

		#	answer=1 if existent and =0 if non-existent
		#verified by JL
		return ($answer);
	} else {
		print("does_file_exist_sref, ref_file is missing\n");
	}

}

=pod sub unique_elements

	filter out only unique elements from an array

=cut 

sub unique_elements {
	my ( $self, $array_ref ) = @_;

	my $results_ref;

	if ($array_ref) {

		my @unique_progs;
		my $total_num_progs4flow = scalar @{$array_ref};
		my $false                = 0;
		my $true                 = 1;
		my $num_unique_progs     = 1;

		my $seen = $true;
		$unique_progs[0] = @{$array_ref}[0];

		# print("manage_files_by2, program in flow: @{$array_ref}[0]\n");

		for ( my $i = 1; $i < $total_num_progs4flow; $i++ ) {

			# print("manage_files_by2, program in flow: @{$array_ref}[$i]\n");
			# print ("1. manage_files_by2, num_unique_progs=$num_unique_progs\n\n");
			for ( my $j = 0; $j < $num_unique_progs; $j++ ) {

				if ( $unique_progs[$j] eq @{$array_ref}[$i] ) {

					# print("program index in flow=$i\n");
					# print(" 1. manage_files_by2,repeated program detected \n");
					# print("manage_files_by2, prog_ repeated: @{$array_ref}[]$i]\n\n");
					$seen = $true;

					# exit if-loop and increment $j
				} else {

					# print("program index in flow=$i\n");
					# print("manage_files_by2, prog @{array_ref}[]$i] is unique\n\n");
					# print ("2. manage_files_by2,unique_prog detected=@{$array_ref}[$i] \n");
					$seen = $false;
				}
			}

			if ($seen) {
				$seen = $false;    #reset for next check
			} else {
				push @unique_progs, @{$array_ref}[$i];

				# print(" 1. manage_files_by2,unique new program found for output \n");
				$num_unique_progs++;
			}

		}    # end all programs

		# print("3. manage_files_by2, unique_progs are: @unique_progs\n");
		# print ("3. manage_files_by2, num_unique_progs=$num_unique_progs\n\n");

		$results_ref = \@unique_progs;
		return ($results_ref);

	} else {
		print("manage_files_by2,unique_elements, missing array\n");
		return ();

	}    # end if
}

=pod

  read a 1-column file

=cut

sub read_1col_aref {

	# open and read and input file
	my ($caller,$ref_file_name) = @_;

	#declare locally scoped variables
	my ($j,$num_rows);
	my ($i,$x);
	my @X;
 	my $line;
	# print("manage_files_by2,read_1col_aref,The output file name = $$ref_file_name\n");
	# set the counter
	
	$i = 0;
	open( IN, "<$$ref_file_name")  or die "Could not open file '$$ref_file_name'. $!";

	# read contents of file
	while ( $line = <IN> ) {

		# print("\n$line");
		chomp($line);
		($x) = split( "  ", $line );
		$X[$i] = $x;

		# print("\n $X[$i]\n");
		$i++;

	}

	close(FILE);

	$num_rows = $i;
	# print ("\nThis file contains $num_rows row(s) of data\n");

	return (\@X);

}

=pod

 read in a 2-columned file
 reads cols 1 and 2 in a text file


=cut

sub read_2cols {

	my ( $variable, $ref_origin ) = @_;

	#declare locally scoped variables
	my ( $i, $line, $t, $x, $num_rows );
	my ( @TIME, @TIME_OUT, @OFFSET, @OFFSET_OUT );
	# print("In this subroutine $$ref_origin\n");

	# open the file of interest
	open( FILE, $$ref_origin ) || print("Can't open. $$ref_origin \n");

	#set the counter
	$i = 1;

	# read contents of shotpoint geometry file
	while ( $line = <FILE> ) {

		#print("\n$line");
		chomp($line);
		( $t, $x ) = split( "  ", $line );
		$TIME[$i]   = $t;
		$OFFSET[$i] = $x;

		#print("\n $TIME[$i] $OFFSET[$i]\n");
		$i = $i + 1;

	}

	close(FILE);

	$num_rows = $i - 1;

	# print out the number of lines of data for the user
	#print ("\nThis file contains $num_rows row(s) of data\n");

	#   to prevent contaminating outside variables
	@TIME_OUT   = @TIME;
	@OFFSET_OUT = @OFFSET;

	return ( \@TIME_OUT, \@OFFSET_OUT, $num_rows );
}

=head2 sub get_3cols_aref
  
  This function reads 3 cols in a text file
  
=cut

sub get_3cols_aref {

	my ($reference, $file_name, $skip_lines) = @_;
	my (@X, @Y, @Z);
	my $lines;

	print ("\nThe input file is called $file_name\n");
	# open the file of interest
	open( FILE, "$file_name" ) || print("Can't open file name, $!\n");
    
    # skip lines
    for (my $i=0; $i< $skip_lines; $i ++ ) {
    	$lines = <FILE>;
    	print("line $i = $lines\n");
    }
    
	#set the counter
	my $i = 0;
	# read contents of file
	while ( my $lines = <FILE> ) {

		#     print("$lines");
		chomp($lines);
		my ( $x, $y, $z ) = split( " ", $lines );

		print("\n$x \n");
		$X[$i] = $x;
		$Y[$i] = $y;
		$Z[$i] = $z;

		#print("\n @X[$i] @Y[$i] @Z[$i] \n");
		$i++;
	}

	# number of geophones stations in file
	my $num_rows = $i - 1;

	#print ("This file contains $num_rows rows\n\n\n");
	# close the file of interest
	close(FILE);

	# make sure arrays do not contaminate outside

	return ( \@X, \@Y, \@Z);

}

=head2 sub read_par

 read parameter file
 file name is a scalar reference (to 
 scalar file name)
 o/p includes array of array references

=cut 

sub read_par {

	my ( $self, $ref_file_name ) = @_;

	print ("\nmanage_files_by2,read_par, The input file is called $$ref_file_name\n");

=pod Steps

     1. open file

     2. set the counter

     3. read contents of parameter file

     4. odd-numbered lines contain tnmo and even contain vnmo
     

=cut

	open( FILE, $$ref_file_name ) || print("Can't open file_name, $!\n");

	my $row = -1;
	my (@Items);
	my ( $i,   $line );
	my ( @row, @ValuesPerRow );

	while ( $line = <FILE> ) {
		$row++;
		my @things;

		# print("manage_files_by2,read_par, $line");

=pod

 1. remove end of line
 2. calculate number of useful elements
 2. only leave the numbers with commas in between:
 	e.g. things=tnmo 0.0567282,0.271768
 	N.B. these are only 2 things and not 3 things

=cut

		chomp($line);
		@things = split /[=,]/, $line;

		# print("manage_files_by2,read_par, things=@things, row= $row\n");
		$Items[$row]        = \@things;
		$ValuesPerRow[$row] = scalar(@things);

		# print("manage_files_by2,read_par, ValuesPerRow=$ValuesPerRow[$row], row=$row\n");

	}
	close(FILE);

	# print("manage_files_by2,read_par, ROW 0 @{$Items[0]} \n");
	# print("manage_files_by2,read_par, ROW 1 @{$Items[1]} \n");
	# print("manage_files_by2,read_par, ROW 0,1 Values per rows: @ValuesPerRow\n");
	return ( \@Items, \@ValuesPerRow );
}

=pod

  write out a 1-column file

=cut

sub write_1col_aref {

	# open and write to output file
	my ( $variable, $ref_X, $ref_file_name, $ref_fmt ) = @_;

	#declare locally scoped variables
	my $j;

	my $num_rows = scalar @$ref_X;

	# $variable is an unused hash

	# print("\n manage_files_by2,write_1col_aref,The output file name = $$ref_file_name\n");
	# print("\n manage_files_by2,write_1col_aref,The output file contains $num_rows rows\n");
	# print("\n manage_files_by2,write_1col_aref,The output file uses the following format: $$ref_fmt\n");

	open( OUT, ">$$ref_file_name" );

	for ( $j = 0; $j < $num_rows; $j++ ) {

		printf OUT "$$ref_fmt\n", @$ref_X[$j];

	}

	close(OUT);
	return ();

}

=pod

  write out a 1-columned file

=cut

sub write_1col1 {

	# open and write to output file
	my ( $variable, $ref_X, $ref_file_name, $ref_fmt ) = @_;

	#declare locally scoped variables
	my $j;

	my $num_rows = scalar $$ref_X;

	# $variable is an unused hash

	#print("\nThe subroutine has is called $variable\n");
	#print("\nThe output file contains $num_rows rows\n");
	#print("\nThe output file uses the following format: $$ref_fmt\n");
	open( OUT, ">$$ref_file_name" );

	for ( $j = 1; $j <= $num_rows; $j++ ) {

		#print OUT  ("$$ref_X[$j] $$ref_Y[$j]\n");
		printf OUT "$$ref_fmt\n", $$ref_X[$j];

		#print("$$ref_X[$j] $$ref_Y[$j]\n");
	}

	close(OUT);
	return ();

}

=pod

  write out a 2-columned file

=cut

sub write_2cols {

	# open and write to output file
	my ( $variable, $ref_X, $ref_Y, $num_rows, $ref_file_name, $ref_fmt ) = @_;

	#declare locally scoped variables
	my $j;

	# $variable is an unused hash

	#print("\nThe subroutine has is called $variable\n");
	#print("\nThe output file contains $num_rows rows\n");
	#print("\nThe output file uses the following format: $$ref_fmt\n");
	open( OUT, ">$$ref_file_name" );

	for ( $j = 1; $j <= $num_rows; $j++ ) {

		#print OUT  ("$$ref_X[$j] $$ref_Y[$j]\n");
		printf OUT "$$ref_fmt\n", $$ref_X[$j], $$ref_Y[$j];

		#print("$$ref_X[$j] $$ref_Y[$j]\n");
	}

	close(OUT);
	return ();

}

=head2 sub write_par

 write parameter file
 file name is a scalar reference to 
 scalar file name

=cut 

sub write_par {

	my ( $self, $ref_outbound, $ref_array_tnmo_row, $ref_array_vnmo_row, $first_name, $second_name ) = @_;

	# print("\nmanage_files_by2,write_par,The input file is called $$ref_outbound\n");

=head2 local definitions

=cut

	my $values_per_row;
	my @tnmo_array               = @$ref_array_tnmo_row;
	my @vnmo_array               = @$ref_array_vnmo_row;
	my $number_of_values_per_row = scalar @tnmo_array;

=pod Steps

     odd-numbered lines contain tnmo and even contain vnmo
     e.g., tnmo=1,2,3
     	   vnm==4,5,6
     
=cut

=head2 open and write values

=cut

	open( my $fh, '>', $$ref_outbound );

	print $fh ("$first_name=$tnmo_array[1]");

	for ( my $i = 2; $i < $number_of_values_per_row; $i++ ) {

		print $fh (",$tnmo_array[$i]");

	}

	print $fh ("\n");

	print $fh ("$second_name=$vnmo_array[1]");

	for ( my $i = 2; $i < $number_of_values_per_row; $i++ ) {

		print $fh (",$vnmo_array[$i]");

	}

	close($fh);
	return ();
}

=head2 sub write_multipar

 write parameter file
 file name is a scalar reference to 
 scalar file name

=cut 

sub write_multipar {

	my (
		$self,               $ref_outbound, $ref_array_cdp_row,
		$ref_array_tnmo_row, $ref_array_vnmo_row,
		$first_name,         $second_name
	) = @_;

	#	print(
	#		"\nmanage_files_by2,write_par,The input file is called $$ref_outbound\n"
	#	);

=head2 local definitions

=cut

	my $values_per_row;
	my @cdp_array                = $ref_array_cdp_row;
	my @tnmo_array               = @$ref_array_tnmo_row;
	my @vnmo_array               = @$ref_array_vnmo_row;
	my $number_of_values_per_row = scalar @tnmo_array;
	my $number_of_cdp_per_row    = scalar @cdp_array;

	#	print("@$ref_array_cdp_row \n");
	#	print("$number_of_values_per_row \n");

=pod Steps

     odd-numbered lines contain tnmo and even contain vnmo
     e.g., tnmo=1,2,3
     	   vnm==4,5,6
     
=cut

=head2 open and write values

=cut

	#print("manage_files_by2,par, tnmo_row @tnmo_array\n");
	#print("manage_files_by2,par, vnmo_row @vnmo_array\n");

	#print("manage_files_by2,par, tnmo_row $tnmo_array[1] \n");

	#print("manage_files_by2,par, ref_outbound $$ref_outbound \n");

	open( my $fh, '>', $$ref_outbound );

	print $fh ("$first_name=$tnmo_array[1]");

	for ( my $i = 2; $i < $number_of_values_per_row; $i++ ) {

		print $fh (",$tnmo_array[$i]");

	}

	print $fh ("\n");

	print $fh ("second_name=$vnmo_array[1]");

	for ( my $i = 2; $i < $number_of_values_per_row; $i++ ) {

		print $fh (",$vnmo_array[$i]");

	}

	print $fh ("\n");

	close($fh);
	return ();
}

1;
