 package randvel3d;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  RANDVEL3D - Add a random velocity layer (RVL) to a gridded             
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 RANDVEL3D - Add a random velocity layer (RVL) to a gridded             
            v(x,y,z) velocity model                                    

	randvel3d <infile n1= n2= >outfile [parameters]			

 Required Parameters:							
 n1=		number of samples along 1st dimension			
 n2=		number of samples along 2nd dimension			

 Optional Parameters:							

 n3=1          number of samples along 3rd dimension			

 mode=1             add single layer populated with random vels	
                    =2 add nrvl layers of random thickness and vel     
 seed=from_clock    random number seed (integer)			

 ---->New layer geometry info						
 i1beg=1       1st dimension beginning sample 				
 i1end=n1/5    1st dimension ending sample 				
 i2beg=1       2nd dimension beginning sample 				
 i2end=n2      2nd dimension ending sample 				
 i3beg=1       3rd dimension beginning sample 				
 i3end=n3      3rd dimension ending sample 				
 ---->New layer velocity info						
 vlsd=v/3     range (std dev) of random velocity in layer, 		
               where v=v(0,0,i1) and i1=(i1beg+i1end)/2 	 	
 add=1         add random vel to original vel (v_orig) at that point 	
               =0 replace vel at that point with (v_orig+v_rand) 	
 how=0         random vels can be higher or lower than v_orig		
               =1 random vels are always lower than v_orig		
               =2 random vels are always higher than v_orig		
 cvel=2000     layer filled with constant velocity cvel 		
               (overides vlsd,add,how params)			
 ---->Smoothing parameters (0 = no smoothing)				
 r1=0.0	1st dimension operator length in samples		
 r2=0.0	2nd dimension operator length in samples		
 r3=0.0	3rd dimension operator length in samples		
 slowness=0	=1 smoothing on slowness; =0 smoothing on velocity	

 nrvl=n1/10    number of const velocity layers to add     		
 pdv=10.       percentage velocity deviation (max) from input model	

 Notes:								
 1. Smoothing radii usually fall in the range of [0,20].		
 2. Smoothing radii can be used to set aspect ratio of random velocity 
    anomalies in the new layer.  For example (r1=5,r2=0,r3=0) will     
    result in vertical vel streaks that mimick vertical fracturing.    
 3. Smoothing on slowness works better to preserve traveltimes relative
    to the unsmoothed case.						
 4. Default case is a random velocity (+/-30%) near surface layer whose
    thickness is 20% of the total 2D model thickness.			
 5. Each layer vel is a random perturbation on input model at that level.
 6. The depth dimension is assumed to be along axis 1.			

 Example:								
 1. 2D RVL with no smoothing						
   makevel nz=250 nx=200 | randvel3d n1=250 n2=200 | ximage n1=250      
 2. 3D RVL with no smoothing						
   makevel nz=250 nx=200 ny=220 |					
   randvel3d n1=250 n2=200 n3=220 | 					
   xmovie n1=250 n2=200					    	



 Author:  U Houston: Chris Liner c. 2008
          Based on smooth3d (CWP: Zhenyue Liu  March 1995)


=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $randvel3d		= {
		_add					=> '',
		_cvel					=> '',
		_how					=> '',
		_i1beg					=> '',
		_i1end					=> '',
		_i2beg					=> '',
		_i2end					=> '',
		_i3beg					=> '',
		_i3end					=> '',
		_mode					=> '',
		_n1					=> '',
		_n2					=> '',
		_n3					=> '',
		_nrvl					=> '',
		_nz					=> '',
		_pdv					=> '',
		_r1					=> '',
		_r2					=> '',
		_r3					=> '',
		_seed					=> '',
		_slowness					=> '',
		_v					=> '',
		_vlsd					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$randvel3d->{_Step}     = 'randvel3d'.$randvel3d->{_Step};
	return ( $randvel3d->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$randvel3d->{_note}     = 'randvel3d'.$randvel3d->{_note};
	return ( $randvel3d->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$randvel3d->{_add}			= '';
		$randvel3d->{_cvel}			= '';
		$randvel3d->{_how}			= '';
		$randvel3d->{_i1beg}			= '';
		$randvel3d->{_i1end}			= '';
		$randvel3d->{_i2beg}			= '';
		$randvel3d->{_i2end}			= '';
		$randvel3d->{_i3beg}			= '';
		$randvel3d->{_i3end}			= '';
		$randvel3d->{_mode}			= '';
		$randvel3d->{_n1}			= '';
		$randvel3d->{_n2}			= '';
		$randvel3d->{_n3}			= '';
		$randvel3d->{_nrvl}			= '';
		$randvel3d->{_nz}			= '';
		$randvel3d->{_pdv}			= '';
		$randvel3d->{_r1}			= '';
		$randvel3d->{_r2}			= '';
		$randvel3d->{_r3}			= '';
		$randvel3d->{_seed}			= '';
		$randvel3d->{_slowness}			= '';
		$randvel3d->{_v}			= '';
		$randvel3d->{_vlsd}			= '';
		$randvel3d->{_Step}			= '';
		$randvel3d->{_note}			= '';
 }


=head2 sub add 


=cut

 sub add {

	my ( $self,$add )		= @_;
	if ( $add ne $empty_string ) {

		$randvel3d->{_add}		= $add;
		$randvel3d->{_note}		= $randvel3d->{_note}.' add='.$randvel3d->{_add};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' add='.$randvel3d->{_add};

	} else { 
		print("randvel3d, add, missing add,\n");
	 }
 }


=head2 sub cvel 


=cut

 sub cvel {

	my ( $self,$cvel )		= @_;
	if ( $cvel ne $empty_string ) {

		$randvel3d->{_cvel}		= $cvel;
		$randvel3d->{_note}		= $randvel3d->{_note}.' cvel='.$randvel3d->{_cvel};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' cvel='.$randvel3d->{_cvel};

	} else { 
		print("randvel3d, cvel, missing cvel,\n");
	 }
 }


=head2 sub how 


=cut

 sub how {

	my ( $self,$how )		= @_;
	if ( $how ne $empty_string ) {

		$randvel3d->{_how}		= $how;
		$randvel3d->{_note}		= $randvel3d->{_note}.' how='.$randvel3d->{_how};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' how='.$randvel3d->{_how};

	} else { 
		print("randvel3d, how, missing how,\n");
	 }
 }


=head2 sub i1beg 


=cut

 sub i1beg {

	my ( $self,$i1beg )		= @_;
	if ( $i1beg ne $empty_string ) {

		$randvel3d->{_i1beg}		= $i1beg;
		$randvel3d->{_note}		= $randvel3d->{_note}.' i1beg='.$randvel3d->{_i1beg};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' i1beg='.$randvel3d->{_i1beg};

	} else { 
		print("randvel3d, i1beg, missing i1beg,\n");
	 }
 }


=head2 sub i1end 


=cut

 sub i1end {

	my ( $self,$i1end )		= @_;
	if ( $i1end ne $empty_string ) {

		$randvel3d->{_i1end}		= $i1end;
		$randvel3d->{_note}		= $randvel3d->{_note}.' i1end='.$randvel3d->{_i1end};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' i1end='.$randvel3d->{_i1end};

	} else { 
		print("randvel3d, i1end, missing i1end,\n");
	 }
 }


=head2 sub i2beg 


=cut

 sub i2beg {

	my ( $self,$i2beg )		= @_;
	if ( $i2beg ne $empty_string ) {

		$randvel3d->{_i2beg}		= $i2beg;
		$randvel3d->{_note}		= $randvel3d->{_note}.' i2beg='.$randvel3d->{_i2beg};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' i2beg='.$randvel3d->{_i2beg};

	} else { 
		print("randvel3d, i2beg, missing i2beg,\n");
	 }
 }


=head2 sub i2end 


=cut

 sub i2end {

	my ( $self,$i2end )		= @_;
	if ( $i2end ne $empty_string ) {

		$randvel3d->{_i2end}		= $i2end;
		$randvel3d->{_note}		= $randvel3d->{_note}.' i2end='.$randvel3d->{_i2end};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' i2end='.$randvel3d->{_i2end};

	} else { 
		print("randvel3d, i2end, missing i2end,\n");
	 }
 }


=head2 sub i3beg 


=cut

 sub i3beg {

	my ( $self,$i3beg )		= @_;
	if ( $i3beg ne $empty_string ) {

		$randvel3d->{_i3beg}		= $i3beg;
		$randvel3d->{_note}		= $randvel3d->{_note}.' i3beg='.$randvel3d->{_i3beg};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' i3beg='.$randvel3d->{_i3beg};

	} else { 
		print("randvel3d, i3beg, missing i3beg,\n");
	 }
 }


=head2 sub i3end 


=cut

 sub i3end {

	my ( $self,$i3end )		= @_;
	if ( $i3end ne $empty_string ) {

		$randvel3d->{_i3end}		= $i3end;
		$randvel3d->{_note}		= $randvel3d->{_note}.' i3end='.$randvel3d->{_i3end};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' i3end='.$randvel3d->{_i3end};

	} else { 
		print("randvel3d, i3end, missing i3end,\n");
	 }
 }


=head2 sub mode 


=cut

 sub mode {

	my ( $self,$mode )		= @_;
	if ( $mode ne $empty_string ) {

		$randvel3d->{_mode}		= $mode;
		$randvel3d->{_note}		= $randvel3d->{_note}.' mode='.$randvel3d->{_mode};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' mode='.$randvel3d->{_mode};

	} else { 
		print("randvel3d, mode, missing mode,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$randvel3d->{_n1}		= $n1;
		$randvel3d->{_note}		= $randvel3d->{_note}.' n1='.$randvel3d->{_n1};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' n1='.$randvel3d->{_n1};

	} else { 
		print("randvel3d, n1, missing n1,\n");
	 }
 }


=head2 sub n2 


=cut

 sub n2 {

	my ( $self,$n2 )		= @_;
	if ( $n2 ne $empty_string ) {

		$randvel3d->{_n2}		= $n2;
		$randvel3d->{_note}		= $randvel3d->{_note}.' n2='.$randvel3d->{_n2};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' n2='.$randvel3d->{_n2};

	} else { 
		print("randvel3d, n2, missing n2,\n");
	 }
 }


=head2 sub n3 


=cut

 sub n3 {

	my ( $self,$n3 )		= @_;
	if ( $n3 ne $empty_string ) {

		$randvel3d->{_n3}		= $n3;
		$randvel3d->{_note}		= $randvel3d->{_note}.' n3='.$randvel3d->{_n3};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' n3='.$randvel3d->{_n3};

	} else { 
		print("randvel3d, n3, missing n3,\n");
	 }
 }


=head2 sub nrvl 


=cut

 sub nrvl {

	my ( $self,$nrvl )		= @_;
	if ( $nrvl ne $empty_string ) {

		$randvel3d->{_nrvl}		= $nrvl;
		$randvel3d->{_note}		= $randvel3d->{_note}.' nrvl='.$randvel3d->{_nrvl};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' nrvl='.$randvel3d->{_nrvl};

	} else { 
		print("randvel3d, nrvl, missing nrvl,\n");
	 }
 }


=head2 sub nz 


=cut

 sub nz {

	my ( $self,$nz )		= @_;
	if ( $nz ne $empty_string ) {

		$randvel3d->{_nz}		= $nz;
		$randvel3d->{_note}		= $randvel3d->{_note}.' nz='.$randvel3d->{_nz};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' nz='.$randvel3d->{_nz};

	} else { 
		print("randvel3d, nz, missing nz,\n");
	 }
 }


=head2 sub pdv 


=cut

 sub pdv {

	my ( $self,$pdv )		= @_;
	if ( $pdv ne $empty_string ) {

		$randvel3d->{_pdv}		= $pdv;
		$randvel3d->{_note}		= $randvel3d->{_note}.' pdv='.$randvel3d->{_pdv};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' pdv='.$randvel3d->{_pdv};

	} else { 
		print("randvel3d, pdv, missing pdv,\n");
	 }
 }


=head2 sub r1 


=cut

 sub r1 {

	my ( $self,$r1 )		= @_;
	if ( $r1 ne $empty_string ) {

		$randvel3d->{_r1}		= $r1;
		$randvel3d->{_note}		= $randvel3d->{_note}.' r1='.$randvel3d->{_r1};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' r1='.$randvel3d->{_r1};

	} else { 
		print("randvel3d, r1, missing r1,\n");
	 }
 }


=head2 sub r2 


=cut

 sub r2 {

	my ( $self,$r2 )		= @_;
	if ( $r2 ne $empty_string ) {

		$randvel3d->{_r2}		= $r2;
		$randvel3d->{_note}		= $randvel3d->{_note}.' r2='.$randvel3d->{_r2};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' r2='.$randvel3d->{_r2};

	} else { 
		print("randvel3d, r2, missing r2,\n");
	 }
 }


=head2 sub r3 


=cut

 sub r3 {

	my ( $self,$r3 )		= @_;
	if ( $r3 ne $empty_string ) {

		$randvel3d->{_r3}		= $r3;
		$randvel3d->{_note}		= $randvel3d->{_note}.' r3='.$randvel3d->{_r3};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' r3='.$randvel3d->{_r3};

	} else { 
		print("randvel3d, r3, missing r3,\n");
	 }
 }


=head2 sub seed 


=cut

 sub seed {

	my ( $self,$seed )		= @_;
	if ( $seed ne $empty_string ) {

		$randvel3d->{_seed}		= $seed;
		$randvel3d->{_note}		= $randvel3d->{_note}.' seed='.$randvel3d->{_seed};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' seed='.$randvel3d->{_seed};

	} else { 
		print("randvel3d, seed, missing seed,\n");
	 }
 }


=head2 sub slowness 


=cut

 sub slowness {

	my ( $self,$slowness )		= @_;
	if ( $slowness ne $empty_string ) {

		$randvel3d->{_slowness}		= $slowness;
		$randvel3d->{_note}		= $randvel3d->{_note}.' slowness='.$randvel3d->{_slowness};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' slowness='.$randvel3d->{_slowness};

	} else { 
		print("randvel3d, slowness, missing slowness,\n");
	 }
 }


=head2 sub v 


=cut

 sub v {

	my ( $self,$v )		= @_;
	if ( $v ne $empty_string ) {

		$randvel3d->{_v}		= $v;
		$randvel3d->{_note}		= $randvel3d->{_note}.' v='.$randvel3d->{_v};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' v='.$randvel3d->{_v};

	} else { 
		print("randvel3d, v, missing v,\n");
	 }
 }


=head2 sub vlsd 


=cut

 sub vlsd {

	my ( $self,$vlsd )		= @_;
	if ( $vlsd ne $empty_string ) {

		$randvel3d->{_vlsd}		= $vlsd;
		$randvel3d->{_note}		= $randvel3d->{_note}.' vlsd='.$randvel3d->{_vlsd};
		$randvel3d->{_Step}		= $randvel3d->{_Step}.' vlsd='.$randvel3d->{_vlsd};

	} else { 
		print("randvel3d, vlsd, missing vlsd,\n");
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