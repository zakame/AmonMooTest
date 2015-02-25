package AmonMooTest::Cache;
use Moo::Role;
use utf8;
use CHI;

requires 'config';

has cache => ( is => 'lazy' );

sub _build_cache {
    my $self = shift;
    CHI->new( driver => 'Memory', global => 1 );
}

1;
