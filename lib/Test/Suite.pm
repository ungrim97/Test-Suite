package Test::Suite;
use 5.008005;
use Moose;

use File::Spec::Functions qw/catdir/;
use FindBin qw/$Bin/;

our $VERSION = "0.01";

has test_dirs => (
    is  => 'rw',
    isa => 'Str',
    default => sub {
        return [ catdir($Bin, 't', 'Tests') ];
    },
);

has test_classes => (
    is => 'rw',
    isa => 'ArrayRef',
    lazy_build => 1,
);

has exclude_tests => (
    is => 'rw',
    isa => 'ArrayRef[Str]',
    default => sub {[]};
);

sub runtests {
    my ($self) = @_;

    my $builder = $self->builder;
    for my $test_class ($self->test_classes){
        $builder->subtest(
            $test_class,
            $test->run_tests(test_args => $self->test_args);
        );
    }
}

sub filter_test_classes {
    my ($self, $directory, $test_classes) = @_;

    return sub {
        return unless $File::Find::name =~ /\.pm$/;
    };
}

sub _build_test_classes {
    my ($self) = @_;

    my $test_classes = [];

    for my $directory ($self->test_dirs){
        $directory = catdir(split '/', $directory);
        find(
            no_chdir    => 1,
            wanted      => \filter_test_class($directory, $test_classes));
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

