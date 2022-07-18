# uninstall_perl_module.pl from PerlTricks.com

use 5.14.2;
use ExtUtils::Installed;
use ExtUtils::Packlist;

# Exit unless a module name was passed
die ("Error: no Module::Name passed as an argument. E.G.\n\t perl $0 Module::Name\n") unless $#ARGV == 0;

my $module = shift @ARGV;

my $installed_modules = ExtUtils::Installed->new;

# iterate through and try to delete every file associated with the module
foreach my $file ($installed_modules->files($module)) {
    print "removing $file\n";
    unlink $file or warn "could not remove $file: $!\n";
}

# delete the module packfile
my $packfile = $installed_modules->packlist($module)->packlist_file;
print "removing $packfile\n";
unlink $packfile or warn "could not remove $packfile: $!\n";

# delete the module directories if they are empty
foreach my $dir (sort($installed_modules->directory_tree($module))) {
    print("removing $dir\n");
    rmdir $dir or warn "could not remove $dir: $!\n";
}
