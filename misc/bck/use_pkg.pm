package use_pkg;
use Moose;

=head2 Default perl lines for start of instantiation
       of imported packages 

=cut

 my @use;

 $use[0] =  
 "\t".'use misc::message;'."\n".
 "\t".'use misc::flow;'."\n";


sub section {
 return (\@use);
}

1;
