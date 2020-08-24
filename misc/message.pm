package message;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: message 
 AUTHOR:  Juan Lorenzo
 DATE:   July 25 2015,
 DESCRIPTION: 
 Version: 1.1

=head2 USE

=head3 NOTES
 communicate information to user 

=head4 
 Examples

=head3 UNIX NOTES  
=head4 CHANGES and their DATES
V0.0.2 April 4, 2020


=cut

=head2 Define
local variables

=cut

use Moose;
our $VERSION = '0.0.2';
use Project_config;

=head2 import variables 

=cut

my $Project = new Project_config();

=head2 Declare
local variables

=cut

my $PL_SEISMIC = $Project->PL_SEISMIC();

=head2 private hash

=cut

my $message = { _text => '' };

=pod

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {
	$message->{_text} = '';
}

=pod

=head2 subroutine file 

 send message to file 

=cut

sub file {
	( $message, my $text ) = @_;

	$message->{_text} = $text if defined($text);
	my $filename = $PL_SEISMIC . '/' . 'log.txt';
	
	open( message_STDOUT, '>>', $filename ) or die $!;
		print message_STDOUT $text . "\n";
	close(message_STDOUT);
}

=pod

=head2 subroutine file 

 send message to screen 

=cut

sub screen {
	( $message, my $text ) = @_;
	$message->{_text} = $text if defined($text);

	#print ("$text\n\n");
	print("Hi\n\n");
}

# a 1 is sent to perl to signify the end of the package
1;
