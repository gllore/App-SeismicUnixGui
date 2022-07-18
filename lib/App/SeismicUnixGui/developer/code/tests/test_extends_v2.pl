use Moose;
#print ("INC=@INC\n");

use lib '$SeismicUnixGui/misc';
extends 'gui_history' =>{ -version => 0.0.2 };

my $gui_history = new gui_history();
$gui_history ->test();