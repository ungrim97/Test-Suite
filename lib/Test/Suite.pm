package Test::Suite;

use 5.008005;
use Moose;
use Test::Suite::Types qw/:all/;

use Test::Builder;
use File::Spec::Functions qw/catdir splitdir rel2abs abs2rel/;
use File::Find;
use FindBin qw/$Bin/;
use Module::Load;

has test_dirs => (
    is  => 'rw',
    isa => ArrayRef[Str],
    default => sub {
        return [ catdir($Bin) ];
    },
);

has test_args => (
    is => 'rw',
    isa => HashRef,
    lazy => 1,
    default => sub {{}},
);

has test_classes => (
    is      => 'rw',
    isa     => ArrayRef[TestSuiteTestClass],
    lazy    => 1,
    builder => '_build_test_classes',
);

has exclude_tests => (
    is      => 'rw',
    isa     => ExcludeRegexp|Undef,
    lazy    => 1,
    coerce  => 1,
    default => sub {undef},
);

has tags => (
    is      => 'rw',
    isa     => ArrayRef[Str],
    lazy    => 1,
    default => sub {[]}
);

has builder => (
    is      => 'rw',
    isa     => 'Test::Builder',
    lazy    => 1,
    default => sub { return Test::Builder->new() },
);

sub runtests {
    return shift->run();
}

sub run {
    my ($self) = @_;
    my $builder = $self->builder;

    for my $test_class (@{$self->test_classes}){
        my $test = $test_class->new(suite => $self, %{$self->test_args});
        $builder->subtest(
            $test_class,
            $test->run_tests,
        );
    }

    $builder->done_testing;
    return $self;
}

sub filter_test_files {
    my ($self, $test_classes) = @_;
    return sub {
        my $file = $File::Find::name;
        return unless $file =~ /\.pm$/;

        $file = abs2rel($file, 't');
        # Turn file names into package names, return if file doesn't look like a package
        $file =~ s/\.pm$//;
        my ($package) = (join '::', grep $_, splitdir($file)) =~ /^([[:word:]]+(?:::[[:word:]]+)*)$/;
        return unless $package && is_TestSuiteTestClass($package);

        unshift @$test_classes, $package;
    };
}

sub _build_test_classes {
    my ($self) = @_;
    my $test_classes = [];

    # All test dirs should be relative to t/ so add t/ to @INC
    unshift @INC, 't';

    # Test dirs is a list of the locations to look for .pm file
    # not a list of the @INC bases
    for my $test_dir (@{$self->test_dirs}){
        # Add OS specific PATH to @INC
        $test_dir = rel2abs(catdir(split '/', $test_dir));

        # Provide overloadable filter for test class loading
        find({
            no_chdir    => 1,
            wanted      => $self->filter_test_files($test_classes),
        }, $test_dir);
    }

    return $test_classes;
}

1;
__END__

=encoding utf-8

=head1 NAME

Test::Suite - It's new $module

=head1 SYNOPSIS

    use Test::Suite;
    

=head1 DESCRIPTION

Test::Suite is ...

=head1 LICENSE

Copyright (C) Mike Francis.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Mike Francis E<lt>ungrim97@gmail.comE<gt>

=cut

