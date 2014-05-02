use Moops;

class Tests::Functional::Moops::Moops1 with Test::Suite::Role::Test {
    use Test::Modern;

    BEGIN {
        ok(1, 'Correctly loaded '.__PACKAGE__);
    }

    method test_test {
        ok(1, 'Tests::Functional::Moops::test_test1 run correctly');
    };
}

1;
