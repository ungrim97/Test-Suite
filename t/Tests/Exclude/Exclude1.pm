package Tests::Exclude::Exclude1;

use Test::Suite::Test;
use Test::Modern;

BEGIN {
    ok(1, 'Correctly loaded '.__PACKAGE__);
}

sub test_exclude {
    ok(0, 'Test::Exclude::Exclude1::test_exclude not run correctly');
}

sub test_noexclude {
    ok(1, 'Test::Exclude::Exclude1::test_noexclude run correctly');
}

1;
