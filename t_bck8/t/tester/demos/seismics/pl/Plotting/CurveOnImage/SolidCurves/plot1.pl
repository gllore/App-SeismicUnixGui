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
	use  suplane;
	use  suximage;

	my $log					= new message();
	my $run					= new flow();
	my $suplane				= new suplane();
	my $suximage				= new suximage();


=head2 Declare

	local variables

=cut

	my (@flow);
	my (@items);
	my (@suplane);
	my (@suximage);

=head2 Set up

	suplane parameter values

=cut

 	 $suplane 	 	 	 	 ->clear();
 	 $suplane [1]  	 	 	 = $suplane ->Step();

=head2 Set up

	suximage parameter values

=cut

 	 $suximage 	 	 	 	 ->clear();
 	 $suximage 	 	 	 	 ->curvecolor(quotemeta('red,black,cyan'));
 	 $suximage 	 	 	 	 ->curvefile(quotemeta($DATA_SEISMIC_TXT.'/'.'curve1'));
 	 $suximage 	 	 	 	 ->curvewidth(quotemeta('1,2,3'));
 	 $suximage 	 	 	 	 ->npair(quotemeta('3,3,3'));
 	 $suximage 	 	 	 	 ->box_X0(quotemeta(50));
 	 $suximage 	 	 	 	 ->box_Y0(quotemeta(50));
 	 $suximage [1]  	 	 	 = $suximage ->Step();


=head2 DEFINE FLOW(s) 


=cut

	 @items	= (
		  $suplane[1], $to,
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


