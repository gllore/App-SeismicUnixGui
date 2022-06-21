use Moose;
#print ("INC=@INC\n");

use lib '/usr/local/pl/LSeismicUnix/misc';
extends 'gui_history' =>{ -version => 0.0.2 };

my $gui_history = new gui_history();
$gui_history ->test();