package Tests::Functional::Parent;

use Test::Suite::Test;
use Test::Modern;

sub test_parent {
    ok(1, 'Ran '.__PACKAGE__.'test_parent');
}

1;
