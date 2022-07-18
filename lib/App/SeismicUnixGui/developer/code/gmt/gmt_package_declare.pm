package gmt_package_declare;
use Moose;


=head2 sub get_all 

  print("gmt_package_declare,subget_all,@lines\n");

=cut

sub get_all {
 my ($self) = @_;
 my ($first,$i);
 my (@lines);

  $first 	= 0;
  $i  		= $first;

  $lines[$i] 		= ("\n");
  $lines[++$i] 		= ' my $on   '."\t\t\t".'= $gmt_var->{_on};'."\n";
  $lines[++$i] 		= ' my $off  '."\t\t\t".'= $gmt_var->{_off};'."\n";
  $lines[++$i] 		= ' my $true '."\t\t\t".'= $gmt_var->{_true};'."\n";
  $lines[++$i] 		= ' my $false'."\t\t\t".'= $gmt_var->{_false};'."\n";
  $lines[++$i] 		= ("\n");

  return(\@lines);
}

1;
