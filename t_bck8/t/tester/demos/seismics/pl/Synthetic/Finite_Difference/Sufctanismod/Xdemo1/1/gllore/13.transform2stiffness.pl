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
	use vel2stiff;

	my $log					= new message();
	my $run					= new flow();
	my $vel2stiff				= new vel2stiff();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@vel2stiff);

=head2 Set up

	vel2stiff parameter values

=cut

 	 $vel2stiff 	 	 	 	 ->clear();
 	 $vel2stiff 	 	 	 	 ->c11_file(quotemeta($DATA_SEISMIC_BIN.'/'.'c11smtest'.$suffix_bin));
 	 $vel2stiff 	 	 	 	 ->c13_file(quotemeta($DATA_SEISMIC_BIN.'/'.'c13smtest'.$suffix_bin));
 	 $vel2stiff 	 	 	 	 ->c33_file(quotemeta($DATA_SEISMIC_BIN.'/'.'c33smtest'.$suffix_bin));
 	 $vel2stiff 	 	 	 	 ->c44_file(quotemeta($DATA_SEISMIC_BIN.'/'.'c44smtest'.$suffix_bin));
 	 $vel2stiff 	 	 	 	 ->c66_file(quotemeta($DATA_SEISMIC_BIN.'/'.'c66smtest'.$suffix_bin));
 	 $vel2stiff 	 	 	 	 ->deltafile(quotemeta($DATA_SEISMIC_BIN.'/'.'deltasmtest'.$suffix_bin));
 	 $vel2stiff 	 	 	 	 ->epsfile(quotemeta($DATA_SEISMIC_BIN.'/'.'epsilonsmtest'.$suffix_bin));
 	 $vel2stiff 	 	 	 	 ->nx(quotemeta(100));
 	 $vel2stiff 	 	 	 	 ->nz(quotemeta(100));
 	 $vel2stiff 	 	 	 	 ->paramtype(quotemeta(1));
 	 $vel2stiff 	 	 	 	 ->rhofile(quotemeta($DATA_SEISMIC_BIN.'/'.'rhosmtest'.$suffix_bin));
 	 $vel2stiff 	 	 	 	 ->vpfile(quotemeta($DATA_SEISMIC_BIN.'/'.'vpsmtest'.$suffix_bin));
 	 $vel2stiff 	 	 	 	 ->vsfile(quotemeta($DATA_SEISMIC_BIN.'/'.'vssmtest'.$suffix_bin));
 	 $vel2stiff [1]  	 	 	 = $vel2stiff ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $vel2stiff[1],
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


