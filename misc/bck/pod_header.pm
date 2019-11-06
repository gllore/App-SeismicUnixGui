package pod_header;
use Moose;

=head2 Default perl lines for the pod_headers of the file

 _first_entry_num is normally 1
 _max_entry_num is defaulted to 14

=cut

 	my @head;

	$head[0] =

'=head2 SYNOPSIS

 PACKAGE NAME: 

 AUTHOR:  

 DATE:

 DESCRIPTION:

 Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES

=head2 CHANGES and their DATES

=cut'."\n\n". 

"\t".'use Moose;';

 $head[1] = "\t".'use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);';          
 $head[2] = "\t".'use Project_config;'."\n";
 $head[3] = "\t".'my $Project = new Project_config();'."\n";
 $head[4] = "\t".'my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU;'."\n";           

sub section {
	 # print("perl/pod_header,@head\n");
 	return (\@head);
}

1;
