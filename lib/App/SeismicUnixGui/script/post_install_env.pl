#!bin/perl

=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL SCRIPT NAME: post_install_env.pl 
 AUTHOR: Juan Lorenzo
 DATE: July 11 2022 

 DESCRIPTION 
 
 Help installer set important environment variables
 needed later to run SeismicUnixGui
 


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

# important variables defined
my $dir = getcwd;
print "\nWorking post_installation.pl\n";
print "From: $dir\n";
print "ARGV[0] = $ARGV[0]\n";

my $outbound ="$dir/blib/lib/App/SeismicUnixGui/script/.temp";

# update file data base on a linux system
print("Running sudo updatedb, which requires sudo privileges!");
system ('sudo updatedb');

# find paths via linux
my $SCRIPT_PATH 		= `locate script\/SeismicUnixGui\ | grep perl`;
my @old_list 			= split('\/',$SCRIPT_PATH);
my $length_old_list  	= scalar @old_list;
my $length_new_list  	= $length_old_list -2;

# slice of array
my @new_list      		= @old_list[0..$length_new_list];
my $SCRIPT_LIB_PATH    	= join('/',@new_list);

@new_list      		= @old_list[0..($length_new_list-1)];
my $LIB_PATH    	= join('/',@new_list);

print ("\nThe system path to \"SeismicUnixGui\" is now \"$LIB_PATH\"\n");
print ("Before running SeismicUnixGui, be sure to add the\n"); 
print ("following 4 lines to the end of your \".bashrc\" file\n\n");
print ("export SeismicUnixGui=$LIB_PATH\n");
print ("export SeismicUnixGui_script=$SCRIPT_LIB_PATH\n");
print ("export PATH=\$PATH::\$SeismicUnixGui_script\n");
print ("export PERL5LIB=\$PERL5LIB:\$SeismicUnixGui\n");
print("\n\nHowever, for a quick, BUT temporary fix, you have 2 options:
A. Cut-and-paste the 3 instructions above, one at a time,
into your command line and execute them one at a time--\n");
print("In case you are unsure that also means -> copy and\n");
print("past each one line at a time into the command line\n");
print("followed by \"Enter\"\n");
print("\nB. Enter the following two bash instructions\n");
print("cd $SCRIPT_LIB_PATH/\n");
print("Next, run a second instruction\n");
print("source set_env_variables.sh\n");
print("Now you can just enter SeismicUnixGui on the command line\n");
print("\n**But,remember, that when you open a new command \n");
print("window the effect of these instructions will cease to exist.\n");
print("Make the changes permanent in your  \".bashrc\" file.\n");
print("If you do not  know how to do this, consult someone who does.\n");

	open( OUT, ">", $outbound)
	
	  or die("File $outbound error");
		printf OUT  ("#!/bin/bash\n");
		printf OUT  ("export SeismicUnixGui=$LIB_PATH \n");
		printf OUT  ("export SeismicUnixGui_script=$SCRIPT_LIB_PATH\n");
		printf OUT  ("export PATH=\$PATH::\$SeismicUnixGui_script\n\n");
		
	close(OUT);
	system("chmod 755 $outbound");
	
	
