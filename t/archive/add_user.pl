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

$instruction[0] = "sudo /usr/sbin/userdel -r $username";
$instruction[1]
	= "sudo /usr/sbin/luseradd --directory=$HOME --plainpassword=$password -g=$username  --shell=/bin/bash $username";
$instruction[2] = "sudo cat $PATH/bashrc_local >> $HOME/.bashrc ";

$message[0] = ("   Clear any pre-existing account information and files belonging to 'tester'");
$message[1] = ("   Create temporary account for tester");
$message[2] = ("   Append environmental variables to tester's '.bashrc' file");

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
