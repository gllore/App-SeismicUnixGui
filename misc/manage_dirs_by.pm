package manage_dirs_by;

use Moose;

# manage_dirs_by  class
# Contains methods/subroutines/functions to operate on directories
# V 1. March 3 2008
# Juan M. Lorenzo

=head2 private hash of shared variables

=cut

my $manage_dirs_by = {

	_directory => '',

};

=head2 clear shared variable(s)
in memory


=cut

sub clear {

	$manage_dirs_by->{_directory} = '';

}



sub get_list_aref {

	my ($self) = @_;
	
	my @list;

	if ( $manage_dirs_by->{_directory} ) {


	}
	else {
		print("manage_dirs_by,$self,get_list_aref missing variable\n");
	}

	my $result = \@list;

	return ($result);

}

sub lsc1_dir_files {

	# this function makes a list of the directory contents
	# one file name per line
	# leaves the list inside the directory of interest
	# writes the list to .lsc1
	#get directory names
	my ($directory) = shift @_;
	system(
		" cd $directory;   		\\
		ls -c1 > .lsc1;			\\
	"
	);
}

sub lsc1_grep_dir_files {

	# this function makes a list of the directory contents
	# one file name per line
	# leaves the list inside the directory of interest
	# writes the list to .lsc1_grep

	#get directory names
	my ($directory) = shift @_;
	my ($pattern)   = shift @_;

	#$pattern = 'asc';
	print("pattern-$pattern\n\n");
	print("directory-$directory\n\n");
	system(
		" cd $directory;   		\\
		ls -c1 | grep $pattern |sort -n > .lsc1_grep;\\
	"
	);
}

sub make_dir {

	# this function/method  makes a  directory
	# if it does not exist already

	# get directory names
	my ($directory) = shift @_;

#    print ("\nmanage_dirs_by, make_dir, Making directories----$directory---\n");

	system(
		"                       	\\
                mkdir -p $directory       	\\
        "
	);

}

sub rm_dir {

	# this function/method deletes a directory

	#get directory names
	my ($directory) = shift @_;

	print("\n Cleaning directory $directory \n");

	system(
		"                       	\\
                rm -r $directory		\\
        "
	);
}


sub set_directory {

	my ( $self, $dir ) = @_;
	
	if (length $dir) {
		
	} else {
		print("manage_dirs_by,self=$self, set_directory, missing variable\n");
	}
	return ();
	
}

sub set_suffix_type {

	my ( $self, $suffix_type) = @_;
	
	if (length $suffix_type) {
		
	} else {
		print("manage_dirs_by,$self, set_suffix_type, missing variable\n");
	}

	return ();
}

1;
