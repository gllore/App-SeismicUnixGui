use Moose;

use manage_files_by2;

my $write = manage_files_by2->new();

my @data;
my $file_name = 'data1.dat';
my $fifo_name = 'data1.dat';
my $format = '%10.3f';

$data[0] = 1;

#$write->set_file_name($file_name);
$write->set_format($format);
#$write->write_1col(\@data);
$write->set_fifo_name($fifo_name);
$write->write_1col2fifo(\@data);