#! /usr/bin/perl
#
use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

  PROGRAM NAME: single file sumute in a loop.
  AUTHOR: Daniel Locci Lopez
  DATE: 
  DESCRIPTION:  
  Mute single gather using parfile, and uses a loop for x number of gathers with their respective parfiless.

  Version 1 December 5, 2019 (for muting surface waves).
  
  NOTES: 
  Pick x,t values in single a gather to mute surface waves and save in a parfile, then use susplit to sepate gathers into ep, and use sumute_single_ep.pl.
  
  e.g:
  susplit < test.su > test_ep.su key=ep numlength=1
   

  
=head3  Steps are as follows:
  

=cut

=pod

  1. Use packages:

     (for subroutines) 
     manage_files_by 
     System_Variables (for subroutines)

     (for variable definitions)
     SeismicUnix (Seismic Unix modules)

     Use classes:
     flow
     message
     suximage

=cut

=pod

LOAD GENERAL PERL LIBRARIES

=cut
	use Moose;
	use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su);
	use Project_config;

	my $Project 		= new Project_config();

	my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU;

	use sumute;
	use message;
	use flow;


=pod

 import system variables

=cut



=pod

  2. Instantiate classes 
     and declare variables

=cut

 my $sumute		= new sumute();
 my $log		= new message();
 my $run    	= new flow();


 my (@su_inbound, @su_outbound);
 my (@parfilename,@suwind_neg_outbound);
 my (@items,@flow);
 my (@ref_to_items);
 my (@suop, @suwind, @log,@run);
 my ($i);
 my (@sumute);



=head3

Set first file, last file


=cut


  my $first_file 				= 1;
  my $last_file  				= 60;
  my $input_parfilename     = 'itop_mute_par_test_ep';

for ($i=$first_file; $i<=$last_file;$i++) {
  $su_inbound[$i]  		= $DATA_SEISMIC_SU.'/'.'split_ep'.$i.'.su';
  $su_outbound[$i]  	= $DATA_SEISMIC_SU.'/'.'split_ep'.$i.'_muted'.'.su';
  
  $parfilename[$i]  	= $input_parfilename.$i;
  
  #printf("file_name_list=$parfilename[$i] \n");
  	

=head3


=cut

$sumute 	 	->clear();
$sumute 	 	->header_word(quotemeta('tracl'));
$sumute 	    ->par_directory(quotemeta('PL_SEISMIC'));
$sumute 	 	->par_file(quotemeta($parfilename[$i]));
$sumute [1]  	= $sumute ->Step();


=pod



=cut



 $ref_to_items[$i]   = [$sumute[1],
 						$in,$su_inbound[$i],
 						$out,$su_outbound[$i] ];
 print(" $ref_to_items[$i]\n");
 $flow[$i][1]        =  $run ->modules($ref_to_items[$i]);




=pod

=head4  RUN FLOW(S)

=cut


 $run->flow(\$flow[$i][1]);

     
=pod

=head4  LOG FLOW(S)TO SCREEN AND FILE

=cut


  print $flow[$i][1]."\n\n";
  #$log->file($flow[$i][1]);


}

