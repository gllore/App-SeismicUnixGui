# program to add a new user in preparation
# for conducting tests of perl programs

# L_SU is a global variable for locating the  main folder
my $L_SU = $ENV{'L_SU'};

my $username = 'tester';
my ( @instruction, @message );
my $password = 'a!efg101$-_qop5';

if ( not length($L_SU) ) {

	print "global variable L_SU must be set";
	print "e.g. in .bashrc: ";
	print " export LSeismicUnix=/usr/local/pl/LSeismicUnix ";

} else {
	print("\$L_SU = $L_SU \n");
}

my $PATH = $L_SU . '/L_SU/t';
my $HOME = $PATH . '/' . $username;

$instruction[0] = "sudo chown $username $HOME/.*";
$instruction[1] = "sudo chgrp $username $HOME/.*";
$instruction[2] = "sudo su - $username";

$message[0] = ("   Give tester ownwership of new files");
$message[1] = ("   Assign tester's group name to new files");
$message[2] = ("   Log into temporary account as the new user: 'tester' &");

if ( -d $HOME ) {

	my $number_of_instructions = scalar @instruction;

	for ( my $i = 1; $i < $number_of_instructions; $i++ ) {

		print("\n$message[$i]:\n");
		system("$instruction[$i]");
		print(">$instruction[$i].\n\t");

	}

} else {

	# NADA
}

