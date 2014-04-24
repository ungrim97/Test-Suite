package Test::Suite::Test;
use Moose::Util qw/apply_all_roles/;

sub import {
    my ($class) = @_;
    my $caller = caller;

    my $export = <<"END";
package $caller;
use Moose;
use Test::Most;

END

    eval $export;
    apply_all_roles($caller, 'Test::Suite::Role::Test');
}

1;
