use Moose;
use Test::Simple tests => 1;

my $me = `whoami`;
chomp $me;

my $HOME = `echo \$HOME`;
chomp $HOME;

if ( $me eq 'root') {

    # must be root
    print ("I am running tests as $me whose home directory is $HOME \n");
    my $instruction = "cp -R .L_SU $HOME";
    print $instruction."\n";
    system $instruction;

    my $flow = '../demo_projects/demos/seismics/pl/shapeNcut/sumute/1.multi_gather_file_mute.pl';

    my $running = `perl $flow`;
    print $running;

} elsif ( $me ne 'root') {
	print ("run sudo test.t\n");

} else {
	print ("unexpected result\n");
}

