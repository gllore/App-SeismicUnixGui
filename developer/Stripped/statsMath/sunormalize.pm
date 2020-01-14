 package sunormalize;


=head1 DOCUMENTATION

=head2 SYNOPSIS

 PACKAGE NAME:  SUNORMALIZE - Trace NORMALIZation by rms, max, or median       ", 
 AUTHOR: Juan Lorenzo
 DATE:   
 DESCRIPTION:
 Version: 

=head2 USE

=head3 NOTES

=head4 Examples

=head3 SEISMIC UNIX NOTES

 SUNORMALIZE - Trace NORMALIZation by rms, max, or median       ", 
               or median balancing                              

   sunormalize <stdin >stdout t0=0 t1=TMAX norm=rms             

 Required parameters:                                           
    dt=tr.dt    if not set in header, dt is mandatory           
    ns=tr.ns    if not set in header, ns is mandatory           

 Optional parameters:                                           
    norm=rms    type of norm rms, max, med , balmed             
    t0=0.0      startimg time for window                        
    t1=TMAX     ending time for window                          

 Notes:                                                         
 Traces are divided by either the root mean squared amplitude,  
 trace maximum, or the median value. The option "balmed" is   
 median balancing which is a shift of the amplitudes by the	 
 median value of the amplitudes.				 



 Author: Ramone Carbonell, 
         Inst. Earth Sciences-CSIC Barcelona, Spain, April 1998.
 Modifications: Nils Maercklin,
         RISSC, University of Naples, Italy, September 2006
         (fixed user input of ns, dt, if values are not set in header).

 Trace header fields accessed: ns, dt
 Trace header fields modified: none

=head2 CHANGES and their DATES

=cut
 use Moose;
 our $VERSION = '0.0.1';
	use L_SU_global_constants();

	my $get					= new L_SU_global_constants();

	my $var				= $get->var();
	my $empty_string    	= $var->{_empty_string};


	my $sunormalize		= {
		_dt					=> '',
		_norm					=> '',
		_ns					=> '',
		_t0					=> '',
		_t1					=> '',
		_Step					=> '',
		_note					=> '',
    };


=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sunormalize->{_Step}     = 'sunormalize'.$sunormalize->{_Step};
	return ( $sunormalize->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sunormalize->{_note}     = 'sunormalize'.$sunormalize->{_note};
	return ( $sunormalize->{_note} );

 }


=head2 sub clear

=cut

 sub clear {

		$sunormalize->{_dt}			= '';
		$sunormalize->{_norm}			= '';
		$sunormalize->{_ns}			= '';
		$sunormalize->{_t0}			= '';
		$sunormalize->{_t1}			= '';
		$sunormalize->{_Step}			= '';
		$sunormalize->{_note}			= '';
 }


=head2 sub dt 


=cut

 sub dt {

	my ( $self,$dt )		= @_;
	if ( $dt ne $empty_string ) {

		$sunormalize->{_dt}		= $dt;
		$sunormalize->{_note}		= $sunormalize->{_note}.' dt='.$sunormalize->{_dt};
		$sunormalize->{_Step}		= $sunormalize->{_Step}.' dt='.$sunormalize->{_dt};

	} else { 
		print("sunormalize, dt, missing dt,\n");
	 }
 }


=head2 sub norm 


=cut

 sub norm {

	my ( $self,$norm )		= @_;
	if ( $norm ne $empty_string ) {

		$sunormalize->{_norm}		= $norm;
		$sunormalize->{_note}		= $sunormalize->{_note}.' norm='.$sunormalize->{_norm};
		$sunormalize->{_Step}		= $sunormalize->{_Step}.' norm='.$sunormalize->{_norm};

	} else { 
		print("sunormalize, norm, missing norm,\n");
	 }
 }


=head2 sub ns 


=cut

 sub ns {

	my ( $self,$ns )		= @_;
	if ( $ns ne $empty_string ) {

		$sunormalize->{_ns}		= $ns;
		$sunormalize->{_note}		= $sunormalize->{_note}.' ns='.$sunormalize->{_ns};
		$sunormalize->{_Step}		= $sunormalize->{_Step}.' ns='.$sunormalize->{_ns};

	} else { 
		print("sunormalize, ns, missing ns,\n");
	 }
 }


=head2 sub t0 


=cut

 sub t0 {

	my ( $self,$t0 )		= @_;
	if ( $t0 ne $empty_string ) {

		$sunormalize->{_t0}		= $t0;
		$sunormalize->{_note}		= $sunormalize->{_note}.' t0='.$sunormalize->{_t0};
		$sunormalize->{_Step}		= $sunormalize->{_Step}.' t0='.$sunormalize->{_t0};

	} else { 
		print("sunormalize, t0, missing t0,\n");
	 }
 }


=head2 sub t1 


=cut

 sub t1 {

	my ( $self,$t1 )		= @_;
	if ( $t1 ne $empty_string ) {

		$sunormalize->{_t1}		= $t1;
		$sunormalize->{_note}		= $sunormalize->{_note}.' t1='.$sunormalize->{_t1};
		$sunormalize->{_Step}		= $sunormalize->{_Step}.' t1='.$sunormalize->{_t1};

	} else { 
		print("sunormalize, t1, missing t1,\n");
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