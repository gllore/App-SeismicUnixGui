package unif2aniso;

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
    DATA_SEISMIC_BIN                   = $Project->DATA_SEISMIC_BIN();

    DATA_SEISMIC_SU                    = $Project->DATA_SEISMIC_SU();

    DATA_SEISMIC_TXT                   = $Project->DATA_SEISMIC_TXT();

    Project                            = new                 

    VERSION                            = '0.0.1';            

    _Step                              = >                   

    _c11_file                          = >                   

    _c13_file                          = >                   

    _c15_file                          = >                   

    _c33_file                          = >                   

    _c35_file                          = >                   

    _c44_file                          = >                   

    _c55_file                          = >                   

    _c66_file                          = >                   

    _dddx                              = >                   

    _dddz                              = >                   

    _dedx                              = >                   

    _dedz                              = >                   

    _delta00                           = >                   

    _dgdx                              = >                   

    _dgdz                              = >                   

    _dqdx                              = >                   

    _dqdz                              = >                   

    _drdx                              = >                   

    _drdz                              = >                   

    _dvpdx                             = >                   

    _dvpdz                             = >                   

    _dvsdx                             = >                   

    _dvsdz                             = >                   

    _dx                                = >                   

    _dz                                = >                   

    _eps00                             = >                   

    _fx                                = >                   

    _fz                                = >                   

    _gamma00                           = >                   

    _method                            = >                   

    _n1                                = >                   

    _ninf                              = >                   

    _note                              = >                   

    _npmax                             = >                   

    _nx                                = >                   

    _nz                                = >                   

    _paramtype                         = >                   

    _phi00                             = >                   

    _q00                               = >                   

    _q_file                            = >                   

    _rho00                             = >                   

    _rho_file                          = >                   

    _tfile                             = >                   

    _vp00                              = >                   

    _vs00                              = >                   

    _x0                                = >                   

    _z0                                = >                   

    c11_file                           = '.$unif2aniso->{_c11_file};

    c13_file                           = '.$unif2aniso->{_c13_file};

    c15_file                           = '.$unif2aniso->{_c15_file};

    c33_file                           = '.$unif2aniso->{_c33_file};

    c35_file                           = '.$unif2aniso->{_c35_file};

    c44_file                           = '.$unif2aniso->{_c44_file};

    c55_file                           = '.$unif2aniso->{_c55_file};

    c66_file                           = '.$unif2aniso->{_c66_file};

    dddx                               = '.$unif2aniso->{_dddx};

    dddz                               = '.$unif2aniso->{_dddz};

    dedx                               = '.$unif2aniso->{_dedx};

    dedz                               = '.$unif2aniso->{_dedz};

    delta00                            = '.$unif2aniso->{_delta00};

    dgdx                               = '.$unif2aniso->{_dgdx};

    dgdz                               = '.$unif2aniso->{_dgdz};

    dqdx                               = '.$unif2aniso->{_dqdx};

    dqdz                               = '.$unif2aniso->{_dqdz};

    drdx                               = '.$unif2aniso->{_drdx};

    drdz                               = '.$unif2aniso->{_drdz};

    dvpdx                              = '.$unif2aniso->{_dvpdx};

    dvpdz                              = '.$unif2aniso->{_dvpdz};

    dvsdx                              = '.$unif2aniso->{_dvsdx};

    dvsdz                              = '.$unif2aniso->{_dvsdz};

    dx                                 = '.$unif2aniso->{_dx};

    dz                                 = '.$unif2aniso->{_dz};

    empty_string                       = $var->{_empty_string};

    eps00                              = '.$unif2aniso->{_eps00};

    false                              = $var->{_false};     

    fx                                 = '.$unif2aniso->{_fx};

    fz                                 = '.$unif2aniso->{_fz};

    gamma00                            = '.$unif2aniso->{_gamma00};

    get                                = new                 

    index                              = number              

    max_index                          = 36;                 

    method                             = '.$unif2aniso->{_method};

    n1                                 = '.$unif2aniso->{_n1};

    ninf                               = '.$unif2aniso->{_ninf};

    npmax                              = '.$unif2aniso->{_npmax};

    nx                                 = '.$unif2aniso->{_nx};

    nz                                 = '.$unif2aniso->{_nz};

    off                                = $var->{_off};       

    on                                 = $var->{_on};        

    paramtype                          = '.$unif2aniso->{_paramtype};

    phi00                              = '.$unif2aniso->{_phi00};

    q00                                = '.$unif2aniso->{_q00};

    q_file                             = '.$unif2aniso->{_q_file};

    rho00                              = '.$unif2aniso->{_rho00};

    rho_file                           = '.$unif2aniso->{_rho_file};

    tfile                              = '.$unif2aniso->{_tfile};

    true                               = $var->{_true};      

    unif2aniso                         = {                   

    var                                = $get->var();        

    vp00                               = '.$unif2aniso->{_vp00};

    vs00                               = '.$unif2aniso->{_vs00};

    x0                                 = '.$unif2aniso->{_x0};

    z0                                 = '.$unif2aniso->{_z0};

=head2 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';


=head2 Import packages

=cut

use L_SU_global_constants();

use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $suffix_bin);
use Project_config;


=head2 instantiation of packages

=cut

my $get					= new L_SU_global_constants();
my $Project				= new Project_config();
my $DATA_SEISMIC_SU		= $Project->DATA_SEISMIC_SU();
my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN();
my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT();

my $var				= $get->var();
my $on				= $var->{_on};
my $off				= $var->{_off};
my $true			= $var->{_true};
my $false			= $var->{_false};
my $empty_string	= $var->{_empty_string};

=head2 Encapsulated
hash of private variables

=cut

my $unif2aniso			= {
	_DATA_SEISMIC_BIN					=> '',
	_DATA_SEISMIC_SU					=> '',
	_DATA_SEISMIC_TXT					=> '',
	_Project					=> '',
	_VERSION					=> '',
	__Step					=> '',
	__c11_file					=> '',
	__c13_file					=> '',
	__c15_file					=> '',
	__c33_file					=> '',
	__c35_file					=> '',
	__c44_file					=> '',
	__c55_file					=> '',
	__c66_file					=> '',
	__dddx					=> '',
	__dddz					=> '',
	__dedx					=> '',
	__dedz					=> '',
	__delta00					=> '',
	__dgdx					=> '',
	__dgdz					=> '',
	__dqdx					=> '',
	__dqdz					=> '',
	__drdx					=> '',
	__drdz					=> '',
	__dvpdx					=> '',
	__dvpdz					=> '',
	__dvsdx					=> '',
	__dvsdz					=> '',
	__dx					=> '',
	__dz					=> '',
	__eps00					=> '',
	__fx					=> '',
	__fz					=> '',
	__gamma00					=> '',
	__method					=> '',
	__n1					=> '',
	__ninf					=> '',
	__note					=> '',
	__npmax					=> '',
	__nx					=> '',
	__nz					=> '',
	__paramtype					=> '',
	__phi00					=> '',
	__q00					=> '',
	__q_file					=> '',
	__rho00					=> '',
	__rho_file					=> '',
	__tfile					=> '',
	__vp00					=> '',
	__vs00					=> '',
	__x0					=> '',
	__z0					=> '',
	_c11_file					=> '',
	_c13_file					=> '',
	_c15_file					=> '',
	_c33_file					=> '',
	_c35_file					=> '',
	_c44_file					=> '',
	_c55_file					=> '',
	_c66_file					=> '',
	_dddx					=> '',
	_dddz					=> '',
	_dedx					=> '',
	_dedz					=> '',
	_delta00					=> '',
	_dgdx					=> '',
	_dgdz					=> '',
	_dqdx					=> '',
	_dqdz					=> '',
	_drdx					=> '',
	_drdz					=> '',
	_dvpdx					=> '',
	_dvpdz					=> '',
	_dvsdx					=> '',
	_dvsdz					=> '',
	_dx					=> '',
	_dz					=> '',
	_empty_string					=> '',
	_eps00					=> '',
	_false					=> '',
	_fx					=> '',
	_fz					=> '',
	_gamma00					=> '',
	_get					=> '',
	_index					=> '',
	_max_index					=> '',
	_method					=> '',
	_n1					=> '',
	_ninf					=> '',
	_npmax					=> '',
	_nx					=> '',
	_nz					=> '',
	_off					=> '',
	_on					=> '',
	_paramtype					=> '',
	_phi00					=> '',
	_q00					=> '',
	_q_file					=> '',
	_rho00					=> '',
	_rho_file					=> '',
	_tfile					=> '',
	_true					=> '',
	_unif2aniso					=> '',
	_var					=> '',
	_vp00					=> '',
	_vs00					=> '',
	_x0					=> '',
	_z0					=> '',
	_Step					=> '',
	_note					=> '',

};

=head2 sub Step

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  Step {

	$unif2aniso->{_Step}     = 'unif2aniso'.$unif2aniso->{_Step};
	return ( $unif2aniso->{_Step} );

 }


=head2 sub note

collects switches and assembles bash instructions
by adding the program name

=cut

 sub  note {

	$unif2aniso->{_note}     = 'unif2aniso'.$unif2aniso->{_note};
	return ( $unif2aniso->{_note} );

 }



=head2 sub clear

=cut

 sub clear {

		$unif2aniso->{_DATA_SEISMIC_BIN}			= '';
		$unif2aniso->{_DATA_SEISMIC_SU}			= '';
		$unif2aniso->{_DATA_SEISMIC_TXT}			= '';
		$unif2aniso->{_Project}			= '';
		$unif2aniso->{_VERSION}			= '';
		$unif2aniso->{__Step}			= '';
		$unif2aniso->{__c11_file}			= '';
		$unif2aniso->{__c13_file}			= '';
		$unif2aniso->{__c15_file}			= '';
		$unif2aniso->{__c33_file}			= '';
		$unif2aniso->{__c35_file}			= '';
		$unif2aniso->{__c44_file}			= '';
		$unif2aniso->{__c55_file}			= '';
		$unif2aniso->{__c66_file}			= '';
		$unif2aniso->{__dddx}			= '';
		$unif2aniso->{__dddz}			= '';
		$unif2aniso->{__dedx}			= '';
		$unif2aniso->{__dedz}			= '';
		$unif2aniso->{__delta00}			= '';
		$unif2aniso->{__dgdx}			= '';
		$unif2aniso->{__dgdz}			= '';
		$unif2aniso->{__dqdx}			= '';
		$unif2aniso->{__dqdz}			= '';
		$unif2aniso->{__drdx}			= '';
		$unif2aniso->{__drdz}			= '';
		$unif2aniso->{__dvpdx}			= '';
		$unif2aniso->{__dvpdz}			= '';
		$unif2aniso->{__dvsdx}			= '';
		$unif2aniso->{__dvsdz}			= '';
		$unif2aniso->{__dx}			= '';
		$unif2aniso->{__dz}			= '';
		$unif2aniso->{__eps00}			= '';
		$unif2aniso->{__fx}			= '';
		$unif2aniso->{__fz}			= '';
		$unif2aniso->{__gamma00}			= '';
		$unif2aniso->{__method}			= '';
		$unif2aniso->{__n1}			= '';
		$unif2aniso->{__ninf}			= '';
		$unif2aniso->{__note}			= '';
		$unif2aniso->{__npmax}			= '';
		$unif2aniso->{__nx}			= '';
		$unif2aniso->{__nz}			= '';
		$unif2aniso->{__paramtype}			= '';
		$unif2aniso->{__phi00}			= '';
		$unif2aniso->{__q00}			= '';
		$unif2aniso->{__q_file}			= '';
		$unif2aniso->{__rho00}			= '';
		$unif2aniso->{__rho_file}			= '';
		$unif2aniso->{__tfile}			= '';
		$unif2aniso->{__vp00}			= '';
		$unif2aniso->{__vs00}			= '';
		$unif2aniso->{__x0}			= '';
		$unif2aniso->{__z0}			= '';
		$unif2aniso->{_c11_file}			= '';
		$unif2aniso->{_c13_file}			= '';
		$unif2aniso->{_c15_file}			= '';
		$unif2aniso->{_c33_file}			= '';
		$unif2aniso->{_c35_file}			= '';
		$unif2aniso->{_c44_file}			= '';
		$unif2aniso->{_c55_file}			= '';
		$unif2aniso->{_c66_file}			= '';
		$unif2aniso->{_dddx}			= '';
		$unif2aniso->{_dddz}			= '';
		$unif2aniso->{_dedx}			= '';
		$unif2aniso->{_dedz}			= '';
		$unif2aniso->{_delta00}			= '';
		$unif2aniso->{_dgdx}			= '';
		$unif2aniso->{_dgdz}			= '';
		$unif2aniso->{_dqdx}			= '';
		$unif2aniso->{_dqdz}			= '';
		$unif2aniso->{_drdx}			= '';
		$unif2aniso->{_drdz}			= '';
		$unif2aniso->{_dvpdx}			= '';
		$unif2aniso->{_dvpdz}			= '';
		$unif2aniso->{_dvsdx}			= '';
		$unif2aniso->{_dvsdz}			= '';
		$unif2aniso->{_dx}			= '';
		$unif2aniso->{_dz}			= '';
		$unif2aniso->{_empty_string}			= '';
		$unif2aniso->{_eps00}			= '';
		$unif2aniso->{_false}			= '';
		$unif2aniso->{_fx}			= '';
		$unif2aniso->{_fz}			= '';
		$unif2aniso->{_gamma00}			= '';
		$unif2aniso->{_get}			= '';
		$unif2aniso->{_index}			= '';
		$unif2aniso->{_max_index}			= '';
		$unif2aniso->{_method}			= '';
		$unif2aniso->{_n1}			= '';
		$unif2aniso->{_ninf}			= '';
		$unif2aniso->{_npmax}			= '';
		$unif2aniso->{_nx}			= '';
		$unif2aniso->{_nz}			= '';
		$unif2aniso->{_off}			= '';
		$unif2aniso->{_on}			= '';
		$unif2aniso->{_paramtype}			= '';
		$unif2aniso->{_phi00}			= '';
		$unif2aniso->{_q00}			= '';
		$unif2aniso->{_q_file}			= '';
		$unif2aniso->{_rho00}			= '';
		$unif2aniso->{_rho_file}			= '';
		$unif2aniso->{_tfile}			= '';
		$unif2aniso->{_true}			= '';
		$unif2aniso->{_unif2aniso}			= '';
		$unif2aniso->{_var}			= '';
		$unif2aniso->{_vp00}			= '';
		$unif2aniso->{_vs00}			= '';
		$unif2aniso->{_x0}			= '';
		$unif2aniso->{_z0}			= '';
		$unif2aniso->{_Step}			= '';
		$unif2aniso->{_note}			= '';
 }


=head2 sub DATA_SEISMIC_BIN 


=cut

 sub DATA_SEISMIC_BIN {

	my ( $self,$DATA_SEISMIC_BIN )		= @_;
	if ( $DATA_SEISMIC_BIN ne $empty_string ) {

		$unif2aniso->{_DATA_SEISMIC_BIN}		= $DATA_SEISMIC_BIN;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' DATA_SEISMIC_BIN='.$unif2aniso->{_DATA_SEISMIC_BIN};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' DATA_SEISMIC_BIN='.$unif2aniso->{_DATA_SEISMIC_BIN};

	} else { 
		print("unif2aniso, DATA_SEISMIC_BIN, missing DATA_SEISMIC_BIN,\n");
	 }
 }


=head2 sub DATA_SEISMIC_SU 


=cut

 sub DATA_SEISMIC_SU {

	my ( $self,$DATA_SEISMIC_SU )		= @_;
	if ( $DATA_SEISMIC_SU ne $empty_string ) {

		$unif2aniso->{_DATA_SEISMIC_SU}		= $DATA_SEISMIC_SU;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' DATA_SEISMIC_SU='.$unif2aniso->{_DATA_SEISMIC_SU};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' DATA_SEISMIC_SU='.$unif2aniso->{_DATA_SEISMIC_SU};

	} else { 
		print("unif2aniso, DATA_SEISMIC_SU, missing DATA_SEISMIC_SU,\n");
	 }
 }


=head2 sub DATA_SEISMIC_TXT 


=cut

 sub DATA_SEISMIC_TXT {

	my ( $self,$DATA_SEISMIC_TXT )		= @_;
	if ( $DATA_SEISMIC_TXT ne $empty_string ) {

		$unif2aniso->{_DATA_SEISMIC_TXT}		= $DATA_SEISMIC_TXT;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' DATA_SEISMIC_TXT='.$unif2aniso->{_DATA_SEISMIC_TXT};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' DATA_SEISMIC_TXT='.$unif2aniso->{_DATA_SEISMIC_TXT};

	} else { 
		print("unif2aniso, DATA_SEISMIC_TXT, missing DATA_SEISMIC_TXT,\n");
	 }
 }


=head2 sub Project 


=cut

 sub Project {

	my ( $self,$Project )		= @_;
	if ( $Project ne $empty_string ) {

		$unif2aniso->{_Project}		= $Project;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' Project='.$unif2aniso->{_Project};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' Project='.$unif2aniso->{_Project};

	} else { 
		print("unif2aniso, Project, missing Project,\n");
	 }
 }


=head2 sub VERSION 


=cut

 sub VERSION {

	my ( $self,$VERSION )		= @_;
	if ( $VERSION ne $empty_string ) {

		$unif2aniso->{_VERSION}		= $VERSION;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' VERSION='.$unif2aniso->{_VERSION};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' VERSION='.$unif2aniso->{_VERSION};

	} else { 
		print("unif2aniso, VERSION, missing VERSION,\n");
	 }
 }


=head2 sub _Step 


=cut

 sub _Step {

	my ( $self,$_Step )		= @_;
	if ( $_Step ne $empty_string ) {

		$unif2aniso->{__Step}		= $_Step;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _Step='.$unif2aniso->{__Step};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _Step='.$unif2aniso->{__Step};

	} else { 
		print("unif2aniso, _Step, missing _Step,\n");
	 }
 }


=head2 sub _c11_file 


=cut

 sub _c11_file {

	my ( $self,$_c11_file )		= @_;
	if ( $_c11_file ne $empty_string ) {

		$unif2aniso->{__c11_file}		= $_c11_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _c11_file='.$unif2aniso->{__c11_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _c11_file='.$unif2aniso->{__c11_file};

	} else { 
		print("unif2aniso, _c11_file, missing _c11_file,\n");
	 }
 }


=head2 sub _c13_file 


=cut

 sub _c13_file {

	my ( $self,$_c13_file )		= @_;
	if ( $_c13_file ne $empty_string ) {

		$unif2aniso->{__c13_file}		= $_c13_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _c13_file='.$unif2aniso->{__c13_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _c13_file='.$unif2aniso->{__c13_file};

	} else { 
		print("unif2aniso, _c13_file, missing _c13_file,\n");
	 }
 }


=head2 sub _c15_file 


=cut

 sub _c15_file {

	my ( $self,$_c15_file )		= @_;
	if ( $_c15_file ne $empty_string ) {

		$unif2aniso->{__c15_file}		= $_c15_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _c15_file='.$unif2aniso->{__c15_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _c15_file='.$unif2aniso->{__c15_file};

	} else { 
		print("unif2aniso, _c15_file, missing _c15_file,\n");
	 }
 }


=head2 sub _c33_file 


=cut

 sub _c33_file {

	my ( $self,$_c33_file )		= @_;
	if ( $_c33_file ne $empty_string ) {

		$unif2aniso->{__c33_file}		= $_c33_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _c33_file='.$unif2aniso->{__c33_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _c33_file='.$unif2aniso->{__c33_file};

	} else { 
		print("unif2aniso, _c33_file, missing _c33_file,\n");
	 }
 }


=head2 sub _c35_file 


=cut

 sub _c35_file {

	my ( $self,$_c35_file )		= @_;
	if ( $_c35_file ne $empty_string ) {

		$unif2aniso->{__c35_file}		= $_c35_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _c35_file='.$unif2aniso->{__c35_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _c35_file='.$unif2aniso->{__c35_file};

	} else { 
		print("unif2aniso, _c35_file, missing _c35_file,\n");
	 }
 }


=head2 sub _c44_file 


=cut

 sub _c44_file {

	my ( $self,$_c44_file )		= @_;
	if ( $_c44_file ne $empty_string ) {

		$unif2aniso->{__c44_file}		= $_c44_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _c44_file='.$unif2aniso->{__c44_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _c44_file='.$unif2aniso->{__c44_file};

	} else { 
		print("unif2aniso, _c44_file, missing _c44_file,\n");
	 }
 }


=head2 sub _c55_file 


=cut

 sub _c55_file {

	my ( $self,$_c55_file )		= @_;
	if ( $_c55_file ne $empty_string ) {

		$unif2aniso->{__c55_file}		= $_c55_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _c55_file='.$unif2aniso->{__c55_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _c55_file='.$unif2aniso->{__c55_file};

	} else { 
		print("unif2aniso, _c55_file, missing _c55_file,\n");
	 }
 }


=head2 sub _c66_file 


=cut

 sub _c66_file {

	my ( $self,$_c66_file )		= @_;
	if ( $_c66_file ne $empty_string ) {

		$unif2aniso->{__c66_file}		= $_c66_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _c66_file='.$unif2aniso->{__c66_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _c66_file='.$unif2aniso->{__c66_file};

	} else { 
		print("unif2aniso, _c66_file, missing _c66_file,\n");
	 }
 }


=head2 sub _dddx 


=cut

 sub _dddx {

	my ( $self,$_dddx )		= @_;
	if ( $_dddx ne $empty_string ) {

		$unif2aniso->{__dddx}		= $_dddx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dddx='.$unif2aniso->{__dddx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dddx='.$unif2aniso->{__dddx};

	} else { 
		print("unif2aniso, _dddx, missing _dddx,\n");
	 }
 }


=head2 sub _dddz 


=cut

 sub _dddz {

	my ( $self,$_dddz )		= @_;
	if ( $_dddz ne $empty_string ) {

		$unif2aniso->{__dddz}		= $_dddz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dddz='.$unif2aniso->{__dddz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dddz='.$unif2aniso->{__dddz};

	} else { 
		print("unif2aniso, _dddz, missing _dddz,\n");
	 }
 }


=head2 sub _dedx 


=cut

 sub _dedx {

	my ( $self,$_dedx )		= @_;
	if ( $_dedx ne $empty_string ) {

		$unif2aniso->{__dedx}		= $_dedx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dedx='.$unif2aniso->{__dedx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dedx='.$unif2aniso->{__dedx};

	} else { 
		print("unif2aniso, _dedx, missing _dedx,\n");
	 }
 }


=head2 sub _dedz 


=cut

 sub _dedz {

	my ( $self,$_dedz )		= @_;
	if ( $_dedz ne $empty_string ) {

		$unif2aniso->{__dedz}		= $_dedz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dedz='.$unif2aniso->{__dedz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dedz='.$unif2aniso->{__dedz};

	} else { 
		print("unif2aniso, _dedz, missing _dedz,\n");
	 }
 }


=head2 sub _delta00 


=cut

 sub _delta00 {

	my ( $self,$_delta00 )		= @_;
	if ( $_delta00 ne $empty_string ) {

		$unif2aniso->{__delta00}		= $_delta00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _delta00='.$unif2aniso->{__delta00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _delta00='.$unif2aniso->{__delta00};

	} else { 
		print("unif2aniso, _delta00, missing _delta00,\n");
	 }
 }


=head2 sub _dgdx 


=cut

 sub _dgdx {

	my ( $self,$_dgdx )		= @_;
	if ( $_dgdx ne $empty_string ) {

		$unif2aniso->{__dgdx}		= $_dgdx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dgdx='.$unif2aniso->{__dgdx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dgdx='.$unif2aniso->{__dgdx};

	} else { 
		print("unif2aniso, _dgdx, missing _dgdx,\n");
	 }
 }


=head2 sub _dgdz 


=cut

 sub _dgdz {

	my ( $self,$_dgdz )		= @_;
	if ( $_dgdz ne $empty_string ) {

		$unif2aniso->{__dgdz}		= $_dgdz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dgdz='.$unif2aniso->{__dgdz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dgdz='.$unif2aniso->{__dgdz};

	} else { 
		print("unif2aniso, _dgdz, missing _dgdz,\n");
	 }
 }


=head2 sub _dqdx 


=cut

 sub _dqdx {

	my ( $self,$_dqdx )		= @_;
	if ( $_dqdx ne $empty_string ) {

		$unif2aniso->{__dqdx}		= $_dqdx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dqdx='.$unif2aniso->{__dqdx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dqdx='.$unif2aniso->{__dqdx};

	} else { 
		print("unif2aniso, _dqdx, missing _dqdx,\n");
	 }
 }


=head2 sub _dqdz 


=cut

 sub _dqdz {

	my ( $self,$_dqdz )		= @_;
	if ( $_dqdz ne $empty_string ) {

		$unif2aniso->{__dqdz}		= $_dqdz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dqdz='.$unif2aniso->{__dqdz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dqdz='.$unif2aniso->{__dqdz};

	} else { 
		print("unif2aniso, _dqdz, missing _dqdz,\n");
	 }
 }


=head2 sub _drdx 


=cut

 sub _drdx {

	my ( $self,$_drdx )		= @_;
	if ( $_drdx ne $empty_string ) {

		$unif2aniso->{__drdx}		= $_drdx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _drdx='.$unif2aniso->{__drdx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _drdx='.$unif2aniso->{__drdx};

	} else { 
		print("unif2aniso, _drdx, missing _drdx,\n");
	 }
 }


=head2 sub _drdz 


=cut

 sub _drdz {

	my ( $self,$_drdz )		= @_;
	if ( $_drdz ne $empty_string ) {

		$unif2aniso->{__drdz}		= $_drdz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _drdz='.$unif2aniso->{__drdz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _drdz='.$unif2aniso->{__drdz};

	} else { 
		print("unif2aniso, _drdz, missing _drdz,\n");
	 }
 }


=head2 sub _dvpdx 


=cut

 sub _dvpdx {

	my ( $self,$_dvpdx )		= @_;
	if ( $_dvpdx ne $empty_string ) {

		$unif2aniso->{__dvpdx}		= $_dvpdx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dvpdx='.$unif2aniso->{__dvpdx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dvpdx='.$unif2aniso->{__dvpdx};

	} else { 
		print("unif2aniso, _dvpdx, missing _dvpdx,\n");
	 }
 }


=head2 sub _dvpdz 


=cut

 sub _dvpdz {

	my ( $self,$_dvpdz )		= @_;
	if ( $_dvpdz ne $empty_string ) {

		$unif2aniso->{__dvpdz}		= $_dvpdz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dvpdz='.$unif2aniso->{__dvpdz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dvpdz='.$unif2aniso->{__dvpdz};

	} else { 
		print("unif2aniso, _dvpdz, missing _dvpdz,\n");
	 }
 }


=head2 sub _dvsdx 


=cut

 sub _dvsdx {

	my ( $self,$_dvsdx )		= @_;
	if ( $_dvsdx ne $empty_string ) {

		$unif2aniso->{__dvsdx}		= $_dvsdx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dvsdx='.$unif2aniso->{__dvsdx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dvsdx='.$unif2aniso->{__dvsdx};

	} else { 
		print("unif2aniso, _dvsdx, missing _dvsdx,\n");
	 }
 }


=head2 sub _dvsdz 


=cut

 sub _dvsdz {

	my ( $self,$_dvsdz )		= @_;
	if ( $_dvsdz ne $empty_string ) {

		$unif2aniso->{__dvsdz}		= $_dvsdz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dvsdz='.$unif2aniso->{__dvsdz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dvsdz='.$unif2aniso->{__dvsdz};

	} else { 
		print("unif2aniso, _dvsdz, missing _dvsdz,\n");
	 }
 }


=head2 sub _dx 


=cut

 sub _dx {

	my ( $self,$_dx )		= @_;
	if ( $_dx ne $empty_string ) {

		$unif2aniso->{__dx}		= $_dx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dx='.$unif2aniso->{__dx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dx='.$unif2aniso->{__dx};

	} else { 
		print("unif2aniso, _dx, missing _dx,\n");
	 }
 }


=head2 sub _dz 


=cut

 sub _dz {

	my ( $self,$_dz )		= @_;
	if ( $_dz ne $empty_string ) {

		$unif2aniso->{__dz}		= $_dz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _dz='.$unif2aniso->{__dz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _dz='.$unif2aniso->{__dz};

	} else { 
		print("unif2aniso, _dz, missing _dz,\n");
	 }
 }


=head2 sub _eps00 


=cut

 sub _eps00 {

	my ( $self,$_eps00 )		= @_;
	if ( $_eps00 ne $empty_string ) {

		$unif2aniso->{__eps00}		= $_eps00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _eps00='.$unif2aniso->{__eps00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _eps00='.$unif2aniso->{__eps00};

	} else { 
		print("unif2aniso, _eps00, missing _eps00,\n");
	 }
 }


=head2 sub _fx 


=cut

 sub _fx {

	my ( $self,$_fx )		= @_;
	if ( $_fx ne $empty_string ) {

		$unif2aniso->{__fx}		= $_fx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _fx='.$unif2aniso->{__fx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _fx='.$unif2aniso->{__fx};

	} else { 
		print("unif2aniso, _fx, missing _fx,\n");
	 }
 }


=head2 sub _fz 


=cut

 sub _fz {

	my ( $self,$_fz )		= @_;
	if ( $_fz ne $empty_string ) {

		$unif2aniso->{__fz}		= $_fz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _fz='.$unif2aniso->{__fz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _fz='.$unif2aniso->{__fz};

	} else { 
		print("unif2aniso, _fz, missing _fz,\n");
	 }
 }


=head2 sub _gamma00 


=cut

 sub _gamma00 {

	my ( $self,$_gamma00 )		= @_;
	if ( $_gamma00 ne $empty_string ) {

		$unif2aniso->{__gamma00}		= $_gamma00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _gamma00='.$unif2aniso->{__gamma00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _gamma00='.$unif2aniso->{__gamma00};

	} else { 
		print("unif2aniso, _gamma00, missing _gamma00,\n");
	 }
 }


=head2 sub _method 


=cut

 sub _method {

	my ( $self,$_method )		= @_;
	if ( $_method ne $empty_string ) {

		$unif2aniso->{__method}		= $_method;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _method='.$unif2aniso->{__method};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _method='.$unif2aniso->{__method};

	} else { 
		print("unif2aniso, _method, missing _method,\n");
	 }
 }


=head2 sub _n1 


=cut

 sub _n1 {

	my ( $self,$_n1 )		= @_;
	if ( $_n1 ne $empty_string ) {

		$unif2aniso->{__n1}		= $_n1;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _n1='.$unif2aniso->{__n1};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _n1='.$unif2aniso->{__n1};

	} else { 
		print("unif2aniso, _n1, missing _n1,\n");
	 }
 }


=head2 sub _ninf 


=cut

 sub _ninf {

	my ( $self,$_ninf )		= @_;
	if ( $_ninf ne $empty_string ) {

		$unif2aniso->{__ninf}		= $_ninf;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _ninf='.$unif2aniso->{__ninf};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _ninf='.$unif2aniso->{__ninf};

	} else { 
		print("unif2aniso, _ninf, missing _ninf,\n");
	 }
 }


=head2 sub _note 


=cut

 sub _note {

	my ( $self,$_note )		= @_;
	if ( $_note ne $empty_string ) {

		$unif2aniso->{__note}		= $_note;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _note='.$unif2aniso->{__note};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _note='.$unif2aniso->{__note};

	} else { 
		print("unif2aniso, _note, missing _note,\n");
	 }
 }


=head2 sub _npmax 


=cut

 sub _npmax {

	my ( $self,$_npmax )		= @_;
	if ( $_npmax ne $empty_string ) {

		$unif2aniso->{__npmax}		= $_npmax;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _npmax='.$unif2aniso->{__npmax};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _npmax='.$unif2aniso->{__npmax};

	} else { 
		print("unif2aniso, _npmax, missing _npmax,\n");
	 }
 }


=head2 sub _nx 


=cut

 sub _nx {

	my ( $self,$_nx )		= @_;
	if ( $_nx ne $empty_string ) {

		$unif2aniso->{__nx}		= $_nx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _nx='.$unif2aniso->{__nx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _nx='.$unif2aniso->{__nx};

	} else { 
		print("unif2aniso, _nx, missing _nx,\n");
	 }
 }


=head2 sub _nz 


=cut

 sub _nz {

	my ( $self,$_nz )		= @_;
	if ( $_nz ne $empty_string ) {

		$unif2aniso->{__nz}		= $_nz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _nz='.$unif2aniso->{__nz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _nz='.$unif2aniso->{__nz};

	} else { 
		print("unif2aniso, _nz, missing _nz,\n");
	 }
 }


=head2 sub _paramtype 


=cut

 sub _paramtype {

	my ( $self,$_paramtype )		= @_;
	if ( $_paramtype ne $empty_string ) {

		$unif2aniso->{__paramtype}		= $_paramtype;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _paramtype='.$unif2aniso->{__paramtype};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _paramtype='.$unif2aniso->{__paramtype};

	} else { 
		print("unif2aniso, _paramtype, missing _paramtype,\n");
	 }
 }


=head2 sub _phi00 


=cut

 sub _phi00 {

	my ( $self,$_phi00 )		= @_;
	if ( $_phi00 ne $empty_string ) {

		$unif2aniso->{__phi00}		= $_phi00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _phi00='.$unif2aniso->{__phi00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _phi00='.$unif2aniso->{__phi00};

	} else { 
		print("unif2aniso, _phi00, missing _phi00,\n");
	 }
 }


=head2 sub _q00 


=cut

 sub _q00 {

	my ( $self,$_q00 )		= @_;
	if ( $_q00 ne $empty_string ) {

		$unif2aniso->{__q00}		= $_q00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _q00='.$unif2aniso->{__q00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _q00='.$unif2aniso->{__q00};

	} else { 
		print("unif2aniso, _q00, missing _q00,\n");
	 }
 }


=head2 sub _q_file 


=cut

 sub _q_file {

	my ( $self,$_q_file )		= @_;
	if ( $_q_file ne $empty_string ) {

		$unif2aniso->{__q_file}		= $_q_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _q_file='.$unif2aniso->{__q_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _q_file='.$unif2aniso->{__q_file};

	} else { 
		print("unif2aniso, _q_file, missing _q_file,\n");
	 }
 }


=head2 sub _rho00 


=cut

 sub _rho00 {

	my ( $self,$_rho00 )		= @_;
	if ( $_rho00 ne $empty_string ) {

		$unif2aniso->{__rho00}		= $_rho00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _rho00='.$unif2aniso->{__rho00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _rho00='.$unif2aniso->{__rho00};

	} else { 
		print("unif2aniso, _rho00, missing _rho00,\n");
	 }
 }


=head2 sub _rho_file 


=cut

 sub _rho_file {

	my ( $self,$_rho_file )		= @_;
	if ( $_rho_file ne $empty_string ) {

		$unif2aniso->{__rho_file}		= $_rho_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _rho_file='.$unif2aniso->{__rho_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _rho_file='.$unif2aniso->{__rho_file};

	} else { 
		print("unif2aniso, _rho_file, missing _rho_file,\n");
	 }
 }


=head2 sub _tfile 


=cut

 sub _tfile {

	my ( $self,$_tfile )		= @_;
	if ( $_tfile ne $empty_string ) {

		$unif2aniso->{__tfile}		= $_tfile;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _tfile='.$unif2aniso->{__tfile};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _tfile='.$unif2aniso->{__tfile};

	} else { 
		print("unif2aniso, _tfile, missing _tfile,\n");
	 }
 }


=head2 sub _vp00 


=cut

 sub _vp00 {

	my ( $self,$_vp00 )		= @_;
	if ( $_vp00 ne $empty_string ) {

		$unif2aniso->{__vp00}		= $_vp00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _vp00='.$unif2aniso->{__vp00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _vp00='.$unif2aniso->{__vp00};

	} else { 
		print("unif2aniso, _vp00, missing _vp00,\n");
	 }
 }


=head2 sub _vs00 


=cut

 sub _vs00 {

	my ( $self,$_vs00 )		= @_;
	if ( $_vs00 ne $empty_string ) {

		$unif2aniso->{__vs00}		= $_vs00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _vs00='.$unif2aniso->{__vs00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _vs00='.$unif2aniso->{__vs00};

	} else { 
		print("unif2aniso, _vs00, missing _vs00,\n");
	 }
 }


=head2 sub _x0 


=cut

 sub _x0 {

	my ( $self,$_x0 )		= @_;
	if ( $_x0 ne $empty_string ) {

		$unif2aniso->{__x0}		= $_x0;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _x0='.$unif2aniso->{__x0};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _x0='.$unif2aniso->{__x0};

	} else { 
		print("unif2aniso, _x0, missing _x0,\n");
	 }
 }


=head2 sub _z0 


=cut

 sub _z0 {

	my ( $self,$_z0 )		= @_;
	if ( $_z0 ne $empty_string ) {

		$unif2aniso->{__z0}		= $_z0;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' _z0='.$unif2aniso->{__z0};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' _z0='.$unif2aniso->{__z0};

	} else { 
		print("unif2aniso, _z0, missing _z0,\n");
	 }
 }


=head2 sub c11_file 


=cut

 sub c11_file {

	my ( $self,$c11_file )		= @_;
	if ( $c11_file ne $empty_string ) {

		$unif2aniso->{_c11_file}		= $c11_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' c11_file='.$unif2aniso->{_c11_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' c11_file='.$unif2aniso->{_c11_file};

	} else { 
		print("unif2aniso, c11_file, missing c11_file,\n");
	 }
 }


=head2 sub c13_file 


=cut

 sub c13_file {

	my ( $self,$c13_file )		= @_;
	if ( $c13_file ne $empty_string ) {

		$unif2aniso->{_c13_file}		= $c13_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' c13_file='.$unif2aniso->{_c13_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' c13_file='.$unif2aniso->{_c13_file};

	} else { 
		print("unif2aniso, c13_file, missing c13_file,\n");
	 }
 }


=head2 sub c15_file 


=cut

 sub c15_file {

	my ( $self,$c15_file )		= @_;
	if ( $c15_file ne $empty_string ) {

		$unif2aniso->{_c15_file}		= $c15_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' c15_file='.$unif2aniso->{_c15_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' c15_file='.$unif2aniso->{_c15_file};

	} else { 
		print("unif2aniso, c15_file, missing c15_file,\n");
	 }
 }


=head2 sub c33_file 


=cut

 sub c33_file {

	my ( $self,$c33_file )		= @_;
	if ( $c33_file ne $empty_string ) {

		$unif2aniso->{_c33_file}		= $c33_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' c33_file='.$unif2aniso->{_c33_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' c33_file='.$unif2aniso->{_c33_file};

	} else { 
		print("unif2aniso, c33_file, missing c33_file,\n");
	 }
 }


=head2 sub c35_file 


=cut

 sub c35_file {

	my ( $self,$c35_file )		= @_;
	if ( $c35_file ne $empty_string ) {

		$unif2aniso->{_c35_file}		= $c35_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' c35_file='.$unif2aniso->{_c35_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' c35_file='.$unif2aniso->{_c35_file};

	} else { 
		print("unif2aniso, c35_file, missing c35_file,\n");
	 }
 }


=head2 sub c44_file 


=cut

 sub c44_file {

	my ( $self,$c44_file )		= @_;
	if ( $c44_file ne $empty_string ) {

		$unif2aniso->{_c44_file}		= $c44_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' c44_file='.$unif2aniso->{_c44_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' c44_file='.$unif2aniso->{_c44_file};

	} else { 
		print("unif2aniso, c44_file, missing c44_file,\n");
	 }
 }


=head2 sub c55_file 


=cut

 sub c55_file {

	my ( $self,$c55_file )		= @_;
	if ( $c55_file ne $empty_string ) {

		$unif2aniso->{_c55_file}		= $c55_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' c55_file='.$unif2aniso->{_c55_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' c55_file='.$unif2aniso->{_c55_file};

	} else { 
		print("unif2aniso, c55_file, missing c55_file,\n");
	 }
 }


=head2 sub c66_file 


=cut

 sub c66_file {

	my ( $self,$c66_file )		= @_;
	if ( $c66_file ne $empty_string ) {

		$unif2aniso->{_c66_file}		= $c66_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' c66_file='.$unif2aniso->{_c66_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' c66_file='.$unif2aniso->{_c66_file};

	} else { 
		print("unif2aniso, c66_file, missing c66_file,\n");
	 }
 }


=head2 sub dddx 


=cut

 sub dddx {

	my ( $self,$dddx )		= @_;
	if ( $dddx ne $empty_string ) {

		$unif2aniso->{_dddx}		= $dddx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dddx='.$unif2aniso->{_dddx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dddx='.$unif2aniso->{_dddx};

	} else { 
		print("unif2aniso, dddx, missing dddx,\n");
	 }
 }


=head2 sub dddz 


=cut

 sub dddz {

	my ( $self,$dddz )		= @_;
	if ( $dddz ne $empty_string ) {

		$unif2aniso->{_dddz}		= $dddz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dddz='.$unif2aniso->{_dddz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dddz='.$unif2aniso->{_dddz};

	} else { 
		print("unif2aniso, dddz, missing dddz,\n");
	 }
 }


=head2 sub dedx 


=cut

 sub dedx {

	my ( $self,$dedx )		= @_;
	if ( $dedx ne $empty_string ) {

		$unif2aniso->{_dedx}		= $dedx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dedx='.$unif2aniso->{_dedx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dedx='.$unif2aniso->{_dedx};

	} else { 
		print("unif2aniso, dedx, missing dedx,\n");
	 }
 }


=head2 sub dedz 


=cut

 sub dedz {

	my ( $self,$dedz )		= @_;
	if ( $dedz ne $empty_string ) {

		$unif2aniso->{_dedz}		= $dedz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dedz='.$unif2aniso->{_dedz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dedz='.$unif2aniso->{_dedz};

	} else { 
		print("unif2aniso, dedz, missing dedz,\n");
	 }
 }


=head2 sub delta00 


=cut

 sub delta00 {

	my ( $self,$delta00 )		= @_;
	if ( $delta00 ne $empty_string ) {

		$unif2aniso->{_delta00}		= $delta00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' delta00='.$unif2aniso->{_delta00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' delta00='.$unif2aniso->{_delta00};

	} else { 
		print("unif2aniso, delta00, missing delta00,\n");
	 }
 }


=head2 sub dgdx 


=cut

 sub dgdx {

	my ( $self,$dgdx )		= @_;
	if ( $dgdx ne $empty_string ) {

		$unif2aniso->{_dgdx}		= $dgdx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dgdx='.$unif2aniso->{_dgdx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dgdx='.$unif2aniso->{_dgdx};

	} else { 
		print("unif2aniso, dgdx, missing dgdx,\n");
	 }
 }


=head2 sub dgdz 


=cut

 sub dgdz {

	my ( $self,$dgdz )		= @_;
	if ( $dgdz ne $empty_string ) {

		$unif2aniso->{_dgdz}		= $dgdz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dgdz='.$unif2aniso->{_dgdz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dgdz='.$unif2aniso->{_dgdz};

	} else { 
		print("unif2aniso, dgdz, missing dgdz,\n");
	 }
 }


=head2 sub dqdx 


=cut

 sub dqdx {

	my ( $self,$dqdx )		= @_;
	if ( $dqdx ne $empty_string ) {

		$unif2aniso->{_dqdx}		= $dqdx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dqdx='.$unif2aniso->{_dqdx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dqdx='.$unif2aniso->{_dqdx};

	} else { 
		print("unif2aniso, dqdx, missing dqdx,\n");
	 }
 }


=head2 sub dqdz 


=cut

 sub dqdz {

	my ( $self,$dqdz )		= @_;
	if ( $dqdz ne $empty_string ) {

		$unif2aniso->{_dqdz}		= $dqdz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dqdz='.$unif2aniso->{_dqdz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dqdz='.$unif2aniso->{_dqdz};

	} else { 
		print("unif2aniso, dqdz, missing dqdz,\n");
	 }
 }


=head2 sub drdx 


=cut

 sub drdx {

	my ( $self,$drdx )		= @_;
	if ( $drdx ne $empty_string ) {

		$unif2aniso->{_drdx}		= $drdx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' drdx='.$unif2aniso->{_drdx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' drdx='.$unif2aniso->{_drdx};

	} else { 
		print("unif2aniso, drdx, missing drdx,\n");
	 }
 }


=head2 sub drdz 


=cut

 sub drdz {

	my ( $self,$drdz )		= @_;
	if ( $drdz ne $empty_string ) {

		$unif2aniso->{_drdz}		= $drdz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' drdz='.$unif2aniso->{_drdz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' drdz='.$unif2aniso->{_drdz};

	} else { 
		print("unif2aniso, drdz, missing drdz,\n");
	 }
 }


=head2 sub dvpdx 


=cut

 sub dvpdx {

	my ( $self,$dvpdx )		= @_;
	if ( $dvpdx ne $empty_string ) {

		$unif2aniso->{_dvpdx}		= $dvpdx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dvpdx='.$unif2aniso->{_dvpdx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dvpdx='.$unif2aniso->{_dvpdx};

	} else { 
		print("unif2aniso, dvpdx, missing dvpdx,\n");
	 }
 }


=head2 sub dvpdz 


=cut

 sub dvpdz {

	my ( $self,$dvpdz )		= @_;
	if ( $dvpdz ne $empty_string ) {

		$unif2aniso->{_dvpdz}		= $dvpdz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dvpdz='.$unif2aniso->{_dvpdz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dvpdz='.$unif2aniso->{_dvpdz};

	} else { 
		print("unif2aniso, dvpdz, missing dvpdz,\n");
	 }
 }


=head2 sub dvsdx 


=cut

 sub dvsdx {

	my ( $self,$dvsdx )		= @_;
	if ( $dvsdx ne $empty_string ) {

		$unif2aniso->{_dvsdx}		= $dvsdx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dvsdx='.$unif2aniso->{_dvsdx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dvsdx='.$unif2aniso->{_dvsdx};

	} else { 
		print("unif2aniso, dvsdx, missing dvsdx,\n");
	 }
 }


=head2 sub dvsdz 


=cut

 sub dvsdz {

	my ( $self,$dvsdz )		= @_;
	if ( $dvsdz ne $empty_string ) {

		$unif2aniso->{_dvsdz}		= $dvsdz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dvsdz='.$unif2aniso->{_dvsdz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dvsdz='.$unif2aniso->{_dvsdz};

	} else { 
		print("unif2aniso, dvsdz, missing dvsdz,\n");
	 }
 }


=head2 sub dx 


=cut

 sub dx {

	my ( $self,$dx )		= @_;
	if ( $dx ne $empty_string ) {

		$unif2aniso->{_dx}		= $dx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dx='.$unif2aniso->{_dx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dx='.$unif2aniso->{_dx};

	} else { 
		print("unif2aniso, dx, missing dx,\n");
	 }
 }


=head2 sub dz 


=cut

 sub dz {

	my ( $self,$dz )		= @_;
	if ( $dz ne $empty_string ) {

		$unif2aniso->{_dz}		= $dz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' dz='.$unif2aniso->{_dz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' dz='.$unif2aniso->{_dz};

	} else { 
		print("unif2aniso, dz, missing dz,\n");
	 }
 }


=head2 sub empty_string 


=cut

 sub empty_string {

	my ( $self,$empty_string )		= @_;
	if ( $empty_string ne $empty_string ) {

		$unif2aniso->{_empty_string}		= $empty_string;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' empty_string='.$unif2aniso->{_empty_string};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' empty_string='.$unif2aniso->{_empty_string};

	} else { 
		print("unif2aniso, empty_string, missing empty_string,\n");
	 }
 }


=head2 sub eps00 


=cut

 sub eps00 {

	my ( $self,$eps00 )		= @_;
	if ( $eps00 ne $empty_string ) {

		$unif2aniso->{_eps00}		= $eps00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' eps00='.$unif2aniso->{_eps00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' eps00='.$unif2aniso->{_eps00};

	} else { 
		print("unif2aniso, eps00, missing eps00,\n");
	 }
 }


=head2 sub false 


=cut

 sub false {

	my ( $self,$false )		= @_;
	if ( $false ne $empty_string ) {

		$unif2aniso->{_false}		= $false;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' false='.$unif2aniso->{_false};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' false='.$unif2aniso->{_false};

	} else { 
		print("unif2aniso, false, missing false,\n");
	 }
 }


=head2 sub fx 


=cut

 sub fx {

	my ( $self,$fx )		= @_;
	if ( $fx ne $empty_string ) {

		$unif2aniso->{_fx}		= $fx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' fx='.$unif2aniso->{_fx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' fx='.$unif2aniso->{_fx};

	} else { 
		print("unif2aniso, fx, missing fx,\n");
	 }
 }


=head2 sub fz 


=cut

 sub fz {

	my ( $self,$fz )		= @_;
	if ( $fz ne $empty_string ) {

		$unif2aniso->{_fz}		= $fz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' fz='.$unif2aniso->{_fz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' fz='.$unif2aniso->{_fz};

	} else { 
		print("unif2aniso, fz, missing fz,\n");
	 }
 }


=head2 sub gamma00 


=cut

 sub gamma00 {

	my ( $self,$gamma00 )		= @_;
	if ( $gamma00 ne $empty_string ) {

		$unif2aniso->{_gamma00}		= $gamma00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' gamma00='.$unif2aniso->{_gamma00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' gamma00='.$unif2aniso->{_gamma00};

	} else { 
		print("unif2aniso, gamma00, missing gamma00,\n");
	 }
 }


=head2 sub get 


=cut

 sub get {

	my ( $self,$get )		= @_;
	if ( $get ne $empty_string ) {

		$unif2aniso->{_get}		= $get;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' get='.$unif2aniso->{_get};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' get='.$unif2aniso->{_get};

	} else { 
		print("unif2aniso, get, missing get,\n");
	 }
 }


=head2 sub index 


=cut

 sub index {

	my ( $self,$index )		= @_;
	if ( $index ne $empty_string ) {

		$unif2aniso->{_index}		= $index;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' index='.$unif2aniso->{_index};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' index='.$unif2aniso->{_index};

	} else { 
		print("unif2aniso, index, missing index,\n");
	 }
 }


=head2 sub max_index 


=cut

 sub max_index {

	my ( $self,$max_index )		= @_;
	if ( $max_index ne $empty_string ) {

		$unif2aniso->{_max_index}		= $max_index;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' max_index='.$unif2aniso->{_max_index};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' max_index='.$unif2aniso->{_max_index};

	} else { 
		print("unif2aniso, max_index, missing max_index,\n");
	 }
 }


=head2 sub method 


=cut

 sub method {

	my ( $self,$method )		= @_;
	if ( $method ne $empty_string ) {

		$unif2aniso->{_method}		= $method;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' method='.$unif2aniso->{_method};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' method='.$unif2aniso->{_method};

	} else { 
		print("unif2aniso, method, missing method,\n");
	 }
 }


=head2 sub n1 


=cut

 sub n1 {

	my ( $self,$n1 )		= @_;
	if ( $n1 ne $empty_string ) {

		$unif2aniso->{_n1}		= $n1;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' n1='.$unif2aniso->{_n1};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' n1='.$unif2aniso->{_n1};

	} else { 
		print("unif2aniso, n1, missing n1,\n");
	 }
 }


=head2 sub ninf 


=cut

 sub ninf {

	my ( $self,$ninf )		= @_;
	if ( $ninf ne $empty_string ) {

		$unif2aniso->{_ninf}		= $ninf;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' ninf='.$unif2aniso->{_ninf};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' ninf='.$unif2aniso->{_ninf};

	} else { 
		print("unif2aniso, ninf, missing ninf,\n");
	 }
 }


=head2 sub npmax 


=cut

 sub npmax {

	my ( $self,$npmax )		= @_;
	if ( $npmax ne $empty_string ) {

		$unif2aniso->{_npmax}		= $npmax;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' npmax='.$unif2aniso->{_npmax};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' npmax='.$unif2aniso->{_npmax};

	} else { 
		print("unif2aniso, npmax, missing npmax,\n");
	 }
 }


=head2 sub nx 


=cut

 sub nx {

	my ( $self,$nx )		= @_;
	if ( $nx ne $empty_string ) {

		$unif2aniso->{_nx}		= $nx;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' nx='.$unif2aniso->{_nx};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' nx='.$unif2aniso->{_nx};

	} else { 
		print("unif2aniso, nx, missing nx,\n");
	 }
 }


=head2 sub nz 


=cut

 sub nz {

	my ( $self,$nz )		= @_;
	if ( $nz ne $empty_string ) {

		$unif2aniso->{_nz}		= $nz;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' nz='.$unif2aniso->{_nz};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' nz='.$unif2aniso->{_nz};

	} else { 
		print("unif2aniso, nz, missing nz,\n");
	 }
 }


=head2 sub off 


=cut

 sub off {

	my ( $self,$off )		= @_;
	if ( $off ne $empty_string ) {

		$unif2aniso->{_off}		= $off;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' off='.$unif2aniso->{_off};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' off='.$unif2aniso->{_off};

	} else { 
		print("unif2aniso, off, missing off,\n");
	 }
 }


=head2 sub on 


=cut

 sub on {

	my ( $self,$on )		= @_;
	if ( $on ne $empty_string ) {

		$unif2aniso->{_on}		= $on;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' on='.$unif2aniso->{_on};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' on='.$unif2aniso->{_on};

	} else { 
		print("unif2aniso, on, missing on,\n");
	 }
 }


=head2 sub paramtype 


=cut

 sub paramtype {

	my ( $self,$paramtype )		= @_;
	if ( $paramtype ne $empty_string ) {

		$unif2aniso->{_paramtype}		= $paramtype;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' paramtype='.$unif2aniso->{_paramtype};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' paramtype='.$unif2aniso->{_paramtype};

	} else { 
		print("unif2aniso, paramtype, missing paramtype,\n");
	 }
 }


=head2 sub phi00 


=cut

 sub phi00 {

	my ( $self,$phi00 )		= @_;
	if ( $phi00 ne $empty_string ) {

		$unif2aniso->{_phi00}		= $phi00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' phi00='.$unif2aniso->{_phi00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' phi00='.$unif2aniso->{_phi00};

	} else { 
		print("unif2aniso, phi00, missing phi00,\n");
	 }
 }


=head2 sub q00 


=cut

 sub q00 {

	my ( $self,$q00 )		= @_;
	if ( $q00 ne $empty_string ) {

		$unif2aniso->{_q00}		= $q00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' q00='.$unif2aniso->{_q00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' q00='.$unif2aniso->{_q00};

	} else { 
		print("unif2aniso, q00, missing q00,\n");
	 }
 }


=head2 sub q_file 


=cut

 sub q_file {

	my ( $self,$q_file )		= @_;
	if ( $q_file ne $empty_string ) {

		$unif2aniso->{_q_file}		= $q_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' q_file='.$unif2aniso->{_q_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' q_file='.$unif2aniso->{_q_file};

	} else { 
		print("unif2aniso, q_file, missing q_file,\n");
	 }
 }


=head2 sub rho00 


=cut

 sub rho00 {

	my ( $self,$rho00 )		= @_;
	if ( $rho00 ne $empty_string ) {

		$unif2aniso->{_rho00}		= $rho00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' rho00='.$unif2aniso->{_rho00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' rho00='.$unif2aniso->{_rho00};

	} else { 
		print("unif2aniso, rho00, missing rho00,\n");
	 }
 }


=head2 sub rho_file 


=cut

 sub rho_file {

	my ( $self,$rho_file )		= @_;
	if ( $rho_file ne $empty_string ) {

		$unif2aniso->{_rho_file}		= $rho_file;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' rho_file='.$unif2aniso->{_rho_file};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' rho_file='.$unif2aniso->{_rho_file};

	} else { 
		print("unif2aniso, rho_file, missing rho_file,\n");
	 }
 }


=head2 sub tfile 


=cut

 sub tfile {

	my ( $self,$tfile )		= @_;
	if ( $tfile ne $empty_string ) {

		$unif2aniso->{_tfile}		= $tfile;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' tfile='.$unif2aniso->{_tfile};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' tfile='.$unif2aniso->{_tfile};

	} else { 
		print("unif2aniso, tfile, missing tfile,\n");
	 }
 }


=head2 sub true 


=cut

 sub true {

	my ( $self,$true )		= @_;
	if ( $true ne $empty_string ) {

		$unif2aniso->{_true}		= $true;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' true='.$unif2aniso->{_true};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' true='.$unif2aniso->{_true};

	} else { 
		print("unif2aniso, true, missing true,\n");
	 }
 }


=head2 sub unif2aniso 


=cut

 sub unif2aniso {

	my ( $self,$unif2aniso )		= @_;
	if ( $unif2aniso ne $empty_string ) {

		$unif2aniso->{_unif2aniso}		= $unif2aniso;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' unif2aniso='.$unif2aniso->{_unif2aniso};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' unif2aniso='.$unif2aniso->{_unif2aniso};

	} else { 
		print("unif2aniso, unif2aniso, missing unif2aniso,\n");
	 }
 }


=head2 sub var 


=cut

 sub var {

	my ( $self,$var )		= @_;
	if ( $var ne $empty_string ) {

		$unif2aniso->{_var}		= $var;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' var='.$unif2aniso->{_var};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' var='.$unif2aniso->{_var};

	} else { 
		print("unif2aniso, var, missing var,\n");
	 }
 }


=head2 sub vp00 


=cut

 sub vp00 {

	my ( $self,$vp00 )		= @_;
	if ( $vp00 ne $empty_string ) {

		$unif2aniso->{_vp00}		= $vp00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' vp00='.$unif2aniso->{_vp00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' vp00='.$unif2aniso->{_vp00};

	} else { 
		print("unif2aniso, vp00, missing vp00,\n");
	 }
 }


=head2 sub vs00 


=cut

 sub vs00 {

	my ( $self,$vs00 )		= @_;
	if ( $vs00 ne $empty_string ) {

		$unif2aniso->{_vs00}		= $vs00;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' vs00='.$unif2aniso->{_vs00};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' vs00='.$unif2aniso->{_vs00};

	} else { 
		print("unif2aniso, vs00, missing vs00,\n");
	 }
 }


=head2 sub x0 


=cut

 sub x0 {

	my ( $self,$x0 )		= @_;
	if ( $x0 ne $empty_string ) {

		$unif2aniso->{_x0}		= $x0;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' x0='.$unif2aniso->{_x0};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' x0='.$unif2aniso->{_x0};

	} else { 
		print("unif2aniso, x0, missing x0,\n");
	 }
 }


=head2 sub z0 


=cut

 sub z0 {

	my ( $self,$z0 )		= @_;
	if ( $z0 ne $empty_string ) {

		$unif2aniso->{_z0}		= $z0;
		$unif2aniso->{_note}		= $unif2aniso->{_note}.' z0='.$unif2aniso->{_z0};
		$unif2aniso->{_Step}		= $unif2aniso->{_Step}.' z0='.$unif2aniso->{_z0};

	} else { 
		print("unif2aniso, z0, missing z0,\n");
	 }
 }


=head2 sub get_max_index

max index = number of input variables -1
 
=cut
 
sub get_max_index {
 	  my ($self) = @_;
    my $max_index = 36;

    return($max_index);
}
 
 
1; 