use Moose;
#print ("INC=@INC\n");

use LSeismicUnix::misc::gui_history;
my $gui_history = new gui_history();
$gui_history ->test();