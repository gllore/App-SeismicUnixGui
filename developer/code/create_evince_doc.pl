use Moose;

my @program;

 $program[0] = 'evince';

# send error to out
 my $instruction = ("evince -h > $program[0].par");
 system $instruction;
 print $instruction."\n";
