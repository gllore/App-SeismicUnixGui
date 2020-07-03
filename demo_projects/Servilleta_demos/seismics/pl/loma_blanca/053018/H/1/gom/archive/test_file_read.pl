use Moose;

my $ref_origin = 'ivpicks_old_sorted_\'junk\'_cdp25';
my $ref_origin = 'bad';

print("$ref_origin\n");

read_2cols ($ref_origin);

sub read_2cols { 

   my ($ref_origin) 		=  @_;

#declare locally scoped variables
   my ($i,$line,$t,$x,$num_rows);
   my (@TIME,@TIME_OUT,@OFFSET,@OFFSET_OUT);

# open the file of interest
  open(FILE,$ref_origin) || print("Can't open. $ref_origin \n");

#set the counter
  $i = 1;

# read contents of shotpoint geometry file
   while ($line = <FILE>) {
	#print("\n$line");
	chomp($line);
        ($t, $x)    = split ("  ",$line);
	$TIME[$i] 	      = $t;
        $OFFSET[$i]           = $x;
        #print("\n $TIME[$i] $OFFSET[$i]\n");
        $i 		 = $i +1;

    }

   close(FILE);

   $num_rows = $i-1;

}
