package AmonMooTest::DB;
use Moo;
use utf8;
extends qw(Teng);

__PACKAGE__->load_plugin('Count');
__PACKAGE__->load_plugin('Replace');
__PACKAGE__->load_plugin('Pager');
__PACKAGE__->load_plugin('FindOrCreate');

1;
