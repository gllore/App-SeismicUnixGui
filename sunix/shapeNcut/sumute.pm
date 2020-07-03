package sumute;

=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUMUTE - MUTE above (or below) a user-defined polygonal curve with	", 
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUMUTE - MUTE above (or below) a user-defined polygonal curve with	", 
	   the distance along the curve specified by key header word 	

 sumute <stdin >stdout xmute= tmute= [optional parameters]		

 Required parameters:							
 xmute=		array of position values as specified by	
 			the `key' parameter				
 tmute=		array of corresponding time values (sec)	
 			in case of air wave muting, correspond to 	
 			air blast duration				#
  ... or input via files:						
 nmute=		number of x,t values defining mute		
 xfile=		file containing position values as specified by	
 			the `key' parameter				
 tfile=		file containing corresponding time values (sec)	
  ... or via header:							
 hmute=		key header word specifying mute time		

 Optional parameters:							
 key=offset		Key header word specifying trace offset 	
 				=tracl  use trace number instead	
 ntaper=0		number of points to taper before hard		
			mute (sine squared taper)			
 mode=0	   mute ABOVE the polygonal curve			
		=1 to zero BELOW the polygonal curve			
		=2 to mute below AND above a straight line. In this case
		 	xmute,tmute describe the total time length of   
			the muted zone as a function of xmute the slope 
			of the line is given by the velocity linvel=	
	 	=3 to mute below AND above a constant velocity hyperbola
			as in mode=2		use suputgthr; xmute,tmute describe the total time
			length of the mute zone as a function of xmute,  
			the velocity is given by the value of linvel=	
 		=4 to mute below AND above a user defined polygonal line
			given by xmute, tmute pairs. The widths in time ", 
			of the muted zone are given by the twindow vector
 linvel=330   		constant velocity for linear or hyperbolic mute	
 tm0=0   		time shift of linear or hyperbolic mute at	
			 \'key\'=0					
 twindow=	vector of mute zone widths in time, operative only in mode=4
  ... or input via file:						
 twfile= 								

 Notes: 								
 The tmute interpolant is extrapolated to the left by the smallest time
 sample on the trace and to the right by the last value given in the	
 tmute array.								

 The files tfile and xfile are files of binary (C-style) floats.	

 In the context of this program "above" means earlier time and	
 "below" means later time (above and below as seen on a seismic section.

 The mode=2 option is intended for removing air waves. The mute is	
 is over a narrow window above and below the line specified by the	
 the line specified by the velocity "linvel". Here the values of     
 tmute, xmute or tfile and xfile define the total time width of the mute.

 If data are spatial, such as the (z-x) output of a migration, then    
 depth values are used in place of times in tmute and tfile. The value 
 of the depth sampling interval is given by the d1 header field	
 You must use the option key=tracl in sumute in this case.		

 Caveat: if data are seismic time sections, then tr.dt must be set. If 
 data are seismic depth sections, then tr.trid must be set to the value
 of TRID_DEPTH and the tr.d1 header field must be set.			
 To find the value of TRID_DEPTH:  					
 type: 								
     sukeyword trid							
	and look for the entry for "Depth-Range (z-x) traces


 Credits:

	SEP: Shuki Ronen
	CWP: Jack K. Cohen, Dave Hale, John Stockwell
	DELPHI: Alexander Koek added airwave mute.
      CWP: John Stockwell added modes 3 and 4
	USBG: Florian Bleibinhaus added hmute + some range checks on mute times
 Trace header fields accessed: ns, dt, delrt, key=keyword, trid, d1
 Trace header fields modified: muts or mute

=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';

use L_SU_global_constants();
use SeismicUnix qw($itop_mute_par_ $ibot_mute_par_);
use Project_config;

my $get     = new L_SU_global_constants();
my $Project = new Project_config;

my $var          = $get->var();
my $empty_string = $var->{_empty_string};
my ($imute_par_);
my ( @tmute, @xmute, @output, @Steps, @gather_number, @par_file );
my $PL_SEISMIC      = $Project->PL_SEISMIC();
my $DATA_SEISMIC_SU = $Project->DATA_SEISMIC_SU();

use SeismicUnix
	qw ($in $out $on $go $to $tmute $xmute $suffix_ascii $off $suffix_su $suffix_bin $temp_single_gather_par_file_mute );

my $sumute = {
	_par_gather_number_aref => '',
	_gather_type            => '',
	_hmute                  => '',
	_key                    => '',
	_linvel                 => '',
	_multi_gather_par_file  => '',
	_multi_gather_su_file   => '',
	_mode                   => '',
	_nmute                  => '',
	_ntaper                 => '',
	_par                    => '',
	_par_directory          => $PL_SEISMIC,
	_susplit_stem           => '.split_',
	_tfile                  => '',
	_tm0                    => '',
	_tmute                  => '',
	_twindow                => '',
	_xfile                  => '',
	_xmute                  => '',
	_Step                   => '',
	_note                   => '',
};

=head2 sub _get_par_sets

=cut

sub _get_par_sets {

	my (@self) = @_;

	if (    $sumute->{_multi_gather_par_file} ne $empty_string
		and $sumute->{_gather_type} ne $empty_string ) {

		use manage_files_by2;
		use control;

=head2 instantiate classes

=cut

		my $files   = new manage_files_by2();
		my $control = new control;

=head2 private definitions

=cut

		my ( @time_picks_aref2, @x_picks_aref2 );
		my @par_gather;
		my $multi_par_file_in;
		my $row = 0;
		my $inbound;
		my @time_picks_aref;
		my $par_gather_number;
		my $par_gather_count;

		$multi_par_file_in = $sumute->{_multi_gather_par_file};
		$inbound           = $PL_SEISMIC . '/' . $multi_par_file_in;

		# print("sumute,_get_par_sets, inbound=$inbound\n");

=head2 read i/p file

=cut

		$control->set_back_slashBgone($inbound);
		$inbound = $control->get_back_slashBgone();

		# open multi-gather_par_file
		my $ref_file_name = \$inbound;
		my ( $items_aref2, $numberOfItems_aref ) = $files->read_par($ref_file_name);

		# 'first array member is gather name
		# ,e.g. 'cdp' or just 'gather'
		# and a list of par_gather numbers
		@par_gather = @{ @{$items_aref2}[0] };
		my $gather_type = $par_gather[0];

=head2 capture errors

=cut

		if (   $gather_type ne $empty_string
			&& $gather_type eq $sumute->{_gather_type} ) {

			# print("sumute, _get_par_sets, gather type=$gather_type and $sumute->{_gather_type}\n");
			# print("sumute, _get_par_sets, gather type OK\n");

		} else {
			print("sumute, _get_par_sets, gather type missing in 1-to-2 places\n");
			print("sumute, _get_par_sets, gather=--$gather_type-- and --$sumute->{_gather_type}--\n");
		}

=head2 share values with namespace
Use splice to remove the first element (index =0)
which is not a number but a gather type of 
gather name, e.g. cdp or ep or gather

=cut

		my $number_of_par_gathers = ( scalar @par_gather ) - 1;
		my $last_par_index        = ( scalar @par_gather ) - 1;
		my @number_of_picks       = @$numberOfItems_aref;

		# print("sumute, _get_par_sets,last_par_index=$last_par_index\n");
		# print("sumute, _get_par_sets,number_of_par_gathers=$number_of_par_gathers\n");
		# print("sumute, _get_par_sets,old par_gather=@par_gather\n");

		my @new_par_gather = @par_gather[ 1 .. $last_par_index ];
		$sumute->{_par_gather_number_aref} = \@new_par_gather;

		# print("sumute, _get_par_sets,new_par_gather=@new_par_gather\n");
		# print("sumute, _get_par_sets,gather_type=$gather_type\n");
		# print("sumute, _get_par_sets,number_of_gathers=$number_of_par_gathers\n");

=head2 collect tmute and xmute
for each gather 

=cut

		for (
			my $par_gather_count = 1, my $i = 0;
			$par_gather_count <= $number_of_par_gathers;
			$par_gather_count++, $i++
		) {

			# print("sumute,_get_par_sets, par_gather_count: $par_gather_count\n");
			$par_gather_number = $par_gather[$par_gather_count];

			# print("sumute,_get_par_sets, par_gather_number: $par_gather_number\n");
			$row = ( $par_gather_count * 2 ) - 1;

			# print("sumute,_get_par_sets, row: $row\n");

			my $last_sample_index = scalar @{ @{$items_aref2}[ ( $row + 1 ) ] } - 1;

			my @new_x_picks = @{ @{$items_aref2}[ ( $row + 1 ) ] }[ 1 .. $last_sample_index ];

			# print("sumute,_get_par_sets, new_x_picks:@new_x_picks,last_sample_index:$last_sample_index\n");
			$x_picks_aref2[$i] = \@new_x_picks;

			my @new_time_picks = @{ @{$items_aref2}[ ($row) ] }[ 1 .. $last_sample_index ];

			# print("sumute,_get_par_sets, new_time_picks:@new_time_picks,last_sample_index:$last_sample_index\n");
			$time_picks_aref2[$i] = \@new_time_picks;

		}    # no. gathers with parameter sets

		# remove fist item of the time and x picks which,
		# when read from the multu-par_file is actually
		# a string linke tmute or xmute
		# Actual first = 'tmute' and 'xmute'-- not numbers
		# last 2 returns are string arrays

		return ( \@time_picks_aref2, \@x_picks_aref2, $tmute, $xmute );

	} else {
		print(
			"sumute,_get_par_sets, missing multi_gather_par_file or
		missing definition of gather type\n"
		);
		return ();
	}

}

=head2 sub Step

	Keeps track of actions for execution in the system
collects switches and assembles bash instructions
by adding the program name

If there is a multi-gather parameter file involved
Daniel Locci, March 2020:
  NOTES: 
  Pick x,t values in single a gather to mute surface waves and save in a 
  parfile, then use susplit to sepate gathers into ep, and use sumute_single_ep.pl. 
  e.g:
  susplit < test.su > test_ep.su key=ep numlength=1


=cut

sub Step {
	my ($self) = @_;

	my $result;

=head2 CASE 

with multi_gather_su_file

=cut

	if (   $sumute->{_multi_gather_par_file} ne $empty_string
		&& $sumute->{_multi_gather_su_file} ne $empty_string
		&& $sumute->{_par_gather_number_aref} ne $empty_string
		&& $sumute->{_gather_type} ne $empty_string ) {

=head2 local definitions

=cut			

		my $file_in   = $sumute->{_multi_gather_su_file};
		my $sufile_in = $file_in . $suffix_su;
		my $inbound   = $DATA_SEISMIC_SU . '/' . $sufile_in;

		# print("sumute,Step, inbound = $inbound\n");

=head2 get modules

=cut

		use susplit;
		use flow;
		use control;

=head2 instantiate modules

=cut	

		my $susplit = susplit->new();
		my $run     = new flow();
		my $control = control->new();

=head2 declare local variables

=cut

		my @susplit;
		my @flow;
		my @split_file_matches;
		my @muted_output;
		my $number_of_split_files = 0;
		my ( @time_picks_aref2, @x_picks_aref2 );
		my ( $time_picks_aref2, $x_picks_aref2, $first_name, $second_name );

=head2 Set up
			#
	susplit parameter values

=cut

		$susplit->clear();
		$susplit->key( $sumute->{_gather_type} );
		$susplit->stem( $sumute->{_susplit_stem} );
		$susplit->suffix($suffix_su);
		$susplit[0] = $susplit->Step();

		# print("1. sumute, Step, susplit= $susplit[0] \n");

=head2 clear past temporary, past
single-gather split from composite su file

=cut

		my $delete_files = '.split_' . '*';
		system("rm -rf $delete_files");
		#

=head2 DEFINE 
Collect FLOW(s)
Run flow in system independently of sumute 


=cut

		my @items = (
			$susplit[0],
			$in,
			$inbound
		);
		$flow[0] = $run->modules( \@items );

=head2 RUN FLOW(s)
			#

=cut

		$run->flow( \$flow[0] );

=head2 LOG FLOW(s)

        to screen

=cut

		# print $flow[0];

=head2 collect output split file names from the PL_SEISMIC directory

=cut

		opendir( my $dh, $PL_SEISMIC, );
		my @split_file_names = grep( /.split_/, readdir($dh) );
		closedir($dh);

		$number_of_split_files = scalar @split_file_names;

		# print("2. sumute,Step,list length = $number_of_split_files\n");
		# print("2. sumute,Step,list[0] $split_file_names[0]\n");
		# print("2. sumute,Step,list[1] $split_file_names[1]\n");
		# print("2. sumute,Step,split_files = @split_file_names\n");

=head2 prepare sumute with split files

=cut

=head2 local error check

=cut

		my $number_of_par_sets = scalar @{ $sumute->{_par_gather_number_aref} };

		if ( $number_of_split_files ne $number_of_par_sets ) {

			print("\n sumute, Step,N.B.:    # of split files (= $number_of_split_files)\n");
			print(" may not equal         # of par files   (= $number_of_par_sets) \n");

		} elsif ( $sumute->{_multi_gather_par_file} eq $empty_string
			&& $sumute->{_multi_gather_su_file} eq $empty_string ) {

			print(" sumute,Step, case2 \n");
			$result = 'sumute' . $sumute->{_Step};
			return ($result);

		} else {

			# NADA
		}

=head2 get the temporary single-gather parameter files
match parameter file to correct split data file

=cut

		( $time_picks_aref2, $x_picks_aref2, $first_name, $second_name ) = _get_par_sets();

		my @par_gather_number = @{ $sumute->{_par_gather_number_aref} };

		if ( $number_of_split_files >= 0 ) {

			for ( my $i = 0; $i < $number_of_par_sets; $i++ ) {

				# match on par file gather number
				my $par_gather_number = '0' . $par_gather_number[$i].$suffix_su;
				
				my @matches           = grep {/$par_gather_number/} @split_file_names;
				# print("2 sumute,Step,gather_number= $par_gather_number[$i]\n");
				# print("2 sumute,Step,matches = @matches\n");
				my $length = scalar @matches ;
				# print("2 sumute,Step,mo. matches = $length\n");
				
=head2  error check
get match to an 
existing split files

=cut

				if ( $length > 1 ) {

					# print("sumute,Step,match error Only one file SHOULD exist\n");
					# print("sumute,Step,But matches= @matches\n");

				} elsif ( ( scalar @matches ) == 1 ) {

					$split_file_matches[$i] = $matches[0];

					# print("sumute,Step,split_file_matches[$i]=$split_file_matches[$i]\n");

				} elsif ( ( scalar @matches ) == 0 ) {

					print("sumute,Step,match error At least one file SHOULD exist\n");

				} else {
					print("sumute,Step,error check\n");
				}

			}    # for all parameter sets

		}    # if split files exist

=head2 First case
i=0

=cut

		my $number_of_split_file_matches = scalar @split_file_matches;

		if ( $number_of_split_file_matches > 0 ) {

			$muted_output[0] = $split_file_matches[0];
			$muted_output[0] =~ s/.su//;
			$muted_output[0] = $PL_SEISMIC . '/' . $muted_output[0] . '_mute' . $suffix_su;

			my @time_picks = @{ @{$time_picks_aref2}[0] };
			my @x_picks    = @{ @{$x_picks_aref2}[0] };

			my $time_picks_w_commas = $control->commify( \@time_picks );
			my $x_picks_w_commas    = $control->commify( \@x_picks );

 			# print("2 sumute,Step,time_picks_aref2[0]=@time_picks\n");
 			# print("sumute,Step,muted_output: $muted_output[0], case 0 \n");
 			# print("sumute,Step,split_file_match: $split_file_matches[0], case 0 \n");
 			# print("1 sumute,Step,time_picks_aref2[0]=@{@{$time_picks_aref2}[0]}\n");
 			# print("1 sumute,Step,x_picks_w_commas=$x_picks_w_commas\n");
  			# print("1 sumute,Step,time_picks_w_commas=$time_picks_w_commas\n");

			$result
				= ' sumute'
				. $in
				. $PL_SEISMIC . '/'
				. $split_file_matches[0]
				. $out
				. $muted_output[0]
				. $sumute->{_Step}
				. ' tmute='
				. $time_picks_w_commas
				. ' xmute='
				. $x_picks_w_commas . "\n";

 			# print("A sumute,Step,result so far \n$result\n");

=head2 intermediate muting cases

=cut

			for ( my $i = 1; $i < ( $number_of_par_sets - 1 ); $i++ ) {

				$muted_output[$i] = $split_file_matches[$i];

	 			# print("2 sumute,Step,muted_output: $muted_output[$i] case i=$i\n");
				$muted_output[$i] =~ s/.su//;
				$muted_output[$i] = $PL_SEISMIC . '/' . $muted_output[$i] . '_mute' . $suffix_su;

				my @time_picks = @{ @{$time_picks_aref2}[$i] };
				my @x_picks    = @{ @{$x_picks_aref2}[$i] };

				my $time_picks_w_commas = $control->commify( \@time_picks );
				my $x_picks_w_commas    = $control->commify( \@x_picks );

				$result
					= $result
					. ' sumute'
					. $in
					. $PL_SEISMIC . '/'
					. $split_file_matches[$i]
					. $out
					. $muted_output[$i]
					. $sumute->{_Step}
					. ' tmute='
					. $time_picks_w_commas
					. ' xmute='
					. $x_picks_w_commas . "\n";

			}    # for all parameter sets

=head2 last case

=cut

			my $last_case = $number_of_par_sets - 1;

			$muted_output[$last_case] = $split_file_matches[$last_case];

 			# print("2 sumute,Step,muted_output: $muted_output[$last_case] case i=$last_case\n");
			$muted_output[$last_case] =~ s/.su//;
			$muted_output[$last_case] = $PL_SEISMIC . '/' . $muted_output[$last_case] . '_mute' . $suffix_su;

			@time_picks = @{ @{$time_picks_aref2}[$last_case] };
			@x_picks    = @{ @{$x_picks_aref2}[$last_case] };

			$time_picks_w_commas = $control->commify( \@time_picks );
			$x_picks_w_commas    = $control->commify( \@x_picks );

			$result
				= $result
				. ' sumute'
				. $in
				. $PL_SEISMIC . '/'
				. $split_file_matches[$last_case]
				. $out
				. $muted_output[$last_case]
				. $sumute->{_Step}
				. ' tmute='
				. $time_picks_w_commas
				. ' xmute='
				. $x_picks_w_commas
				."\n";

 			# print("2 sumute,Step,result for everything\n$result\n");

=head2  concatenate muted results
create concatenated output file name

=cut

			my $string = $sumute->{_multi_gather_su_file};
			$string =~ s/.su//;
			my $outbound_concatenated_mute_file = $DATA_SEISMIC_SU.'/'.$string . '_mute' . $suffix_su;
 			# print(" sumute,Step, concatenated_mute_file: $outbound_concatenated_mute_file \n");

=head2 cat first case
	and then the rest in a loop

=cut

			$result = $result . 'cat' . ' ' . $muted_output[0] . ' ';

			for ( my $i = 1; $i < $number_of_par_sets; $i++ ) {

				$result = $result . $muted_output[$i] . ' ';

			}

=head2 finish concatenation

=cut

#			$result = $result 
#				. $out 
#				. $outbound_concatenated_mute_file;
			# print("4. sumute,Step,result=$result \n");
			return ($result);

		} else {
			print("sumute,Step,unexpected number_of_split_file_matches \n");
			return ();
		}    # split_file matches exist

	} elsif ( $sumute->{_multi_gather_par_file} eq $empty_string
		&& $sumute->{_multi_gather_su_file} eq $empty_string ) {

		# print(" sumute,Step, case2 \n");
		$result = 'sumute' . $sumute->{_Step};
		return ($result);

	} else {
		print(" sumute, Step, unexpected value\n");
		print(" sumute, Step,multi_gather_par_file=$sumute->{_multi_gather_par_file} \n");
		print(" sumute, Step,multi_gather_su_file=$sumute->{_multi_gather_su_file} \n");
		print(" sumute, Step,par_gather_number_aref=$sumute->{_par_gather_number_aref} \n");
		print(" sumute, Step,gather_type=$sumute->{_gather_type} \n");
		return ();

	}    # sub pre-conditions

	print("sumute,Step,result=$result \n");

}

=head2 Subroutine Steps

       Keeps track of actions for execution in the system
       when more that one gather is being processed in the flow
       at a time
       Place contents of each line of the mute tables (t and index) 
       array into either a tmute or an xmute array for each file

 print("$output[$line]\n\n");
 print ("tmute is $sumute->{_tmute}\n\n");
 print ("$sumute->{_Steps}\n\n");
            #print (" sub Steps shows: $sumute->{_Steps_array}[$i]\n\n");

=cut

sub Steps {

	# use Project_config;
	# my $Project = new Project_config();
	use SeismicUnix qw ($in $out $to $suffix_su);
	use flow;

	my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
	my $run = new flow();
	my ( @items, @outbound );

	for ( my $i = 1; $i <= $sumute->{_number_of_par_files}; $i++ ) {
		tmute( $sumute->{_tmute_array}[$i] );
		xmute( $sumute->{_xmute_array}[$i] );

		$outbound[$i]
			= $DATA_SEISMIC_SU . '/'
			. $sumute->{_file_in} . '_'
			. $sumute->{_gather_type}
			. $sumute->{_gather_number_array}[$i]
			. $suffix_su;

		@items = (
				  'suwind key='
				. $sumute->{_gather_type} . ' min='
				. $sumute->{_gather_number_array}[$i] . ' max='
				. $sumute->{_gather_number_array}[$i],
			$in,  $DATA_SEISMIC_SU . '/' . $sumute->{_file_in} . $suffix_su,
			$to,  ' sumute ' . $sumute->{_Steps},
			$out, $outbound[$i]
		);

		$sumute->{_Steps_array}[$i] = $run->modules( \@items );

		print(" sub Steps shows: $sumute->{_Steps_array}[$i]\n\n");

	}    # for many parameter files

	return (
		$sumute->{_Steps_array},
		$sumute->{_number_of_par_files},
		$sumute->{_gather_number_array}, \@outbound
	);
}

=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

sub note {

	$sumute->{_note} = 'sumute' . $sumute->{_note};
	return ( $sumute->{_note} );

}

=head2 sub clear

=cut

sub clear {
	$sumute->{_par_gather_number_aref} = '';
	$sumute->{_gather_type}            = '';
	$sumute->{_hmute}                  = '';
	$sumute->{_key}                    = '';
	$sumute->{_linvel}                 = '';
	$sumute->{_mode}                   = '';
	$sumute->{_multi_gather_par_file}  = '';
	$sumute->{_multi_gather_su_file}   = '';
	$sumute->{_nmute}                  = '';
	$sumute->{_ntaper}                 = '';
	$sumute->{_par}                    = '',
	$sumute->{_susplit_stem}			= '.split_',      # maintain, do not clear
	$sumute->{_par_directory}			= $PL_SEISMIC,    # maintain,do not clear
	$sumute->{_tfile}					= '';
	$sumute->{_tm0}     = '';
	$sumute->{_tmute}   = '';
	$sumute->{_twindow} = '';
	$sumute->{_xfile}   = '';
	$sumute->{_xmute}   = '';
	$sumute->{_Step}    = '';
	$sumute->{_note}    = '';
}

=head2 sub gather_type 
for example can be ep cdp 
and refers to the types of gathers that
are being muted

=cut

sub gather_type {

	my ( $self, $gather_type ) = @_;
	if ( $gather_type ne $empty_string ) {

		$sumute->{_gather_type} = $gather_type;

	} else {
		print("sumute, gather_type, missing gather_type,\n");
	}
}

=head2 sub header_word


=cut

sub header_word {

	my ( $self, $key ) = @_;
	if ( $key ne $empty_string ) {

		$sumute->{_key}  = $key;
		$sumute->{_note} = $sumute->{_note} . ' key=' . $sumute->{_key};
		$sumute->{_Step} = $sumute->{_Step} . ' key=' . $sumute->{_key};

	} else {
		print("sumute, header_word, missing key,\n");
	}
}

=head2 sub header_word


=cut

sub headerword {

	my ( $self, $key ) = @_;
	if ( $key ne $empty_string ) {

		$sumute->{_key}  = $key;
		$sumute->{_note} = $sumute->{_note} . ' key=' . $sumute->{_key};
		$sumute->{_Step} = $sumute->{_Step} . ' key=' . $sumute->{_key};

	} else {
		print("sumute, headerword, missing key,\n");
	}
}

=head2 sub hmute 


=cut

sub hmute {

	my ( $self, $hmute ) = @_;
	if ( $hmute ne $empty_string ) {

		$sumute->{_hmute} = $hmute;
		$sumute->{_note}  = $sumute->{_note} . ' hmute=' . $sumute->{_hmute};
		$sumute->{_Step}  = $sumute->{_Step} . ' hmute=' . $sumute->{_hmute};

	} else {
		print("sumute, hmute, missing hmute,\n");
	}
}

=head2 sub key 


=cut

sub key {

	my ( $self, $key ) = @_;
	if ( $key ne $empty_string ) {

		$sumute->{_key}  = $key;
		$sumute->{_note} = $sumute->{_note} . ' key=' . $sumute->{_key};
		$sumute->{_Step} = $sumute->{_Step} . ' key=' . $sumute->{_key};

	} else {
		print("sumute, key, missing key,\n");
	}
}

=head2 sub linvel 

	The constant velocity used for linear or hyperbolic mutes

=cut

sub linvel {

	my ( $self, $linvel ) = @_;
	if ( $linvel ne $empty_string ) {

		$sumute->{_linvel} = $linvel;
		$sumute->{_note}   = $sumute->{_note} . ' linvel=' . $sumute->{_linvel};
		$sumute->{_Step}   = $sumute->{_Step} . ' linvel=' . $sumute->{_linvel};

	} else {
		print("sumute, linvel, missing linvel,\n");
	}
}

#=head2 Subroutine list
# deprecated in version L_SU 0.4.0
# March 2020 JML
#
# list of gather numbers to mute
# There must be accompanying mute parameters in
# additional files that correspond to each of the
# shotgather (ep), cdp gather etc. numbers inside the list
# for example,
#   "1" should correspond to something like:
#   "11" should correspond to something like:
#
# itop_mute_par_suFileName_binheaderType1
# itop_mute_par_suFileName_binheaderType11
#
# e.g., itop_mute_par_All_cmp_ep11
#
# Usage 1:
#To mute an array of shotpoint gathers (numbers in list)
#  and su file name to which mute is applied
#  sufile does NOT have a ".su" extension.
#
#Example:
#       $sumute->list('top_mute_list',\$file_in[1],\$binheader[1]);
#        file_in is the sunix file
#        binheader is either offset,tracl  etc.
#        whereas the gather type is either cdp, ep etc.
#
#=cut
#
#sub list {
#	my ( $sub, $list, $ref_file_in, $ref_gather_type ) = @_;
#
#=head2 Error
#
#     Messages
#
#=cut
#
#	if ( defined($list) ) {
#
#		$sumute->{_list} = $list;
#		$sumute->{_note} = $sumute->{_note} . ' list=' . $sumute->{_list};
#
#	} else {
#		print(" Error: list name is missing in subroutine list");
#
#	}
#
#	if ($ref_file_in) {
#		$sumute->{_file_in} = $$ref_file_in;
#
#print("file is $sumute->{_file_in}\n\n");
#	} else {
#		print(" Error: su file is missing in subroutine list");
#
#	}
#	if ($ref_gather_type) {
#		$sumute->{_gather_type} = $$ref_gather_type;
#
#print("gather_type is $sumute->{_gather_type}\n\n");
#	} else {
#		print(" Error: gather type is missing in subroutine list");
#
#	}
#
#=head2 Insert package
#
# into namespace
#
#=cut
#
#	use manage_files_by;
#	use Project_config;
#	my $Project = new Project_config();
#
#=head2 Load
#
# variables into local namespace
#
#=cut
#
#	my ($numberOfFiles);
#	my ( $ref_file_names, $i );
#	my ( $file_number, $ref_values, $ref_numberOfValues );
#	my (@sufile_in);
#
#=head2 read a list
#
# of file names
#
# testing
#
#  print(" number of files is $numberOfFiles\n");
#  for (my $i=1; $i<=$numberOfFiles;$i++) {
#       print("\n file $i is $$ref_file_names[$i]");
#   }
#
#=cut
#
#	( $ref_file_names, $numberOfFiles )
#		= manage_files_by::read_1col( \$sumute->{_list} );
#
#	if ($numberOfFiles) {
#		$sumute->{_number_of_par_files} = $numberOfFiles;
#	}
#
#=head2
#
# read contents of each file in the list
# into arrays
# each line of the list is a gather number and
# indicates in which file the mute picks are found
#
# testing
#
#      $row = scalar @$ref_numberOfValues;
#      print(" \nfor file #$file_number, number of rows is $row\n");
#          print("par file is $par_file\n\n");
#      for (my $i=0; $i<$row;$i++) {
#          print("\n row $i contains $$ref_values[$i]");
#          print(" i.e., $$ref_numberOfValues[$i] values\n");
#          }
#
# line=2 is needed to skip the  first two lines
# i.e. tnmo= vnmo=
# first initializaed as 1 and then incremented
#
#=cut
#
#	for ( $file_number = 1; $file_number <= $sumute->{_number_of_par_files}; $file_number++ ) {
#
#		$sumute->{_gather_number_array}[$file_number] = $$ref_file_names[$file_number];
#		$sumute->{_par_file_array}[$file_number]
#			= $PL_SEISMIC . '/'
#			. $imute_par_
#			. $sumute->{_file_in} . '_'
#			. $sumute->{_gather_type}
#			. $sumute->{_gather_number_array}[$file_number];
#		( $ref_values, $ref_numberOfValues ) = manage_files_by::read_par( \$sumute->{_par_file_array}[$file_number] );
#
#		my $row = scalar @$ref_numberOfValues;
#		print(" \nfor file #$file_number, number of rows is $row\n");
#		print("par file is $sumute->{_par_file_array}[$file_number]\n\n");
#		for ( my $i = 0; $i < $row; $i++ ) {
#			print("\n row $i contains $$ref_values[$i]");
#			print(" i.e., $$ref_numberOfValues[$i] values\n");
#		}
#
#=head2
#
# place contents of each file in the list
# into an array
# @output is an array referenced within the hash of this namespace
#
# testing
#
# print("for i=0 output is $sumute->{_output}[0]\n\n");
# print("for i=$i tmute is $sumute->{_output}[$i]\n\n");
# print("for i=0 output is $$ref_values[0]\n\n");
# print("for i=1 output is $$ref_values[(0+1)]\n\n");
#
#          $sumute->{_output}[$i] =  $$ref_values[$i];
#          print("for file=$file_number tmute is $sumute->{_tmute_array}[$file_number]\n\n");
#          print("for file=$file_number xmute is $sumute->{_xmute_array}[$file_number]\n\n");
#=cut
#
#		$sumute->{_row} = scalar @$ref_numberOfValues;
#		for ( $i = 0; $i < $sumute->{_row}; $i = $i + 2 ) {
#			$sumute->{_tmute_array}[$file_number] = $$ref_values[$i];
#			$sumute->{_xmute_array}[$file_number] = $$ref_values[ ( $i + 1 ) ];
#		}
#	}    # end of reading par files
#
#=head2
#
#   Create sets a  mute flow for each T-X pick file ("par" file)
#          print("for i=$i,and line=$line tmute is $sumute->{_tmute_array}[$line]\n\n");
#          print("for i=$i,and line=$line xmute is $sumute->{_xmute_array}[$line]\n\n");
#
#
#=cut
#
#}    # end of sub list

=head2 sub mode 

	Defines how the mute window is picked

=cut

sub mode {

	my ( $self, $mode ) = @_;
	if ( $mode ne $empty_string ) {

		$sumute->{_mode} = $mode;
		$sumute->{_note} = $sumute->{_note} . ' mode=' . $sumute->{_mode};
		$sumute->{_Step} = $sumute->{_Step} . ' mode=' . $sumute->{_mode};

	} else {
		print("sumute, mode, missing mode,\n");
	}
}

=head2 sub multi_gather_par_file

sumute can only handle one
set of mute picks per file
so a multi-gather file has to be
split.
A multi-gather par file for muting
assembles these picks into one file
using the same format as sunmo
par files.
However, currently sumute can not
read multi-gather-par files.
The user is unaware in L_SU GUI.

multi-gather_par_files are 
written like sunmo files with cdp numbers on the first line
and tnmo and vnmo alternating on successive lines

=cut

sub multi_gather_par_file {

	my ( $self, $multi_gather_par_file ) = @_;

	if ( $multi_gather_par_file ne $empty_string ) {

		use manage_files_by2;

=head2 instantiate classes

=cut

		my $files = new manage_files_by2();

=head2 module definitions$sumute->{_par_gather_number_aref}

=cut

		my ( @time_picks_aref2, @x_picks_aref2 );

		$sumute->{_multi_gather_par_file} = $multi_gather_par_file;

		my ( $time_picks_aref2, $x_picks_aref2, $first_name, $second_name ) = _get_par_sets();

		# collect single-gather mute paramters (tmut and xmute3)
		# write tmute and xmute in successive lines

		# run _get_par_sets previously
		my $number_of_gathers = scalar @{ $sumute->{_par_gather_number_aref} };

		# print("sumute,multi_gather_par_file, number_of_gathers=$number_of_gathers\n");

		for ( my $i = 0; $i < $number_of_gathers; $i++ ) {

			my $time_picks_ref = @{$time_picks_aref2}[$i];
			my $x_picks_ref    = @{$x_picks_aref2}[$i];

			# print("sumute,multi_gather_par_file, time_picks=@{$time_picks_ref}\n");
			# print("sumute,multi_gather_par_file, x_picks=@{$x_picks_ref}\n");

		}

	} else {
		print("sumute,multi_gather_par_file, missing mult-gather-par file\n");
		return ();
	}
	return ();
}

=head2 sub multi_gather_su_file 


=cut

sub multi_gather_su_file {

	my ( $self, $multi_gather_su_file ) = @_;
	if ( $multi_gather_su_file ne $empty_string ) {

		$sumute->{_multi_gather_su_file} = $multi_gather_su_file;

		# print("sumute, multi_gather_su_file=$multi_gather_su_file\n");

	} else {
		print("sumute, multi_gather_su_file, missing multi_gather_su_file,\n");
	}
}

=head2 sub nmute 


=cut

sub nmute {

	my ( $self, $nmute ) = @_;
	if ( $nmute ne $empty_string ) {

		$sumute->{_nmute} = $nmute;
		$sumute->{_note}  = $sumute->{_note} . ' nmute=' . $sumute->{_nmute};
		$sumute->{_Step}  = $sumute->{_Step} . ' nmute=' . $sumute->{_nmute};

	} else {
		print("sumute, nmute, missing nmute,\n");
	}
}

=head2 sub ntaper 


=cut

sub ntaper {

	my ( $self, $ntaper ) = @_;
	if ( $ntaper ne $empty_string ) {

		$sumute->{_ntaper} = $ntaper;
		$sumute->{_note}   = $sumute->{_note} . ' ntaper=' . $sumute->{_ntaper};
		$sumute->{_Step}   = $sumute->{_Step} . ' ntaper=' . $sumute->{_ntaper};

	} else {
		print("sumute, ntaper, missing ntaper,\n");
	}
}

=head2 sub par 


=cut

sub par {

	my ( $self, $par ) = @_;
	if ( $par ne $empty_string && $sumute->{_par_directory} ne $empty_string ) {

		$sumute->{_par}  = $par;
		$sumute->{_note} = $sumute->{_note} . ' par=' . $sumute->{_par_directory} . '/' . $sumute->{_par};
		$sumute->{_Step} = $sumute->{_Step} . ' par=' . $sumute->{_par_directory} . '/' . $sumute->{_par};

	} else {
		print("sumute, par, missing par,or par_directory\n");
	}
}

=head2 sub par_directory

 selection of arbitrary
 parfile directory


=cut

sub par_directory {

	my ( $self, $par_directory ) = @_;

	if ( $par_directory ne $empty_string ) {

		if ( $par_directory eq 'PL_SEISMIC' ) {

			$par_directory = $PL_SEISMIC;
			$sumute->{_par_directory} = $par_directory;

		} else {
			print("sumute, par_directory, unexpected par_directory,\n");
		}

	} else {
		print("sumute, par_directory, missing par_directory,\n");
	}
}

=head2 sub par_file 


=cut

sub par_file {

	my ( $self, $par ) = @_;

	if ( $par ne $empty_string && $sumute->{_par_directory} ne $empty_string ) {

		$sumute->{_par}  = $par;
		$sumute->{_note} = $sumute->{_note} . ' par=' . $sumute->{_par_directory} . '/' . $sumute->{_par};
		$sumute->{_Step} = $sumute->{_Step} . ' par=' . $sumute->{_par_directory} . '/' . $sumute->{_par};

	} else {
		print("sumute, par_file, missing par or par_directory,\n");
	}
}

=head2 sub parfile 


=cut

sub parfile {

	my ( $self, $par ) = @_;
	if ( $par ne $empty_string && $sumute->{_par_directory} ne $empty_string ) {

		$sumute->{_par}  = $par;
		$sumute->{_note} = $sumute->{_note} . ' par=' . $sumute->{_par_directory} . '/' . $sumute->{_par};
		$sumute->{_Step} = $sumute->{_Step} . ' par=' . $sumute->{_par_directory} . '/' . $sumute->{_par};

	} else {
		print("sumute, parfile, missing par,or par_directory\n");
	}
}

=head2 sub tfile 


=cut

sub tfile {

	my ( $self, $tfile ) = @_;
	if ( $tfile ne $empty_string ) {

		$sumute->{_tfile} = $tfile;
		$sumute->{_note}  = $sumute->{_note} . ' tfile=' . $sumute->{_tfile};
		$sumute->{_Step}  = $sumute->{_Step} . ' tfile=' . $sumute->{_tfile};

	} else {
		print("sumute, tfile, missing tfile,\n");
	}
}

=head2 sub tm0 


=cut

sub tm0 {

	my ( $self, $tm0 ) = @_;
	if ( $tm0 ne $empty_string ) {

		$sumute->{_tm0}  = $tm0;
		$sumute->{_note} = $sumute->{_note} . ' tm0=' . $sumute->{_tm0};
		$sumute->{_Step} = $sumute->{_Step} . ' tm0=' . $sumute->{_tm0};

	} else {
		print("sumute, tm0, missing tm0,\n");
	}
}

=head2 sub tmute 

	Defines the time (vertical-axis) portion of the window to mute

=cut

sub tmute {

	my ( $self, $tmute ) = @_;
	if ( $tmute ne $empty_string ) {

		$sumute->{_tmute} = $tmute;
		$sumute->{_note}  = $sumute->{_note} . ' tmute=' . $sumute->{_tmute};
		$sumute->{_Step}  = $sumute->{_Step} . ' tmute=' . $sumute->{_tmute};

	} else {
		print("sumute, tmute, missing tmute,\n");
	}
}

=head2 sub twindow 


=cut

sub twindow {

	my ( $self, $twindow ) = @_;
	if ( $twindow ne $empty_string ) {

		$sumute->{_twindow} = $twindow;
		$sumute->{_note}    = $sumute->{_note} . ' twindow=' . $sumute->{_twindow};
		$sumute->{_Step}    = $sumute->{_Step} . ' twindow=' . $sumute->{_twindow};

	} else {
		print("sumute, twindow, missing twindow,\n");
	}
}

=head2 sub type 


=cut

sub type {

	my ( $self, $mode ) = @_;

	if ( $mode ne $empty_string ) {

		if ( $mode eq 'top' ) {
			$mode       = 0;
			$imute_par_ = $itop_mute_par_;

		}

		if ( $mode eq 'bottom' ) {
			$mode       = 1;
			$imute_par_ = $ibot_mute_par_;
		}

		$sumute->{_mode} = $mode;
		$sumute->{_note} = $sumute->{_note} . ' mode=' . $sumute->{_mode};
		$sumute->{_Step} = $sumute->{_Step} . ' mode=' . $sumute->{_mode};

	} else {
		print("sumute, type, missing mode,\n");
	}
}

=head2 sub xfile 


=cut

sub xfile {

	my ( $self, $xfile ) = @_;
	if ( $xfile ne $empty_string ) {

		$sumute->{_xfile} = $xfile;
		$sumute->{_note}  = $sumute->{_note} . ' xfile=' . $sumute->{_xfile};
		$sumute->{_Step}  = $sumute->{_Step} . ' xfile=' . $sumute->{_xfile};

	} else {
		print("sumute, xfile, missing xfile,\n");
	}
}

=head2 sub xmute 


=cut

sub xmute {

	my ( $self, $xmute ) = @_;
	if ( $xmute ne $empty_string ) {

		$sumute->{_xmute} = $xmute;
		$sumute->{_note}  = $sumute->{_note} . ' xmute=' . $sumute->{_xmute};
		$sumute->{_Step}  = $sumute->{_Step} . ' xmute=' . $sumute->{_xmute};

	} else {
		print("sumute, xmute, missing xmute,\n");
	}
}

=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut

sub get_max_index {
	my ($self) = @_;
	my $max_index = 15;

	return ($max_index);
}

1;
