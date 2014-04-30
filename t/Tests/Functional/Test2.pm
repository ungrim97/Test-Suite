package Tests::Functional::Test2;

use Test::Suite::Test;
use Test::Modern;

BEGIN {
    ok(1, 'Correctly loaded '.__PACKAGE__);
}

sub test_loaded {
    my ($self) = @_;

    ok(1, "Tests::Functional::Test2::loaded called successfully");
}

sub test_start {
    ok(1, "Ran test start method");
}

sub test_finish {
    ok(1, "Ran test finish method");
}

1;
