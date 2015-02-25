package AmonMooTest::Web::Dispatcher;
use Moo;
use utf8;
use Amon2::Web::Dispatcher::RouterBoom;

any '/' => sub {
    my ($c) = @_;
    my $counter = $c->session->get('counter') || 0;
    $counter++;
    $c->session->set('counter' => $counter);
    return $c->render('index.tx', {
        counter => $counter,
    });
};

post '/reset_counter' => sub {
    my $c = shift;
    $c->session->remove('counter');
    return $c->redirect('/');
};

post '/account/logout' => sub {
    my ($c) = @_;
    $c->session->expire();
    return $c->redirect('/');
};

get '/hello/:name' => sub {
    my ( $c, $args ) = @_;
    if ( my $r
        = $c->db->find_or_create( member => { name => $args->{name} } ) )
    {
        my $n = $r->name;
        my $m = "Hello $n!";
        if ( my $cnt = $c->session->get("counter_$n") || 0) {
            $m = "Welcome back, $n!";
        }
        else {
            $cnt++;
            $c->session->set( "counter_$n", $cnt );
        }
        return $c->create_simple_status_page( 200, $m );
    }
};

get '/bye/:name' => sub {
    my ( $c, $args ) = @_;
    my $n = $args->{name};
    $c->session->remove("counter_$n");
    $c->create_simple_status_page( 200, "Bye, $n!" );
};

1;
