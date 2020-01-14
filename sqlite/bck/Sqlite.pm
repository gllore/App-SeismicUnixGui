#! /usr/bin/perl

package Sqlite;

use SU;

sub new {
    my $class  = shift;
    my $sqlite = {
        _min
        , => shift,
        _max
        , => shift,
        _db
        , => shift,
        _key1
        , => shift,
        _key2
        ,       => shift,
        _table, => shift,
    };
    bless $sqlite, $class;
    return $sqlite;
}

# manage sqlite3 data base
# with the following functions
# and definitions

sub set_min {
    my ( $sqlite, $min ) = @_;
    $sqlite->{_min} = $min if defined($min);
    $min_val = $sqlite->{_min};

    #print 'min:'.$sqlite->{_min}."\n\n";
}

sub get_range {
    my ( $sqlite, $get_range ) = @_;
    $sqlite->{_get_range} = $get_range if defined($get_range);
}

sub set_max {
    my ( $sqlite, $max ) = @_;
    $sqlite->{_max} = $max if defined($max);
    $max_val = $sqlite->{_max};

    #print 'max:'.$sqlite->{_max}."\n\n";
}

sub set_db {
    my ( $sqlite, $ref_db ) = @_;
    $sqlite->{_db} = $$ref_db[1] if defined($ref_db);
    $dba1 = $sqlite->{_db};
}

sub set_key1 {
    my ( $sqlite, $key1 ) = @_;
    $sqlite->{_key1} = $key1 if defined($key1);
    $key11 = scalar( $sqlite->{_key1} );

}

sub set_key2 {
    my ( $sqlite, $key2 ) = @_;
    $sqlite->{_key2} = $key2 if defined($key2);
    $key22 = scalar( $sqlite->{_key2} );
}

sub set_table {
    my ( $sqlite, $table ) = @_;
    $sqlite->{_table} = $table if defined($table);
    $table1 = $sqlite->{_table};
}

sub get_list {
    my ($sqlite) = @_;
    print 'getting list' . "\n\n";

    @db_arguments = { RaiseError => 1, AutoCommit => 1 };

    print("Opening an existing database...$dba1\n\n");
    $dbh = DBI->connect( "dbi:SQLite:$dba1", "", "", $db_arguments[1] )
      or die "Couldn't connect to database: " . DBI->errstr;

    if ( $dbh->err() ) { die "$DBI::errstr\n"; }

    #prepare query

    #    print 'key1:'.$key11."\n\n";
    #    print 'key2:'.$key22."\n\n";
    #    print 'table:'.$table1."\n\n";
    #    print 'dba1:'.$dba1."\n\n";
    #    print 'max_val:'.$max_val."\n\n";
    #    print 'min_val:'.$min_val."\n\n";

    $sth = $dbh->prepare(
        "SELECT $key11 ,$key22
		       FROM   $table1 
		       WHERE  ($key22 > $min_val
		       AND ($key22 < $max_val) )
		     "
    );

    print("SELECT $key11 FROM $table1 WHERE ($key22 > $min_val\n");
    print("AND ($key22 < $max_val))\n\n");

    # enquire
    $sth->execute();

    # process query results
    my $rows = $sth->fetchall_arrayref( [ 0, 1 ] );
    $num_rows = scalar(@$rows);

    # restrict num_rows for testing only
    #  $num_rows=4;

    for ( $i = 0 ; $i < $num_rows ; $i++ ) {

        # row is the array of pointer
        # to the row contents
        # raw site name
        my ($name);
        ($name) = @$rows[$i];
        print("\n$key1=@$name[0]\n");
        my $string_value = @$name[0];
        $array_key1[$i] = $string_value;
    }

    print("number of matches = $num_rows \n\n");
    return ( \@array_key1 );

}

@ISA = qw(Exporter);

#export all; import at will
@EXPORT_OK = qw($db $filename $segy $start_time);

$db         = 'db';
$filename   = 'filename';
$segy       = 'segy';
$start_time = 'start_time';

use DBI;
use warnings;
use strict;

use lib '/usr/local/pl/libAll';

use manage_files_by;

# declare local arrays

# declare database handle (pointer to database)
my ( $dbh, $i, $name, $num_rows, $rows, $sth );
my $ref_dbhlite_inbound;
my $string_value;
my ( $key1, $key2, $table, $val );    # from DB table
my ( $ref_array_key1, $ref_array_key2 );
my ( @ref_array_key1, @ref_array_key2 );
my ( @array_key1,     @array_key2 );
my @array_list;
my $array_list;
my @ref_dbhlite_inbound;
my @db_arguments;
my ( @name, @rows );

sub get_file_list {

    # get the list of file names from a database

    $ref_dbhlite_inbound = shift @_;

    #print("database name is @$ref_dbhlite_inbound[1]\n\n");

    # DATABASE WORK #########################
    # establish database arguments for performing
    # several tasks
    # such as opening and closing database files
    # or carrying out defined database functions
    @db_arguments = { RaiseError => 1, AutoCommit => 1 };

    # open an existing database
    print("Opening an existing database...@$ref_dbhlite_inbound[1]\n\n");
    $dbh = DBI->connect( "dbi:SQLite:@$ref_dbhlite_inbound[1]",
        "", "", $db_arguments[1] )
      or die "Couldn't connect to database: " . DBI->errstr;

    if ( $dbh->err() ) { die "$DBI::errstr\n"; }

    #prepare query
    $sth = $dbh->prepare("SELECT filename FROM segy");

    # enquire
    $sth->execute();

    # process query results
    $rows     = $sth->fetchall_arrayref();
    $num_rows = scalar(@$rows);

    #for each row write out the value of the file name
    for ( $i = 0 ; $i < $num_rows ; $i++ ) {

        # raw file name
        $name         = @$rows[$i];
        $string_value = @$name[0];

        #print ("\nvalue=@$name[0]\n");

        # file name without trailing white spaces
        $string_value = manage_files_by::trime($string_value);
        my $size = length($string_value);

        #print ("size of value is $size\n\n");

        $array_list[$i] = $string_value;
    }

    return ( \@array_list );
}

sub get {

    # get the list of file names ($key1) from a database
    # and a table name
    # todo see it if works with numeric values as well as
    # strings
    #my $ref_array_listshift @_;

    $key1                = shift @_;
    $table               = shift @_;
    $ref_dbhlite_inbound = shift @_;

    #print("database name is @$ref_dbhlite_inbound[1]\n\n");

    # DATABASE WORK #########################
    # establish database arguments for performing
    # several tasks
    # such as opening and closing database files
    # or carrying out defined database functions
    @db_arguments = { RaiseError => 1, AutoCommit => 1 };

    # open an existing database
    print("Opening an existing database...@$ref_dbhlite_inbound[1]\n\n");
    $dbh = DBI->connect( "dbi:SQLite:@$ref_dbhlite_inbound[1]",
        "", "", $db_arguments[1] )
      or die "Couldn't connect to database: " . DBI->errstr;

    if ( $dbh->err() ) { die "$DBI::errstr\n"; }

    #prepare query
    $sth = $dbh->prepare("SELECT $key1 FROM $table");

    # enquire
    $sth->execute();

    # process query results
    $rows     = $sth->fetchall_arrayref();
    $num_rows = scalar(@$rows);

    # for each row write out the value of the file name
    for ( $i = 0 ; $i < $num_rows ; $i++ ) {

        # raw file name
        $name         = @$rows[$i];
        $string_value = @$name[0];

        #print ("\nvalue=@$name[0]\n");

        # file name without trailing white spaces
        $string_value = manage_files_by::trime($string_value);
        my $size = length($string_value);

        #print ("size of value is $size\n\n");

        $array_list[$i] = $string_value;
    }

    return ( \@array_list );
}

sub get_key1FRMtableWHkey2GTval {
    $key1                = shift @_;
    $key2                = shift @_;
    $table               = shift @_;
    $val                 = shift @_;
    $ref_dbhlite_inbound = shift @_;

    # DATABASE WORK #########################
    # establish database arguments for performing
    # several tasks
    # such as opening and closing database files
    # or carrying out defined database functions
    @db_arguments = { RaiseError => 1, AutoCommit => 1 };

    # open an existing database
    print("Opening an existing database...$$ref_dbhlite_inbound[1]\n\n");
    $dbh = DBI->connect( "dbi:SQLite:$$ref_dbhlite_inbound[1]",
        "", "", $db_arguments[1] )
      or die "Couldn't connect to database: " . DBI->errstr;

    if ( $dbh->err() ) { die "$DBI::errstr\n"; }

    #prepare query
    $sth = $dbh->prepare(
        "SELECT $key1,$key2
		       FROM   $table
		       WHERE  ($key2 > $val
		       AND ($key2 is not NULL) )
		     "
    );

    print("Select $key1 from $table where $key2 > $val\n\n");

    # enquire
    $sth->execute();

    # process query results
    my $rows = $sth->fetchall_arrayref( [ 0, 1 ] );
    $num_rows = scalar(@$rows);

    # restrict for testing only
    #  $num_rows=5;
    for ( $i = 0 ; $i < $num_rows ; $i++ ) {

        # row is the array of pointer
        # to the row contents
        # raw site name
        my ($name);
        ($name) = @$rows[$i];
        print("\n$key1=@$name[0]\n");
        my $string_value = @$name[0];
        $array_key1[$i] = $string_value;
    }

    print("number of matches = $num_rows \n\n");
    return ( \@array_key1 );
}

sub get_key1Nkey2FRMtableWHkey2GTval {
    $key1                = shift @_;
    $key2                = shift @_;
    $table               = shift @_;
    $val                 = shift @_;
    $ref_dbhlite_inbound = shift @_;

    # DATABASE WORK #########################
    # establish database arguments for performing
    # several tasks
    # such as opening and closing database files
    # or carrying out defined database functions
    @db_arguments = { RaiseError => 1, AutoCommit => 1 };

    # open an existing database
    print("Opening an existing database...$$ref_dbhlite_inbound[1]\n\n");
    $dbh = DBI->connect( "dbi:SQLite:$$ref_dbhlite_inbound[1]",
        "", "", $db_arguments[1] )
      or die "Couldn't connect to database: " . DBI->errstr;

    if ( $dbh->err() ) { die "$DBI::errstr\n"; }

    #prepare query
    $sth = $dbh->prepare(
        "SELECT $key1,$key2
		       FROM   $table
		       WHERE  ($key2 > $val 
		       AND ($key2 is not NULL) )
		     "
    );

    print("Select $key1 from $table where $key2 > $val\n\n");

    # enquire
    $sth->execute();

    # process query results
    my $rows = $sth->fetchall_arrayref( [ 0, 1 ] );
    $num_rows = scalar(@$rows);

    # restrict for testing only
    #  $num_rows=5;
    for ( $i = 0 ; $i < $num_rows ; $i++ ) {

        # row is the array of pointer
        # to the row contents
        # raw site name
        my ($name);
        ($name) = @$rows[$i];
        print("\n$key1=@$name[0]\n");
        print("\n$key2=@$name[1]\n");
        my $string_value = @$name[0];
        my $number_value = @$name[1];
        $array_key1[$i] = $string_value;
        $array_key2[$i] = $number_value;
    }

    print("number of matches = $num_rows \n\n");
    return ( \@array_key1, \@array_key2 );
}

sub update {
    $key1                = shift @_;
    $ref_array_key1      = shift @_;
    $key2                = shift @_;
    $ref_array_key2      = shift @_;
    $ref_dbhlite_inbound = shift @_;
    $table               = shift @_;

    my $size1 = scalar(@$ref_array_key1);
    my $size2 = scalar(@$ref_array_key2);

    print("key1 = $key1 \n\n DB=$$ref_dbhlite_inbound\n\n");
    print("key2 = $key2 \n\n ");
    print("$key1 array size is $size1\n\n");
    print("$key2 array size is $size2\n\n");

    # error messages
    if ( $size1 != $size2 ) {
        print("WARNING:\n$key1 array size does not equal $key2 array size\n\n");
    }

    #print ("array1 = @$ref_array_key1\n\n");
    #print ("array2 = @$ref_array_key2\n\n");

    # DATABASE WORK #########################
    # establish database arguments for performing
    # several tasks
    # such as opening and closing database files
    # or carrying out defined database functions
    @db_arguments = { RaiseError => 1, AutoCommit => 1 };

    # open an existing database
    print("Opening an existing database...$$ref_dbhlite_inbound\n\n");
    $dbh = DBI->connect( "dbi:SQLite:$$ref_dbhlite_inbound",
        "", "", $db_arguments[1] )
      or die "Couldn't connect to database: " . DBI->errstr;

    if ( $dbh->err() ) { die "$DBI::errstr\n"; }

    #prepare query
    $sth = $dbh->prepare(
        "UPDATE $table 
		 SET $key1 = ?
		 WHERE $key2 = ? 
		     "
    );
    if ( $dbh->err() ) { die "$DBI::errstr\n"; }

    # enquire
    #my $size1=3;

    for ( $i = 0 ; $i < $size1 ; $i++ ) {
        $sth->execute( $$ref_array_key1[$i], $$ref_array_key2[$i] );
        print(
"Updated $table \n\tSET $key1=$$ref_array_key1[$i] WHERE $key2=$$ref_array_key2[$i]\n\n"
        );
    }

}

1;
