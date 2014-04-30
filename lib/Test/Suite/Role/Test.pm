use Moops;

=head1 NAME

Test::Suite::Role::Test

=head1 SYNOPSIS

    with Test::Suite::Role::Test;

=head1 DESCRIPTION

A Moose Role used to inform L<Test::Suite> that this class contains TEST_METHODS.

=cut

role Test::Suite::Role::Test {

    has suite => (
        is => 'ro',
        isa => 'Test::Suite',
        required => 1,
    );

    method run_tests {
        return sub {
            $self->test_startup() if $self->can('test_startup');

            for my $test (@{$self->_filter_test_methods}){
                $self->test_start($test) if $self->can('test_start');
                $self->$test;
                $self->test_finish($test) if $self->can('test_finish');
            }

            $self->test_takedown() if $self->can('test_takedown');
        }
    }

    method _filter_test_methods {
        my $control_methods = qr/test_(?:start|finish|startup|takedown)/;
        my $not_test        = qr/^(?!test_)/;
        my $filter_test_methods = qr/$not_test|$control_methods/;

        my $tests = [];
        for my $test_method ($self->meta->get_method_list){
            next if $test_method =~ $filter_test_methods;
            push $tests, $test_method;
        }

        return $tests;
    }
};

=head1 METHODS

=head2 run_tests

Called by runtests in Test::Suite, run_tests is called on a new TEST_CLASS instance and
should return a subref that handles all execution of the tests for TEST_CLASS. See C<Test::Harness::subtest>
for the arguments this subref will recieve.

This method is responsible for executing each of the test methods on the consuming
test class. A series of test control methods are called around the various test methods
that can be used to controll the flow of the tests being run.


=head2 _filter_test_method

Returns a list of all the test methods that the consuming class provides.

By default all methods that start with test_ and all internal test control methods:
    test_start
    test_finish
    test_startup
    test_takedown
are considered test methods that should be run.

Any class overloading this methods should provide an array ref of all methods that should be
executed as test methods.

=cut

1;
