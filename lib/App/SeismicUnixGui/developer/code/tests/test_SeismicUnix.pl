use Moose;

use App::SeismicUnixGui::developer::code::tests::My_SeismicUnix qw(@b);     # Only imports $a 

print $b[0]."\n"; # does not print the first element