package message_director;

use Moose;
use App::SeismicUnixGui::messages::FileDialog_button_messages;
use App::SeismicUnixGui::messages::FileDialog_close_messages;
use App::SeismicUnixGui::messages::color_listbox_messages;
use App::SeismicUnixGui::misc::save_button_messages;
use App::SeismicUnixGui::messages::flows_messages;
use App::SeismicUnixGui::messages::immodpg_messages;
use App::SeismicUnixGui::messages::iPick_messages;
use App::SeismicUnixGui::messages::run_button_messages;
use App::SeismicUnixGui::messages::null_messages;
use App::SeismicUnixGui::messages::project_selector_messages;
use App::SeismicUnixGui::messages::superflow_messages;

my $flows             = new flows_messages;
my $FileDialog_button = new FileDialog_button_messages;
my $FileDialog_close  = new FileDialog_button_messages;
my $run_button        = new run_button_messages;
my $save_button       = new save_button_messages;
my $superflow         = new superflow_messages;
my $null              = new null_messages;
my $project_selector  = new project_selector_messages;
my $iPick             = new iPick_messages;
my $immodpg			  = new immodpg_messages;
my $color_listbox		  = new color_listbox_messages;

=head1 DOCUMENTATION

=head2 SYNOPSIS 
PACKAGE NAME: message_director 
 AUTHOR: Juan Lorenzo
         Nov 21 2017 

 DESCRIPTION: 
 Version: 1.0

 Messages to user in L_SU

=head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 SEISMIC UNIX NOTES  

=head4 CHANGES and their DATES

=cut

=head2 private hash 

 
=cut

my $message_director = {
    _cdp_num       => '',
    _gather_num    => '',
    _gather_type   => '',
    _gather_header => '',
    _type          => '',
    _instructions  => ''
};

=head2 subroutine clear

  sets all variable strings to '' 

=cut

sub clear {

    $message_director->{_cdp_num}       = '';
    $message_director->{_gather_num}    = '';
    $message_director->{_gather_type}   = '';
    $message_director->{_gather_header} = '';
    $message_director->{_type}          = '';
    $message_director->{_instructions}  = '';
}

sub flows {
    my ( $self, $number ) = @_;
    my $message_ref = $flows->get();
    my $message     = @$message_ref[$number];

    # print("message_director,flows,message =$message\n");
    return ($message);
}

sub FileDialog_button {
    my ( $self, $number ) = @_;
    my $message_ref = $FileDialog_button->get();
    my $message     = @$message_ref[$number];

    # print("message_director,FileDialog_button,message =$message\n");
    return ($message);
}

sub FileDialog_close {
    my ( $self, $number ) = @_;
    my $message_ref = $FileDialog_close->get();
    my $message     = @$message_ref[$number];

    # print("message_director,FileDialog_close,message =$message\n");
    return ($message);
}

sub color_listbox {
    my ($self, $number ) = @_;

    my $message_ref = $color_listbox->get();
    my $message     = @$message_ref[$number];
#    print("message_director,color_listbox,message =$message\n");
    
    return ($message);
}

sub immodpg {
    my ( $self, $number ) = @_;

    my $message_ref = $immodpg->get();
    my $message     = @$message_ref[$number];
    # print("message_director,immodpg,message =$message\n");
    
    return ($message);
}

sub iPick {
    my ( $self, $number ) = @_;
    my $message_ref = $iPick->get();
    my $message     = @$message_ref[$number];
    print("message_director,iPick,message =$message\n");
    return ($message);
}

sub null_button {
    my ( $self, $number ) = @_;
    my $message_ref = $null->get();
    my $message     = @$message_ref[$number];

    # print("message_director,null,message =$message\n");
    return ($message);
}

sub project_selector {
    my ( $self, $number ) = @_;
    my $message_ref = $project_selector->get();
    my $message     = @$message_ref[$number];

    # print("message_director,project_selector,message =$message\n");
    return ($message);
}

sub run_button {
    my ( $self, $number ) = @_;
    my $message_ref = $run_button->get();
    my $message     = @$message_ref[$number];

    # print("message_director,run_button,message =$message\n");
    return ($message);
}

sub save_button {
    my ( $self, $number ) = @_;
    my $message_ref = $save_button->get();
    my $message     = @$message_ref[$number];

    # print("message_director,save_button,message =$message\n");
    return ($message);
}

sub superflow {
    my ( $self, $number ) = @_;
    my $message_ref = $superflow->get();
    my $message     = @$message_ref[$number];

    # print("message_director,sueprflow,message =$message\n");
    return ($message);
}

1;
