package seismics;
use Moose;

=pod

 perform math on arrays by  class
 Contains methods/subroutines/functions to operate on directories
 Assumption is that the first pick is greater than 0
 TODO: implement error calls
 V 1. April 9  2009 
 to Moose Aug 1 2015
 Juan M. Lorenzo

=cut

sub Vrms2Vint {

=pod
 $variable is an unused hash reference

=cut

   my ($variable,$ref_T,$ref_Vrms,$num_elements)	=  @_;


# declare locally scoped variables
  my ($i,$num_points_Vint);
  my (@Vint,@Time,@Vint_out,@Time_out);

   if($$ref_T[1] == 0.) {
	print("\nWARNING: first time pick = 0\n");
   	for ($i=2; $i<=$num_elements; $i++) {
       		$Vint[$i] = sqrt((($$ref_Vrms[$i] * $$ref_Vrms[$i]* $$ref_T[$i])  - ($$ref_Vrms[$i-1] * $$ref_Vrms[$i-1]* $$ref_T[$i-1]))/($$ref_T[$i] - $$ref_T[$i-1]));
	$Time[$i] = $$ref_T[$i];
    	}
	$Vint[1] = $Vint[2];
	$Time[1] = $$ref_T[1];
    }

   if($$ref_T[1] > 0.) {
   	#print("\ninitial value is: $$ref_T[1] ");
    	$Vint[1] = $$ref_Vrms[1]; 
	$Time[1] = $$ref_T[1];

   	for ($i=2; $i<=$num_elements; $i++) {
       		$Vint[$i] = sqrt((($$ref_Vrms[$i] * $$ref_Vrms[$i]* $$ref_T[$i])  - ($$ref_Vrms[$i-1] * $$ref_Vrms[$i-1]* $$ref_T[$i-1]))/($$ref_T[$i] - $$ref_T[$i-1]));
	$Time[$i] = $$ref_T[$i];
    	}
   }
#   to prevent contaminating outside variables
        @Vint_out 		= @Vint;
	@Time_out 		= @Time;
	$num_points_Vint 	= $num_elements;

return(\@Vint_out,\@Time_out,$num_points_Vint);

}

1;
