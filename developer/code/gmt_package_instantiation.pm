package gmt_package_instantiation;
use Moose;


=head2 sub get_all 

  print("gmt_package_instantiation,sub get_all,@lines\n");

=cut

sub get_all {
 my ($self) = @_;
 my ($first,$i);
 my (@lines);

  $first 	= 0;
  $i  		= $first;

  $lines[$i] 		= ("\n");
  $lines[++$i] 		=  ' my $get    '."\t\t".'= new GMTglobal_constants();'."\n";
  $lines[++$i] 		=  ' my $gmt_var'."\t\t".'= $get->gmt_var();'."\n";
  $lines[++$i] 		= ("\n");

  return(\@lines);
}

1;
