package xk;

use Moose;

=pod

kill processes
# do it quietly -q
# wait -wq

=cut

sub kill_this {

    my $program_name = shift @_;

    my $this = $program_name if defined($program_name);

    if ( $this eq 'ximage' || $this eq 'suximage' ) {

        system("killall ximage -wq");
    }

    if ( $this eq 'suxwigb' || $this eq 'xwigb' ) {

        # do it -wq uietly
        system("killall xwigb -wq");

        #system("killall suxwigb -wq");
    }

    if ( $this eq 'suxgraph' || $this eq 'xgraph' ) {
        system("killall xgraph -wq");
    }

    return ();

}

1;
