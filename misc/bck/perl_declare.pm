package perl_declare;
use Moose;

=head2 Default perl lines for
     declaring required packages

=cut

 my @declare;

 $declare[0] = '
 my ($DATA_SEISMIC_SU) = System_Variables::DATA_SEISMIC_SU(); ';

 $declare[1] = ' my (@flow,@file_in,@sufile_in,@inbound);
 my (@items,@outbound);

 '; 

sub section {
 return (\@declare);
}

1;
