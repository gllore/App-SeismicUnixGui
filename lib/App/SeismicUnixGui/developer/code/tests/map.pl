

my $defstartup = 'default.perldlrc';
my @pm_names = qw( PDL.pm Lite.pm LiteF.pm AutoLoader.pm Options.pm
                    Matrix.pm Reduce.pm Lvalue.pm Constants.pm);
my %pm = map { my $h = '$()/';
               $h .= 'PDL/' if $_ !~ /PDL.pm$/;
               ( $_, $h . $_ );
           } ( @pm_names, $defstartup );
           
 
           foreach my $key ( keys %pm) {
              print $key."\n";
           };