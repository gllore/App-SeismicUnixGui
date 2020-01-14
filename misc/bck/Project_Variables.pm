package Project_Variables;

# DATE      format is DAY MONTH YEAR
# ENVIRONMENT VARIABLES FOR THIS PROJECT
# Notes:
# 1. Default DATE format is DAY MONTH YEAR
# 2. only change what lies between single
# inverted commas
# 3. the directory hierarchy is 
# $PROJECT_HOME/$date/$line
# Warning: Do not modify $HOME


  BEGIN {
                use Shell qw(echo);

                $home_directory = ` echo \$HOME`;
                chomp $home_directory;
        }
   $HOME 		= $home_directory;


# default values are required 

   $PROJECT_HOME	= $HOME.'/FalseRiver';;
   $site			= 'core_1';

# 
   $monitoring_well	= '';
   $preparation_well	= '041914';
   $stage		= 'H';
   $process		= '1';
#
sub date {

	$date=$site;
        return ($date);
}

sub HOME {
	return ($HOME);
}

sub PROJECT_HOME {
	return ($PROJECT_HOME);
}

sub line {
	$line = $monitoring_well;
	return ($line);
}
sub component {
	$component = $preparation_well;
	return ($component);
}

sub stage {
	return ($stage);
}

sub process {
	return ($process)
}


1;
