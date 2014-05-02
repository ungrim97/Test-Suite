use Test::Suite;
Test::Suite->new(test_dirs => ["t/Tests/Exclude"], exclude_tests => [qr/_exclude/])->run;
