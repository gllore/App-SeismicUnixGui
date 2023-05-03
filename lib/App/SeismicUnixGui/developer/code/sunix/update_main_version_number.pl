use Moose;

=head2 SYNOPSIS

PACKAGE NAME: update_main_version_number.pl

AUTHOR:  

DATE: V 0.1 May 3 2023

DESCRIPTION: replace version number in key files

Version: 0.1


=head2 USE

=head3 NOTES



=head4 Examples

=head2 SYNOPSIS
    
=head2 CHANGES and their DATES

=cut

use aliased 'App::SeismicUnixGui::misc::manage_files_by2';
use Cwd;

my $manage_files_by2 = manage_files_by2->new();

my (@file,@file_bck);
my $path;
my @path2file;
my @inbound;
my @outbound_bck;
my @outbound;
my ( @line2find, @replacement );

my $up3dirs = '/../../../';


=head2 set replacement text
and file

=cut

my $local   = getcwd();

my $i=0;
$line2find[$i]    = 'L_SUV0.82.6.pl';
$replacement[$i]  = 'L_SUV0.82.7.pl';
$file[$i]         = 'L_SU.pl';
$path2file[$i]    =  $local . $up3dirs . 'script';

$i=1;
$line2find[$i]   = "\$VERSION = '0.82.6';";
$replacement[$i] = "\$VERSION = '0.82.7';";
$file[$i]        = 'About.pm';
$path2file[$i]   =  $local . $up3dirs . 'messages';

=head2 Set files and paths

=cut


$i=1;

$file_bck[$i] = $file[$i].'_bck';


$inbound[$i]      = $path2file[$i] . '/' . $file[$i];
$outbound[$i]     = $path2file[$i] . '/' . $file[$i];
$outbound_bck[$i] = $path2file[$i] . '/archive/' . $file_bck[$i];

# save a backup file
system("cp $inbound[$i] $outbound_bck[$i]");

# slurp every file
$manage_files_by2->set_pathNfile( $inbound[$i] );
my $slurp_ref = manage_files_by2->get_whole();

my @slurp           = @$slurp_ref;
my $length_of_slurp = scalar @slurp;

for ( my $line_idx = 0 ; $line_idx < $length_of_slurp ; $line_idx++ ) {

	# CASE within each *.pm file
	my $string = $slurp[$line_idx];

	#  chomp $string;    # remove all newlines
	if ( $string =~ m/$line2find[0]/ ) {
		$string =~ s/$line2find[0]/$replacement[0]/;
		print(" substitution successful: $string\n");
	}

	$slurp[$line_idx] = $string;

}

open( OUT, ">$outbound[$i]" )
  or die("File $outbound[$i] not found");

foreach my $text (@slurp) {	
	
	printf OUT $text."\n";

#	print("$text \n");
}
close(OUT);

