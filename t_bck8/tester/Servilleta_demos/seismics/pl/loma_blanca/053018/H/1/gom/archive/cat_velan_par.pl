use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS

 PROGRAM NAME: cat_velan_par.pl P 
 Purpose: add traces 
  AUTHOR:  Juan M. Lorenzo
  DEPENDS: Seismic Unix modules from CSM 
  DATE:    July 31 2013 V0.1
           Oct. 31, 2016 V0.2 for nmo
  DESCRIPTION:  

=head2 USAGE

 perl cat_velan_par.pl

=head2 NOTES

=head2 STEPS 

 1. Read list of cdp file numbers
 e.g., 
      11
      12

 2. Add a prefix and read in the cdp file parameters
 $ivpicks_sorted_par_file_name_cdp11

    tnmo=a,b,c
    vnmo=A,B,C

 $ivpicks_sorted_par_file_name_cdp12

    tnmo=d,e,f
    vnmo=D,E,F


 3. Rearrange parameters in memory

   cdp=11,12
   tnmo=a,b,c
   vnmo=A,B,C
   tnmo=d,e,f
   vnmo=D,E,F

 4. Write out final composite parameter file

=cut

 use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $itop_mute_par_ $ivpicks_sorted_par_ $_cdp
		     $_stkvel $_mute ); 
 use flow;
 use message;
 use manage_files_by;
 use Project_config;

#ivpicks_sorted_par 

=head2 Instantiate classes

     Use classes:
     flow
     log
     message

=cut

  my $log 					= new message();
  my $run    				= new flow();
  my $Project				= new Project_config();

  my ($PL_SEISMIC) 			= $Project->PL_SEISMIC();

=head2 Declare

  local variables 

=cut

  my (@flow,@data_in);
  my (@suCatPar,@suCatParNote,$suCatParVersion);
  my ($par_file,$row,$file_number);
  my (@cdp,@output,@outbound);
  my ($numberOfFiles);
  my $ref_file_names;
  my ($ref_values,$ref_numberOfValues,$par_file_list);
  my ($binheader_type);

=head2 Declare

  file names 

=cut

=head2

=cut
	# my @ARGV;
	# print("my ARGV is: @ARGV \n");
	if ( $ARGV[0] ) {
	
		$data_in[1] 		   = $ARGV[0]; # junk

   		$par_file_list       	= $ARGV[1]; #'cdp_par_file_list';
   		$outbound[1]         	=  $PL_SEISMIC.'/'.$data_in[1].$_stkvel;
		
	} else {
		
		# print("ARGV[0]=$ARGV[0] ARGV[1]=$ARGV[1] \n");
		print("usage: perl cat_velan_par (seismic unix data in) (a list of parameter file numbers) \n"); 
		
		print("e.g. perl cat_velan_par 'junk' 'cdp_par_file_list' \n");
			exit(0);	
	}



=head2 DEFINE FLOW(S)
 
=cut

  
=head2 RUN FLOW(S)

=cut


=head2

 read a list of file names

=cut 

 ($ref_file_names,$numberOfFiles) = manage_files_by::read_1col(\$par_file_list);

=pod testing

  print(" number of files is $numberOfFiles\n");
  for (my $i=1; $i<=$numberOfFiles;$i++) {
       print("\n file $i is $$ref_file_names[$i]");
       print("\n file $i is $$ref_file_names[$i]");
   }

 print(" number of files is $numberOfFiles\n");
	for (my $i=1; $i<=$numberOfFiles;$i++) {

		 print("\n file $i is $PL_SEISMIC/ivpicks_sorted_par_$data_in[1]_cdp$$ref_file_names[$i]\n");
   	}

=cut

=head2
 
 read contents of each file in the list
 into arrays
 each line of the list is a cdp number as well as an 
 indicator of what file the velocity picks are in

=cut

 my $line=1;

 for ($file_number=1; $file_number <=$numberOfFiles;$file_number++) {

      $par_file          		= $$ref_file_names[$file_number];
      $cdp[$file_number]		= $$ref_file_names[$file_number];
      $par_file					= $PL_SEISMIC.'/'.$ivpicks_sorted_par_.$data_in[1].$_cdp.$par_file;
      #$par_file				= $PL_SEISMIC.'/'.$itop_mute_par_.$data_in[1].$binheader_type.$par_file;
      ($ref_values,$ref_numberOfValues) = manage_files_by::read_velan_par(\$par_file);


=pod testing

      $row = scalar @$ref_numberOfValues;
      print(" \nfor file $par_file\n");
      print(" \nfor file #$file_number, number of rows is $row\n");
      for (my $i=0; $i<$row;$i++) {
          print("\n row $i contains $$ref_values[$i]");
          print(" i.e., $$ref_numberOfValues[$i] values\n");
      }

=cut

=head2
 
 place contents of each file in the list
 into an array

 	print("$output[$line]\n\n");

=cut
      $row = scalar @$ref_numberOfValues;

      for (my $i=0; $i<$row;$i++,$line++) {
        $output[$line] =  $$ref_values[$i];
      }
  }


=head2
 
 write output to a file 


 testing
         print("\ncdp=");
          print("$cdp[1]");
      for (my $i=2; $i<$file_number;$i++) {
          print(",$cdp[$i]");
      }
          print("\n");

      for (my $i=1; $i<$line;$i=$i+2) {
          print("tnmo=$output[$i]\n");
          print("vnmo=$output[($i+1)]\n");
      }
     

=cut

   manage_files_by::write_velan_par(\@cdp,\@output,\$outbound[1]); 
   print("writing $outbound[1]\n");
# $run->flow(\$flow[1]);
# 
#=head2 LOG FLOW(S)
#
# TO SCREEN AND FILE
#
#=cut
#
## print  "$flow[1]\n";
##$log->file($flow[1]);
##
