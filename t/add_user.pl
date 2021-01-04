# program to add a new user in preparation
# for conducting tests of perl programs
my $username = 'tester';
my ( @instruction, @message );
my $password = 'a!efg101$-_qop5';
my $PATH     = '/usr/local/pl/L_SU/t';
my $HOME     = $PATH . '/' . $username;

$instruction[0] = "sudo /usr/sbin/userdel -r $username";
$instruction[1]
	= "sudo /usr/sbin/luseradd --directory=$HOME --plainpassword=$password -g=$username  --shell=/bin/bash $username";
$instruction[2] = "sudo cat $PATH/bashrc_local >> $HOME/.bashrc ";
$instruction[3] = "sudo chown $username $HOME/.*";
$instruction[4] = "sudo chgrp $username $HOME/.*";
$instruction[5] = "sudo su - $username";

$message[0] = ("   Clear any pre-existing account information and files belonging to 'tester'");
$message[1] = ("   Create temporary account for tester");
$message[2] = ("   Append environmental variables to tester's '.bashrc' file");
$message[3] = ("   Give tester ownwership of new files");
$message[4] = ("   Assign tester's group name to new files");
$message[5] = ("   Log into temporary account as the new user: 'tester' &");

if ( -d $HOME ) {
	
	my $i = 0;
	print("\n$message[$i]:\n");
	system("$instruction[$i]" );
	print(">$instruction[$i]\n");

} else {
  # NADA
}

my $number_of_instructions = scalar @instruction;

for ( my $i = 1; $i < $number_of_instructions; $i++ ) {

	print("\n$message[$i]:\n");
	system("$instruction[$i]");
	print(">$instruction[$i].\n\t");

}

