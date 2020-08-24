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
	use  data_in;
	use  sufdmod2;
	use  suxmovie;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sufdmod2				= new sufdmod2();
	my $suxmovie				= new suxmovie();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sufdmod2);
	my (@suxmovie);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('vel_out'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('bin'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	sufdmod2 parameter values

=cut

 	 $sufdmod2 	 	 	 	 ->clear();
 	 $sufdmod2 	 	 	 	 ->boundary_conditions(quotemeta('1,1,1,1'));
 	 $sufdmod2 	 	 	 	 ->dx(quotemeta(5));
 	 $sufdmod2 	 	 	 	 ->dz(quotemeta(5));
 	 $sufdmod2 	 	 	 	 ->hsfile_out(quotemeta($DATA_SEISMIC_SU.'/'.'hseis'.$suffix_su));
 	 $sufdmod2 	 	 	 	 ->hsz(quotemeta(500));
 	 $sufdmod2 	 	 	 	 ->mt(quotemeta(5));
 	 $sufdmod2 	 	 	 	 ->nx(quotemeta(200));
 	 $sufdmod2 	 	 	 	 ->nz(quotemeta(200));
 	 $sufdmod2 	 	 	 	 ->source_seismogram_out(quotemeta($DATA_SEISMIC_SU.'/'.'sseis'.$suffix_su));
 	 $sufdmod2 	 	 	 	 ->tmax(quotemeta(0.5));
 	 $sufdmod2 	 	 	 	 ->verbose(quotemeta(1));
 	 $sufdmod2 	 	 	 	 ->vsfile_out(quotemeta($DATA_SEISMIC_SU.'/'.'vseis'.$suffix_su));
 	 $sufdmod2 	 	 	 	 ->vsx(quotemeta(500));
 	 $sufdmod2 	 	 	 	 ->xs(quotemeta(500));
 	 $sufdmod2 	 	 	 	 ->zs(quotemeta(500));
 	 $sufdmod2 [1]  	 	 	 = $sufdmod2 ->Step();

=head2 Set up

	suxmovie parameter values

=cut

 	 $suxmovie 	 	 	 	 ->clear();
 	 $suxmovie 	 	 	 	 ->clip(quotemeta(1));
 	 $suxmovie 	 	 	 	 ->cmap(quotemeta('gray'));
 	 $suxmovie 	 	 	 	 ->d1(quotemeta(5));
 	 $suxmovie 	 	 	 	 ->d2(quotemeta(5));
 	 $suxmovie 	 	 	 	 ->f1(quotemeta(0));
 	 $suxmovie 	 	 	 	 ->f2(quotemeta(0));
 	 $suxmovie 	 	 	 	 ->interp(quotemeta(0));
 	 $suxmovie 	 	 	 	 ->loop(quotemeta(2));
 	 $suxmovie 	 	 	 	 ->n1(quotemeta(200));
 	 $suxmovie 	 	 	 	 ->n2(quotemeta(200));
 	 $suxmovie 	 	 	 	 ->ntr(quotemeta(48200));
 	 $suxmovie 	 	 	 	 ->title(quotemeta('Acoustic Finite-Differencing'));
 	 $suxmovie 	 	 	 	 ->windowtitle(quotemeta('Movie'));
 	 $suxmovie 	 	 	 	 ->x_label(quotemeta('distance (m)'));
 	 $suxmovie 	 	 	 	 ->y_label(quotemeta('depth (m)'));
 	 $suxmovie [1]  	 	 	 = $suxmovie ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sufdmod2[1], $in,
		  $data_in[1], $to,
		  $suxmovie[1],
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


