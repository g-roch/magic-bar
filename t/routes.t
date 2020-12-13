use Cro::HTTP::Test;
use Test;
use MagicBar::Routes;

test-service routes, {
    test get('/'),
            status => 200,
            body-text => '<h1> MagicBar </h1>';
}

done-testing;
