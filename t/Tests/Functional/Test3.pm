package Tests::Functional::Test3;

use Test::Suite::Test;
use Test::Modern;

has test_arg => (
    is => 'ro',
    isa => 'Str',
    required => 1,
);

sub test_args {
    my ($self) = @_;
    
    ok($self->test_arg, __PACKAGE__.'has test_arg set');
    is($self->test_arg => 'test_arg_str', '  \_ set to correct value');
}

__PACKAGE__->meta->make_immutable();
1;
