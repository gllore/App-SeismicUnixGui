#!/usr/bin/perl
use strict;
use warnings;
use Tk;

# Create main window
my $mw = MainWindow->new;
$mw->title("Perl/Tk Listbox Test");

# Create a frame to organize layout
my $frame = $mw->Frame()->pack(-padx => 10, -pady => 10);

# Add a label
$frame->Label(-text => "Select an item from the list:")->pack;

# Create the Listbox
my $listbox = $frame->Listbox(
    -selectmode => 'single',
    -height     => 5,
    -width      => 30
)->pack(-pady => 5);

# Populate the listbox
my @items = qw(Apple Banana Cherry Date Elderberry Fig Grape);
$listbox->insert('end', @items);

# Add a button to show selected item
my $label = $frame->Label(-text => "Selected: (none)")->pack(-pady => 5);

$frame->Button(
    -text    => "Show Selection",
    -command => sub {
        my @selected_indices = $listbox->curselection;
        if (@selected_indices) {
            my $selected_item = $listbox->get($selected_indices[0]);
            $label->configure(-text => "Selected: $selected_item");
        } else {
            $label->configure(-text => "Selected: (none)");
        }
    }
)->pack(-pady => 5);

# Exit button
$frame->Button(
    -text    => "Quit",
    -command => sub { exit }
)->pack(-pady => 5);

MainLoop;
