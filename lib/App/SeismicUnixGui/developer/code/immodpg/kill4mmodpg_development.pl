use Moose;

# started in L_SU (a bash script) 
# as perl L_SUV0.5.0.pl
my $ans = `ps -ef | grep perl | grep L_SUV0.5.0.pl`;
chomp $ans;
my @words = split (/\s+/, $ans);
my $process_id = $words[1];
system("kill -9 $process_id");
print("kill -9 $words[1]\n");
print("@words\n");

# bash scripts L_SU or L_SU &
$ans = `ps -ef | grep bash | grep L_SU`;
chomp $ans;
print("$ans\n");
@words = split (/\s+/, $ans);
$process_id = $words[1];
system("kill -9 $process_id\n");
print("kill -9 $words[1]\n");
print("@words\n");

# started by immodpg1.1-- a fortran
# program
$ans = `ps -ef | grep pgxwin_server`;
chomp $ans;
@words = split (/\s+/, $ans);
$process_id = $words[1];
system("kill -9 $process_id\n");
print("kill -9 $words[1]\n");
print("@words\n");

# started in immodpg (a bash script)
$ans = `ps -ef | grep perl | grep immodpg.pl`;
chomp $ans;
@words = split (/\s+/, $ans);
$process_id = $words[1];
system("kill -9 $process_id\n");
print("kill -9 $process_id \n");
print("@words\n");

# started in immodpg ( a bash script)
# immodpg1.1 is a fortran program
$ans = `ps -ef | grep immodpg1.1`;
chomp $ans;
@words = split (/\s+/, $ans);
$process_id = $words[1];
system("kill -9 $process_id\n");
print("kill -9 $process_id \n");
print("@words\n");

# immodpg ( a bash script)
$ans = `ps -ef | grep immodpg`;
chomp $ans;
@words = split (/\s+/, $ans);
$process_id = $words[1];
system("kill -9 $process_id\n");
print("kill -9 $process_id \n");
print("@words\n");