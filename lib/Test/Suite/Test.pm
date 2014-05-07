package Test::Suite::Test;

use Moose ();
use Moose::Exporter;
use MooseX::MethodAttributes;

Moose::Exporter->setup_import_methods(
    base_class_roles => [qw/Test::Suite::Role::Test/],
    also             => [qw/Moose MooseX::MethodAttributes/],
);

1;
