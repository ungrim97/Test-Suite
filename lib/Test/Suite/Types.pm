use Moops;

library Test::Suite::Types extends Types::Standard declares ExcludeRegexp {
    declare ExcludeRegexp,
        as RegexpRef;

    coerce ExcludeRegexp,
        from ArrayRef, via { my $regex = join '|', @$_; return qr/$regex/; },
        from Str,      via { return qr/$_/; }
}

1;
