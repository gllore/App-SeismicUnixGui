package segdread;
use Moose;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PACKAGE NAME: segdread 
 AUTHOR: Juan Lorenzo
 DATE: June 22 2016 
 DESCRIPTION read segd-formatted data 
 Version 1
 Notes: 
 Package name is the same as the file name
 Moose is a package that allows an object-oriented
 syntax to organizing your programs

=cut

=head2  Notes from Seismic Unix

 SEGDREAD - read an SEG-D tape					
									
 segdread > stdout tape=						
									
									
 Required parameters:						 
	tape=	   input tape device				
 			tape=- to read from stdin			
									
 Optional parameters:						 
	use_stdio=0	for record devices (9-track reel tape drive)   
			=1 for pipe, disk and fixed-block 8mm drives   
	verbose=0	silent operation				
			= 1 ; echo every 'vblock' traces		
			= 2 ; echo information about blocks	    
	vblock=50	echo every 'vblock' traces under verbose option
	ptmin=1	 first shot to read				
	ptmax=INT_MAX   last shot to read				
	gain=0	  no application of gain			 
	aux=0	   no recovery of auxiliary traces		
	errmax=0	allowable number of consecutive tape IO errors 
	ns=0		override of computed ns to work around SEG-D   
			flaws.  Ignored when use_stdio=0.		
	pivot_year=30   Use current century for 2 digit yrs less than  
			pivot_year, previous century otherwise.	
									
	 type:   sudoc segdread   for further information
 	

=cut

=head2 USAGE 1 

 Example:
 $segdread->clear();
 $segdread->tape($segdread_inbound[1]);
 $segdread->verbose(1);
 $segdread->ptmax(1);
 $segdread->aux(0);
 $segdread->use_stdio(1);
 $segdread[1] = $segdread->Step();

=cut

my $segdread = {
    _aux 				=> '',
    _errmax 				=> '',
    _gain 				=> '',
    _note 				=> '',
    _ns 				=> '',
    _pivot_year 			=> '',
    _ptmax  				=> '',
    _ptmin 				=> '',
    _Step 				=> '',
    _tape 				=> '',
    _use_stdio  			=> '',
    _vblock  				=> '',
    _verbose 				=> ''
   };

=pod

 Notes:								

=head2 sub clear:

 clean hash of its values

=cut

sub clear {
    $segdread->{_aux} 			= '';
    $segdread->{_errmax} 		= '';
    $segdread->{_gain} 			= '';
    $segdread->{_note} 			= '';
    $segdread->{_ns} 			= '';
    $segdread->{_pivot_year} 		= '';
    $segdread->{_ptmax} 		= '';
    $segdread->{_ptmin} 		= '';
    $segdread->{_Step} 			= '';
    $segdread->{_tape} 			= '';
    $segdread->{_use_stdio} 		= '';
    $segdread->{_vblock} 		= '';
    $segdread->{_verbose} 		= '';
}
=head2 subroutine aux 


=cut
 
 sub aux {
   my ($variable, $aux) =	 @_;
   if($aux) {
    $segdread->{_aux}=$aux;
    $segdread->{_Step}   = $segdread->{_Step}.' aux='.$segdread->{_aux} ;
    $segdread->{_note}   = $segdread->{_note}.' aux='.$segdread->{_aux} ;
   }

}

=head2 subroutine  errmax

=cut

 sub errmax {
   my ($variable, $errmax)		= @_;
   if($errmax) {
    $segdread->{_errmax}			= $errmax;
    $segdread->{_Step}       		= $segdread->{_Step}.' errmax='.$segdread->{_errmax} ;
    $segdread->{_note}       		= $segdread->{_note}.' errmax='.$segdread->{_errmax} ;
   }
}

=head2 subroutine  gain

=cut

 sub gain {
   my ($variable, $gain)		= 	@_;
   if($gain) {
     $segdread->{_gain}	      =	$gain;
    $segdread->{_Step}       = $segdread->{_Step}.' gain='.$segdread->{_gain} ;
    $segdread->{_note}       = $segdread->{_note}.' gain='.$segdread->{_gain} ;
   }
}


=head2 subroutine  note

=cut

 sub note {
   my ($variable, $note)	 = @_;

   if($note) {
    $segdread->{_note}	= $note;
    $segdread->{_Step}         = $segdread->{_Step}.' note='.$segdread->{_note} ;
    $segdread->{_note}         = $segdread->{_note}.' note='.$segdread->{_note} ;
   }
}


=head2 subroutine  ns

=cut

sub ns {
   my ($variable, $ns)	= @_;
      $segdread->{_ns}	= $ns;
     return $segdread->{_ns};
}

=head2 subroutine  pivot_year

=cut

sub pivot_year {
   my ($variable, $pivot_year)		= @_;
   if($pivot_year) {
    $segdread->{_pivot_year}		=$pivot_year;
    $segdread->{_Step}       	= $segdread->{_Step}.' pivot_year='.$segdread->{_pivot_year} ;
    $segdread->{_note}       	= $segdread->{_note}.' pivot_year='.$segdread->{_pivot_year} ;
   }
}

=head2 subroutine  ptmax

=cut

sub ptmax {
   my ($variable, $ptmax)	= @_;
   if($ptmax) {
    $segdread->{_ptmax}	= $ptmax;
    $segdread->{_Step}       	= $segdread->{_Step}.' ptmax='.$segdread->{_ptmax} ;
    $segdread->{_note}       	= $segdread->{_note}.' ptmax='.$segdread->{_ptmax} ;
   }
}

=head2 subroutine  ptmin


=cut

 sub ptmin {

   my ($variable, $ptmin)	= @_;
   if($ptmin) {
    $segdread->{_ptmin}    	= $ptmin;
    $segdread->{_Step}       	= $segdread->{_Step}.' ptmin='.$segdread->{_ptmin} ;
    $segdread->{_note}       	= $segdread->{_note}.' ptmin='.$segdread->{_ptmin} ;
   }
}

=head2 subroutine Step 

=cut

sub Step {

    $segdread->{_Step}       = 'segdread '.$segdread->{_Step};
    return $segdread->{_Step};

}

=head2 subroutine tape 

=cut

sub tape {
 my ($variable, $tape)	= @_;
   if($tape) {
    $segdread->{_tape}	= $tape;
    $segdread->{_Step}       		= $segdread->{_Step}.' tape='.$segdread->{_tape} ;
    $segdread->{_note}       		= $segdread->{_note}.' tape='.$segdread->{_tape} ;
   }

}

=head2 subroutine  use_stdio

=cut

sub use_stdio {
 my ($variable, $use_stdio)			= @_;
   if($use_stdio) {
    $segdread->{_use_stdio}    		= $use_stdio;
    $segdread->{_Step}       		= $segdread->{_Step}.' use_stdio='.$segdread->{_use_stdio} ;
    $segdread->{_note}       		= $segdread->{_note}.' use_stdio='.$segdread->{_use_stdio} ;
   }
}


=head2 subroutine vblock


=cut

sub vblock {
    my ($variable, $vblock ) = @_;
    if ($vblock ) {
        $segdread->{_vblock}  = $vblock ;
        print 'vblock='.$vblock."\n\n";    
    	$segdread->{_Step}     = $segdread->{_Step}.' vblock='.$segdread->{_vblock} ;
    	$segdread->{_note}     = $segdread->{_note}.' receiver_statics_file_output='.$segdread->{_vblock} ;
        }
     }

=head2 subroutine  verbose

=cut

 sub verbose{

   my ($variable, $verbose)	= @_;
   if($verbose) {
    $segdread->{_verbose}    	= $verbose;
    $segdread->{_Step}       	= $segdread->{_Step}.' verbose='.$segdread->{_verbose} ;
    $segdread->{_note}       	= $segdread->{_note}.' verbose='.$segdread->{_verbose} ;
   }
}



=head2

 place 1; at end of the package

=cut

1;
