requires 'perl', '5.008001';
requires 'Moose';
requires 'Types::Standard', '0.042';
requires 'Type::Library', '0.042';
requires 'Module::Load', '0.32';

on 'test' => sub {
    requires 'Test::Modern', '0.007';
};

