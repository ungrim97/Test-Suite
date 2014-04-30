use Test::Suite;

Test::Suite->new(test_dirs => ['t/Tests/Functional'], test_args => {test_arg => 'test_arg_str'})->runtests;
