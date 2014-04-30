use Moops;

class Tests::Functional::Moops with Test::Suite::Role::Test {
    use Test::Modern;
    sub test_test1 {
        ok(1, 'Tests::Functional::Moops::test_test1 run correctly');
    }
}
