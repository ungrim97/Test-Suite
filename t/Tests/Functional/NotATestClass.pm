package Tests::Functional::NotATestClass;

use Moose;
use Test::Modern;

BEGIN {
    ok(1, 'Correctly loaded '.__PACKAGE__);
}

sub test_method {
    ok(0, 'This is not a test class so this test should never be run');
}

__PACKAGE__->meta->make_immutable();
1;
