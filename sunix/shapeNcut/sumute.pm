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
 			air blast duration				
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
			as in mode=2 xmute,tmute describe the total time
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
my $PL_SEISMIC = $Project->PL_SEISMIC();

my $sumute = {
    _hmute         => '',
    _key           => '',
    _linvel        => '',
    _mode          => '',
    _nmute         => '',
    _ntaper        => '',
    _par           => '',
    _par_directory => '',
    _tfile         => '',
    _tm0           => '',
    _tmute         => '',
    _twindow       => '',
    _xfile         => '',
    _xmute         => '',
    _Step          => '',
    _note          => '',
};

=head2 sub Step

	Keeps track of actions for execution in the system
collects switches and assembles bash instructions
by adding the program name

=cut

sub Step {

    $sumute->{_Step} = 'sumute' . $sumute->{_Step};
    return ( $sumute->{_Step} );

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

    use Project_config;
    my $Project = new Project_config();
    use SeismicUnix qw ($in $out $to $suffix_su);
    use flow;

    my ($DATA_SEISMIC_SU) = $Project->DATA_SEISMIC_SU();
    my $run = new flow();
    my ( @items, @outbound );

    for ( my $i = 1 ; $i <= $sumute->{_number_of_par_files} ; $i++ ) {
        tmute( $sumute->{_tmute_array}[$i] );
        xmute( $sumute->{_xmute_array}[$i] );

        $outbound[$i] =
            $DATA_SEISMIC_SU . '/'
          . $sumute->{_file_in} . '_'
          . $sumute->{_gather_type}
          . $sumute->{_gather_number_array}[$i]
          . $suffix_su;

        @items = (
            'suwind key='
              . $sumute->{_gather_type} . ' min='
              . $sumute->{_gather_number_array}[$i] . ' max='
              . $sumute->{_gather_number_array}[$i],
            $in, $DATA_SEISMIC_SU . '/' . $sumute->{_file_in} . $suffix_su,
            $to, ' sumute ' . $sumute->{_Steps},
            $out, $outbound[$i]
        );

        $sumute->{_Steps_array}[$i] = $run->modules( \@items );

        #print (" sub Steps shows: $sumute->{_Steps_array}[$i]\n\n");
    }
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

    $sumute->{_hmute}           = '';
    $sumute->{_key}             = '';
    $sumute->{_linvel}          = '';
    $sumute->{_mode}            = '';
    $sumute->{_nmute}           = '';
    $sumute->{_ntaper}          = '';
    $sumute->{_par}             = '',
      $sumute->{_par_directory} = '',
      $sumute->{_tfile}         = '';
    $sumute->{_tm0}     = '';
    $sumute->{_tmute}   = '';
    $sumute->{_twindow} = '';
    $sumute->{_xfile}   = '';
    $sumute->{_xmute}   = '';
    $sumute->{_Step}    = '';
    $sumute->{_note}    = '';
}

=head2 sub header_word


=cut

sub header_word {

    my ( $self, $key ) = @_;
    if ( $key ne $empty_string ) {

        $sumute->{_key}  = $key;
        $sumute->{_note} = $sumute->{_note} . ' key=' . $sumute->{_key};
        $sumute->{_Step} = $sumute->{_Step} . ' key=' . $sumute->{_key};

    }
    else {
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

    }
    else {
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

    }
    else {
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

    }
    else {
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

    }
    else {
        print("sumute, linvel, missing linvel,\n");
    }
}

=head2 Subroutine list

 list of gather numbers to mute
 There must be accompanying mute parameters in 
 additional files that correspond to each of the
 shotgather (ep), cdp gather etc. numbers inside the list	
 for example, 
   "1" should correspond to something like:
   "11" should correspond to something like:

 itop_mute_par_suFileName_binheaderType1
 itop_mute_par_suFileName_binheaderType11

 e.g., itop_mute_par_All_cmp_ep11

 Usage 1:
To mute an array of shotpoint gathers (numbers in list)
  and su file name to which mute is applied 
  sufile does NOT have a ".su" extension.

Example:
       $sumute->list('top_mute_list',\$file_in[1],\$binheader[1]);
        file_in is the sunix file
        binheader is either offset,tracl  etc.
        whereas the gather type is either cdp, ep etc.
        
=cut

sub list {
    my ( $sub, $list, $ref_file_in, $ref_gather_type ) = @_;

=head2 Error

     Messages

=cut

    if ( defined($list) ) {

        $sumute->{_list} = $list;
        $sumute->{_note} = $sumute->{_note} . ' list=' . $sumute->{_list};

    }

    else {
        print(" Error: list name is missing in subroutine list");

    }

    if ($ref_file_in) {
        $sumute->{_file_in} = $$ref_file_in;

        #print("file is $sumute->{_file_in}\n\n");
    }
    else {
        print(" Error: su file is missing in subroutine list");

    }
    if ($ref_gather_type) {
        $sumute->{_gather_type} = $$ref_gather_type;

        #print("gather_type is $sumute->{_gather_type}\n\n");
    }
    else {
        print(" Error: gather type is missing in subroutine list");

    }

=head2 Insert package

 into namespace

=cut

    use manage_files_by;
    use Project_config;
    my $Project = new Project_config();

=head2 Load 

 variables into local namespace

=cut

    my ($numberOfFiles);
    my ( $ref_file_names, $i );
    my ( $file_number, $ref_values, $ref_numberOfValues );
    my (@sufile_in);
    my ($PL_SEISMIC) = $Project->PL_SEISMIC();

=head2 read a list 

 of file names

 testing

  print(" number of files is $numberOfFiles\n");
  for (my $i=1; $i<=$numberOfFiles;$i++) {
       print("\n file $i is $$ref_file_names[$i]");
   }

=cut 

    ( $ref_file_names, $numberOfFiles ) =
      manage_files_by::read_1col( \$sumute->{_list} );

    if ($numberOfFiles) {
        $sumute->{_number_of_par_files} = $numberOfFiles;
    }

=head2
 
 read contents of each file in the list
 into arrays
 each line of the list is a gather number and
 indicates in which file the mute picks are found

 testing

      $row = scalar @$ref_numberOfValues;
      print(" \nfor file #$file_number, number of rows is $row\n");
          print("par file is $par_file\n\n");
      for (my $i=0; $i<$row;$i++) {
          print("\n row $i contains $$ref_values[$i]");
          print(" i.e., $$ref_numberOfValues[$i] values\n");
          }

 line=2 is needed to skip the  first two lines
 i.e. tnmo= vnmo=
 first initializaed as 1 and then incremented

=cut

    for (
        $file_number = 1 ;
        $file_number <= $sumute->{_number_of_par_files} ;
        $file_number++
      )
    {

        $sumute->{_gather_number_array}[$file_number] =
          $$ref_file_names[$file_number];
        $sumute->{_par_file_array}[$file_number] =
            $PL_SEISMIC . '/'
          . $imute_par_
          . $sumute->{_file_in} . '_'
          . $sumute->{_gather_type}
          . $sumute->{_gather_number_array}[$file_number];
        ( $ref_values, $ref_numberOfValues ) = manage_files_by::read_par(
            \$sumute->{_par_file_array}[$file_number] );

        my $row = scalar @$ref_numberOfValues;
        print(" \nfor file #$file_number, number of rows is $row\n");
        print("par file is $sumute->{_par_file_array}[$file_number]\n\n");
        for ( my $i = 0 ; $i < $row ; $i++ ) {
            print("\n row $i contains $$ref_values[$i]");
            print(" i.e., $$ref_numberOfValues[$i] values\n");
        }

=head2
 
 place contents of each file in the list
 into an array
 @output is an array referenced within the hash of this namespace

 testing

 print("for i=0 output is $sumute->{_output}[0]\n\n");
 print("for i=$i tmute is $sumute->{_output}[$i]\n\n");
 print("for i=0 output is $$ref_values[0]\n\n");
 print("for i=1 output is $$ref_values[(0+1)]\n\n");

          $sumute->{_output}[$i] =  $$ref_values[$i];
          print("for file=$file_number tmute is $sumute->{_tmute_array}[$file_number]\n\n");
          print("for file=$file_number xmute is $sumute->{_xmute_array}[$file_number]\n\n");
=cut

        $sumute->{_row} = scalar @$ref_numberOfValues;
        for ( $i = 0 ; $i < $sumute->{_row} ; $i = $i + 2 ) {
            $sumute->{_tmute_array}[$file_number] = $$ref_values[$i];
            $sumute->{_xmute_array}[$file_number] =
              $$ref_values[ ( $i + 1 ) ];
        }
    }    # end of reading par files

=head2

   Create sets a  mute flow for each T-X pick file ("par" file)
          print("for i=$i,and line=$line tmute is $sumute->{_tmute_array}[$line]\n\n");
          print("for i=$i,and line=$line xmute is $sumute->{_xmute_array}[$line]\n\n");
  

=cut

}    # end of sub list

=head2 sub mode 

	Defines how the mute window is picked

=cut

sub mode {

    my ( $self, $mode ) = @_;
    if ( $mode ne $empty_string ) {

        $sumute->{_mode} = $mode;
        $sumute->{_note} = $sumute->{_note} . ' mode=' . $sumute->{_mode};
        $sumute->{_Step} = $sumute->{_Step} . ' mode=' . $sumute->{_mode};

    }
    else {
        print("sumute, mode, missing mode,\n");
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

    }
    else {
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

    }
    else {
        print("sumute, ntaper, missing ntaper,\n");
    }
}

=head2 sub par 


=cut

sub par {

    my ( $self, $par ) = @_;
    if ( $par ne $empty_string && $sumute->{_par_directory} ne $empty_string ) {

        $sumute->{_par} = $par;
        $sumute->{_note} =
            $sumute->{_note} . ' par='
          . $sumute->{_par_directory} . '/'
          . $sumute->{_par};
        $sumute->{_Step} =
            $sumute->{_Step} . ' par='
          . $sumute->{_par_directory} . '/'
          . $sumute->{_par};

    }
    else {
        print("sumute, par, missing par,or par_directory\n");
    }
}

=head2 sub par_directory

 can = 'PL_SEISMIC'
 TODO: something else


=cut

sub par_directory {

    my ( $self, $par_directory ) = @_;

    if ( $par_directory ne $empty_string ) {

        if ( $par_directory eq 'PL_SEISMIC' ) {

            $par_directory = $PL_SEISMIC;
            $sumute->{_par_directory} = $par_directory;

        }
        else {
            print("sumute, par_directory, unexpected par_directory,\n");
        }

    }
    else {
        print("sumute, par_directory, missing par_directory,\n");
    }
}

=head2 sub par_file 


=cut

sub par_file {

    my ( $self, $par ) = @_;

    if ( $par ne $empty_string && $sumute->{_par_directory} ne $empty_string ) {

        $sumute->{_par} = $par;
        $sumute->{_note} =
            $sumute->{_note} . ' par='
          . $sumute->{_par_directory} . '/'
          . $sumute->{_par};
        $sumute->{_Step} =
            $sumute->{_Step} . ' par='
          . $sumute->{_par_directory} . '/'
          . $sumute->{_par};

    }
    else {
        print("sumute, par_file, missing par or par_directory,\n");
    }
}

=head2 sub parfile 


=cut

sub parfile {

    my ( $self, $par ) = @_;
    if ( $par ne $empty_string && $sumute->{_par_directory} ne $empty_string ) {

        $sumute->{_par} = $par;
        $sumute->{_note} =
            $sumute->{_note} . ' par='
          . $sumute->{_par_directory} . '/'
          . $sumute->{_par};
        $sumute->{_Step} =
            $sumute->{_Step} . ' par='
          . $sumute->{_par_directory} . '/'
          . $sumute->{_par};

    }
    else {
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

    }
    else {
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

    }
    else {
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

    }
    else {
        print("sumute, tmute, missing tmute,\n");
    }
}

=head2 sub twindow 


=cut

sub twindow {

    my ( $self, $twindow ) = @_;
    if ( $twindow ne $empty_string ) {

        $sumute->{_twindow} = $twindow;
        $sumute->{_note} =
          $sumute->{_note} . ' twindow=' . $sumute->{_twindow};
        $sumute->{_Step} =
          $sumute->{_Step} . ' twindow=' . $sumute->{_twindow};

    }
    else {
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

    }
    else {
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

    }
    else {
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

    }
    else {
        print("sumute, xmute, missing xmute,\n");
    }
}

=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut

sub get_max_index {
    my ($self) = @_;
    my $max_index = 13;

    return ($max_index);
}

1;
