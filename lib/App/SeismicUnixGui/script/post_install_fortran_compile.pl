#!/bin/perl

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL SCRIPT NAME: post_install_fortran_compile.pl 
 AUTHOR: Juan Lorenzo
 DATE: October 9, 2022 

 DESCRIPTION 

 
 Help installer compile fortran programs

=cut

=head2 USE

=head3 NOTES
	
	Post-installation files are stored somewhere on the system,
	e.g., Distribution directory for SeismicUnixGui =
	/usr/local/lib/x86_64-linux-gnu/perl/5.30.0/auto/
	App/SeismicUnixGui

=head4 Examples


=head2 CHANGES and their DATES

=cut 

use Moose;
use Cwd;
use Env;
use Shell qw(echo);

my $C_PATH;
my $SeismicUnixGui;
my $ans = 'n';
my $path;

# important variables defined
# from perspective of App-SeismicUnixGui
my $local_dir    = getcwd;
my $FORTRAN_PATH = $local_dir.'/blib/lib/App/SeismicUnixGui'.'/'.'fortran';
my $PGPLOT_DIR  = $ENV->{'PGPLOT_DIR'};


print("\n\tINSTALLATION OF FORTRAN PROGRAMS\n");

if (!defined($PGPLOT_DIR) or $PGPLOT_DIR eq '' ) {

	print("Warning: PGPLOT_DIR variable is not found\n");

} elsif ( defined($PGPLOT_DIR) ) {

	print("PGPLOT_DIR variable is defined\n");
	print("PGPLOT_DIR = $PGPLOT_DIR\n");

} else {
	print ("Unexpected result from fortran installation script\n");
}
print("Fortran path=$FORTRAN_PATH\n");
print("If you want to compile FORTRAN programs, \n");
print("you must have the \"pgplot\" libraries compiled and installed. \n");
print("If the \"PGPLOT_DIR\" environment variable does not exist,for sudo\n");
print("then respond NO to the following question. \n\n");
print("Do you want to compile FORTRAN program? (y/n) \n");
$ans = <STDIN>;
chomp $ans;

if ( ( $ans eq 'N' ) or ( $ans eq 'n' ) ) {
		#
	print("\nOK, your answer is no.\n");
	print("Please come back when you are ready, but first \n");
	print ("Install pgplot and put the following line \n");
	print ("in your \".bashrc\" file:\n");
	print("      export PGPLOT=/usr/local/pgplot \n\n");
	exit;

}
elsif ( ( $ans eq 'Y' ) or ( $ans eq 'y' ) ) {

	print "OK, Proceeding to compile\n";
	system("cd $FORTRAN_PATH; bash run_me_only.sh ");
	
}
else {
	print("post_installation_fortran_compile.pl, unexpected answer\n");
}

print("Hit Enter to continue\n");
<STDIN>

