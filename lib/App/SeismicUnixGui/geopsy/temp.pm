package App::SeismicUnixGui::geopsy::gpdc2specfem2d;

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: gpdc2specfem2d.pm
 AUTHOR: Juan Lorenzo
 DATE:   V 0.0.1 May 10 2026

         
 DESCRIPTION:

 Package to copy gpdc models from local directory 
 into a specfem2d directory. The modified files (Par,   )
 will be used to run specfem2d simulations.


=head2 USE

=head3 NOTES 

=head4 
 Examples

=head3 NOTES  

=head4 CHANGES and their DATES

=cut

use Moose;
our $VERSION = '0.0.1';

=head2 Load modules

=cut

use aliased 'App::SeismicUnixGui::misc::manage_files_by2';
use aliased 'App::SeismicUnixGui::misc::manage_text_by';
use aliased 'App::SeismicUnixGui::misc::L_SU_global_constants';
use aliased 'App::SeismicUnixGui::misc::dirs';
use Carp qw(confess);
use POSIX qw(round);

=head2 Instantiate

   new modules

=cut

my $manage_files_by2      = manage_files_by2->new();
my $text        = manage_text_by->new();

=head2

  hash array of important variables used within
  this package

=cut

my $gpdc2specfem2d= {
	_thickness_m_aref => '',
	_Vp_mps_aref     => '',
	_Vs_mps_aref     => '',
	_rho_kgm3_aref   => '',
    _inbound_gpdc    => '',
    _model_path_specfem2d  => '',
    _material_type    => 1, # default to 1 for elastic, but can be set to other values as needed
    _number_of_specfem2d_layers => 0, # default to 0, but can be set to other values as needed
    _nx               => 0,
};

my @text_to_replace_a;
my $text_to_replace;


=head2 sub find_Par_file_indices

    This subroutine searches for the indices of the lines in the Par_file that need to be replaced with the values from the gpdc model
    The lines to replace are:
     - nbmodels
     - nbregions
     - the lines that define the different regions and their corresponding model numbers
     - the lines that define the velocity and density models
=cut 

sub _find_Par_file_indices {

    my ($slurp_aref) = @_;

    confess "Input array reference is undefined"
        unless defined $slurp_aref;

    my @slurp = @$slurp_aref;

    my $length_of_slurp = scalar(@slurp);

    # SEARCH TERMS
    my $first_velden_line2find = "# velocity and density models";
    my $last_velden_line2find  = "# external tomography file";
    my $nbmodels_line2find     = "# available material types";
    my $first_nbregions_line2find    = "# define the different regions";
    my $last_nbregions_line2find     = "# display parameters";

    # OUTPUT INDICES
    my $first_velden_line2find_index;
    my $last_velden_line2find_index;
    my $nbmodels_line2find_index;
    my $first_nbregions_line2find_index;
    my $last_nbregions_line2find_index;

    for (my $i = 0 ; $i < $length_of_slurp ; $i++) {

        my $string = $slurp[$i];

        if ($string =~ /$first_velden_line2find/) {

            $first_velden_line2find_index = $i - 2;
        }

        if ($string =~ /$last_velden_line2find/) {

            $last_velden_line2find_index = $i - 2;

        }

        if ($string =~ /$nbmodels_line2find/) {

            $nbmodels_line2find_index = $i - 1;

            # print("nbmodels_line2find_index: ",
            #       "$nbmodels_line2find_index\n");
        }

        if ($string =~ /$first_nbregions_line2find/) {

            $first_nbregions_line2find_index = $i + 1;

        }

        if ($string =~ /$last_nbregions_line2find/) {

            $last_nbregions_line2find_index = $i -2;

        }
    }

    # error checking
    confess "Could not find first velocity-density section"
        unless defined $first_velden_line2find_index;

    confess "Could not find last velocity-density section"
        unless defined $last_velden_line2find_index;

    confess "Could not find nbmodels section"
        unless defined $nbmodels_line2find_index;

    confess "Could not find nbregions section"
        unless defined $first_nbregions_line2find_index;

    confess "Could not find last nbregions section"
        unless defined $last_nbregions_line2find_index;

    return (
        $first_velden_line2find_index,
        $last_velden_line2find_index,
        $nbmodels_line2find_index,
        $first_nbregions_line2find_index,
        $last_nbregions_line2find_index,
    );
}

=head2 sub _get_layer_numbers_aref  

=cut

sub _get_specfem2d_layer_numbers_aref {

    my $number_of_specfem2d_layers = $gpdc2specfem2d->{_number_of_specfem2d_layers};


    confess "number_of_specfem2d_layers is not defined\n" unless defined $number_of_specfem2d_layers;
    
    my @layers = (1 .. $number_of_specfem2d_layers);

    return \@layers;
   
}

=head2 sub _get_material_type  

=cut

sub _get_material_type {
   
    my $material_type = $gpdc2specfem2d->{_material_type};

    confess "Material type is not defined\n" unless defined $material_type;
    return $material_type;
}

=head2 sub _set_number_of_specfem2d_layers

    Assume that the number of layers equals the number of different layer types.
    That is, each layer is characterized by a unique set of physical parameters

=cut

sub _set_number_of_specfem2d_layers {

    my ($number_of_specfem2d_layers) = @_;

    confess "Number of layers must be defined\n" unless defined $number_of_specfem2d_layers;
 
    $gpdc2specfem2d->{_number_of_specfem2d_layers} = $number_of_specfem2d_layers;
    # print "Number of layers set to: $number_of_specfem2d_layers \n";

}   


=head2 sub _set_mesh_region_arrays

    This subroutine builds the nxmin, nxmax, nzmin, nzmax, and layer_num arrays
    that define the spectral-element mesh regions and their corresponding model numbers

=cut

sub _set_mesh_region_arrays {

    my ($thickness_m_aref, $nx, $old_number_of_specfem2d_layers) = @_;

    confess "thickness_m array reference is required\n"
        unless defined $thickness_m_aref;

    confess "nx is required\n"
        unless defined $nx;

    confess "old_number_of_specfem2d_layers is required\n"
        unless defined $old_number_of_specfem2d_layers; 

    my @thickness_m = @{$thickness_m_aref};

    # TODO: dz may change in future
    my $dz         = 1.0;
    my $threshold  = $dz/2.;
    my @nxmin;
    my @nxmax;
    my @nzmin;
    my @nzmax;
    my @text_to_insert;
    my @number_array;

    # QC
    my @new_thickness_m;

    for (my $i=0, my $j=0;$i<$old_number_of_specfem2d_layers;$i++) {
            
        if ($thickness_m[$i] < $threshold) {
            # do nothing
            # print("skip a thin layer\n");
        }
        else {
            $new_thickness_m[$j] = $thickness_m[$i];
            $j++;
        }
    }
    
    # update number of actual layers
    my $new_number_of_specfem2d_layers    = scalar @new_thickness_m;
    # print "new_number_of_specfem2d_layers = $new_number_of_specfem2d_layers\n";
    confess "new_number_of_specfem2d_layers is too small\n" unless  ($new_number_of_specfem2d_layers >0);

    # find cumulative thickness
    my $num         = $new_number_of_specfem2d_layers;
    my $end_index   = $num-1;
    my $sum         = 0;

    for my $i (0 .. $end_index) {
        $sum += round($new_thickness_m[$i]);
    }

    # initalize the first layer
    $nzmax[0] = round($sum/$dz);
    $nzmin[0] = $nzmax[0] - round($new_thickness_m[0]/$dz) + 1;
    $nxmin[0] = 1;
    $nxmax[0] = $nx;

    for (my $i = 1; $i < $new_number_of_specfem2d_layers; $i++) {
        $nxmin[$i]  = 1;
        $nxmax[$i]  = $nx;
        $nzmax[$i]  = $nzmin[$i-1] -1;
        $nzmin[$i]  = $nzmax[$i]- round($new_thickness_m[$i]/$dz) + 1;
    }

    for (my $i = 0, my $layer_num=1; 
           $i < $new_number_of_specfem2d_layers; 
           $i++, $layer_num++) {

        $text_to_insert[$i] = "$nxmin[$i] $nxmax[$i] $nzmin[$i] $nzmax[$i]  $layer_num";
        @number_array[$i] =  [$nxmin[$i],$nxmax[$i],
                                $nzmin[$i],$nzmax[$i],
                                $layer_num];
        #    print "top to bott layer: $text_to_insert[$i]\n";
    }
    return (\@text_to_insert,\@number_array,$new_number_of_specfem2d_layers);
}


=head2 sub get_gpdc_model

=cut

sub get_gpdc_model {

    my $inbound = $gpdc2specfem2d->{_inbound_gpdc};

    confess "No input file provided\n" unless length $inbound;

    open(my $fh, "<", $inbound) or die "Cannot open $inbound: $!\n";

    # Read first line
    my $number_of_gpdc_layers = <$fh>;

    # gpdc layers are larger that specfem2d layers
    # because the gpdc model includes a half-space layer that is not included in the specfem2d model
    chomp($number_of_gpdc_layers);
    my $number_of_specfem2d_layers = $number_of_gpdc_layers - 1;
    # print "number of layers = $number_of_specfem2d_layers\n";
    _set_number_of_specfem2d_layers($number_of_specfem2d_layers);

    my @thickness_m;
    my @Vp_mps;
    my @Vs_mps;
    my @rho_kgm3;

    while (my $line = <$fh>) {

        chomp($line);
        next if $line =~ /^\s*$/;

        $line =~ s/^\s+//;
        $line =~ s/\s+$//;

        my ($thickness, $vp, $vs, $rho) = split(/\s+/, $line);

        push @thickness_m, $thickness;
        push @Vp_mps,      $vp;
        push @Vs_mps,      $vs;
        push @rho_kgm3,    $rho;
    }

    close($fh);

    # Store the arrays in the object for later use
    $gpdc2specfem2d->{_thickness_m_aref} = \@thickness_m;
    $gpdc2specfem2d->{_Vp_mps_aref}     = \@Vp_mps;
    $gpdc2specfem2d->{_Vs_mps_aref}     = \@Vs_mps;
    $gpdc2specfem2d->{_rho_kgm3_aref}   = \@rho_kgm3;

    # return variables to the main as array references
    # is optional if you want to use the arrays directly from the object properties
    return (
        \@thickness_m,
        \@Vp_mps,
        \@Vs_mps,
        \@rho_kgm3,
    );

}

=head2 sub set_gpdc_model_fileNpath 

=cut        

sub set_gpdc_model_fileNpath { 
    my ($self,$inbound_gpdc) = @_;

    confess "No input file provided\n" unless length $inbound_gpdc;
    confess "Cannot find input file: $inbound_gpdc\n" unless -e $inbound_gpdc;
    
    $gpdc2specfem2d->{_inbound_gpdc} = $inbound_gpdc;

}


=head2 sub set_material_type

=cut

sub set_material_type {
    my ($self, $material_type) = @_;

    confess "Material type must be defined\n" unless defined $material_type;
 
    $gpdc2specfem2d->{_material_type} = $material_type;

}



=head2 sub set_specfem2d_model_path  

=cut

sub set_specfem2d_model_path { 
    my ($self,$path_specfem2d) = @_;

    confess "No input file provided\n" unless length $path_specfem2d;
    confess "Cannot find input file: $path_specfem2d\n" unless -e $path_specfem2d;
    
    $gpdc2specfem2d->{_model_path_specfem2d} = $path_specfem2d;
    # print "Input specfem2d model path set to: $path_specfem2d \n";

}

=head2 sub

  set_specfem2d_Par_file
  replace the lines in the Par_file with the values from the gpdc model
   - thickness_m
   - Vp_mps
   - Vs_mps
   - rho_kgm3
   The "model number" in the Par_file corresponds to the material number 
   We assume that each layer is characterized by a different set of physical parameters
   and/or material typ (e.g. elastic, vs. acoustic, vs. anisotropic, etc.).

=cut

sub set_specfem2d_Par_file{

    my $model_path_specfem2d = $gpdc2specfem2d->{_model_path_specfem2d};

    my $specfem2d_layer_number;
    # TODO: add this path to Project.config
    my $Par_file_path = $model_path_specfem2d.'/DATA';
    my $file_name     = 'Par_file';
    my $Qkappa        = 9999.; # default value for Qkappa, can be set to other values as needed
    my $Qmu           = 9999.; # default value for Qmu, can be set to other values as needed

    # prepare to read the file into an array
    $manage_files_by2->set_file_in($file_name);
    $manage_files_by2->set_directory($Par_file_path);

    # slurp the file into an array
    # all lines are chomped
    my $whole_aref      = manage_files_by2->get_whole();
    my $length_of_slurp   = scalar @{$whole_aref};
    my $max_index_slurp   = $length_of_slurp - 1;
	my @slurp             = @{$whole_aref};

    # dereference the arrays from the object properties
    my @thickness_m = @{$gpdc2specfem2d->{_thickness_m_aref}};
    my @Vp_mps      = @{$gpdc2specfem2d->{_Vp_mps_aref}};
    my @Vs_mps      = @{$gpdc2specfem2d->{_Vs_mps_aref}};
    my @rho_kgm3    = @{$gpdc2specfem2d->{_rho_kgm3_aref}};
    my $number_of_specfem2d_layers = scalar(@thickness_m) -1;

    # foreach my $i (@thickness_m) {
    # print("$i is thickness from top to bottom\n");
    # }

    ### CASE 1A. SEARCH FOR THE LINES IN THE Par_file TO REPLACE with the values from the gpdc model
    my $first_velden_line2find      = "# velocity and density models";
    my $last_velden_line2find       = "# external tomography file";
    my $mid_velden_line2find        = "## acoustic";
    my $nbmodels_line2find          = "# available material types";

    my ($last_velden_line2find_index)      =$text->find_index_for_lines2replace(\@slurp, $last_velden_line2find);
    my ($nbmodels_line2find_index)         =$text->find_index_for_lines2replace(\@slurp, $nbmodels_line2find);
    my ($first_velden_line2find_index)     =$text->find_index_for_lines2replace(\@slurp, $first_velden_line2find);
    my ($mid_velden_line2find_index)       =$text->find_index_for_lines2replace(\@slurp, $mid_velden_line2find);

    # magic adjustments
    $first_velden_line2find_index += 3; # to account for the 3 lines of comments after the line with the search term
    $mid_velden_line2find_index = $mid_velden_line2find_index + 4;
    $last_velden_line2find_index  -= 2; # to account for the line of comments before the line with the search term
    $nbmodels_line2find_index     -= 1; # to account for the line

    ### CASE 1B. REPLACE MULTIPLE SINGLE LINES IN THE Par_file with the values from the gpdc model
    # WILL NOT ADD new lines, but will replace the existing lines with the new values from the gpdc model
    my @position_of_lines2replace = ($nbmodels_line2find_index);

    @text_to_replace_a = ("nbmodels                        = $number_of_specfem2d_layers");

    my $index;
    for (my $i=0; $i < scalar(@position_of_lines2replace); $i++ ) {

        $index = $position_of_lines2replace[$i];

        if ($index <= $last_velden_line2find_index) {

            $slurp[$index]     = $text_to_replace_a[$i];
  
        } elsif ($index > $last_velden_line2find_index) {

            $slurp[$index]    = $text_to_replace_a[$i];

        } else {
            confess "Index $index is out of bounds for the Par_file lines to replace\n";
        }

    }

    ### CASE 1B. Build a text block of line to insert for the velocity and density models
    my $material_type =  _get_material_type();
    my @layer_number =  @{_get_specfem2d_layer_numbers_aref()};

    my @text_to_insert_1;
    for (my $layers = 0; $layers < $number_of_specfem2d_layers; $layers++) {

        push @text_to_insert_1,
        join(' ',
            $layer_number[$layers],
            $material_type,
            round($rho_kgm3[$layers]) . ".d0",
            round($Vp_mps[$layers])   . ".d0",
            round($Vs_mps[$layers])   . ".d0",
            0,
            0,
            $Qkappa . ".d0",
            $Qmu    . ".d0",
            0, 0, 0, 0, 0, 0
        );
    }

    # add a newline to the end of text_to_insert_1
    push @text_to_insert_1,' ';

    ### CASE 1C. Introduce a new block of lines that overwrite existing lines
    # Remove lines between mid_velden_line2find_index and last_velden_line2find_index

    my @expel_top = @slurp[0..$mid_velden_line2find_index];  
    my @expel_bot = @slurp[($mid_velden_line2find_index+1)..$last_velden_line2find_index];

    my @expel_1;
    push @expel_1, @expel_top;
    push @expel_1, @expel_bot;

    ### CASE 2A.SEARCH FOR SINGLE LINES IN THE Par_file TO REPLACE with the values from the gpdc model
    my $first_nbregions_line2find          = "# format of each line: nxmin nxmax nzmin nzmax material_number";
    my $last_nbregions_line2find           = "# display parameters";
    my $num_x_spectral_elements_line2find  = "# number of elements along X";
    my ($first_nbregions_line2find_index)  =$text->find_index_for_lines2replace(\@expel_1, $first_nbregions_line2find);
    my ($last_nbregions_line2find_index)   =$text->find_index_for_lines2replace(\@expel_1, $last_nbregions_line2find);
    my ($num_x_spectral_elements_line2find_index)   =$text->find_index_for_lines2replace(\@expel_1, $num_x_spectral_elements_line2find);
          
    # magic adjustments
    $first_nbregions_line2find_index -= 1; # to account for an extra line above line of search term
    $last_nbregions_line2find_index  -= 3; # to account for the 3 lines of comments before the line with the search term

    # print("first_nbregions_line2find_index:$first_nbregions_line2find_index\n");
    # print("$expel_1[$first_nbregions_line2find_index]\n");

    # print("num_x_spectral_elements_line2find_index:$num_x_spectral_elements_line2find_index\n");
    # print("$expel_1[$num_x_spectral_elements_line2find_index]\n");
    # print("last_nbregions_line2find_index:$last_nbregions_line2find_index\n");
    # print("$expel_1[$last_nbregions_line2find_index]\n");

    my $line_temp = $expel_1[$num_x_spectral_elements_line2find_index];
    my ($nx) = $line_temp =~ /nx\s*=\s*(\d+)/;
    $gpdc2specfem2d->{_nx} = $nx;

    ### CASE 2B. BUILD text that defines spectral-element mesh regions and 
    # their corresponding model numbers  
    # spectral-elemnt regions increase Left-to-right for X direction and 
    # in the UP direction for Z
    # Note that layer numbers from gpdc increase from top to bottom
    my @layer_number2 =  @{_get_specfem2d_layer_numbers_aref()};

    my ($block2insert_aref,$number_array_aref,$new_number_of_specfem2d_layers) = _set_mesh_region_arrays(
                                \@thickness_m, 
                            $nx, $number_of_specfem2d_layers);

    my @block_to_insert_2 = @{$block2insert_aref};

     ### CASE 2C. Replace single lines
    my $text_to_replace = ("nbregions                       = $new_number_of_specfem2d_layers              # then set below the different regions and model number for each region");
    $expel_1[$first_nbregions_line2find_index]   = $text_to_replace;

    ### CALSE 2C. CLEAR a block of CHOMPED(!) lines
    # adjust with magic number spaces
    my $first_index2clear = $first_nbregions_line2find_index +2;
    my $last_index2clear  = $last_nbregions_line2find_index-2;
    my $number_2clear  = $last_index2clear - $first_index2clear + 3;
    splice(@expel_1,$first_index2clear,$number_2clear);

    ### CASE 2C. INSERT the block of lines with the velocity and density models into the Par_file
    # adjust with magic number spaces
    my $nbregions_line2insert_index = $first_nbregions_line2find_index+1;

    my $new_expel_aref_2 = $text->insert_block_after_position(
        \@expel_1,
        \@block_to_insert_2,
        $nbregions_line2insert_index
    );
    my @expel_3 = @$new_expel_aref_2;

	# write out the corrected file
    # first bakup old file
    system ("cp $Par_file_path/$file_name $Par_file_path/$file_name.bak\n");

    my $outbound = $Par_file_path.'/'.$file_name;
    open(my $fh, ">", $outbound) or confess "Cannot open $outbound";

        foreach my $line (@expel_3) {
            print $fh  "$line\n";
        }

    close($fh);
}

=head2 sub

  set_specfem2d_interfaces_file

=cut

sub set_specfem2d_interfaces_file{

    my $nx=$gpdc2specfem2d->{_nx};
    my $model_path_specfem2d = $gpdc2specfem2d->{_model_path_specfem2d};

    confess "model_path_specfem2d must be defined\n" unless length $model_path_specfem2d;
    confess "nx num must be defined\n" unless length $nx;
    confess "No thickness data \n" unless length $gpdc2specfem2d->{_thickness_m_aref};

    # default values (todo)
    my $num_of_points            = 2;
    my $increment_btw_interfaces = 6;
    # First interface
    my $interface_num = 1;
    my $start_height =0;
    my $dz=1; #spectral element height)
    my $from_idx;
    my $to_idx;
    my @text2replace;
    my $array_ref;
    my @block4appendix;
    my @block4replacement;
    my @num_spectral_elements;
    my @mesh_data;
    my @cum_height_m;
    $cum_height_m[0] = 0; # starting with the bottom interface
    my @header;
    my @expel_1;
    my $end_of_section;
    my @layer_thickness_m;

    ### A. READ in the interfaces.dat file
        # read the RAW file into an array
    my $Par_file_path = $model_path_specfem2d.'/DATA';
    my $file_name     = 'interfaces.dat';

    $manage_files_by2->set_file_in($file_name);
    $manage_files_by2->set_directory($Par_file_path);

    # slurp the file into an array
    # all lines are chomped	# write out the corrected file
    my $whole_aref      = manage_files_by2->get_whole();
    my $length_of_slurp = scalar @{$whole_aref};
    my $max_index_slurp = $length_of_slurp - 1;
	my @slurp           = @{$whole_aref};

    # dereference the arrays from the object properties
    my @thickness_m = @{$gpdc2specfem2d->{_thickness_m_aref}};    
    my $number_of_specfem2d_layers = scalar (@thickness_m) -1;

    ### B. ESTIMATE interface heights from the base of the model
     # Bring in spectral element thicknesses.
     # Because we (1)skipped some layers that are too thin
     # and we skip the last half-space layer
     # the number of layers can change from the input gpdc model
    my ($text2insert_aref,$number_array_aref,$new_number_of_specfem2d_layers) 
                        = _set_mesh_region_arrays(
                            \@thickness_m, 
                            $nx, $number_of_specfem2d_layers);
    @mesh_data           = @$number_array_aref;

    # first interface is the bottom of the model
    # interface  heights increase from bottom (1) to top (max)
    # layer numbers increase from top to bottom
    my $number_of_interfaces = $new_number_of_specfem2d_layers + 1;

    for (my $num=($new_number_of_specfem2d_layers-1), my $i=0, my $j=1; 
           $i < $new_number_of_specfem2d_layers; 
           $i++,$j++,$num--) {

        $num_spectral_elements[$i] = $mesh_data[$num][3] - $mesh_data[$num][2] + 1;
        $layer_thickness_m[$i]      = $num_spectral_elements[$i] * $dz;
        $cum_height_m[$j]             = $layer_thickness_m[$i] + $cum_height_m[$i];
        print("interface ($j+1), cum_height in m $cum_height_m[$j]\n");
        print("number of spectral elements in layer $i is $num_spectral_elements[$i]\n");
    }

    ###  Change the text in the interfaces.dat file
    # CASE 1A. SEARCH FOR THE LINES IN THE interfaces.dat _file 
    # TO REPLACE with the values from the gpdc model
    my $num_interfaces_line2find          = "# number of interfaces";
    my ($num_interfaces_line2find_index)  = $text->find_index_for_lines2replace(
                                             \@slurp, $num_interfaces_line2find);
    # print("num_interfaces_line2find_index:$num_interfaces_line2find_index\n");

    # magic adjustments
    $num_interfaces_line2find_index  += 2; # to account for the 1 line of comments after the line with the search term
    my $interface_num_line2find_index = $num_interfaces_line2find_index + 5; # to account for the 2 line of comments after the line with the search term

    ### CASE 1B. Replace single line of text
    $text2replace[0]                     = ("$number_of_interfaces");
    $array_ref = $text->replace_line(\@slurp, $num_interfaces_line2find_index, $text2replace[0]);
    @slurp     = @$array_ref;

    ### CASE 1C. FIRST replacement of a line and a block of text
       # Replace a single line of text
       # interface_num = default = 1; frist cumulative height =0
    $text2replace[1] = ("# interface number $interface_num (bottom of the mesh)");
    $array_ref = $text->replace_line(\@slurp, $interface_num_line2find_index, $text2replace[1]);
    @slurp     = @$array_ref;

    # Build and replace a single block of text
    # extract all the altered portions of the slurp so far
    @block4replacement = ($num_of_points, " 0 $cum_height_m[0]", " $nx $cum_height_m[0]");
    $from_idx          = $interface_num_line2find_index + 2;
    $to_idx            = $interface_num_line2find_index + 4;
    $array_ref         = $text->replace_block(\@slurp, $from_idx, $to_idx,\@block4replacement);
    @slurp             = @$array_ref;
    $end_of_section    = $to_idx;
    @expel_1           = @slurp[0..$end_of_section];  
    
    ### CASE 1D. Build and APPEND additional MULTIPLE blocks of text
    # Update the line indices and iterface number 
    # Interface number increases from bottom to top!
    $interface_num_line2find_index = $interface_num_line2find_index + $increment_btw_interfaces;

    # starts at interface =2, top of lowermost layer
    $interface_num++;
    for (my $i=$interface_num, my $j=1;
            $i <= $new_number_of_specfem2d_layers;
            $i++,$j++) {

        @header   = ("#", "# interface number $i", "#");
        @block4appendix  = ($num_of_points, " 0 $cum_height_m[$j]", " $nx $cum_height_m[$j]");

        push @header, @block4appendix;
        $array_ref        = $text->append_block(\@expel_1,\@header);
        @expel_1          = @$array_ref;      
     }

     ### CASE 1E. Build and APPEND top interface coordinates
        my $i = $new_number_of_specfem2d_layers ;
        my $j = $i+1;
        @header   = ("#", "# interface numberr $j", "#");
        @block4appendix  = ($num_of_points, " 0 $cum_height_m[$i]", " $nx $cum_height_m[$i]");
        push @header, @block4appendix;
        $array_ref        = $text->append_block(\@expel_1,\@header);
        @expel_1          = @$array_ref;  

    ### CASE 1F. Build and Append LAST block of text
    my @block1 = ("#","#", "# for each layer, we give the number of spectral elements in the vertical direction",
                 "#","#", "# layer number 1 (bottom layer)");
    push @expel_1,@block1;

    ### CASE 1F. Build and Append additional MULTIPLE blocks of text
    #  $i < $new_number_of_specfem2d_layers-1
    for (my $i=0; $i < $new_number_of_specfem2d_layers; $i++) {

        my @block2 = ("#",$num_spectral_elements[$i]);
        push @expel_1,@block2;

    }

	# write out the corrected file
    # backup old file first
    system ("cp $Par_file_path/$file_name $Par_file_path/$file_name.bak\n");
    my $outbound = $Par_file_path.'/'.$file_name;
    open(my $fh, ">", $outbound) or confess "Cannot open $outbound";

        foreach my $line (@expel_1) {
            # print "$line\n";
            print $fh  "$line\n";
        }

    close($fh);



}

1;