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

=head2 CHANGES and their DATES

=cut


	use Moose;
	use SeismicUnix qw ($in $out $on $go $to $suffix_ascii $off $suffix_su $suffix_bin);
	use Project_config;

	my $Project		= new Project_config();
	my $DATA_SEISMIC_SU	= $Project->DATA_SEISMIC_SU;
	my $DATA_SEISMIC_BIN	= $Project->DATA_SEISMIC_BIN;
	my $DATA_SEISMIC_TXT	= $Project->DATA_SEISMIC_TXT;

	use message;
	use flow;
	use sufctanismod;
	use data_out;

	my $log					= new message();
	my $run					= new flow();
	my $sufctanismod				= new sufctanismod();
	my $data_out				= new data_out();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@sufctanismod);
	my (@data_out);

=head2 Set up

	sufctanismod parameter values

=cut

 	 $sufctanismod 	 	 	 	 ->clear();
 	 $sufctanismod 	 	 	 	 ->afile(quotemeta($DATA_SEISMIC_BIN.'/'.'c11smtest'.$suffix_bin));
 	 $sufctanismod 	 	 	 	 ->cfile(quotemeta($DATA_SEISMIC_BIN.'/'.'c33smtest'.$suffix_bin));
 	 $sufctanismod 	 	 	 	 ->dfile(quotemeta($DATA_SEISMIC_BIN.'/'.'rhosmtest'.$suffix_bin));
 	 $sufctanismod 	 	 	 	 ->dofct(quotemeta(1));
 	 $sufctanismod 	 	 	 	 ->dt(quotemeta(0.001));
 	 $sufctanismod 	 	 	 	 ->dx(quotemeta(5));
 	 $sufctanismod 	 	 	 	 ->dz(quotemeta(5));
 	 $sufctanismod 	 	 	 	 ->eta(quotemeta(0.015));
 	 $sufctanismod 	 	 	 	 ->eta0(quotemeta(0.012));
 	 $sufctanismod 	 	 	 	 ->fctxbeg(quotemeta(0));
 	 $sufctanismod 	 	 	 	 ->fctxend(quotemeta(100));
 	 $sufctanismod 	 	 	 	 ->fctzbeg(quotemeta(0));
 	 $sufctanismod 	 	 	 	 ->fctzend(quotemeta(100));
 	 $sufctanismod 	 	 	 	 ->ffile(quotemeta($DATA_SEISMIC_BIN.'/'.'c13smtest'.$suffix_bin));
 	 $sufctanismod 	 	 	 	 ->fpeak(quotemeta(30));
 	 $sufctanismod 	 	 	 	 ->impulse(quotemeta(1));
 	 $sufctanismod 	 	 	 	 ->indexdt(quotemeta(0));
 	 $sufctanismod 	 	 	 	 ->indexux(quotemeta(0));
 	 $sufctanismod 	 	 	 	 ->indexuy(quotemeta(0));
 	 $sufctanismod 	 	 	 	 ->indexuz(quotemeta(1));
 	 $sufctanismod 	 	 	 	 ->isurf(quotemeta(2));
 	 $sufctanismod 	 	 	 	 ->lfile(quotemeta($DATA_SEISMIC_BIN.'/'.'c44smtest'.$suffix_bin));
 	 $sufctanismod 	 	 	 	 ->mbx1(quotemeta(10));
 	 $sufctanismod 	 	 	 	 ->mbx2(quotemeta(900));
 	 $sufctanismod 	 	 	 	 ->mbz1(quotemeta(10));
 	 $sufctanismod 	 	 	 	 ->mbz2(quotemeta(90));
 	 $sufctanismod 	 	 	 	 ->movebc(quotemeta(1));
 	 $sufctanismod 	 	 	 	 ->nfile(quotemeta($DATA_SEISMIC_BIN.'/'.'c66smtest'.$suffix_bin));
 	 $sufctanismod 	 	 	 	 ->nt(quotemeta(250));
 	 $sufctanismod 	 	 	 	 ->nx(quotemeta(100));
 	 $sufctanismod 	 	 	 	 ->nz(quotemeta(100));
 	 $sufctanismod 	 	 	 	 ->order(quotemeta(4));
 	 $sufctanismod 	 	 	 	 ->receiverdepth(quotemeta('sz'));
 	 $sufctanismod 	 	 	 	 ->reflxfile(quotemeta($DATA_SEISMIC_SU.'/'.'xreflectionx'.$suffix_su));
 	 $sufctanismod 	 	 	 	 ->reflyfile(quotemeta($DATA_SEISMIC_SU.'/'.'yreflectiony'.$suffix_su));
 	 $sufctanismod 	 	 	 	 ->reflzfile(quotemeta($DATA_SEISMIC_SU.'/'.'zreflectionz'.$suffix_su));
 	 $sufctanismod 	 	 	 	 ->source(quotemeta(1));
 	 $sufctanismod 	 	 	 	 ->suhead(quotemeta(1));
 	 $sufctanismod 	 	 	 	 ->sx(quotemeta(50));
 	 $sufctanismod 	 	 	 	 ->sz(quotemeta(50));
 	 $sufctanismod 	 	 	 	 ->time(quotemeta(0.25));
 	 $sufctanismod 	 	 	 	 ->verbose(quotemeta(0));
 	 $sufctanismod 	 	 	 	 ->wavelet(quotemeta(1));
 	 $sufctanismod [1]  	 	 	 = $sufctanismod ->Step();

=head2 Set up

	data_out parameter values

=cut

 	 $data_out 	 	 	 	 ->clear();
 	 $data_out 	 	 	 	 ->base_file_name(quotemeta('junk'));
 	 $data_out 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_out [1]  	 	 	 = $data_out ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sufctanismod[1], $out,
		  $data_out[1],
		  $go
		  );
	$flow[1] = $run->modules(\@items);


=head2 RUN FLOW(s) 


=cut

	$run->flow(\$flow[1]);



=head2 LOG FLOW(s)

	to screen and FILE

=cut

	print $flow[1];

	$log->file($flow[1]);


