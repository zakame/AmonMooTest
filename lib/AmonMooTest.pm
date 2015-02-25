package AmonMooTest;
use Moo;
use utf8;
our $VERSION='0.01';
use 5.008001;
extends qw/Amon2/;
# Enable project local mode.
__PACKAGE__->make_local_context();

with 'AmonMooTest::Database';

1;
__END__

=head1 NAME

AmonMooTest - AmonMooTest

=head1 DESCRIPTION

This is a main context class for AmonMooTest

=head1 AUTHOR

AmonMooTest authors.

