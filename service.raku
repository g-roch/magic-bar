use Cro::HTTP::Log::File;
use Cro::HTTP::Server;
use MagicBar::Routes;

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => %*ENV<MAGICBAR_HOST> ||
        die("Missing MAGICBAR_HOST in environment"),
    port => %*ENV<MAGICBAR_PORT> ||
        die("Missing MAGICBAR_PORT in environment"),
    application => routes(),
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ]
);
$http.start;
say "Listening at http://%*ENV<MAGICBAR_HOST>:%*ENV<MAGICBAR_PORT>";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
