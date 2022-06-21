package gmt_package_pod;
use Moose;

my $path;
my $LSeismicUnix;
use Shell qw(echo);

BEGIN {

$LSeismicUnix = ` echo \$LSeismicUnix`;
chomp $LSeismicUnix;
$path = $LSeismicUnix.'/'.'developer/code/sunix';

}
use lib "$path";
extends 'sunix_package_pod';

=head2 encapsulated variables

=cut

 my $gmt_package_pod = {
		_package_name		=> '',
		_subroutine_name	=> '',
		_gmt_doc			=> '',
		_num_lines			=> '',
		_local_variables	=> '',
    };

=head2 Default perl lines for  a subroutine 


=cut

 my @lines;

 $lines[0] = ("\n");


=head2 sub set_gmt_doc 

 	Complete gmt documentation

=cut

 	sub set_gmt_doc {

  		my ($self,$aref) 					= @_;
		if($aref) {
  			$gmt_package_pod->{_gmt_doc} 	= $aref;
  			# print("gmt_package_pod,set_gmt_doc,whole @{$gmt_package_pod->{_gmt_doc}} \n");
  			$gmt_package_pod->{_num_lines} 	= scalar (@{$aref});
  			 # print("gmt_package_pod,set_gmt_doc,num_lines $gmt_package_pod->{_num_lines} \n");
		}
	return();
 	}


=head2 sub header

	Introductory header for each package

=cut

sub header {
  my ($self) = @_;
  my ($first,$last,$i);
  my @h_lines;
  $first 				= 0;
  $i  					= $first;
  my $name				= $gmt_package_pod->{_package_name};
  my $aref              = $gmt_package_pod->{_gmt_doc};

  $h_lines[$i] 			= ("\n\n=head1 DOCUMENTATION\n\n");
  $h_lines[++$i] 		= ("=head2 SYNOPSIS\n\n");
  $h_lines[++$i] 		= ("PACKAGE NAME: $name\n");
  $h_lines[++$i] 		= ("AUTHOR: Juan Lorenzo\n");
  $h_lines[++$i] 		= ("DATE:   \n");
  $h_lines[++$i] 		= ("DESCRIPTION:\n");
  $h_lines[++$i] 		= ("Version: \n\n");
  $h_lines[++$i] 		= ("=head2 USE\n\n");
  $h_lines[++$i] 		= ("=head3 NOTES\n\n");
  $h_lines[++$i] 		= ("=head4 Examples\n\n");
  $h_lines[++$i] 		= ("=head3 GMT NOTES\n\n");

     
	my $num_lines = $gmt_package_pod->{_num_lines};
    for (my $j=0 ,$i++; $j < $num_lines; $j++,$i++) {
	 	# print(" line # is $j\n");

  		$h_lines[$i] 		= @$aref[$j];#."\n";
 	}
  $h_lines[$i] 		= ("\n=head2 CHANGES and their DATES\n\n");
  $h_lines[++$i] 	= ("=cut\n\n");
  my $size = scalar @h_lines;
  			# print("gmt_package_pod,num_lines,$size\n");
  			# print("gmt_package_pod,header\n @h_lines");
 return(\@h_lines);
}

=head2 sub gmt_package_name

  print("gmt_package_pod,name,@lines\n");

=cut

sub gmt_package_name {
 my ($self,$name) = @_;
 $gmt_package_pod->{_package_name} = $name;
 return();
}


=head2 sub subroutine_name

  print("package_pod,name,@lines\n");

=cut

sub subroutine_name {
 my ($self,$name_aref) = @_;
 my ($first,$last,$i,$sub_name);

 $gmt_package_pod->{_subroutine_name} = $$name_aref;

  $first 	= 1;
  $i  		= $first;

  $lines[$i] 		= ("=head2 sub $$name_aref \n");
  $lines[++$i] 		=  ("\n");
  $lines[++$i] 		=  ("\n");
  $lines[++$i] 		= ("=cut\n");
}


=head2 sub section 

 print("gmt_package_pod,section,@lines\n");

=cut

sub section {
 my ($self) = @_;
 return (\@lines);
}

1;
