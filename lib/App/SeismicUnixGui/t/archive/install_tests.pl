# L_SU is a global variable for locating the  main folder
my $L_SU = $ENV{'L_SU'};

my $username = 'tester';
my ( @instruction, @message );
my $password = 'a!efg101$-_qop5';

if ( not length($L_SU) ) {

	print "global variable L_SU must be set";
	print "e.g. in .bashrc: ";
	print " export SeismicUnixGui=/usr/local/pl/SeismicUnixGui ";

} else {
	print("\$L_SU = $L_SU \n");
}

my $PATH = $L_SU . '/t';
my $HOME = $PATH . '/' . $username;

$instruction[0] = ("sudo cp ../demo_projects/demos ./$username/");
$instruction[1] = ("sudo cp -r ./LSU ./$username/");

$message[0] = ("   Copy demos project into $username\'s directory");
$message[1] = ("   Copy L_SU configuration directory and files into $username\'s directory");

if ( -d $HOME ) {

	my $number_of_instructions = scalar @instruction;
	
	for ( my $i = 0; $i < $number_of_instructions; $i++ ) {
		
		print("\n$message[$i]:\n");
		# system("$instruction[$i]");
		print(">$instruction[$i].\n\t");
	}

} else {

	# NADA
}