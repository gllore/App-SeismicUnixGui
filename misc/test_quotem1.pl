use Moose;

use Project_config;
	my $Project		= new Project_config();
	my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN;
	my $DATA_SEISMIC_SEGY	= $Project->DATA_SEISMIC_SEGY;
	my $DATA_SEISMIC_SU	= $Project->DATA_SEISMIC_SU;
	my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT;
	
my $suffix_sgy = '.sgy';
#my $ans =quotemeta ('0029'.$suffix_sgy);
##
#$ans =~ s/\\//;
#print ("ans=$ans\n");


#$suffix_sgy =~ s/\.//;
#$ans = $suffix_sgy;
#print ("ans=$ans\n");
my $value = '0050';
my $ans= '\''.$value.'\'';

readdir(quotemeta($DATA_SEISMIC_SEGY.'/'$ans).$suffix_sgy);
 
