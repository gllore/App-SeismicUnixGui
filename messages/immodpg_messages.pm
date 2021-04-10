package immodpg_messages;

use Moose;

sub get {
    my ( $self) = @_;
    my @message;

$message[0] = ("Warning:  Interactive Fortran should not run in
background. Is L_SU running in the foreground? \n
If it is not, on command line
(1) enter:   'fg', return, return,
	or 
(2) run L_SU again, but without '&' \n
	(immodpg_message=0)\n");
	
$message[1] =("Warning:  Corrupt layer in model
Solutions: \n
(1) Copy backup file .immodpg.out to
    'immodpg.out'
or    
(2) Delete  immodpg.out and possibly 
   .immodpg.out, too; and  Restart immodpg\n
        (immodpg_message=1)
");

    return ( \@message );
}

1;

