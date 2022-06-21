
=head1 DOCUMENTATION


=head2 SYNOPSIS 
Test perl scripts in:
demos and Servilleta_demos

 PERL PROGRAM NAME: test.pl 
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 1 2021


DESCRIPTION 
To see test code (bash and perl) on screen, uncomment:
           $log->command_line();
           
To review test code (bash and perl), stored in a file ('log.txt')
uncomment:
           $log->send2file_name();
           
 To  run procedures, uncomment:
           $run->system();
 
 To run the tests, run the flows, logged in as
 a regular user, with sudo privileges. Move to the following 
 directory:
 
             /usr/local/pl/t
             
 and type:
      perl test.pl

 BASED ON:

=cut

=head2 USE

perl test.pl all
perl test.all clean
 

=head3 NOTES

Each testing step consists of (a) running commands
as well as (b) generating messages for the user, both on
the command line as well as log file for review after
the testing is complete.

Testing is broken into steps:

1. Create the user called 'tester' in the system

2.


=head4 Examples


=head2 CHANGES and their DATES

V0.0.2 Add documentation 7.12.21

=cut 


=head2 Declare classes

=cut

use Moose;
our $VERSION = '0.0.2';
use LSeismicUnix::misc::L_SU_global_constants;

use lib '.';
use check 0.0.1;
use clean 0.0.1;
use configuration 0.0.2;
use flow;
use message;
use user 0.0.1;


=head2 Instantiation

=cut
my $get         = L_SU_global_constants->new();
my $check         = check->new();
my $clean         = clean->new();
my $configuration = configuration->new();
my $log           = message->new();
my $run           = new flow();
my $user          = user->new();


=head2 Private variables

=cut
my $var                           = $get->var();
my $true                          = $var->{_true};
my $false                         = $var->{_false};
my $log_file_txt        = $var->{_log_file_txt};
my $test_dir_name       = $var->{_test_dir_name};

my @message;
my @instruction;
my ( $message_aref, $instruction_aref );
my $number_of_instructions;
my $number_of_messages;
my $go_clean_switch = $false;
my $go_all_switch   = $false;

my $term = $ARGV[0];

# count input terms from command line
my $total = $#ARGV + 1;
print ("  You entered: perl test.pl @ARGV\n");

if ($total != 1 ) {
	print "Example usage: perl test.pl clean,
	or   perl test.pl all\n";
	exit;
}

=pod

 confirm work paths
 create an empty log file
 
=cut

my $L_SU = $ENV{'L_SU'};

if ( not length($L_SU) ) {

	print "global variable L_SU must be set\n";
	print "e.g., in .bashrc: ";
	print " export L_SU=/usr/local/pl/L_SU ";

} else {
#	print("test.pl: \$L_SU = $L_SU; NADA \n");
}


my $PATH           			= $L_SU . '/'.$test_dir_name;
my $PATH_n_logfile 	= $PATH . '/' . $log_file_txt;


=head2 Create log file

=cut

open( message_STDOUT, '>', $PATH_n_logfile ) or die $!;
close(message_STDOUT);

#$l = length $term;
#print "2.l=$l\n";

=head2 Switches

=cut

if ( (length $term)  ) {

	if ( $term eq 'clean' ) {
		
#		printf "number is greater than 10\n";
		$go_clean_switch = $true;
		$go_all_switch = $false;
		
	} elsif ($term eq 'all') {
		
#		printf "number is less than 10\n";
		$go_all_switch = $true;
		$go_clean_switch = $false;
		
	} else {
		printf "number is equal to 10\n";
	}
}


if ( $go_all_switch == $true ) {

=head2 Create user="tester"

=cut

	( $message_aref, $instruction_aref ) = $user->get_instructions();
	@instruction = @$instruction_aref;

	$number_of_messages     = 5;
	$number_of_instructions = 4;

=pod

instructions first

=cut

	$log->set_file_name($log_file_txt);
	$log->set_message_aref($instruction_aref);
	$log->set_number_of_messages($number_of_instructions);
	$log->command_line();
	$log->send2file_name();

	$run->set_instruction_aref($instruction_aref);
	$run->set_number_of_instructions($number_of_instructions);

	#$run->system();

=pod

messages next

=cut

	$log->set_file_name($log_file_txt);
	$log->set_message_aref($message_aref);
	$log->set_number_of_messages($number_of_messages);
	$log->command_line();
	$log->send2file_name();

=head2 Set configuration files

=cut

	$configuration->set_preparations();

	( $message_aref, $instruction_aref ) = $configuration->get_instructions();

	$number_of_messages     = 12;
	$number_of_instructions = 12;

=pod

instructions first

=cut

	$log->set_file_name($log_file_txt);
	$log->set_message_aref($instruction_aref);
	$log->set_number_of_messages($number_of_instructions);
	$log->command_line();
	$log->send2file_name();

	$run->set_instruction_aref($instruction_aref);
	$run->set_number_of_instructions($number_of_instructions);

	#$run->system();

=pod

messages next

=cut

	$log->set_file_name($log_file_txt);
	$log->set_message_aref($message_aref);
	$log->set_number_of_messages($number_of_messages);
	$log->command_line();
	$log->send2file_name();

=head2 Run to
see test results

=cut

	$check->get_test_results();

	( $message_aref, $instruction_aref ) = $check->get_instructions();

	$number_of_messages     = 2;
	$number_of_instructions = 4;

=pod

messages first

=cut

	$log->set_file_name($log_file_txt);
	$log->set_message_aref($message_aref);
	$log->set_number_of_messages($number_of_messages);
	$log->command_line();
	$log->send2file_name();

=pod

instructions next
But run them internally in check.pm

=cut

	$log->set_file_name($log_file_txt);
	$log->set_message_aref($instruction_aref);
	$log->set_number_of_messages($number_of_instructions);
	$log->command_line();
	$log->send2file_name();

}

if ( $go_clean_switch eq $true ) {

=head2 set clean

=cut

	( $message_aref, $instruction_aref ) = $clean->get_instructions();

	$number_of_messages     = 1;
	$number_of_instructions = 1;

=pod

instructions first

=cut

	$run->set_instruction_aref($instruction_aref);
	$run->set_number_of_instructions($number_of_instructions);
	$run->system();

=pod

messages next

=cut

	$log->set_file_name($log_file_txt);
	$log->set_message_aref($message_aref);
	$log->set_number_of_messages($number_of_messages);
	$log->command_line();
	$log->send2file_name();

}

