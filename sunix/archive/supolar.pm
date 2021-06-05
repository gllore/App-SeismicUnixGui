package supolar;

=pod

=head1 DOCUMENTATION

=head2 SYNOPSIS 

 PROGRAM NAME: supolar 
 AUTHOR: Juan Lorenzo
 DATE: Nov 1 2012
 DESCRIPTION polarization analysis 
 DEPENDS: on CSM seismic unix module "supolar" 
 Version 1

 SUPOLAR - POLarization analysis of three-component data               
                                                                       
 supolar <stdin [optional parameters]                                  
                                                                       
 Required parameters:                                                  
    none                                                               
                                                                       
 Optional parameters:                                                  
    dt=(from header)  time sampling intervall in seconds    

    all=0             1, 2, 3 = set all output flags to that value  

    amplitude parameter or                 
    amp=0             1 = amplitude parameters: instantaneous,         
                          quadratic, and eigenresultant ir, qr, and er
    angle_units or
    angle=rad         unit of angles theta and phi, choose "rad",    
                      "deg", or "gon"                              
   
    azimuth_principal_axes
    phi=0             1, 2, 3 = horizontal azimuth of principal axis 
 
    base_file_name or
    file=polar        base of output file name(s)    

    correlation_window_width_s  or         
    wl=0.1            correlation window length in seconds   

    correlation_window_type   or       
    win=boxcar        correlation window shape, choose "boxcar",     
                      "hanning", "bartlett", or "welsh"          

    flatness or                   
    f1=0              1 = flatness or oblateness coefficient 

    gobal_parameter or      
    tau=0             1 = global polarization parameter                

    incidence_angle_principal_axis or
    theta=0           1, 2, 3 = incidence angle of principal axis   
 
    linearity or          
    l1=0              1 = linearity coefficient   
    
    components_polarizatiion or           
    dir=1             1 = 3 components of direction of polarization    
                          (the only three-component output file) 
    planarity or
    pln=0   1 = planarity measure     

    rectilinearity or                  
    rl=1              1 = rectilinearity evaluating 2 eigenvalues,     
                      2, 3 = rectilinearity evaluating 3 eigenvalues 

    rectilinearity contrast  or 
    rlq=1.0           contrast parameter for rectilinearity

    output_ellipticities
    ellip=0           1 = principal, subprincipal, and transverse      
                          ellipticities e21, e31, and e32              
    
    verbose=0         1 = echo additional information                  
                                                                       
                                                                       
 Notes:                                                                
    Three adjacent traces are considered as one three-component        
    dataset.                                                           
    Correct calculation of angles theta and phi requires the first of  
    these traces to be the vertical component, followed by the two     
    horizontal components (e.g. Z, N, E, or Z, inline, crossline).     
    Significant signal energy on Z is necessary to resolve the 180 deg 
    ambiguity of phi (options phi=2,3 only).                           
                                                                       
    Each calculated polarization attribute is written into its own     
    SU file. These files get the same base name (set with "file=")   
    and the parameter flag as an extension (e.g. polar.rl).            
                                                                       
    In case of a tapered correlation window, the window length wl may  
    have to be increased compared to the boxcar case, because of their y
    smaller effective widths (Bartlett, Hanning: 1/2, Welsh: 1/3).     
                                                                       
 Range of values:                                                      
    parameter     option  interval                                     
    rl            1, 2    0.0 ... 1.0   (1.0: linear polarization)     
    rl            3      -1.0 ... 1.0                                  
    tau, l1       1       0.0 ... 1.0   (1.0: linear polarization)     
    pln, f1       1       0.0 ... 1.0   (1.0: planar polarization)     
    e21, e31, e32 1       0.0 ... 1.0   (0.0: linear polarization)     
    theta         1      -pi/2... pi/2  rad                            
    theta         2, 3    0.0 ... pi/2  rad                            
    phi           1      -pi/2... pi/2  rad                            
    phi           2      -pi  ... pi    rad   (see notes above)        
    phi           3       0.0 ... 2 pi  rad i  (see notes above) 



=cut

sub new {
    my $class   = shift;
    my $supolar = {
        _output_amplitude
        , => shift,
        _amp
        , => shift,
        _angle_units
        , => shift,
        _angle
        , => shift,
        _azimuth_principal_axes
        , => shift,
        _phi
        , => shift,
        _base_file_name
        , => shift,
        _file
        , => shift,
        _correlation_window_width_s
        , => shift,
        _wl
        , => shift,
        _correlation_window_type
        , => shift,
        _win
        , => shift,
        _default_values
        , => shift,
        _all
        , => shift,
        _flatness
        , => shift,
        _f1
        , => shift,
        _global_parameter
        , => shift,
        _tau
        , => shift,
        _incidence_angle_principal_axis
        , => shift,
        _theta
        , => shift,
        _linearity
        , => shift,
        _l1
        , => shift,
        _note
        , => shift,
        _components_polarization
        , => shift,
        _dir
        , => shift,
        _planarity
        , => shift,
        _pln
        , => shift,
        _rectilinearity
        , => shift,
        _rl
        , => shift,
        _rectilinearity_contrast
        , => shift,
        _rlq
        , => shift,
        _Step
        , => shift,
        _verbose
        , => shift,
        _output_ellipticities
        ,       => shift,
        _ellip, => shift
    };
    bless $supolar, $class;
    initiate();
    return $supolar;
}

sub initiate {
    $supolar->{_Step} = '';
    $supolar->{_note} = '';
    my $newline          = '
';
}

sub clear {
    my ($supolar) = @_;
    $supolar->{_output_amplitude}               = '';
    $supolar->{_amp}                            = '';
    $supolar->{_angle_units}                    = '';
    $supolar->{_angle}                          = '';
    $supolar->{_azimuth_principal_axes}         = '';
    $supolar->{_phi}                            = '';
    $supolar->{_base_file_name}                 = '';
    $supolar->{_file}                           = '';
    $supolar->{_correlation_window_type}        = '';
    $supolar->{_win}                            = '';
    $supolar->{_correlation_window_width_s}     = '';
    $supolar->{_wl}                             = '';
    $supolar->{_default_values}                 = '';
    $supolar->{_all}                            = '';
    $supolar->{_flatness}                       = '';
    $supolar->{_f1}                             = '';
    $supolar->{_global_parameter}               = '';
    $supolar->{_tau}                            = '';
    $supolar->{_incidence_angle_principal_axis} = '';
    $supolar->{_theta}                          = '';
    $supolar->{_linearity}                      = '';
    $supolar->{_l1}                             = '';
    $supolar->{_note}                           = '';
    $supolar->{_components_polarization}        = '';
    $supolar->{_dir}                            = '';
    $supolar->{_planarity}                      = '';
    $supolar->{_pln}                            = '';
    $supolar->{_rectilinearity}                 = '';
    $supolar->{_rl}                             = '';
    $supolar->{_rectilinearity_contrast}        = '';
    $supolar->{_rlq}                            = '';
    $supolar->{_verbose}                        = '';
    $supolar->{_output_ellipticities}           = '';
    $supolar->{_ellip}                          = '';
    $supolar->{_Step}                           = '';
}

sub all {
    my ( $supolar, $all ) = @_;
    $supolar->{_all} = $all if defined($all);
    $supolar->{_Step} = $supolar->{_Step} . ' all=' . $supolar->{_all};
}

sub amp {
    my ( $supolar, $amp ) = @_;
    $supolar->{_amp}  = $amp if defined($amp);
    $supolar->{_note} = $supolar->{_note} . ' amp=' . $supolar->{_amp};
    $supolar->{_Step} = $supolar->{_Step} . ' amp=' . $supolar->{_amp};
}

sub angle {
    my ( $supolar, $angle ) = @_;
    $supolar->{_angle} = $angle if defined($angle);
    $supolar->{_note}  = $supolar->{_note} . ' angle=' . $supolar->{_angle};
    $supolar->{_Step}  = $supolar->{_Step} . ' angle=' . $supolar->{_angle};
}

sub angle_units {
    my ( $supolar, $angle_units ) = @_;
    $supolar->{_angle_units} = $angle_units if defined($angle_units);
    $supolar->{_note} =
      $supolar->{_note} . ' angle=' . $supolar->{_angle_units};
    $supolar->{_Step} =
      $supolar->{_Step} . ' angle=' . $supolar->{_angle_units};
}

sub azimuth_principal_axes {
    my ( $supolar, $azimuth_principal_axes ) = @_;
    $supolar->{_azimuth_principal_axes} = $azimuth_principal_axes
      if defined($azimuth_principal_axes);
    $supolar->{_note} =
      $supolar->{_note} . ' phi=' . $supolar->{_azimuth_principal_axes};
    $supolar->{_Step} =
      $supolar->{_Step} . ' phi=' . $supolar->{_azimuth_principal_axes};
}

sub base_file_name {
    my ( $supolar, $base_file_name ) = @_;
    $supolar->{_base_file_name} = $base_file_name if defined($base_file_name);
    $supolar->{_note} =
      $supolar->{_note} . ' file=' . $supolar->{_base_file_name};
    $supolar->{_Step} =
      $supolar->{_Step} . ' file=' . $supolar->{_base_file_name};
}

sub components_polarization {
    my ( $supolar, $components_polarization ) = @_;
    $supolar->{_components_polarization} = $components_polarization
      if defined($components_polarization);
    $supolar->{_note} =
      $supolar->{_note} . ' dir=' . $supolar->{_components_polarization};
    $supolar->{_Step} =
      $supolar->{_Step} . ' dir=' . $supolar->{_components_polarization};

}

sub correlation_window_type {
    my ( $supolar, $correlation_window_type ) = @_;
    $supolar->{_correlation_window_type} = $correlation_window_type
      if defined($correlation_window_type);
    $supolar->{_note} =
      $supolar->{_note} . ' win=' . $supolar->{_correlation_window_type};
    $supolar->{_Step} =
      $supolar->{_Step} . ' win=' . $supolar->{_correlation_window_type};
}

sub correlation_window_length_s {
    my ( $supolar, $correlation_window_length_s ) = @_;
    $supolar->{_correlation_window_length_s} = $correlation_window_length_s
      if defined($correlation_window_length_s);
    $supolar->{_note} =
      $supolar->{_note} . ' wl=' . $supolar->{_correlation_window_length_s};
    $supolar->{_Step} =
      $supolar->{_Step} . ' wl=' . $supolar->{_correlation_window_length_s};
}

sub default_values {
    my ( $supolar, $default_values ) = @_;
    $supolar->{_default_values} = $default_values if defined($default_values);
    $supolar->{_Step} =
      $supolar->{_Step} . ' all=' . $supolar->{_default_values};
}

sub dir {
    my ( $supolar, $dir ) = @_;
    $supolar->{_dir}  = $dir if defined($dir);
    $supolar->{_note} = $supolar->{_note} . ' dir=' . $supolar->{_dir};
    $supolar->{_Step} = $supolar->{_Step} . ' dir=' . $supolar->{_dir};

}

sub ellip {
    my ( $supolar, $ellip ) = @_;
    $supolar->{_ellip} = $ellip if defined($ellip);
    $supolar->{_note}  = $supolar->{_note} . ' ellip=' . $supolar->{_ellip};
    $supolar->{_Step}  = $supolar->{_Step} . ' ellip=' . $supolar->{_ellip};

}

sub file {
    my ( $supolar, $file ) = @_;
    $supolar->{_file} = $file if defined($file);
    $supolar->{_note} = $supolar->{_note} . ' file=' . $supolar->{_file};
    $supolar->{_Step} = $supolar->{_Step} . ' file=' . $supolar->{_file};
}

sub flatness {
    my ( $supolar, $flatness ) = @_;
    $supolar->{_flatness} = $flatness if defined($flatness);
    $supolar->{_note}     = $supolar->{_note} . ' f1=' . $supolar->{_flatness};
    $supolar->{_Step}     = $supolar->{_Step} . ' f1=' . $supolar->{_flatnes};
}

sub f1 {
    my ( $supolar, $f1 ) = @_;
    $supolar->{_f1}   = $f1 if defined($f1);
    $supolar->{_note} = $supolar->{_note} . ' f1=' . $supolar->{_f1};
    $supolar->{_Step} = $supolar->{_Step} . ' f1=' . $supolar->{_f1};
}

sub global_parameter {
    my ( $supolar, $global_parameter ) = @_;
    $supolar->{_global_paramter} = $global_parameter
      if defined($global_parameter);
    $supolar->{_note} =
      $supolar->{_note} . ' tau=' . $supolar->{_global_parameter};
    $supolar->{_Step} =
      $supolar->{_Step} . ' tau=' . $supolar->{_global_parameter};
}

sub incidence_angle_principal_axis {
    my ( $supolar, $incidence_angle_principal_axis ) = @_;
    $supolar->{_incidence_angle_principal_axis} =
      $incidence_angle_principal_axis
      if defined($incidence_angle_principal_axis);
    $supolar->{_note} =
        $supolar->{_note}
      . ' theta='
      . $supolar->{_incidence_angle_principal_axis};
    $supolar->{_Step} =
        $supolar->{_Step}
      . ' theta='
      . $supolar->{_incidence_angle_principal_axis};
}

sub linearity {
    my ( $supolar, $linearity ) = @_;
    $supolar->{_linearity} = $linearity if defined($linearity);
    $supolar->{_note} = $supolar->{_note} . ' l1=' . $supolar->{_linearity};
    $supolar->{_Step} = $supolar->{_Step} . ' l1=' . $supolar->{_linearity};

}

sub l1 {
    my ( $supolar, $l1 ) = @_;
    $supolar->{_l1}   = $l1 if defined($l1);
    $supolar->{_note} = $supolar->{_note} . ' l1=' . $supolar->{_l1};
    $supolar->{_Step} = $supolar->{_Step} . ' l1=' . $supolar->{_l1};

}

sub note {
    my ($supolar) = @_;
    $supolar->{_note} = $supolar->{_note};
    return $supolar->{_note};
}

sub output_amplitude {
    my ( $supolar, $output_amplitude ) = @_;
    $supolar->{_output_amplitude} = $output_amplitude
      if defined($output_amplitude);
    $supolar->{_note} =
      $supolar->{_note} . ' amp=' . $supolar->{_output_amplitude};
    $supolar->{_Step} =
      $supolar->{_Step} . ' amp=' . $supolar->{_output_amplitude};
}

sub phi {
    my ( $supolar, $phi ) = @_;
    $supolar->{_phi}  = $phi if defined($phi);
    $supolar->{_note} = $supolar->{_note} . ' phi=' . $supolar->{_phi};
    $supolar->{_Step} = $supolar->{_Step} . ' phi=' . $supolar->{_phi};
}

sub planarity {
    my ( $supolar, $planarity ) = @_;
    $supolar->{_planarity} = $planarity if defined($planarity);
    $supolar->{_note} = $supolar->{_note} . ' pln=' . $supolar->{_planarity};
    $supolar->{_Step} = $supolar->{_Step} . ' pln=' . $supolar->{_planarity};
}

sub pln {
    my ( $supolar, $pln ) = @_;
    $supolar->{_pln}  = $pln if defined($pln);
    $supolar->{_note} = $supolar->{_note} . ' pln=' . $supolar->{_pln};
    $supolar->{_Step} = $supolar->{_Step} . ' pln=' . $supolar->{_pln};
}

sub rectilinearity {
    my ( $supolar, $rectilinearity ) = @_;
    $supolar->{_rectilinearity} = $rectilinearity if defined($rectilinearity);
    $supolar->{_note} =
      $supolar->{_note} . ' rl=' . $supolar->{_rectilinearity};
    $supolar->{_Step} =
      $supolar->{_Step} . ' rl=' . $supolar->{_rectilinearity};

}

sub rectilinearity_contrast {
    my ( $supolar, $rectilinearity_contrast ) = @_;
    $supolar->{_rectilinearity_contrast} = $rectilinearity_contrast
      if defined($rectilinearity_contrast);
    $supolar->{_note} =
      $supolar->{_note} . ' rlq=' . $supolar->{_rectilinearity_contrast};
    $supolar->{_Step} =
      $supolar->{_Step} . ' rlq=' . $supolar->{_rectilinearity_contrast};

}

sub rl {
    my ( $supolar, $rl ) = @_;
    $supolar->{_rl}   = $rl if defined($rl);
    $supolar->{_note} = $supolar->{_note} . ' rl=' . $supolar->{_rl};
    $supolar->{_Step} = $supolar->{_Step} . ' rl=' . $supolar->{_rl};

}

sub rlq {
    my ( $supolar, $rlq ) = @_;
    $supolar->{_rlq}  = $rlq if defined($rlq);
    $supolar->{_note} = $supolar->{_note} . ' rlq=' . $supolar->{_rlq};
    $supolar->{_Step} = $supolar->{_Step} . ' rlq=' . $supolar->{_rlq};

}

sub Step {
    my ($supolar) = @_;
    $supolar->{_Step} = 'supolar' . $supolar->{_Step};
    return $supolar->{_Step};
}

sub tau {
    my ( $supolar, $tau ) = @_;
    $supolar->{_tau}  = $tau if defined($tau);
    $supolar->{_note} = $supolar->{_note} . ' tau=' . $supolar->{_tau};
    $supolar->{_Step} = $supolar->{_Step} . ' tau=' . $supolar->{_tau};
}

sub theta {
    my ( $supolar, $theta ) = @_;
    $supolar->{_theta} = $theta if defined($theta);
    $supolar->{_note}  = $supolar->{_note} . ' theta=' . $supolar->{_theta};
    $supolar->{_Step}  = $supolar->{_Step} . ' theta=' . $supolar->{_theta};
}

sub verbose {
    my ( $supolar, $verbose ) = @_;
    $supolar->{_verbose} = $verbose if defined($verbose);
    $supolar->{_note}    = $supolar->{_note} . ' =' . $supolar->{_verbose};
    $supolar->{_Step}    = $supolar->{_Step} . ' =' . $supolar->{_verbose};

}

sub output_ellipticities {
    my ( $supolar, $output_ellipticities ) = @_;
    $supolar->{_output_ellipticities} = $output_ellipticities
      if defined($output_ellipticities);
    $supolar->{_note} =
      $supolar->{_note} . ' ellip=' . $supolar->{_output_ellipticities};
    $supolar->{_Step} =
      $supolar->{_Step} . ' ellip=' . $supolar->{_output_ellipticities};

}

sub win {
    my ( $supolar, $win ) = @_;
    $supolar->{_win}  = $win if defined($win);
    $supolar->{_note} = $supolar->{_note} . ' win=' . $supolar->{_win};
    $supolar->{_Step} = $supolar->{_Step} . ' win=' . $supolar->{_win};
}

sub wl {
    my ( $supolar, $wl ) = @_;
    $supolar->{_wl}   = $wl if defined($wl);
    $supolar->{_note} = $supolar->{_note} . ' wl=' . $supolar->{_wl};
    $supolar->{_Step} = $supolar->{_Step} . ' wl=' . $supolar->{_wl};
}

=head2 sub get_max_index

max index = number of input variables -1

=cut

sub get_max_index {
    my ($self) = @_;

    # only file_name : index=6
    my $max_index = 6;

    return ($max_index);
}

1;
