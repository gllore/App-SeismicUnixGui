use Moose;
our $VERSION = '0.5.0';

my $path;
my $SeismicUnixGui;
use Shell qw(echo);

BEGIN {

$SeismicUnixGui = ` echo \$SeismicUnixGui`;
chomp $SeismicUnixGui;
$path = $SeismicUnixGui.'/'.'misc';

}
use lib "$path";

#extends 'gui_history' => { -version => 0.0.2 };

#use Tk;
#use Tk::Pane;
#use Tk::NoteBook;
use App::SeismicUnixGui::misc::L_SU '0.1.7';
use App::SeismicUnixGui::misc::L_SU_global_constants;
print ("$SeismicUnixGui\n");

=head2 Instantiation

=cut

my $get         = L_SU_global_constants->new();
#my $L_SU        = L_SU->new();
#my $gui_history = gui_history->new();

=head2 Import Special Variables

=cut

my $global_libs                   = $get->global_libs();
my $var                           = $get->var();
my $on                            = $var->{_on};
my $true                          = $var->{_true};
my $false                         = $var->{_false};
my $empty_string                  = $var->{_empty_string};
my $flow_type                     = $get->flow_type_href();
my $alias_FileDialog_button_label = $get->alias_FileDialog_button_label_aref;
my $superflow_names_gui_aref      = $get->superflow_names_gui_aref();
my $file_dialog_type              = $get->file_dialog_type_href();

print("main,global_libs=$global_libs->{_images}\n");
print("on = $on\n");
print("Hit Enter to continue\n");
<STDIN>;
