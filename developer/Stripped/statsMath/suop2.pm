 package suop2;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUOP2 - do a binary operation on two data sets			
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUOP2 - do a binary operation on two data sets			

 suop2 data1 data2 op=diff [trid=111] >stdout				

 Required parameters:							
 	none								

 Optional parameter:							
 	op=diff		difference of two panels of seismic data	
 			=sum  sum of two panels of seismic data		
 			=prod product of two panels of seismic data	
 			=quo quotient of two panels of seismic data	
 			=ptdiff differences of a panel and single trace	
 			=ptsum sum of a panel and single trace		
 			=ptprod product of a panel and single trace	
 			=ptquo quotient of a panel and single trace	
 			=zipper do "zipper" merge of two panels	

  trid=FUNPACKNYQ	output trace identification code. (This option  
 			is active only for op=zipper)			
			For SU version 39-43 FUNPACNYQ=111		
 			(See: sukeyword trid     for current value)	


 Note1: Output = data1 "op" data2 with the header of data1		

 Note2: For convenience and backward compatibility, this		
 	program may be called without an op code as:			

 For:  panel "op" panel  operations: 				
 	susum  file1 file2 == suop2 file1 file2 op=sum			
 	sudiff file1 file2 == suop2 file1 file2 op=diff			
 	suprod file1 file2 == suop2 file1 file2 op=prod			
 	suquo  file1 file2 == suop2 file1 file2 op=quo			

 For:  panel "op" trace  operations: 				
 	suptsum  file1 file2 == suop2 file1 file2 op=ptsum		
 	suptdiff file1 file2 == suop2 file1 file2 op=ptdiff		
 	suptprod file1 file2 == suop2 file1 file2 op=ptprod		
 	suptquo  file1 file2 == suop2 file1 file2 op=ptquo		

 Note3: If an explicit op code is used it must FOLLOW the		
	filenames.							

 Note4: With op=quo and op=ptquo, divide by 0 is trapped and 0 is returned.

 Note5: Weighted operations can be specified by setting weighting	
	coefficients for the two datasets:				
	w1=1.0								
	w2=1.0								

 Note6: With op=zipper, it is possible to set the output trace id code 
 		(See: sukeyword trid)					
  This option processes the traces from two files interleaving its samples.
  Both files must have the same trace length and must not longer than	
  SU_NFLTS/2  (as in SU 39-42  SU_NFLTS=32768).			

  Being "tr1" a trace of data1 and "tr2" the corresponding trace of
  data2, The merged trace will be :					

  tr[2*i]= tr1[i]							
  tr[2*i+1] = tr2[i]							

  The default value of output tr.trid is that used by sufft and suifft,
  which is the trace id reserved for the complex traces obtained through
  the application of sufft. See also, suamp.				

 For operations on non-SU binary files  use:farith 			

 Credits:
	SEP: Shuki Ronen
	CWP: Jack K. Cohen
	CWP: John Stockwell, 1995, added panel op trace options.
	: Fernando M. Roxo da Motta <petro@roxo.org> - added zipper op

 Notes:
	If efficiency becomes important consider inverting main loop
	and repeating operation code within the branches of the switch.

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $suop2		= {
		_FUNPACNYQ					=> '',
		_Output					=> '',
		_SU_NFLTS					=> '',
		_file2					=> '',
		_op					=> '',
		_trid					=> '',
		_w1					=> '',
		_w2					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$suop2->{_Step}     = 'suop2'.$suop2->{_Step};
	return ( $suop2->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$suop2->{_note}     = 'suop2'.$suop2->{_note};
	return ( $suop2->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$suop2->{_FUNPACNYQ}			= '';
		$suop2->{_Output}			= '';
		$suop2->{_SU_NFLTS}			= '';
		$suop2->{_file2}			= '';
		$suop2->{_op}			= '';
		$suop2->{_trid}			= '';
		$suop2->{_w1}			= '';
		$suop2->{_w2}			= '';
		$suop2->{_Step}			= '';
		$suop2->{_note}			= '';
 }


=head2 sub FUNPACNYQ 


=cut

 sub FUNPACNYQ {

	my ( $self,$FUNPACNYQ )		= @_;
	if ( $FUNPACNYQ ne $empty_string ) {

		$suop2->{_FUNPACNYQ}		= $FUNPACNYQ;
		$suop2->{_note}		= $suop2->{_note}.' FUNPACNYQ='.$suop2->{_FUNPACNYQ};
		$suop2->{_Step}		= $suop2->{_Step}.' FUNPACNYQ='.$suop2->{_FUNPACNYQ};

	} else { 
		print("suop2, FUNPACNYQ, missing FUNPACNYQ,\n");
	 }
 }


=head2 sub Output 


=cut

 sub Output {

	my ( $self,$Output )		= @_;
	if ( $Output ne $empty_string ) {

		$suop2->{_Output}		= $Output;
		$suop2->{_note}		= $suop2->{_note}.' Output='.$suop2->{_Output};
		$suop2->{_Step}		= $suop2->{_Step}.' Output='.$suop2->{_Output};

	} else { 
		print("suop2, Output, missing Output,\n");
	 }
 }


=head2 sub SU_NFLTS 


=cut

 sub SU_NFLTS {

	my ( $self,$SU_NFLTS )		= @_;
	if ( $SU_NFLTS ne $empty_string ) {

		$suop2->{_SU_NFLTS}		= $SU_NFLTS;
		$suop2->{_note}		= $suop2->{_note}.' SU_NFLTS='.$suop2->{_SU_NFLTS};
		$suop2->{_Step}		= $suop2->{_Step}.' SU_NFLTS='.$suop2->{_SU_NFLTS};

	} else { 
		print("suop2, SU_NFLTS, missing SU_NFLTS,\n");
	 }
 }


=head2 sub file2 


=cut

 sub file2 {

	my ( $self,$file2 )		= @_;
	if ( $file2 ne $empty_string ) {

		$suop2->{_file2}		= $file2;
		$suop2->{_note}		= $suop2->{_note}.' file2='.$suop2->{_file2};
		$suop2->{_Step}		= $suop2->{_Step}.' file2='.$suop2->{_file2};

	} else { 
		print("suop2, file2, missing file2,\n");
	 }
 }


=head2 sub op 


=cut

 sub op {

	my ( $self,$op )		= @_;
	if ( $op ne $empty_string ) {

		$suop2->{_op}		= $op;
		$suop2->{_note}		= $suop2->{_note}.' op='.$suop2->{_op};
		$suop2->{_Step}		= $suop2->{_Step}.' op='.$suop2->{_op};

	} else { 
		print("suop2, op, missing op,\n");
	 }
 }


=head2 sub trid 


=cut

 sub trid {

	my ( $self,$trid )		= @_;
	if ( $trid ne $empty_string ) {

		$suop2->{_trid}		= $trid;
		$suop2->{_note}		= $suop2->{_note}.' trid='.$suop2->{_trid};
		$suop2->{_Step}		= $suop2->{_Step}.' trid='.$suop2->{_trid};

	} else { 
		print("suop2, trid, missing trid,\n");
	 }
 }


=head2 sub w1 


=cut

 sub w1 {

	my ( $self,$w1 )		= @_;
	if ( $w1 ne $empty_string ) {

		$suop2->{_w1}		= $w1;
		$suop2->{_note}		= $suop2->{_note}.' w1='.$suop2->{_w1};
		$suop2->{_Step}		= $suop2->{_Step}.' w1='.$suop2->{_w1};

	} else { 
		print("suop2, w1, missing w1,\n");
	 }
 }


=head2 sub w2 


=cut

 sub w2 {

	my ( $self,$w2 )		= @_;
	if ( $w2 ne $empty_string ) {

		$suop2->{_w2}		= $w2;
		$suop2->{_note}		= $suop2->{_note}.' w2='.$suop2->{_w2};
		$suop2->{_Step}		= $suop2->{_Step}.' w2='.$suop2->{_w2};

	} else { 
		print("suop2, w2, missing w2,\n");
	 }
 }


=head2 sub get_max_index
 
max index = number of input variables -1
 
=cut
 
  sub get_max_index {
 	my ($self) = @_;
	# only file_name : index=36
 	my $max_index = 36;
	
 	return($max_index);
 }
 
 
1; 