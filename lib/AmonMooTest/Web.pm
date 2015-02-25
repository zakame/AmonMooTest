package AmonMooTest::Web;
use Moo;
use utf8;
extends qw/AmonMooTest Amon2::Web/;
use File::Spec;

# dispatcher
use AmonMooTest::Web::Dispatcher;
sub dispatch {
    return (AmonMooTest::Web::Dispatcher->dispatch($_[0]) or die "response is not generated");
}

# load plugins
__PACKAGE__->load_plugins(
    'Web::FillInFormLite',
    'Web::JSON',
    '+AmonMooTest::Web::Plugin::Session',
);

# setup view
use AmonMooTest::Web::View;
{
    sub create_view {
        my $view = AmonMooTest::Web::View->make_instance(__PACKAGE__);
        no warnings 'redefine';
        *AmonMooTest::Web::create_view = sub { $view }; # Class cache.
        $view
    }
}

# for your security
__PACKAGE__->add_trigger(
    AFTER_DISPATCH => sub {
        my ( $c, $res ) = @_;

        # http://blogs.msdn.com/b/ie/archive/2008/07/02/ie8-security-part-v-comprehensive-protection.aspx
        $res->header( 'X-Content-Type-Options' => 'nosniff' );

        # http://blog.mozilla.com/security/2010/09/08/x-frame-options/
        $res->header( 'X-Frame-Options' => 'DENY' );

        # Cache control.
        $res->header( 'Cache-Control' => 'private' );
    },
);

1;
