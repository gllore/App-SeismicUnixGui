package su_spec;

=pod 

 specifications for seismic unix programs
 both macros and individual modules
  
=cut

sub {

    use Config::Simple;
    my ( $self, $program ) = @_;
    my $path = '/usr/local/pl/libAll/';
    my $path = './';
    my $spec = new Config::Simple();
    my @CFG;
    if ( defined $program ) {

        my $this = $program;
        $cfg = $spec ( $path . $this . '_spec' );
        $CFG[0] = "file_name";
        $CFG[1] = $cfg->param("file_name");
        return ( $\@CFG );
    }

    return ();
  }
  1;
