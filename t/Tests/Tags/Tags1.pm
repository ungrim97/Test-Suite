package Tests::Tags::Tags1;

use Test::Suite::Test;
use Test::Modern;

BEGIN {
    ok(1, 'Correctly loaded '.__PACKAGE__);
}

sub test_tags1 :Tags(qw/test_tags1 test_tag2/) {
    ok(1, 'Test::Functional::Tags1::test_tag1 run correctly' );
}

sub test_tags2 :Tags(qw/test_tags2/) {
    ok(0, 'Test::Functional::Tags1::test_tag2 not run');
}

sub test_notag {
    ok(0, 'Test::Functional::Tags1::test_notag not run');
}

1;
