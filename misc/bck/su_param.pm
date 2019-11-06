package su_param;
	use Moose;
	
=head1 DOCUMENTATION


=head2 SYNOPSIS 

 PERL PACKAGE NAME: su_param 
 AUTHOR: 	Juan Lorenzo
 DATE: 		May 5 2018 

 DESCRIPTION V 0.2
     

 BASED ON: 0.1


=cut

=head2 USE

=head3 NOTES

=head4 Examples


=head2 CHANGES and their DATES
	May 5 2018 looks for configurations
	first in the local directory
	then in the default configuration
	directory /usr/local/pl/big_streams/config

=cut 
	
	

=head2

 parameters for seismic unix programs
 both macros and individual modules
  
=cut


 	use L_SU_global_constants;
    use L_SU_local_user_constants;
    
 	my $get  				= new L_SU_global_constants();
 	my $lib  				= $get->global_libs();
 	my $lib_path   			= $lib->{_param};
 	my $local_path   		= $lib->{_default_path};

 	my $var					= $get->var();

	my %name_space;
	my $true   				= $var->{_true};
	my $false  				= $var->{_false};
	
    my $usr_config 			= L_SU_local_user_constants->new();
    my $ACTIVE_PROJECT		= $usr_config->get_ACTIVE_PROJECT();
	my $user_config_path 	= $ACTIVE_PROJECT;

	my $su_param = {
    	_name_space 		=> 'name_space',
    	_lib_path			=> $lib_path,		
    	_local_path			=> '',
    	_user_config_path   => $user_config_path,
    	_names_aref			=> '',		
	    };


=head2 sub get

  returns values
  as an array
  input is a scalar reference
  used both by superflow and seismic unix configuration files
  
 Read a default specification file 
 If default specification file# does not exist locally
 then look in the user's configuration directory
 ~HOME/.L_SU/configuration/active and if that does not exist
 then use the default one defined under global libs

  Debug with
    print ("this is $this\n");
    print ("self is $self,program is $program\n");

  Changing the name space variables to lower
  case is not a general solution because
  original variables can have mixed upper and lower
  case names
  Older versions used Config::Simple
    my $a = Config::Simple->import_from($this,'Z');
     foreach my $key ( keys %Z:: )
    {
       my $x = lc $key;
        print "key is $x\n";
        print "$cfg->param($key)\n";
    }


=cut

sub get {
	my ($self,$program_sref)  = @_;

  	if (defined $program_sref) {
    	my (@CFG);
    	my ($length,$names_aref,$values_aref);
    	my ($i,$j,$program,$path);

    	use readfiles;
    	my $read 		= new readfiles();
    	
    	# reset the following test
    	my $local_config_exists = _check4local_config($program_sref);
    	my $user_config_exists 	= _check4user_config($program_sref);
    	
#			 print("su_param, get, local_config_exists: $local_config_exists\n");
#			 print("su_param, get,user_config_exists: $user_config_exists\n");
			 
		if( $local_config_exists) { # within $PL_SEISMIC
			use Project_config;
			my $Project 				= Project_config->new();
			my $PL_SEISMIC 				= $Project->PL_SEISMIC();
			$su_param->{_local_path} 	= $PL_SEISMIC;
			
			$path 						= $su_param->{_local_path};
			 # print("1.1 su_param,get,local configuration files exists\n");
			 # print("1.2 su_param,get,PL_SEISMIC path is now $su_param->{_local_path} \n");
			 
		} elsif ( $user_config_exists ){  # ./L_SU/configuration/active/Project.config
			  $path 					= $su_param->{_user_config_path};
			 # print("2.1 su_param,get,user configuration files exists\n");
			 # print("2.2 su_param,get,active path is now $su_param->{_user_config_path} \n");
			 
		}else { # global libs
			$path 					= $su_param->{_lib_path};
			# print("3.1 su_param,get,using global lib-- default path \n");
			# print("3.2 su_param,get,global lib path is now $su_param->{_lib_path} \n");
		}
		
    	$program 					= $path.'/'.$$program_sref.'.config'; 
    	# print("su_param, get,configuration file to read=$program\n");

    	($names_aref,$values_aref) 	= $read->configs($program);
    	$su_param->{_names_aref} 	= $names_aref;
    	$length                    	= scalar @$names_aref;

    					 #print("su_param,get:we have $length pairs\n\n");
    	for ( $i=0,$j=0; $i <$length; $i++,$j=$j+2 ) {

     		$CFG[$j]     	= $$names_aref[$i];
     		
     		$CFG[($j+1)] 	= $$values_aref[$i]; 
     		# print("su_param,get,values: $CFG[$j+1]\n");
    	}
    	
    		return(\@CFG);
	}
}
=head2 sub _check4local_config

 check for local versions of the configuration files
 needs name_sref
 look in PL_SEISMIC

=cut


 sub _check4local_config {
 	my ($name_sref) 	= @_;
 	
 	use Project_config;
	my $Project 			= Project_config->new();	
	my $PL_SEISMIC 			= $Project->PL_SEISMIC();	
	my $ans 				= $false;
	
	if($name_sref) {
		my $prog_name_config    = $PL_SEISMIC.'/'.$$name_sref.'.config';
		
		if (-e ($prog_name_config) ) {
			$ans  = $true;
			   # print("su_param,_check4local_config,found: $prog_name_config. Using local configuration file\n");
			   $ans = $true;
		} else {
			$ans = $false;
			  # print("su_param,_check4local_config, $prog_name_config not found\n")
		}
	} else {
		print("su_param,_check4local_config, missing name_sref \n");
		$ans = $false;
	}
	return($ans);
}

#=head2 sub check4local_config
#
# check for local versions of the configuration files
# look in PL_SEISMIC
#
#=cut
#
#
#sub check4local_config {
#
# 	my ($self,$name_sref) 	= @_;
# 	
#	my $ans 				= $false;
#	
#	if($name_sref) {
#		if (-e ($$name_sref.'.config') ) {
#			$ans  = $true;
#			   # print("su_param,check4local_config,$$name_sref.config found, Using local configuration file\n");
#			   # print("su_param,check4local_config=$ans\n");
#		} else {
#			$ans = $false;
#			   # print("su_param,check4local_config,$$name_sref not found\n")
#		}
#	}
#	return($ans);
#}

=head2 sub _check4user_config

 check for versions of the configuration files
 in the user's configuration directory:
 .L_SU/configuration/active

=cut


sub _check4user_config {

 	my ($name_sref) 	= @_;
	
	my $ans 				= $false;
	
	if($name_sref) {
		if (-e ($ACTIVE_PROJECT.'/'.$$name_sref.'.config') ) {
			$ans  = $true;
			   # print("su_param,_check4user_config,$$name_sref.config found, Using user configuration file\n");
			   # print("su_param,_check4user_config=$ans\n");
		} else {
			$ans = $false;
			   # print("su_param,_check4user_config,$$name_sref not found. Using default (GLOBAL LIBS) configuration file\n")
		}
	}
	return($ans);
}


=head2 sub check4user_config

 check for versions of the configuration files
 in the user's configuration directory:
 .L_SU/configuration/active

=cut


sub check4user_config {

 	my ($self,$name_sref) 	= @_;

 	
	my $ans 				= $false;
	
	if($name_sref) {
		if (-e ($ACTIVE_PROJECT.'/'.$$name_sref.'.config') ) {
			$ans  = $true;
			   # print("su_param,check4user_config,$$name_sref.config found, Using user configuration file\n");
			   # print("su_param,check4user_config=$ans\n");
		} else {
			$ans = $false;
			   # print("su_param,check4user_config,$$name_sref not found. Using default (GLOBAL LIBS) configuration file\n")
		}
	}
	return($ans);
}


=head2 sub length 
not found
 This length is twice the number of parameter
  names
  print("su_param,length: is $length\n");


=cut

 sub length {

   my ($self)  = @_;
   if ($su_param->{_names_aref}) {
   	   my $length = (scalar @{$su_param->{_names_aref}}) *2;
   		return($length);
   } else {
   		# print ("su_param,length, empty names array reference\n");
   }

 }

1;
