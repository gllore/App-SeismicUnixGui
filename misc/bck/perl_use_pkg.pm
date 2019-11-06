package perl_use_pkg;
use Moose;

=head2 Default perl lines for instantiation
       of imported packages 

=cut

 my @use;

 $use[0] = 
 ' use message;
 use flow;
 ';


sub section {
 return (\@use);
}

1;
