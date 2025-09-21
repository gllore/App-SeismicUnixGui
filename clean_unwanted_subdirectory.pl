use strict;
use warnings;
use File::Find;
use File::Path qw(remove_tree);

my $target_dir_name = ".vscode"; # Name of the subdirectory to find and delete
my $start_directory = ".";                      # Directory to start searching from (e.g., current directory)

my @found_dirs;

# Define the wanted subroutine for File::Find
sub wanted {
    # Check if the current item is a directory and matches the target name
    if (-d && $_ eq $target_dir_name) {
        push @found_dirs, $File::Find::name;
    }
}

# Traverse the directory tree to find the subdirectory
find(\&wanted, $start_directory);

# Process the found directories
if (@found_dirs) {
    print "Found subdirectories to delete:\n";
    foreach my $dir_path (@found_dirs) {
        print "  $dir_path\n";
        # Delete the subdirectory and its contents
        # The 'remove_tree' function from File::Path handles recursive deletion
        if (remove_tree($dir_path)) {
            print "Successfully deleted: $dir_path\n";
        } else {
            warn "Failed to delete $dir_path: $!\n";
        }
    }
} else {
    print "Subdirectory '$target_dir_name' not found in '$start_directory'.\n";
}

