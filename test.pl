#!/usr/bin/perl
use Moose;
use Tk;

use L_SU_global_constants;
my $get                 = L_SU_global_constants->new();
my $var             = $get->var();

my $top_level;
my $mw = MainWindow->new;
$mw->title( "MainWindow1" );
$mw->geometry("100x100+0+0");

 $top_level = $mw->Toplevel(
 	-background =>$var->{_my_yellow},
       );
       
   $top_level->geometry('250x200+400+400');

   
   my $upper_frame = $top_level->Frame(
	-borderwidth => $var->{_no_borderwidth},
	-background  => $var->{_my_yellow},
);

   my $lower_frame = $top_level->Frame(
   	-borderwidth => $var->{_no_borderwidth},
	 -background => $var->{_my_yellow},
	 -height     => '10',
);
   
    my $label = $upper_frame->Label(
         -background => $var->{_my_yellow},
);
        
     my $ok_button = $top_level->Button(
            -text    => "ok",
            -command => sub { $top_level->grabRelease;
                              $top_level->withdraw }
        );
        
$upper_frame->pack(
   -side => "top",
	-fill => 'x',
	-expand => 0,
	-anchor   => "nw",
);

$label->pack;  
$lower_frame->pack(
  -side => "top",
	-fill => 'x',
	-expand => 1,
	-anchor   => "nw",
);
$ok_button->pack;
$top_level->withdraw;


$top_level->title( "immodpg" );
$label->configure (
	 -text => "\nThis is the error message\nThis is the error message\n
        This is the error message\nThis is the error message\n
        This is the error message\nThis is the error message\n
        This is the error message\n",
        );
$top_level->deiconify();
$top_level->raise();

MainLoop;
