use Test::Suite;

Test::Suite->new(test_dir => ['t/Tests/Functional'], test_args => {test_arg => 'test_arg_str'})->runtests;
