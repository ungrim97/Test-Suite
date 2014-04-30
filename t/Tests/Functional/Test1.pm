package Tests::Functional::Test1;

use Test::Suite::Test;
use Test::Modern;

BEGIN {
    ok(1, 'Correctly loaded '.__PACKAGE__);
}

sub test_loaded {
    my ($self) = @_;

    ok(1, 'Test::Unit::Test1::loaded called successfully');
    ok($self->DOES('Test::Suite::Role::Test'), 'Performs the test suite test role');
    is(ref $self => __PACKAGE__, '$self is of the correct class');
}

sub not_a_test_method {
    ok(0, "That test should never be run");
}

__PACKAGE__->meta->make_immutable();
1;
