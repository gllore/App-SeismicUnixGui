use ExtUtils::Manifest qw(mkmanifest skipcheck manicheck maniread);
 
 mkmanifest();
 
#my @missing_files    = manicheck;
#my @skipped          = skipcheck;

#my @extra_files      = filecheck;
#my($missing, $extra) = fullcheck;
# 
#my $found    = manifind();
# 
my $manifest = maniread();

foreach my $key (keys %$manifest) {
	
   print (" key is $key\n");
   
}


 
#manicopy($read,$target);
# 
#maniadd({$file => $comment, ...});
