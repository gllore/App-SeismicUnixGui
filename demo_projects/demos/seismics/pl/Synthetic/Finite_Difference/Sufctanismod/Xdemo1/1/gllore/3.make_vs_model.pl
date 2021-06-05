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
	use data_in;
	use sugain;
	use suximage;

	my $log					= new message();
	my $run					= new flow();
	my $data_in				= new data_in();
	my $sugain				= new sugain();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@data_in);
	my (@sugain);
	my (@suximage);

=head2 Set up

	data_in parameter values

=cut

 	 $data_in 	 	 	 	 ->clear();
 	 $data_in 	 	 	 	 ->base_file_name(quotemeta('xreflectionx'));
 	 $data_in 	 	 	 	 ->suffix_type(quotemeta('su'));
 	 $data_in [1]  	 	 	 = $data_in ->Step();

=head2 Set up

	sugain parameter values

=cut

 	 $sugain 	 	 	 	 ->clear();
 	 $sugain 	 	 	 	 ->pbal(quotemeta(1));
 	 $sugain 	 	 	 	 ->tmpdir(quotemeta('/tmp'));
 	 $sugain [1]  	 	 	 = $sugain ->Step();

=head2 Set up

	suximage parameter values

=cut

 	 $suximage 	 	 	 	 ->clear();
 	 $suximage 	 	 	 	 ->cmap(quotemeta('hsv0'));
 	 $suximage 	 	 	 	 ->dx(quotemeta(1.0));
 	 $suximage 	 	 	 	 ->first_time_sample_value(quotemeta(0.0));
 	 $suximage 	 	 	 	 ->gridcolor(quotemeta('blu'));
 	 $suximage 	 	 	 	 ->ylabel(quotemeta('Time (s)'));
 	 $suximage 	 	 	 	 ->xlabel(quotemeta('Surface coord. (m)'));
 	 $suximage 	 	 	 	 ->legend(quotemeta(1));
 	 $suximage 	 	 	 	 ->percent4clip(quotemeta(99.5));
 	 $suximage 	 	 	 	 ->title(quotemeta('Vertical component of horizontal section'));
 	 $suximage 	 	 	 	 ->units(quotemeta('unit'));
 	 $suximage 	 	 	 	 ->verbose(quotemeta(1));
 	 $suximage 	 	 	 	 ->windowtitle(quotemeta('suximage'));
 	 $suximage 	 	 	 	 ->box_X0(quotemeta(500));
 	 $suximage 	 	 	 	 ->box_Y0(quotemeta(500));
 	 $suximage 	 	 	 	 ->box_width(quotemeta(550));
 	 $suximage 	 	 	 	 ->box_height(quotemeta(500));
 	 $suximage [1]  	 	 	 = $suximage ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $sugain[1], $in,
		  $data_in[1], $to,
		  $suximage[1],
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


