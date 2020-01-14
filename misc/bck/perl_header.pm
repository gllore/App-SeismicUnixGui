package perl_header;
use Moose;

=head2 Default perl lines for the headers of the file

 _first_entry_num is normally 1
 _max_entry_num is defaulted to 14

=cut

 my @head;

 $head[0] = (" use Moose;");
 $head[1] = ' use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);';          
 $head[2] = ' use System_Variables;'."\n";          

sub section {
 return (\@head);
}

1;
