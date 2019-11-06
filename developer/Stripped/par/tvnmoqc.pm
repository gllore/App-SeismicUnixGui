 package tvnmoqc;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  TVNMOQC - Check tnmo-vnmo pairs; create t-v column files           
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 TVNMOQC - Check tnmo-vnmo pairs; create t-v column files           

 tvnmoqc [parameters] cdp=... tnmo=... vnmo=...                     

   Example:                                                         
 tvnmoqc mode=1 \\                                                  
 cdp=15,35 \\                                                       
 tnmo=0.0091,0.2501,0.5001,0.7501,0.9941 \\                         
 vnmo=1497.0,2000.0,2500.0,3000.0,3500.0 \\                         
 tnmo=0.0082,0.2402,0.4902,0.7402,0.9842 \\                         
 vnmo=1495.0,1900.0,2400.0,2900.0,3400.0                            

 Required Parameter:                                                
   prefix=        Prefix of output t-v file(s)                      
                  Required only for mode=2                          

 Optional Parameter:                                                
   mode=1         1=qc: check that tnmo values increase             
                  2=qc and output t-v files                         

 mode=1                                                             
   TVNMOQC checks that there is a tnmo and vnmo series for each CDP 
     and it checks that each tnmo series increases in time.         

 mode=2                                                             
   TVNMOQC does mode=1 checking, plus ...                           

   TVNMOQC converts par (MKPARFILE) values written as:              

          cdp=15,35,...,95 \\                                       
          tnmo=t151,t152,...,t15n \\                                
          vnmo=v151,v152,...,v15n \\                                
          tnmo=t351,t352,...,t35n \\                                
          vnmo=v351,v352,...,v35n \\                                
          tnmo=... \\                                               
          vnmo=... \\                                               
          tnmo=t951,t952,...,t95n \\                                
          vnmo=v951,v952,...,v95n \\                                

   to column format. The format of each output file is:             

          t1 v1                                                     
          t2 v2                                                     
           ...                                                      
          tn vn                                                     

   One file is output for each input pair of tnmo-vnmo series.      

   A CDP VALUE MUST BE SUPPLIED FOR EACH TNMO-VNMO ROW PAIR.        

   Prefix of each output file is the user-supplied value of         
     parameter PREFIX.                                              
   Suffix of each output file is the cdp value.                     
   For the example above, output files names are:                   
     PREFIX.15  PREFIX.35  ...  PREFIX.95                           


 Credits:
      MTU: David Forel (adapted from SUNMO)

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $tvnmoqc		= {
		_2					=> '',
		_cdp					=> '',
		_mode					=> '',
		_prefix					=> '',
		_tnmo					=> '',
		_vnmo					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$tvnmoqc->{_Step}     = 'tvnmoqc'.$tvnmoqc->{_Step};
	return ( $tvnmoqc->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$tvnmoqc->{_note}     = 'tvnmoqc'.$tvnmoqc->{_note};
	return ( $tvnmoqc->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$tvnmoqc->{_2}			= '';
		$tvnmoqc->{_cdp}			= '';
		$tvnmoqc->{_mode}			= '';
		$tvnmoqc->{_prefix}			= '';
		$tvnmoqc->{_tnmo}			= '';
		$tvnmoqc->{_vnmo}			= '';
		$tvnmoqc->{_Step}			= '';
		$tvnmoqc->{_note}			= '';
 }


=head2 sub 2 


=cut

 sub 2 {

	my ( $self,$2 )		= @_;
	if ( $2 ne $empty_string ) {

		$tvnmoqc->{_2}		= $2;
		$tvnmoqc->{_note}		= $tvnmoqc->{_note}.' 2='.$tvnmoqc->{_2};
		$tvnmoqc->{_Step}		= $tvnmoqc->{_Step}.' 2='.$tvnmoqc->{_2};

	} else { 
		print("tvnmoqc, 2, missing 2,\n");
	 }
 }


=head2 sub cdp 


=cut

 sub cdp {

	my ( $self,$cdp )		= @_;
	if ( $cdp ne $empty_string ) {

		$tvnmoqc->{_cdp}		= $cdp;
		$tvnmoqc->{_note}		= $tvnmoqc->{_note}.' cdp='.$tvnmoqc->{_cdp};
		$tvnmoqc->{_Step}		= $tvnmoqc->{_Step}.' cdp='.$tvnmoqc->{_cdp};

	} else { 
		print("tvnmoqc, cdp, missing cdp,\n");
	 }
 }


=head2 sub mode 


=cut

 sub mode {

	my ( $self,$mode )		= @_;
	if ( $mode ne $empty_string ) {

		$tvnmoqc->{_mode}		= $mode;
		$tvnmoqc->{_note}		= $tvnmoqc->{_note}.' mode='.$tvnmoqc->{_mode};
		$tvnmoqc->{_Step}		= $tvnmoqc->{_Step}.' mode='.$tvnmoqc->{_mode};

	} else { 
		print("tvnmoqc, mode, missing mode,\n");
	 }
 }


=head2 sub prefix 


=cut

 sub prefix {

	my ( $self,$prefix )		= @_;
	if ( $prefix ne $empty_string ) {

		$tvnmoqc->{_prefix}		= $prefix;
		$tvnmoqc->{_note}		= $tvnmoqc->{_note}.' prefix='.$tvnmoqc->{_prefix};
		$tvnmoqc->{_Step}		= $tvnmoqc->{_Step}.' prefix='.$tvnmoqc->{_prefix};

	} else { 
		print("tvnmoqc, prefix, missing prefix,\n");
	 }
 }


=head2 sub tnmo 


=cut

 sub tnmo {

	my ( $self,$tnmo )		= @_;
	if ( $tnmo ne $empty_string ) {

		$tvnmoqc->{_tnmo}		= $tnmo;
		$tvnmoqc->{_note}		= $tvnmoqc->{_note}.' tnmo='.$tvnmoqc->{_tnmo};
		$tvnmoqc->{_Step}		= $tvnmoqc->{_Step}.' tnmo='.$tvnmoqc->{_tnmo};

	} else { 
		print("tvnmoqc, tnmo, missing tnmo,\n");
	 }
 }


=head2 sub vnmo 


=cut

 sub vnmo {

	my ( $self,$vnmo )		= @_;
	if ( $vnmo ne $empty_string ) {

		$tvnmoqc->{_vnmo}		= $vnmo;
		$tvnmoqc->{_note}		= $tvnmoqc->{_note}.' vnmo='.$tvnmoqc->{_vnmo};
		$tvnmoqc->{_Step}		= $tvnmoqc->{_Step}.' vnmo='.$tvnmoqc->{_vnmo};

	} else { 
		print("tvnmoqc, vnmo, missing vnmo,\n");
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