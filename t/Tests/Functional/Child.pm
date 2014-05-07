package Tests::Functional::Child;

use parent 'Tests::Functional::Parent';
use Test::Modern;

sub test_child {
    ok(1, 'Ran '.__PACKAGE__.' test_child');
    ok(__PACKAGE__->isa('Tests::Functional::Parent'), 'ISA Tests::Functional::Parent');
    ok(__PACKAGE__->can('test_parent'), 'Has access to parent methods');
}

1;
