
=head1 DOCUMENTATION


=head2 SYNOPSIS 
Test perl scripts in:
demos and Servilleta_demos

 PERL PROGRAM NAME: test.pl 
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 1 2021


DESCRIPTION 
     

 BASED ON:

=cut

=head2 USE

=head3 NOTES

=head4 Examples


=head2 CHANGES and their DATES

=cut 

use Moose;
use lib '.';
use check 0.0.1;
use clean 0.0.1;
use configuration 0.0.2;
use flow;
use message;
use user 0.0.1;

my @message;
my @instruction;
my ( $message_aref, $instruction_aref );
my $number_of_instructions;
my $number_of_messages;

=head2 Instantiation

=cut

my $check         = check->new();
my $clean         = clean->new();
my $configuration = configuration->new();
my $log           = message->new();
my $run					= new flow();
my $user          = user->new();

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

	#	print("test.pl: \$L_SU = $L_SU \n");
}

my $PATH    = $L_SU . '/t';
my $logfile = $PATH . '/log.txt';

open( message_STDOUT, '>', $logfile ) or die $!;
close(message_STDOUT);

=head2 Create user="tester"

=cut

( $message_aref, $instruction_aref ) = $user->get_instructions();
@instruction = @$instruction_aref;

$number_of_messages     = 5;
$number_of_instructions = 4;

=pod

instructions first

=cut

$log->set_file_name($logfile);
$log->set_message_aref($instruction_aref);
$log->set_number_of_messages($number_of_instructions);
#$log->command_line();
#$log->file_name();

=pod

messages next

=cut

$log->set_file_name($logfile);
$log->set_message_aref($message_aref);
$log->set_number_of_messages($number_of_messages);
$log->command_line();
#$log->file_name();

#$run->set_instruction_aref($instruction_aref);
#$run->set_number_of_instructions($number_of_instructions);
#$run->system();

=head2 Set configuration files

=cut

$configuration->set_preparations();

( $message_aref, $instruction_aref ) = $configuration->get_instructions();

$number_of_messages     = 12;
$number_of_instructions = 12;

=pod

instructions first

=cut

$log->set_file_name($logfile);
$log->set_message_aref($instruction_aref);
$log->set_number_of_messages($number_of_instructions);
#$log->command_line();
#$log->file_name();

=pod

messages next

=cut

$log->set_file_name($logfile);
$log->set_message_aref($message_aref);
$log->set_number_of_messages($number_of_messages);
$log->command_line();
#$log->file_name();

#$run->set_instruction_aref($instruction_aref);
#$run->set_number_of_instructions($number_of_instructions);
#$run->system();


=head2 Run tests

=cut

( $message_aref, $instruction_aref ) = $check->get_instructions();

	$number_of_messages     = 1;
	$number_of_instructions = 0;
	
=pod

instructions first

=cut

$log->set_file_name($logfile);
$log->set_message_aref($instruction_aref);
$log->set_number_of_messages($number_of_instructions);
#$log->command_line();
#$log->file_name();

=pod

messages next

=cut

$log->set_file_name($logfile);
$log->set_message_aref($message_aref);
$log->set_number_of_messages($number_of_messages);
$log->command_line();
#$log->file_name();

#$run->set_instruction_aref($instruction_aref);
#$run->set_number_of_instructions($number_of_instructions);
#$run->system();


=head2 See test results

=cut

$check->get_test_results();


=head2 set clean

=cut

( $message_aref, $instruction_aref ) = $clean->get_instructions();

	$number_of_messages     = 0;
	$number_of_instructions = 0;
	
=pod

instructions first

=cut

$log->set_file_name($logfile);
$log->set_message_aref($instruction_aref);
$log->set_number_of_messages($number_of_instructions);
#$log->command_line();
#$log->file_name();

=pod

messages next

=cut

$log->set_file_name($logfile);
$log->set_message_aref($message_aref);
$log->set_number_of_messages($number_of_messages);
$log->command_line();
#$log->file_name();

#$run->set_instruction_aref($instruction_aref);
#$run->set_number_of_instructions($number_of_instructions);
#$run->system();