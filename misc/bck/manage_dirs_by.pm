package manage_dirs_by;

# manage_dirs_by  class
# Contains methods/subroutines/functions to operate on directories
# V 1. March 3 2008 
# Juan M. Lorenzo


sub lsc1_dir_files {
 # this function makes a list of the directory contents
 # one file name per line
 # leaves the list inside the directory of interest
 # writes the list to .lsc1
#get directory names
        my ($directory) = shift @_;
	system(" cd $directory;   		\\
		ls -c1 > .lsc1;			\\
	");
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
	print ("pattern-$pattern\n\n");
	print ("directory-$directory\n\n");
	system(" cd $directory;   		\\
		ls -c1 | grep $pattern |sort -n > .lsc1_grep;\\
	");
}

sub make_dir {

# this function/method  makes a  directory
# if it does not exist already

#get directory names
        my ($directory) = shift @_;
		
	 # print ("\nMaking directories $directory \n");

	system ("                       	\\
                mkdir -p $directory       	\\
        ");

}

sub rm_dir {

# this function/method deletes a directory

#get directory names
        my ($directory) = shift @_;
		
	 print ("\n Cleaning directory $directory \n");

	system ("                       	\\
                rm -r $directory		\\
        ");
}



1;
