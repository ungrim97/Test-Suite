package Test::Suite::Types;

use Type::Library
    -base,
    -declare => qw/ExcludeRegexp TestSuiteTestClass/;
use Type::Utils -all;

extends 'Types::Standard';

use Module::Load;

subtype ExcludeRegexp,
    as RegexpRef;

coerce ExcludeRegexp,
    from ArrayRef, via { my $regex = join '|', @$_; return qr/$regex/; },
    from Str,      via { return qr/$_/; };

subtype TestSuiteTestClass,
    as Str,
    where {
        load $_;
        $_->DOES('Test::Suite::Role::Test');
    },
    message {
        "$_ is not a valid test class";
    };

1;
