use Moose;

use App::SeismicUnixGui::configs::big_streams::Project_config;
	my $Project		= Project_config->new();
	my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN;
	my $DATA_SEISMIC_SEGY	= $Project->DATA_SEISMIC_SEGY;
	my $DATA_SEISMIC_SU	= $Project->DATA_SEISMIC_SU;
	my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT;
	
my $suffix_sgy = '.sgy';
#my $ans =quotemeta ('0029'.$suffix_sgy);
##
#$ans =~ s/\\//;
#print ("ans=$ans\n");


quotemeta($DATA_SEISMIC_SEGY.'/'.''0029'').$suffix_sgy);

#$suffix_sgy =~ s/\.//;
#$ans = $suffix_sgy;
#print ("ans=$ans\n");
my $value = '0050';
my $ans= '\''.$value.'\'';
$ans = 'system("sh script.sh --help");quotemeta($DATA_SEISMIC_SEGY.'/'$ans).$suffix_sgy;
 
 open(FH, '>', 'delete_me.pl');
 print FH $ans."\n";
 close(FH);
