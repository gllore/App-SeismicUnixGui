#!/bin/perl

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL SCRIPT NAME: post_install_c_compile.pl 
 AUTHOR: Juan Lorenzo
 DATE: July 11 2022 

 DESCRIPTION 

 
 Help installer compile C and fortran programs

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

# find paths via linux
my $SCRIPT_PATH 		= `locate script\/SeismicUnixGui\ | grep perl`;
my @old_list 			= split('\/',$SCRIPT_PATH);
my $length_old_list  	= scalar @old_list;
my $length_new_list  	= $length_old_list -2;

# slice of array
my @new_list      		= @old_list[0..$length_new_list];
my $SCRIPT_LIB_PATH    	= join('/',@new_list);

$SeismicUnixGui = ` echo \$SeismicUnixGui`;
chomp $SeismicUnixGui;
$C_PATH 	 = $SeismicUnixGui.'/'.'c/synseis';
print("C_PATH=$C_PATH\n");
print("Do you want to compile C standalone program? (y/n)\n");

$ans = <>;
chomp $ans;

if ( ( $ans eq 'N' ) or ( $ans eq 'n' ) ) {

	print("OK, your answer is no.  Bye!");
	exit;

}
elsif ( ( $ans eq 'Y' ) or ( $ans eq 'y' ) ) {
	
	print "OK, Proceeding to compile\n";
#	print("pwd=$C_PATH\n");
	system("cd $C_PATH; bash run_me_only.sh ");
#	system("cd $C_PATH; pwd #bash run_me_only.sh");
#	
}
else {
	print("post_installation_c_compile.pl, unexpected answer\n");
}

