package su_spec;
use Moose;

=head2

 specifications for seismic unix programs
 both macros and individual modules
  
=cut

my %name_space;

my $su_spec = {
    _name_space 		=> 'name_space',
    _path			=> '/usr/local/pl/libAll/',		
	    };

=head2 sub get

  Debug with
    print ("this is $this\n");
    print ("self is $self,program is $program\n");

  Changing the name space variables to lower
  case is not a general solution because
  original variabls can have mixed upper and lower
  case names
    my $a = Config::Simple->import_from($this,'Z');
     foreach my $key ( keys %Z:: )
    {
       my $x = lc $key;
        print "key is $x\n";
        print "$cfg->param($key)\n";
    }

=cut

=head2 sub get 

  returns values of namespace hash
  as an array

 use Config::Simple;
  Config::Simple	->import_from($this,$su_spec->{_name_space});
  $size               = keys %name_space:: ;
  print("we have $size keys\n\n");
  print(" param is @$ref_param\n\n");
  print("name/value pairs :  @$ref_name[$i] $value[$i]\n");

  becuase hashes are not ordered, we take theyr names/keys
  from an  array and locate the values through the hash
  brought in by Config::Simple

=cut

sub get {

 my ($self,$program)  = @_;
 my (@CFG,@ref_name,@value);
 my ($this,$cfg,$size,$ref_name);
 my ($i,$j);

  if (defined $program) {
    $this 		= $su_spec->{_path}.$program.'_spec'; 
    $cfg        	= new Config::Simple($this);
    $ref_name           = param($this);
    $i=0; 
     foreach my $name (@$ref_name) {
       $value[$i] 	=  $cfg->param($name);
       #print("name is $name  \n\n");
       #print("value is $value[$i]  \n\n");
       $i++;
     }
     $size = $i;
     #print("we have $size keys\n\n");
     for ($i=0,$j=0; $i <$size; $i++,$j=$j+2 ) {
      $CFG[$j]   = $$ref_name[$i]; 
      $CFG[($j+1)] = $value[$i]; 
      #print("$i name/value pairs :  @$ref_name[$j] $value[$j]\n");
     }
    return(\@CFG);
   } 
 return();
}


=head2 sub size

  returns size of namespace hash
  print("we have $size keys\n\n");

=cut

sub size {

 my ($self,$program)  = @_;
 use Config::Simple;

  if (defined $program) {
    my ($this,$cfg,$size);
    $this 		= $su_spec->{_path}.$program.'_spec'; 
    #print($this);
    Config::Simple	->import_from($this,$su_spec->{_name_space});
    $size               = keys %name_space:: ; 

    return($size);
  }
 return();
 } 


=head2 sub param

  returns parameter keys/names 
     print("@$ref_param\n\n");

=cut

 
 sub param {
   my ($program)  = @_;
   if (defined $program) {
     my $ref_param;
     use readfiles;
     my $read 		= new readfiles();
     $ref_param  	= $read->specs($program);
     return($ref_param);
   }
 }


1;
