 package gmt_package;

 use Moose;

my $path;
my $LSeismicUnix;
use Shell qw(echo);

BEGIN {

$LSeismicUnix = ` echo \$LSeismicUnix`;
chomp $LSeismicUnix;
$path = $LSeismicUnix.'/'.'misc';

}

use lib "$path";
 extends 'sunix_package';
 
 my $package = sunix_package ->new;

=head2 sunix_package extends sunix_pl
 which shares many similar attributes to current 
 class in that files are examined for patterns
 However, the current class uses gmt_doc files
 rather than sunix perl scripts

=cut

=head2 initialize shared anonymous hash 

  key/value pairs

=cut

 my $gmt_package = {
  	  _config_file_out	=> '',
  	  _file_in			=> '',
  	  _file_out			=> '',
  	  _length			=> '',
  	  _name				=> '',
  	  _num_lines		=> '',
  	  _path_out			=> '',
  	  _gmt_doc			=> '',
  	  _outbound			=> '',
    };

=pod declare local variables

=cut

   	my @param_names;
	my @param_symbol;
	my @param_option;


=pod sub write_config 

 open and write configuration 
 file

=cut

sub write_config {
 	my($self) = shift;

 	if ($gmt_package->{_config_file_out} && $gmt_package->{_length} ) { # avoids errors

   		my $OUT;
    	my $outbound	= $gmt_package->{_path_out}.$gmt_package->{_config_file_out};
   				# print ("gmt_package,write_config $gmt_package->{_outbound}\n");

    	open  $OUT, '>', $outbound or die;
    	for (my $i=0; $i < $gmt_package->{_length}; $i++) {
        	printf $OUT "    %-35s%1s%-20s\n",@{$gmt_package->{_param_names}}[$i],'= ',
        	@{$gmt_package->{_param_values}}[$i];
    	}     
    	close($OUT);
   	}
 }


=head2 sub set_gmt_doc

  print("gmt_doc is $gmt_package->{_gmt_doc}\n");

=cut

	sub set_gmt_doc {
  		my($self,$gmt_doc_aref) 	= @_;

		if ($gmt_doc_aref) {
  		$gmt_package->{_gmt_doc} 	=  $gmt_doc_aref;
  		$gmt_package->{_num_lines} 	=  scalar @$gmt_doc_aref;
  		  # print("gmt_package,gmt_doc @{$gmt_package->{_gmt_doc}}\n");
		}
		return();
	}

=head2 sub set_file_out

   		 print("1. sunix_package,file_out is $sunix_package->{_file_out}\n");

=cut

sub set_file_out {
  my($self,$file_aref) = @_;
  $gmt_package->{_file_out} =  @$file_aref[0];
}


=head2 sub set_name
  print("name is $gmt_package->{_name}\n");

=cut

sub set_name {
  my($self,$file_aref) = @_;
  $gmt_package->{_name} =  @$file_aref[0];
	# print("gmt_package,set_name,name:$gmt_package->{_name}\n");
}


=head2 sub set_gmt_xtra_param_names

  				print("gmt_package,param_names  @{$gmt_package->{_param_names}}\n");
	add conventional note and Step to sequence

=cut

 sub set_gmt_xtra_param_names {
  	my($self,$names_aref) = @_;
  	my $len 					= scalar @$names_aref;
    @$names_aref[($len++)] 		= 'infile';
    @$names_aref[($len++)] 		= 'outfile';
    @$names_aref[($len++)] 		= 'limits';
    @$names_aref[($len++)] 		= 'projection';
    @$names_aref[($len++)] 		= 'no_head';
    @$names_aref[($len++)] 		= 'no_tail';
    @$names_aref[($len++)] 		= 'verbose';
  	@$names_aref[($len++)] 		= 'Step';
  	@$names_aref[($len++)] 		= 'note';
  	$gmt_package->{_param_names}= $names_aref ;
  	$gmt_package->{_length} 	=  scalar @$names_aref;
 }


=pod sub write 

 open  and write 
 to the file

=cut

 sub write_pm {
   my($self) = shift;

   if ($gmt_package->{_file_out} && $gmt_package->{_length} ) { # avoids errors

   		my $OUT;
     	use gmt_package_encapsulated;
     	use gmt_package_header;
     	use gmt_package_declare;
     	use gmt_package_instantiation;
     	use gmt_package_clear;
     	use gmt_package_pod;
     	use gmt_package_subroutine;
     	use gmt_package_tail;

     	my $encapsulated 	    = gmt_package_encapsulated->new();
     	my $header 	    		= gmt_package_header->new();
     	my $declare  			= gmt_package_declare->new();
     	my $instantiation  		= gmt_package_instantiation->new();
     	my $clear 	    		= gmt_package_clear->new();
     	my $pod 	       		= gmt_package_pod->new();
     	my $subroutine			= gmt_package_subroutine->new();
     	my $tail				= gmt_package_tail->new();

     	$encapsulated			->package_name($gmt_package->{_name});
     	$encapsulated	        ->param_names($gmt_package->{_param_names});
		$clear					->package_name($gmt_package->{_name});
		$clear					->param_names($gmt_package->{_param_names});
     	$pod					->gmt_package_name($gmt_package->{_name});
     	$pod					->set_gmt_doc($gmt_package->{_gmt_doc});
     	$subroutine				->name($gmt_package->{_name});
     	$gmt_package->{_outbound}= $gmt_package->{_path_out}.$gmt_package->{_file_out};

      		 # print ("gmt_package outbound $gmt_package->{_outbound}\n");;
      		 #  print ("gmt_package  name $gmt_package->{_name}\n");;

      	open  $OUT, '>', $gmt_package->{_outbound} or die;
      		print $OUT @{$header->package_section($gmt_package->{_name})};
      		print $OUT @{$pod->header()};
      		print $OUT @{$header->get_Moose_section};
      		print $OUT @{$header->get_version_section};
      		print $OUT @{$header->get_use_package_section};
			print $OUT @{$pod->get_instantiation};
			print $OUT @{$instantiation->get_all};
			print $OUT @{$pod->get_declare};
			print $OUT @{$declare->get_all};
			print $OUT @{$pod->get_encapsulated};
      		print $OUT @{$encapsulated->section};
			print $OUT @{$pod->get_clear};
      		print $OUT @{$clear->section};
			#print $OUT @{$pod->get_V};
 			#print $OUT @{$subroutine->get_V};

				# exclude regular subroutines :
				# 	 projection
				# 	 infile 
				# 	 outfile 
				# 	 projection
				# 	 limits
				# 	 no_head
				# 	 no_tail
				# 	 verbose 
				# 	 note 
				# 	 Step
				# 	 subroutines (last 9)
		my $length = $gmt_package->{_length} - 9;
      	for (my $i=0; $i < $length; $i++) {

      		$subroutine->set_param_name_aref(\@{$gmt_package->{_param_names}}[$i]);
      		$pod	   ->subroutine_name(\@{$gmt_package->{_param_names}}[$i]);
        	print $OUT @{$pod->section};
        	print $OUT @{$subroutine->section};
      	}     

 		$param_names[0]  = 'infile';
		$param_symbol[0] = '';
      	$subroutine->set_param_symbol(\$param_symbol[0]);
      	$subroutine->set_param_name(\$param_names[0]);
      	$pod	   ->subroutine_name(\$param_names[0]);
		print $OUT @{$pod->section};
       	print $OUT @{$subroutine->get_param_section};

 		$param_names[0]  = 'outfile';
		$param_symbol[0] = '-G';
      	$subroutine->set_param_symbol(\$param_symbol[0]);
      	$subroutine->set_param_name(\$param_names[0]);
      	$subroutine->set_param_option();
      	$pod	   ->subroutine_name(\$param_names[0]);
		print $OUT @{$pod->section};
       	print $OUT @{$subroutine->get_param_section};

 		$param_names[0] = 'limits';
      	$pod	   ->subroutine_name(\$param_names[0]);
		print $OUT @{$pod->section};
       	print $OUT @{$subroutine->get_limits};
       				#print  @{$subroutine->get_limits};
       				
 		$param_names[0] = 'no_head';
      	$pod	   ->subroutine_name(\$param_names[0]);
		print $OUT @{$pod->section};
       	print $OUT @{$subroutine->get_no_head};
       				 # print @{$subroutine->get_no_head};
       				 
 		$param_names[0] = 'no_tail';
      	$pod	   ->subroutine_name(\$param_names[0]);
		print $OUT @{$pod->section};
       	print $OUT @{$subroutine->get_no_tail};
       				#print  @{$subroutine->get_no_tail};
       				
 		$param_names[0] = 'projection';
      	$pod	   ->subroutine_name(\$param_names[0]);
		print $OUT @{$pod->section};
       	print $OUT @{$subroutine->get_projection};
       				 # print @{$subroutine->get_projection};
       				 
 		$param_names[0]  = 'verbose';
		$param_symbol[0] = '-V';
        $param_option[0] = 'on_or_off';
      	$subroutine->set_param_symbol(\$param_symbol[0]);
      	$subroutine->set_param_option(\$param_option[0]);
      	$subroutine->set_param_name(\$param_names[0]);
      	$pod	   ->subroutine_name(\$param_names[0]);
		print $OUT @{$pod->section};
       	print $OUT @{$subroutine->get_param_section};

 		$param_names[0] = 'limits';

 		$param_names[0] = 'Step';
      	$pod	   ->subroutine_name(\$param_names[0]);
		print $OUT @{$pod->section};
       	print $OUT @{$subroutine->get_Step};
       				#print  @{$subroutine->get_Step};
       				
 		$param_names[0] = 'note';
      	$pod	   ->subroutine_name(\$param_names[0]);
		print $OUT @{$pod->section};
       	print $OUT @{$subroutine->get_note};
       				 # print @{$subroutine->get_note};
       				 
      	print $OUT @{$tail->section};
     	close($OUT);
   }

 }

1;
