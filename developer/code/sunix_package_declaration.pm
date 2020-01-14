package sunix_package_declaration;
use Moose;

	my @lines;

=head2 declaration variables

=cut

 my $sunix_package_declaration = {
		_package_name      => '',
		_subroutine_name   => '',
		_param_names   	    => '',
    };

=head2 sub make_section 

 print("sunix_package_declaration,get_section,@lines\n");
	    "\t".'my $get					= new L_SU_global_constants();'."\n\n".
=cut

 sub make_section {
 	
	my ($self) = @_;
	
	    $lines[0] =
	    'my $get'."\t\t\t\t\t".'= new L_SU_global_constants();'."\n";
	    $lines[1] = 'my $Project' . "\t\t\t\t" . '= new Project_config();' . "\n";
		$lines[2] = 'my $DATA_SEISMIC_SU' . "\t\t" . '= $Project->DATA_SEISMIC_SU();' . "\n";
		$lines[3] = 'my $DATA_SEISMIC_BIN' . "\t" . '= $Project->DATA_SEISMIC_BIN();' . "\n";
		$lines[4] = 'my $DATA_SEISMIC_TXT' . "\t" . '= $Project->DATA_SEISMIC_TXT();' . "\n\n";    
		$lines[5] = 'my $var'."\t\t\t\t".'= $get->var();'."\n";
		$lines[6] = 'my $on'."\t\t\t\t".'= $var->{_on};'."\n";
		$lines[7] = 'my $off'."\t\t\t\t".'= $var->{_off};'."\n";
		$lines[8] = 'my $true'."\t\t\t".'= $var->{_true};'."\n";
		$lines[9] = 'my $false'."\t\t\t".'= $var->{_false};'."\n";			
		$lines[10] = 'my $empty_string'."\t".'= $var->{_empty_string};'."\n";
		
		return (\@lines);
 }
	
=head2 sub get_section 

 print("sunix_package_declaration,get_section,@lines\n");

=cut

	sub get_section {
 		my ($self) = @_;
 		return (\@lines);
	}

1;
