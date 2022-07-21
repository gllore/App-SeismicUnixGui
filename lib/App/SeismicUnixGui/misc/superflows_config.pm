package App::SeismicUnixGui::misc::superflows_config;
use Moose;

my $path;
my $SeismicUnixGui;
use Shell qw(echo);

BEGIN {

$SeismicUnixGui = ` echo \$SeismicUnixGui`;
chomp $SeismicUnixGui;
$path = $SeismicUnixGui.'/'.'misc';

}
use lib "$path";
extends 'su_param';

1;
