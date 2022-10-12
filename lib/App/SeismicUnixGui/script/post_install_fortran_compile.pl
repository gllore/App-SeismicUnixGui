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
use Shell qw(echo);

my $C_PATH;
my $SeismicUnixGui;
my $ans 	= 'n';
my $path;

# important variables defined
my $local_dir = getcwd;

my $FORTRAN_PATH 	= $local_dir.'/blib/lib/App/SeismicUnixGui'.'/'.'fortran';
print("FORTRAN_PATH=$FORTRAN_PATH\n");
print("Do you want to compile FORTRAN programs? \n");
print("  You must have the \"pgplot\" libraries compiled and installed. \n");
print("  If the \"PGPLOT_DIR\" environment variable does not exist,\n");
print("  then respond NO to the following question. \n\n");
print("Do you want to compile FORTRAN program? (y/n) \n");
$ans = <STDIN>;
chomp $ans;

if ( ( $ans eq 'N' ) or ( $ans eq 'n' ) ) {

	print("OK, your answer is no.\n");
	print(" Install pgplot. \n Put the following line in your \".bashrc\" file:\n");
	print("      export PGPLOT=/usr/local/pgplot \n");
	print(" Please come back when you are ready\n");
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

