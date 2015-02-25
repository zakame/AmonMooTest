package AmonMooTest::Database;
use Moo::Role;
use utf8;
use AmonMooTest::DB::Schema;
use AmonMooTest::DB;

requires 'config';

my $schema = AmonMooTest::DB::Schema->instance;

has db => ( is => 'lazy' );

sub _build_db {
    my $c    = shift;
    my $conf = $c->config->{DBI}
        or die "Missing configuration about DBI";
    AmonMooTest::DB->new(
        schema       => $schema,
        connect_info => [@$conf],

        # I suggest to enable following lines if you are using mysql.
        # on_connect_do => [
        #     'SET SESSION sql_mode=STRICT_TRANS_TABLES;',
        # ],
    );
}

1;
