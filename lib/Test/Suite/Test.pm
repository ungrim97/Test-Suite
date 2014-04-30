package Test::Suite::Test;

use Moose ();
use Moose::Exporter;

Moose::Exporter->setup_import_methods(
    base_class_roles => [qw/Test::Suite::Role::Test/],
    also             => (qw/Moose/),
);

1;
