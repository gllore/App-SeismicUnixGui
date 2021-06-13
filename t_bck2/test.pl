
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
use configuration 0.0.1;
use user 0.0.1;

my @message;
my @instruction;
my ( $message_aref, $instruction_aref );
my $number_of_instructions;
my $number_of_messages;

my $check         = check->new();
my $clean         = clean->new();
my $configuration = configuration->new();
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

=head2 create user="tester"

=cut

( $message_aref, $instruction_aref ) = $user->get_instructions();
@message     = @$message_aref;
@instruction = @$instruction_aref;

$number_of_instructions = scalar @instruction;
$number_of_messages     = scalar @message;

if (   length($number_of_messages)
	or length($number_of_instructions) ) {

	$number_of_messages =4;
	$number_of_instructions=4;
	open( message_STDOUT, '>>', $logfile ) or die $!;
	
	for ( my $i = 0; $i < $number_of_messages; $i++ ) {

		# print("\t$message[$i]\n");
		if ( length( $message[$i] ) ) {
			print message_STDOUT ("$message[$i]") . "\n";
		}

	}

	for ( my $i = 0; $i < $number_of_instructions; $i++ ) {
		
		# print("$instruction[$i]\n");
		if ( length( $instruction[$i] ) ) {
			print message_STDOUT ("$instruction[$i]") . "\n";
		}

		if ( length( $instruction[$i] ) ) {
			print message_STDOUT (">$instruction[$i]") . "\n";
            system( $instruction[$i] );
		}

	}
	close(message_STDOUT);

} else {
	print("\nl106:test.pl, bad instructions or messages for users\n");
}

=head2 set work files

=cut

( $message_aref, $instruction_aref ) = $configuration->get_instructions();
@message     = @$message_aref;
@instruction = @$instruction_aref;

$number_of_instructions = scalar @instruction;
$number_of_messages     = scalar @message;

$number_of_messages =0;
if (   length($number_of_messages)
	or length($number_of_instructions) ) {

	open( message_STDOUT, '>>', $logfile ) or die $!;
	for ( my $i = 0; $i < $number_of_messages; $i++ ) {

		# print("\t$message[$i]\n");
		# print("$instruction[$i]\n");

		if ( length( $message[$i] ) ) {
			print message_STDOUT ("$message[$i]") . "\n";
		}

		if ( length( $instruction[$i] ) ) {
			print message_STDOUT (">$instruction[$i]") . "\n";
			# system( $instruction[$i] );
		}

	}
	close(message_STDOUT);

} else {
	print("\nL135. test.pl, bad instructions or messages for configurations\n");
}

=head2 set check

=cut

( $message_aref, $instruction_aref ) = $check->get_instructions();
@message     = @$message_aref;
@instruction = @$instruction_aref;

$number_of_instructions = scalar @instruction;
$number_of_messages     = scalar @message;

$number_of_messages =0;
if (   length($number_of_messages)
	or length($number_of_instructions) ) {

	open( message_STDOUT, '>>', $logfile ) or die $!;
	for ( my $i = 0; $i < $number_of_messages; $i++ ) {

		# print("\t$message[$i]\n");
		# print("$instruction[$i]\n");

		if ( length( $message[$i] ) ) {
			print message_STDOUT ("$message[$i]") . "\n";
		}

		if ( length( $instruction[$i] ) ) {
			print message_STDOUT (">$instruction[$i]") . "\n";
			# system( $instruction[$i] );
		}

	}
	close(message_STDOUT);

} else {
	print("\nL135. test.pl, bad instructions or messages for configurations\n");
}

=head2 set clean

=cut

( $message_aref, $instruction_aref ) = $clean->get_instructions();
@message     = @$message_aref;
@instruction = @$instruction_aref;

$number_of_instructions = scalar @instruction;
$number_of_messages     = scalar @message;

$number_of_messages =0;
if (   length($number_of_messages)
	or length($number_of_instructions) ) {

	my $text;
	open( message_STDOUT, '>>', $logfile ) or die $!;

	for ( my $i = 0; $i < $number_of_messages; $i++ ) {

		# print("\t$message[$i]\n");
		# print(">$instruction[$i].\n\t");

		if ( length( $message[$i] ) ) {
			print message_STDOUT ("$message[$i]") . "\n";
		}

		if ( length( $instruction[$i] ) ) {
			print message_STDOUT (">$instruction[$i]") . "\n";
			#		system( $instruction[$i] );
		}

	}
	close(message_STDOUT);

} else {
	print("\ntest.pl, bad instructions or messages for cleans\n");
}
