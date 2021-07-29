package gmt_package_subroutine;

=head2 encapsualted variables

=cut

 	our $VERSION = '1.20';
 	use Moose;
	use L_SU_global_constants;
	my $get				= new L_SU_global_constants();

 	my $var				= $get->var();
	my $on         		= $var->{_on};
	my $off        		= $var->{_off};
	my $true       		= $var->{_true};
	my $false      		= $var->{_false};

 	my $gmt_package_subroutine = {
		_package_name   => '',
		_param_symbol   => '',
		_param_name   	=> '',
		_param_option  	=> '',
    };

=head2 Default perl lines for a subroutine 


=cut

 my @lines;

 $lines[0] = ("\n");


=head2 sub set_param_name


=cut

 sub set_param_name {

 	my ($self,$param_name_ref) = @_;
	if ($param_name_ref) {
 		$gmt_package_subroutine->{_param_name} = $$param_name_ref;
	}
 	 print("1. gmt_package_subroutine,set_param_name $$param_name_ref\n");

}



=head2 sub set_param_name_aref

  print("gmt_package_subroutine,name,@lines\n");

=cut

sub set_param_name_aref {
 my ($self,$name_aref) = @_;
 my ($first,$i,$package_name);

 $package_name = $gmt_package_subroutine->{_package_name};

  $first 	= 1;
  $i  		= $first;

  $lines[$i] 		= (" sub $$name_aref {\n");
  $lines[++$i]		=  '   my ( $self,$'.$$name_aref.' )'.("\t\t").'= @_;'.("\n");
  $lines[++$i]		=  '   if ( $'.$$name_aref.' ) {'.("\n");
  $lines[++$i]		=  '     $'.$package_name.'->{_'.$$name_aref.'}'.("\t\t").'= $'.$$name_aref.';'.("\n"); 
  $lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\' -'. $$name_aref.'\'.$'.$package_name.'->{_'.$$name_aref.'};'.("\n") ; 
  $lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\' -'. $$name_aref.'\'.$'.$package_name.'->{_'.$$name_aref.'};'.("\n"); 
  $lines[++$i] 		= '   }'.("\n");
  $lines[++$i] 		= (" }\n");
  $lines[++$i] 		= ("\n");
}



=head2 sub set_param_symbol


=cut

 sub set_param_symbol {

 	my ($self,$param_symbol_ref) = @_;
	if ($param_symbol_ref) {
 		$gmt_package_subroutine->{_param_symbol} = $$param_symbol_ref;
	}
 	# print("1. gmt_package_subroutine,set_param_symbol $$param_symbol_ref\n");

}

=head2 sub set_param_option


=cut

 sub set_param_option {

 	my ($self,$param_option_ref) = @_;
	if ($param_option_ref) {

		if ($$param_option_ref eq 'on_or_off') {
 			$gmt_package_subroutine->{_param_option} = $$param_option_ref;
		} else{
 			$gmt_package_subroutine->{_param_option} = $off;
		}
 	 	#print("1. gmt_package_subroutine,set_param_option $$param_option_ref\n");
	}


}



=head2 sub get_param_section

  print("gmt_package_subroutine,name,@lines\n");

=cut

 sub get_param_section {
 	my ($self) = @_;
 	my ($first,$i);
	my ($package_name,$symbol,$param_name,$param_option);
 	my @lines;

    $package_name 	= $gmt_package_subroutine->{_package_name};
	$symbol 		= $gmt_package_subroutine->{_param_symbol};
	$param_name 	= $gmt_package_subroutine->{_param_name};
	$param_option 	= $gmt_package_subroutine->{_param_option};

  	$lines[0] 	= ("\n");
  	$first 		= 1;
  	$i  		= $first;

	if($param_option eq 'on_or_off') {

 		$lines[$i]   	= ("\n");

  		$lines[++$i] 		= (" sub $param_name {\n");
  		$lines[++$i]		=  '   my ( $self,$verbose )'.("\t\t\t").'= @_;'.("\n");
  		$lines[++$i]		=  '   if ( $verbose eq $on ) {'.("\n");
  		$lines[++$i]		=  '     $'.$package_name.'->{_'.$param_name.'}'.("\t").'= \'\';'."\n"; 
  		$lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\' -V'.'\'.$'.$package_name.'->{_'.$param_name.'};'.("\n"); 
  		$lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\' -V'.'\'.$'.$package_name.'->{_'.$param_name.'};'.("\n"); 
  		$lines[++$i] 		= '   }'.("\n");
  		$lines[++$i] 		= (" }\n");
  		$lines[++$i] 		= ("\n");

	} else {

  		$lines[$i] 		= (" sub $param_name {\n");
  		$lines[++$i]		=  '   my ( $self,$'.$param_name.' )'.("\t\t").'= @_;'.("\n");
  		$lines[++$i]		=  '   if ( $'.$param_name.' ) {'.("\n");
  		$lines[++$i]		=  '     $'.$package_name.'->{_'.$param_name.'}'.("\t\t").'= $'.$param_name.';'.("\n"); 
  		$lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\' '.$symbol.'\'.$'.$package_name.'->{_'.$param_name.'};'.("\n") ; 
  		$lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\' '.$symbol.'\'.$'.$package_name.'->{_'.$param_name.'};'.("\n"); 
  		$lines[++$i] 		= '   }'.("\n");
  		$lines[++$i] 		= (" }\n");
  		$lines[++$i] 		= ("\n");


	}

 return (\@lines);
}

=head2 sub get_no_head

  print("gmt_package_subroutine,name,@lines\n");

=cut

 sub get_no_head {
 	my ($self) = @_;
 	my ($i,$first,$package_name);
	my @lines;

 	$package_name 		= $gmt_package_subroutine->{_package_name};
  	my $name 			= 'no_head';
  	$first   			= 0;
  	$i       			= $first;

  	$lines[$i] 		= (" sub $name {\n");
  	$lines[++$i]		=  '   my ( $self,$'.$name.' )'.("\t\t").'= @_;'.("\n");
  	$lines[++$i]		=  '   if ( $'.$name.' ) {'.("\n");
  	$lines[++$i]		=  '     $'.$package_name.'->{_'.$name.'}'.("\t\t").'= $'.$name.';'.("\n"); 
  	$lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\' -K'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n") ; 
  	$lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\' -K'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n"); 
  	$lines[++$i] 		= '   }'.("\n");
  	$lines[++$i] 		= (" }\n");
  	$lines[++$i] 		= ("\n");
	return(\@lines);
}

=head2 sub get_no_tail

  print("gmt_package_subroutine,name,@lines\n");

=cut

 sub get_no_tail {
 	my ($self) = @_;
 	my ($i,$first,$package_name);
	my @lines;

 	$package_name 		= $gmt_package_subroutine->{_package_name};
  	my $name 			= 'no_tail';
  	$first   			= 0;
  	$i       			= $first;

  	$lines[$i] 		= (" sub $name {\n");
  	$lines[++$i]		=  '   my ( $self,$'.$name.' )'.("\t\t").'= @_;'.("\n");
  	$lines[++$i]		=  '   if ( $'.$name.' ) {'.("\n");
  	$lines[++$i]		=  '     $'.$package_name.'->{_'.$name.'}'.("\t\t").'= $'.$name.';'.("\n"); 
  	$lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\' -O'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n") ; 
  	$lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\' -O'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n"); 
  	$lines[++$i] 		= '   }'.("\n");
  	$lines[++$i] 		= (" }\n");
  	$lines[++$i] 		= ("\n");
	return(\@lines);
}



=head2 sub get_limits

  print("gmt_package_subroutine,name,@lines\n");

=cut

 sub get_limits {
 	my ($self) = @_;
 	my ($i,$first,$package_name);
	my @lines;

 	$package_name 		= $gmt_package_subroutine->{_package_name};
  	my $name 			= 'limits';
  	$first   			= 0;
  	$i       			= $first;

  	$lines[$i] 		= (" sub $name {\n");
  	$lines[++$i]		=  '   my ( $self,$'.$name.' )'.("\t\t").'= @_;'.("\n");
  	$lines[++$i]		=  '   if ( $'.$name.' ) {'.("\n");
  	$lines[++$i]		=  '     $'.$package_name.'->{_'.$name.'}'.("\t\t").'= $'.$name.';'.("\n"); 
  	$lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\' -R'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n") ; 
  	$lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\' -R'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n"); 
  	$lines[++$i] 		= '   }'.("\n");
  	$lines[++$i] 		= (" }\n");
  	$lines[++$i] 		= ("\n");
	return(\@lines);
}


=head2 sub get_projection

  print("gmt_package_subroutine,name,@lines\n");

=cut

 sub get_projection {
 	my ($self) = @_;
 	my ($i,$first,$package_name);
	my @lines;

 	$package_name 		= $gmt_package_subroutine->{_package_name};
  	my $name 			= 'projection';
  	$first   			= 0;
  	$i       			= $first;

  	$lines[$i] 		= (" sub $name {\n");
  	$lines[++$i]		=  '   my ( $self,$'.$name.' )'.("\t\t").'= @_;'.("\n");
  	$lines[++$i]		=  '   if ( $'.$name.' ) {'.("\n");
  	$lines[++$i]		=  '     $'.$package_name.'->{_'.$name.'}'.("\t\t").'= $'.$name.';'.("\n"); 
  	$lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\' -J'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n") ; 
  	$lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\' -J'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n"); 
  	$lines[++$i] 		= '   }'.("\n");
  	$lines[++$i] 		= (" }\n");
  	$lines[++$i] 		= ("\n");
	return(\@lines);
}



=head2 sub get_note

  print("gmt_package_subroutine,get_note,@lines\n");

=cut

 sub get_note {
	my ($self) = @_;
 	my ($package_name, $first);
 	my @lines;
	my $i 			= 0;
	if ($gmt_package_subroutine->{_package_name}) {   # error check
    	my $name  		= 'note';
 		$package_name   = $gmt_package_subroutine->{_package_name};
 		$lines[$i]   	= ("\n");

  		$lines[++$i] 		= (" sub $name {\n");
  		$lines[++$i]		=  '   my ( $self )'.("\t\t\t").'= @_;'.("\n");
  		$lines[++$i]		=  '   if ( $self ) {'.("\n");
  		$lines[++$i]		=  '     $'.$package_name.'->{_'.$name.'}'.("\t").'= \''.$package_name.' \'.$'.$package_name.'->{_'.$name.'};'."\n"; 
  		$lines[++$i] 		=  '     return ( $'.$package_name.'->{_'.$name.'} );'.("\t").("\n"); 
  		$lines[++$i] 		= '   }'.("\n");
  		$lines[++$i] 		= (" }\n");
  		$lines[++$i] 		= ("\n");

		return(\@lines);
	}else {
		print("gmt_package_subroutine,get_note,Error:missing package name\n");
	}
 }


=head2 sub get_verbose

  print("gmt_package_subroutine,get_verbose,@lines\n");

=cut

 sub get_verbose {
	my ($self) = @_;
 	my ($package_name);
 	my @lines;
	my $i 			= 0;
	if ($gmt_package_subroutine->{_package_name}) {   # error check
    	my $name  		= 'verbose';
 		$package_name   = $gmt_package_subroutine->{_package_name};
 		$lines[$i]   	= ("\n");

  		$lines[++$i] 		= (" sub $name {\n");
  		$lines[++$i]		=  '   my ( $self,$verbose )'.("\t\t\t").'= @_;'.("\n");
  		$lines[++$i]		=  '   if ( $verbose eq $on ) {'.("\n");
  		$lines[++$i]		=  '     $'.$package_name.'->{_'.$name.'}'.("\t").'= \'\';'."\n"; 
  		$lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\' -V'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n"); 
  		$lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\' -V'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n"); 
  		$lines[++$i] 		= '   }'.("\n");
  		$lines[++$i] 		= (" }\n");
  		$lines[++$i] 		= ("\n");

		return(\@lines);
	}else {
		print("gmt_package_subroutine,get_verbose,Error:missing package name\n");
	}
 }

=head2 sub get_V

  print("gmt_package_subroutine,get_V,@lines\n");

=cut

 sub get_V {
	my ($self,$V) = @_;
 	my ($package_name);
 	my @lines;
	my $i 			= 0;
	if ($gmt_package_subroutine->{_package_name}) {   # error check
    	my $name  		= 'V';
 		$package_name   = $gmt_package_subroutine->{_package_name};
 		$lines[$i]   	= ("\n");

  		$lines[++$i] 		= (" sub $name {\n");
  		$lines[++$i]		=  '   my ( $self,$V)'.("\t\t\t").'= @_;'.("\n");
  		$lines[++$i]		=  '   if ( $V eq $on ) {'.("\n");
  		$lines[++$i]		=  '     $'.$package_name.'->{_'.$name.'}'.("\t").'= \'\';'."\n"; 
  		$lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\' -V'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n"); 
  		$lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\' -V'.'\'.$'.$package_name.'->{_'.$name.'};'.("\n"); 
  		$lines[++$i] 		= '   }'.("\n");
  		$lines[++$i] 		= (" }\n");
  		$lines[++$i] 		= ("\n");

		return(\@lines);
	}else {
		print("gmt_package_subroutine,get_V,Error:missing package name\n");
	}
 }




=head2 sub get_Step

  print("gmt_package_subroutine,get_Step,@lines\n");

=cut

 sub get_Step {
	my ($self) = @_;
 	my ($package_name, $first);
 	my @lines;
	my $i 			= 0;
	if ($gmt_package_subroutine->{_package_name}) {   # error check
    	my $name  		= 'Step';
 		$package_name   = $gmt_package_subroutine->{_package_name};
 		$lines[$i]   	= ("\n");

  		$lines[++$i] 		= (" sub $name {\n");
  		$lines[++$i]		=  '   my ( $self )'.("\t\t\t").'= @_;'.("\n");
  		$lines[++$i]		=  '   if ( $self ) {'.("\n");
  		$lines[++$i]		=  '   $'.$package_name.'->{_'.$name.'}'.("\t").'= \'gmt '.$package_name.' \'.$'.$package_name.'->{_'.$name.'};'."\n"; 
  		$lines[++$i] 		=  '     return ( $'.$package_name.'->{_'.$name.'} );'.("\t").("\n"); 
  		$lines[++$i] 		= '   }'.("\n");
  		$lines[++$i] 		= (" }\n");
  		$lines[++$i] 		= ("\n");

		return(\@lines);
	}else {
		print("gmt_package_subroutine,get_Step,Error:missing package name\n");
	}
 }


=head2 sub name

 print("gmt_package_subroutine,name $name_href\n");

=cut

sub name {

 my ($self,$name_href) = @_;
 $gmt_package_subroutine->{_package_name} = $name_href;
 # print("gmt_package_subroutine,name $name_href\n");

}


=head2 sub param_name

  print("gmt_package_subroutine,name,@lines\n");

=cut

sub param_name {
 my ($self,$name_aref) = @_;
 my ($first,$i,$package_name);

 $package_name = $gmt_package_subroutine->{_package_name};

  $first 	= 1;
  $i  		= $first;

  $lines[$i] 		= (" sub $$name_aref {\n");
  $lines[++$i]		=  '   my ( $self,$'.$$name_aref.' )'.("\t\t").'= @_;'.("\n");
  $lines[++$i]		=  '   if ( $'.$$name_aref.' ) {'.("\n");
  $lines[++$i]		=  '     $'.$package_name.'->{_'.$$name_aref.'}'.("\t\t").'= $'.$$name_aref.';'.("\n"); 
  $lines[++$i] 		=  '     $'.$package_name.'->{_note}'.("\t").'= $'.$package_name.'->{_note}.'.'\' -'. $$name_aref.'\'.$'.$package_name.'->{_'.$$name_aref.'};'.("\n") ; 
  $lines[++$i] 		=  '     $'.$package_name.'->{_Step}'.("\t").'= $'.$package_name.'->{_Step}.'.'\' -'. $$name_aref.'\'.$'.$package_name.'->{_'.$$name_aref.'};'.("\n"); 
  $lines[++$i] 		= '   }'.("\n");
  $lines[++$i] 		= (" }\n");
  $lines[++$i] 		= ("\n");
}

=head2 sub section 

 print("gmt_package_subroutine,section,@lines\n");

=cut

sub section {
 my ($self) = @_;
 return (\@lines);
}

1;
