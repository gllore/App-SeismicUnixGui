#! /usr/bin/perl 

$name[1]     = 'abaho'; 
$class_size  = 1;

for ($i=1; $i <= $class_size; $i++) {
    system 'echo', ("/usr/sbin/userdel -rf $name[$i]");
    system("/usr/sbin/userdel -rf $name[$i]");
}
