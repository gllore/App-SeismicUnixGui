
my $name = 'tester';
my ( @instruction, @message );
my $password = 'a!efg101$-_qop5';
my $PATH     = '/usr/local/pl/L_SU/t';
my $HOME     = $PATH . '/' . $name;

$instruction[0] = "sudo /usr/sbin/userdel -r $name";
$instruction[1]
	= "sudo /usr/sbin/luseradd --directory=$HOME --plainpassword=$password -g=$name  --shell=/bin/bash $name";
$instruction[2] = "sudo cat $PATH/bashrc_local >> $HOME/.bashrc ";
$instruction[3] = "sudo chown $name $HOME/.*";
$instruction[4] = "sudo chgrp $name $HOME/.*";
$instruction[5] = "sudo su - $name";

$message[0] = ("Clear any pre-existing account information and files belonging to 'tester'");
$message[1] = ("Create temporary account for tester");
$message[2] = ("Append environmental variables to tester's '.bashrc' file");
$message[3] = ("Give tester ownwership of new files");
$message[4] = ("Assign tester's group name to new files");
$message[5] = ("Log into temporary account as the new user: 'tester'");

if ( -d $HOME ) {
	
	my $i = 0;
	print("\n$message[$i]:\n");
	system( $instruction[$i] );
	print("\t>$instruction[$i].\n");

} else {
  # NADA
}

my $number_of_instructions = scalar @instruction;

for ( my $i = 1; $i < $number_of_instructions; $i++ ) {

	print("\n$message[$i]:\n");
	system("$instruction[$i]");
	print("\t>$instruction[$i].\n\t");

}

# system("chown $name /home/$name/.*");
# system("chgrp $name /home/$name/.*");
#

