use strict;
use warnings;
use Tk;

my $mw = MainWindow->new;
my @items = qw/Apple Banana Cherry Date Elderberry/;

my $listbox = $mw->Listbox(-selectmode => 'single')->pack();
$listbox->insert('end', @items);

# Highlight the third item (index 2)
my $item_to_select = 2; 
$listbox->selectionClear(0, 'end');
$listbox->selectionSet($item_to_select);
# Optional: make the item visible if it's off-screen
$listbox->see($item_to_select); 

MainLoop;
