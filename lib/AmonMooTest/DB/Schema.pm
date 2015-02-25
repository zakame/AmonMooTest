package AmonMooTest::DB::Schema;
use Moo;
use utf8;

use Teng::Schema::Declare;

base_row_class 'AmonMooTest::DB::Row';

table {
    name 'member';
    pk 'id';
    columns qw(id name);
};

1;
