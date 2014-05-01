use Test::Suite;

Test::Suite->new(tags => [qw/test_tags1/], test_dirs => ['t/Tests/Tags'])->runtests;
