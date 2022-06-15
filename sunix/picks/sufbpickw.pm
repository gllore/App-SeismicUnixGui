package sufbpickw;

=head2 SYNOPSIS

PACKAGE NAME: 

AUTHOR:  

DATE:

DESCRIPTION:

Version:

=head2 USE

=head3 NOTES

=head4 Examples

=head2 SYNOPSIS

=head3 SEISMIC UNIX NOTES
 SUFBPICKW - First break auto picker				



   sufbpickw < infile >outfile					



 Required parameters:						

  none								

 Optional parameters:						

 keyg=ep						 	

 window=.03	Length of forward and backward windows (s)	

 test=1	Output the characteristic function	 	

		This can be used for testing window size	

 Template							

 o=		offset...				  	

 t=		time pairs for defining first break search	

			window centre				

 tdv=.05	Half length of the search window		



 If the template is specified the maximum value of the		

 characteristic function is searched in the window		

  defined by the template only.Default is the whole trace.	



  The time of the pick is stored in header word unscale 	



   

 segy data 

segy *trp;				/* SEGY trace array

segy trtp;				/* SEGY trace

int 

main( int argc, char *argv[] )

{

	

	segy **rec_o;	   /* trace header+data matrix  

	

	cwp_String keyg;

	cwp_String typeg;		

	Value valg;

		   	

	int first=0;		/* true when we passed the first gather

	int ng=0;

	float dt;

	int nt;

	int ntr;



	unsigned int np;	/* Number of points in pick template

	float *t=NULL;		/* array defining pick template times

	float *o=NULL;		/* array defining pick template offsets

	

	float window;

	int iwindow;

	int *itimes;

	int *itimes2;

	float *offset;

	float tdv;

	int itdv;

	float *find;

	int nowindow=0;

	int test=0;

	

	FILE *ttp;

		

	initargs(argc, argv);

   	requestdoc(1);

	

	if (!countparval("t")) {

		np=2;

		nowindow=1;

	} else {

		np=countparval("t");

	}

	

	if(!nowindow) { 

		t  = ealloc1float(np);

		o  = ealloc1float(np);

	

		if( np == countparval("o")) {

			getparfloat("t",t);

			getparfloat("o",o);

		} else {

			err(" t and o has different number of elements\n");

		}

	}







	ttp = efopen("test.su","w");

		

	if (!getparstring("keyg", &keyg)) keyg ="ep";

	

	if (!getparfloat("window",&window)) window =0.02;

	if (!getparfloat("tdv",&tdv)) tdv = -1.0;

	if (!getparint("test",&test)) test = 1;

	

        checkpars();

	/* get information from the first header

	rec_o = get_gather(&keyg,&typeg,&valg,&nt,&ntr,&dt,&first);

	

	iwindow=NINT(window/dt);

	if(tdv==-1.0) {

		itdv=nt;

	} else {

		itdv=NINT(2.0*tdv/dt);

	}

	

	if(ntr==0) err("Can't get first record\n");

	do {

		ng++;

		

		itimes = ealloc1int(ntr);

		itimes2 = ealloc1int(ntr);

		offset = ealloc1float(ntr);

		

		/* Phase 1

		/* Loop through traces

		{ int itr,ifbt;

		  int it;

		  float fbt;

		  float ampb;		

		  float ampf;

		  float *wf,*wb;

		  float *cf;		/* Characteristic function

		  

		  

		  cf=ealloc1float(nt);

		  find=ealloc1float(nt);

		  for(it=0;it<nt;it++)

		  	find[it]=(float)it;

		  

		  for(itr=0;itr<ntr;itr++) {

		  

		  	memset( (void *) cf, (int) '\0', nt*FSIZE);

			

			if(nowindow) {

				ifbt=0;

			} else {

		  	/* Linear inperpolation of estimtated fb time

				offset[itr] =(*rec_o[itr]).offset; 

		  		intlin(np,o,t,t[0],t[np-1],1,&offset[itr],&fbt);

		  		ifbt = NINT(fbt/dt);

			}

			

		  

			wb = &(*rec_o[itr]).data[0];

			wf = &(*rec_o[itr]).data[iwindow];

			ampb = sasum(iwindow,wb,1)+FLT_EPSILON;

			ampf = sasum(iwindow,wf,1)+FLT_EPSILON;

		  	for(it=iwindow;it<nt-iwindow-1;it++) {

				cf[it] = ampf/ampb;

				/* setup next window

				ampb -= fabs((*rec_o[itr]).data[it-iwindow]);

				ampf -= fabs((*rec_o[itr]).data[it]);

				ampb += fabs((*rec_o[itr]).data[it]);

				ampf += fabs((*rec_o[itr]).data[it+iwindow]);

			}

			/* Smooth the characteristic function

			smooth_segmented_array(&find[iwindow],&cf[iwindow],nt-iwindow-1,iwindow,1,5);

		  	

			/* find the maximum*/

			it=MIN(MAX(ifbt-itdv/2,0),nt-1);

			



			wb = &cf[it];

			

			itimes[itr] = isamax(itdv,wb,1)+it;

			

			/* Final check

			if(itimes[itr] == ifbt-itdv/2 || itimes[itr] == ifbt+itdv/2)

				itimes[itr]=0;

				 

			(*rec_o[itr]).unscale=dt*itimes[itr];

			

			if(test)

				memcpy( (void *) &(*rec_o[itr]).data[0], (const void *) cf, nt*FSIZE);



		  }

		  free1float(cf);

		  free1float(find);

		}



		free1int(itimes);

		free1int(itimes2);

		free1float(offset);

		

		rec_o = put_gather(rec_o,&nt,&ntr);

		rec_o = get_gather(&keyg,&typeg,&valg,&nt,&ntr,&dt,&first);

	} while(ntr);

	return EXIT_SUCCESS;



}

=head2 User's notes (Juan Lorenzo)
untested

=cut


=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';


=head2 Import packages

=cut

use L_SU_global_constants();

use SeismicUnix qw ($go $in $off $on $out $ps $to $suffix_ascii $suffix_bin $suffix_ps $suffix_segy $suffix_su);
use Project_config;


=head2 instantiation of packages

=cut

my $get					= new L_SU_global_constants();
my $Project				= new Project_config();
my $DATA_SEISMIC_SU		= $Project->DATA_SEISMIC_SU();
my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN();
my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT();

my $PS_SEISMIC      	= $Project->PS_SEISMIC();

my $var				= $get->var();
my $on				= $var->{_on};
my $off				= $var->{_off};
my $true			= $var->{_true};
my $false			= $var->{_false};
my $empty_string	= $var->{_empty_string};

=head2 Encapsulated
hash of private variables

=cut

my $sufbpickw			= {
	_ampb					=> '',
	_ampf					=> '',
	_cf					=> '',
	_find					=> '',
	_first					=> '',
	_ifbt					=> '',
	_it					=> '',
	_itdv					=> '',
	_itimes					=> '',
	_itimes2					=> '',
	_itr					=> '',
	_iwindow					=> '',
	_keyg					=> '',
	_ng					=> '',
	_nowindow					=> '',
	_np					=> '',
	_ntr					=> '',
	_o					=> '',
	_offset					=> '',
	_rec_o					=> '',
	_t					=> '',
	_tdv					=> '',
	_test					=> '',
	_ttp					=> '',
	_unscale					=> '',
	_wb					=> '',
	_wf					=> '',
	_window					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$sufbpickw->{_Step}     = 'sufbpickw'.$sufbpickw->{_Step};
	return ( $sufbpickw->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$sufbpickw->{_note}     = 'sufbpickw'.$sufbpickw->{_note};
	return ( $sufbpickw->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$sufbpickw->{_ampb}			= '';
		$sufbpickw->{_ampf}			= '';
		$sufbpickw->{_cf}			= '';
		$sufbpickw->{_find}			= '';
		$sufbpickw->{_first}			= '';
		$sufbpickw->{_ifbt}			= '';
		$sufbpickw->{_it}			= '';
		$sufbpickw->{_itdv}			= '';
		$sufbpickw->{_itimes}			= '';
		$sufbpickw->{_itimes2}			= '';
		$sufbpickw->{_itr}			= '';
		$sufbpickw->{_iwindow}			= '';
		$sufbpickw->{_keyg}			= '';
		$sufbpickw->{_ng}			= '';
		$sufbpickw->{_nowindow}			= '';
		$sufbpickw->{_np}			= '';
		$sufbpickw->{_ntr}			= '';
		$sufbpickw->{_o}			= '';
		$sufbpickw->{_offset}			= '';
		$sufbpickw->{_rec_o}			= '';
		$sufbpickw->{_t}			= '';
		$sufbpickw->{_tdv}			= '';
		$sufbpickw->{_test}			= '';
		$sufbpickw->{_ttp}			= '';
		$sufbpickw->{_unscale}			= '';
		$sufbpickw->{_wb}			= '';
		$sufbpickw->{_wf}			= '';
		$sufbpickw->{_window}			= '';
		$sufbpickw->{_Step}			= '';
		$sufbpickw->{_note}			= '';
 }


=head2 sub ampb 


=cut

 sub ampb {

	my ( $self,$ampb )		= @_;
	if ( $ampb ne $empty_string ) {

		$sufbpickw->{_ampb}		= $ampb;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' ampb='.$sufbpickw->{_ampb};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' ampb='.$sufbpickw->{_ampb};

	} else { 
		print("sufbpickw, ampb, missing ampb,\n");
	 }
 }


=head2 sub ampf 


=cut

 sub ampf {

	my ( $self,$ampf )		= @_;
	if ( $ampf ne $empty_string ) {

		$sufbpickw->{_ampf}		= $ampf;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' ampf='.$sufbpickw->{_ampf};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' ampf='.$sufbpickw->{_ampf};

	} else { 
		print("sufbpickw, ampf, missing ampf,\n");
	 }
 }


=head2 sub cf 


=cut

 sub cf {

	my ( $self,$cf )		= @_;
	if ( $cf ne $empty_string ) {

		$sufbpickw->{_cf}		= $cf;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' cf='.$sufbpickw->{_cf};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' cf='.$sufbpickw->{_cf};

	} else { 
		print("sufbpickw, cf, missing cf,\n");
	 }
 }


=head2 sub find 


=cut

 sub find {

	my ( $self,$find )		= @_;
	if ( $find ne $empty_string ) {

		$sufbpickw->{_find}		= $find;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' find='.$sufbpickw->{_find};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' find='.$sufbpickw->{_find};

	} else { 
		print("sufbpickw, find, missing find,\n");
	 }
 }


=head2 sub first 


=cut

 sub first {

	my ( $self,$first )		= @_;
	if ( $first ne $empty_string ) {

		$sufbpickw->{_first}		= $first;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' first='.$sufbpickw->{_first};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' first='.$sufbpickw->{_first};

	} else { 
		print("sufbpickw, first, missing first,\n");
	 }
 }


=head2 sub ifbt 


=cut

 sub ifbt {

	my ( $self,$ifbt )		= @_;
	if ( $ifbt ne $empty_string ) {

		$sufbpickw->{_ifbt}		= $ifbt;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' ifbt='.$sufbpickw->{_ifbt};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' ifbt='.$sufbpickw->{_ifbt};

	} else { 
		print("sufbpickw, ifbt, missing ifbt,\n");
	 }
 }


=head2 sub it 


=cut

 sub it {

	my ( $self,$it )		= @_;
	if ( $it ne $empty_string ) {

		$sufbpickw->{_it}		= $it;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' it='.$sufbpickw->{_it};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' it='.$sufbpickw->{_it};

	} else { 
		print("sufbpickw, it, missing it,\n");
	 }
 }


=head2 sub itdv 


=cut

 sub itdv {

	my ( $self,$itdv )		= @_;
	if ( $itdv ne $empty_string ) {

		$sufbpickw->{_itdv}		= $itdv;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' itdv='.$sufbpickw->{_itdv};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' itdv='.$sufbpickw->{_itdv};

	} else { 
		print("sufbpickw, itdv, missing itdv,\n");
	 }
 }


=head2 sub itimes 


=cut

 sub itimes {

	my ( $self,$itimes )		= @_;
	if ( $itimes ne $empty_string ) {

		$sufbpickw->{_itimes}		= $itimes;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' itimes='.$sufbpickw->{_itimes};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' itimes='.$sufbpickw->{_itimes};

	} else { 
		print("sufbpickw, itimes, missing itimes,\n");
	 }
 }


=head2 sub itimes2 


=cut

 sub itimes2 {

	my ( $self,$itimes2 )		= @_;
	if ( $itimes2 ne $empty_string ) {

		$sufbpickw->{_itimes2}		= $itimes2;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' itimes2='.$sufbpickw->{_itimes2};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' itimes2='.$sufbpickw->{_itimes2};

	} else { 
		print("sufbpickw, itimes2, missing itimes2,\n");
	 }
 }


=head2 sub itr 


=cut

 sub itr {

	my ( $self,$itr )		= @_;
	if ( $itr ne $empty_string ) {

		$sufbpickw->{_itr}		= $itr;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' itr='.$sufbpickw->{_itr};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' itr='.$sufbpickw->{_itr};

	} else { 
		print("sufbpickw, itr, missing itr,\n");
	 }
 }


=head2 sub iwindow 


=cut

 sub iwindow {

	my ( $self,$iwindow )		= @_;
	if ( $iwindow ne $empty_string ) {

		$sufbpickw->{_iwindow}		= $iwindow;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' iwindow='.$sufbpickw->{_iwindow};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' iwindow='.$sufbpickw->{_iwindow};

	} else { 
		print("sufbpickw, iwindow, missing iwindow,\n");
	 }
 }


=head2 sub keyg 


=cut

 sub keyg {

	my ( $self,$keyg )		= @_;
	if ( $keyg ne $empty_string ) {

		$sufbpickw->{_keyg}		= $keyg;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' keyg='.$sufbpickw->{_keyg};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' keyg='.$sufbpickw->{_keyg};

	} else { 
		print("sufbpickw, keyg, missing keyg,\n");
	 }
 }


=head2 sub ng 


=cut

 sub ng {

	my ( $self,$ng )		= @_;
	if ( $ng ne $empty_string ) {

		$sufbpickw->{_ng}		= $ng;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' ng='.$sufbpickw->{_ng};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' ng='.$sufbpickw->{_ng};

	} else { 
		print("sufbpickw, ng, missing ng,\n");
	 }
 }


=head2 sub nowindow 


=cut

 sub nowindow {

	my ( $self,$nowindow )		= @_;
	if ( $nowindow ne $empty_string ) {

		$sufbpickw->{_nowindow}		= $nowindow;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' nowindow='.$sufbpickw->{_nowindow};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' nowindow='.$sufbpickw->{_nowindow};

	} else { 
		print("sufbpickw, nowindow, missing nowindow,\n");
	 }
 }


=head2 sub np 


=cut

 sub np {

	my ( $self,$np )		= @_;
	if ( $np ne $empty_string ) {

		$sufbpickw->{_np}		= $np;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' np='.$sufbpickw->{_np};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' np='.$sufbpickw->{_np};

	} else { 
		print("sufbpickw, np, missing np,\n");
	 }
 }


=head2 sub ntr 


=cut

 sub ntr {

	my ( $self,$ntr )		= @_;
	if ( $ntr ne $empty_string ) {

		$sufbpickw->{_ntr}		= $ntr;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' ntr='.$sufbpickw->{_ntr};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' ntr='.$sufbpickw->{_ntr};

	} else { 
		print("sufbpickw, ntr, missing ntr,\n");
	 }
 }


=head2 sub o 


=cut

 sub o {

	my ( $self,$o )		= @_;
	if ( $o ne $empty_string ) {

		$sufbpickw->{_o}		= $o;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' o='.$sufbpickw->{_o};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' o='.$sufbpickw->{_o};

	} else { 
		print("sufbpickw, o, missing o,\n");
	 }
 }


=head2 sub offset 


=cut

 sub offset {

	my ( $self,$offset )		= @_;
	if ( $offset ne $empty_string ) {

		$sufbpickw->{_offset}		= $offset;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' offset='.$sufbpickw->{_offset};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' offset='.$sufbpickw->{_offset};

	} else { 
		print("sufbpickw, offset, missing offset,\n");
	 }
 }


=head2 sub rec_o 


=cut

 sub rec_o {

	my ( $self,$rec_o )		= @_;
	if ( $rec_o ne $empty_string ) {

		$sufbpickw->{_rec_o}		= $rec_o;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' rec_o='.$sufbpickw->{_rec_o};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' rec_o='.$sufbpickw->{_rec_o};

	} else { 
		print("sufbpickw, rec_o, missing rec_o,\n");
	 }
 }


=head2 sub t 


=cut

 sub t {

	my ( $self,$t )		= @_;
	if ( $t ne $empty_string ) {

		$sufbpickw->{_t}		= $t;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' t='.$sufbpickw->{_t};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' t='.$sufbpickw->{_t};

	} else { 
		print("sufbpickw, t, missing t,\n");
	 }
 }


=head2 sub tdv 


=cut

 sub tdv {

	my ( $self,$tdv )		= @_;
	if ( $tdv ne $empty_string ) {

		$sufbpickw->{_tdv}		= $tdv;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' tdv='.$sufbpickw->{_tdv};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' tdv='.$sufbpickw->{_tdv};

	} else { 
		print("sufbpickw, tdv, missing tdv,\n");
	 }
 }


=head2 sub test 


=cut

 sub test {

	my ( $self,$test )		= @_;
	if ( $test ne $empty_string ) {

		$sufbpickw->{_test}		= $test;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' test='.$sufbpickw->{_test};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' test='.$sufbpickw->{_test};

	} else { 
		print("sufbpickw, test, missing test,\n");
	 }
 }


=head2 sub ttp 


=cut

 sub ttp {

	my ( $self,$ttp )		= @_;
	if ( $ttp ne $empty_string ) {

		$sufbpickw->{_ttp}		= $ttp;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' ttp='.$sufbpickw->{_ttp};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' ttp='.$sufbpickw->{_ttp};

	} else { 
		print("sufbpickw, ttp, missing ttp,\n");
	 }
 }


=head2 sub unscale 


=cut

 sub unscale {

	my ( $self,$unscale )		= @_;
	if ( $unscale ne $empty_string ) {

		$sufbpickw->{_unscale}		= $unscale;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' unscale='.$sufbpickw->{_unscale};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' unscale='.$sufbpickw->{_unscale};

	} else { 
		print("sufbpickw, unscale, missing unscale,\n");
	 }
 }


=head2 sub wb 


=cut

 sub wb {

	my ( $self,$wb )		= @_;
	if ( $wb ne $empty_string ) {

		$sufbpickw->{_wb}		= $wb;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' wb='.$sufbpickw->{_wb};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' wb='.$sufbpickw->{_wb};

	} else { 
		print("sufbpickw, wb, missing wb,\n");
	 }
 }


=head2 sub wf 


=cut

 sub wf {

	my ( $self,$wf )		= @_;
	if ( $wf ne $empty_string ) {

		$sufbpickw->{_wf}		= $wf;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' wf='.$sufbpickw->{_wf};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' wf='.$sufbpickw->{_wf};

	} else { 
		print("sufbpickw, wf, missing wf,\n");
	 }
 }


=head2 sub window 


=cut

 sub window {

	my ( $self,$window )		= @_;
	if ( $window ne $empty_string ) {

		$sufbpickw->{_window}		= $window;
		$sufbpickw->{_note}		= $sufbpickw->{_note}.' window='.$sufbpickw->{_window};
		$sufbpickw->{_Step}		= $sufbpickw->{_Step}.' window='.$sufbpickw->{_window};

	} else { 
		print("sufbpickw, window, missing window,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
	my $max_index = 27;

    return($max_index);
}
 
 
1;
