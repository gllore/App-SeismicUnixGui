
=head1 DOCUMENTATION


=head2 SYNOPSIS 
Test perl scripts in:
demos and Servilleta_demos

 PERL PROGRAM NAME: test.pl 
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 1 2021


DESCRIPTION 
 
 To run the tests, run the flows, logged in as
 a regular user, with sudo privileges. Move to the following 
 directory:
 
             /usr/local/pl/t
             
 and type:
      perl test.pl -all

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
V 0.0.3 Add switches on 7.13.21

=cut 

=head2 Declare classes

=cut

use Moose;
our $VERSION = '0.0.3';
use LSeismicUnix::misc::L_SU_global_constants;

use lib '.';
use LSeismicUnix::t::check '0.0.1';
use LSeismicUnix::t::clean '0.0.1';
use LSeismicUnix::t::configuration '0.0.2';
use LSeismicUnix::misc::flow;
use LSeismicUnix::misc::message;
use LSeismicUnix::t::user '0.0.1';

=head2 Instantiation

=cut

my $get           = L_SU_global_constants->new();
my $check         = check->new();
my $clean         = clean->new();
my $configuration = configuration->new();
my $log           = message->new();
my $run           = new flow();
my $user          = user->new();

=head2 Private variables

=cut

my $var           = $get->var();
my $true          = $var->{_true};
my $false         = $var->{_false};
my $log_file_txt  = $var->{_log_file_txt};
my $test_dir_name = $var->{_test_dir_name};

my @message;
my @instruction;
my ( $message_aref, $instruction_aref );
my $number_of_instructions;
my $number_of_messages;

my $go_run_check_switch         = $false;
my $go_run_clean_switch         = $false;
my $go_run_configuration_switch = $false;
my $go_run_user_switch          = $false;
my $go_show_messages_switch     = $false;
my $go_show_instructions_switch = $false;

my $term = $ARGV[0];

=head2 Switches
count input terms from command line

=cut

my $total_switches = $#ARGV + 1;
print("You entered: perl test.pl @ARGV\n");

if ( length $total_switches
	&& $total_switches < 1 ) {

	print("Warning: Bad syntax\n");
	print "
  Example 1: perl test.pl -clean -show messages -show instructions,
  Example 2: perl test.pl -all\n\n";
	print(
		"options are:
	-run user
	-run configuration
	-run check
	-show messages
	-show instructions
	-all  ( does not include clean)
	-clean 
(Switches can be repeated)\n"
	);
	exit;

} elsif ( length $total_switches
	&& $total_switches >= 1 ) {

	my $term_counter;

	for (
		my $counter = 0,
		$term_counter = 0; $counter < $total_switches; $term_counter++
	) {

		my $term = $ARGV[$counter];

		if ( $term eq '-clean' ) {

			$counter++;
			$go_run_clean_switch = $true;

			#			print("TERM=$term\n");

		} elsif ( $term eq '-all' ) {

			$counter++;
			$go_run_user_switch          = $true;
			$go_run_configuration_switch = $true;
			$go_run_check_switch         = $true;

			#			print("TERM=$term\n");

		} elsif ( $term eq '-run' ) {

			$counter++;
			my $value = $ARGV[$counter];

			#			print("TERM=$term, VALUE=$value\n");

			if ( length $value ) {

				if ( $value eq 'user' ) {

					$counter++;
					$go_run_user_switch = $true;

				} elsif ( $value eq 'configuration' ) {

					$counter++;
					$go_run_configuration_switch = $true;

				} elsif ( $value eq 'check' ) {

					$counter++;
					$go_run_check_switch = $true;

				} elsif ( $value eq 'clean' ) {

					$counter++;
					$go_run_clean_switch = $true;

				} else {
					print("test.pl, unexpected value after show switch \n");
				}

			} else {
				print("test.pl, unexpected value after show switch \n");
			}
		} elsif ( $term eq '-show' ) {

			$counter++;
			my $value = $ARGV[$counter];

			#			print("TERM=$term, VALUE=$value\n");

			if ( length $value ) {

				if ( $value eq 'messages' ) {

					$counter++;
					$go_show_messages_switch = $true;

				} elsif ( $value eq 'instructions' ) {

					$counter++;
					$go_show_instructions_switch = $true;

				} else {
					print("test.pl, unexpected value after show switch \n");
				}

			} else {
				print("test.pl, missing value after show switch \n");
			}

		} else {

		}

	}    # end examination of all the switches

	print("test.pl, #terms= $term_counter\n");

} else {
	print("test.pl missing switches \n");
}

=pod

 confirm work paths
 create an empty log file
 
=cut

my $L_SU = $ENV{'L_SU'};

if ( not length($L_SU) ) {

	print "global variable L_SU must be set\n";
	print "e.g., in .bashrc: ";
	print " export LSeismicUnix=/usr/local/pl/LSeismicUnix ";

} else {

	#	print("test.pl: \$L_SU = $L_SU; NADA \n");
}

my $PATH           = $L_SU . '/' . $test_dir_name;
my $PATH_n_logfile = $PATH . '/' . $log_file_txt;

=head2 Create log file

=cut

open( message_STDOUT, '>', $PATH_n_logfile ) or die $!;
close(message_STDOUT);

=head2 Create user="tester"

=cut

( $message_aref, $instruction_aref ) = $user->get_instructions();
@instruction = @$instruction_aref;

if ($go_show_instructions_switch) {

	$number_of_instructions = 5;

} else {
	$number_of_instructions = 0;
}

if ($go_show_messages_switch) {

	$number_of_messages = 5;

} else {
	$number_of_messages = 0;
}

=pod

display instructions first

=cut

$log->set_file_name($log_file_txt);
$log->set_message_aref($instruction_aref);
$log->set_number_of_messages($number_of_instructions);
$log->command_line();
$log->send2file_name();

=pod

run instructions

=cut

if ( $go_run_user_switch == $true ) {

	my $number_of_instructions = 5;
	$run->set_instruction_aref($instruction_aref);
	$run->set_number_of_instructions($number_of_instructions);
	$run->system();

}

=pod

display messages next

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

if ($go_show_instructions_switch) {

	$number_of_instructions = 12;
} else {
	$number_of_instructions = 0;
}

if ($go_show_messages_switch) {

	$number_of_messages = 12;

} else {
	$number_of_messages = 0;
}

=pod

display instructions first

=cut

$log->set_file_name($log_file_txt);
$log->set_message_aref($instruction_aref);
$log->set_number_of_messages($number_of_instructions);
$log->command_line();
$log->send2file_name();

=pod

run instructions

=cut

if ( $go_run_configuration_switch == $true ) {

	my $number_of_instructions = 12;
	$run->set_instruction_aref($instruction_aref);
	$run->set_number_of_instructions($number_of_instructions);
	$run->system();

}

=pod

display messages next

=cut

$log->set_file_name($log_file_txt);
$log->set_message_aref($message_aref);
$log->set_number_of_messages($number_of_messages);
$log->command_line();
$log->set_PATH($PATH);
$log->send2file_name();

=head2 Run to
see test results

=cut

if ( $go_run_check_switch eq $true ) {

	$check->get_test_results();

}

( $message_aref, $instruction_aref ) = $check->get_instructions();

if ($go_show_instructions_switch) {

	$number_of_instructions = 4;

} else {
	$number_of_instructions = 0;
}

if ($go_show_messages_switch) {

	$number_of_messages = 2;

} else {
	$number_of_messages = 0;
}

=pod

messages first

=cut

$log->set_file_name($log_file_txt);
$log->set_message_aref($message_aref);
$log->set_number_of_messages($number_of_messages);
$log->command_line();
$log->set_PATH($PATH);

$log->send2file_name();

=pod

instructions next
But run them internally in check.pm

=cut

$log->set_file_name($log_file_txt);
$log->set_message_aref($instruction_aref);
$log->set_number_of_messages($number_of_instructions);
$log->command_line();
$log->set_PATH($PATH);
$log->send2file_name();

=head2 set clean

=cut

( $message_aref, $instruction_aref ) = $clean->get_instructions();

if ($go_show_instructions_switch) {

	$number_of_instructions = 1;

} else {
	$number_of_instructions = 0;
}

if ($go_show_messages_switch) {

	$number_of_messages = 1;

} else {
	$number_of_messages = 0;
}

=pod

run instructions

=cut

if ( $go_run_clean_switch eq $true ) {

	my $number_of_instructions = 1;
	$run->set_instruction_aref($instruction_aref);
	$run->set_number_of_instructions($number_of_instructions);
	$run->system();
}

=pod

display messages next

=cut

$log->set_file_name($log_file_txt);
$log->set_message_aref($message_aref);
$log->set_number_of_messages($number_of_messages);
$log->command_line();
$log->set_PATH($PATH);
$log->send2file_name();

