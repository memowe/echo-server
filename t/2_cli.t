#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use Test::More tests => 2;
use ojo;
use FindBin '$Bin';

# read script output
open my $cli, '-|', "$^X $Bin/../create_echo.pl 'ßänkju!'"
    or die "couldn't open pipe to command line interface: $!\n";
chomp(my $url       = <$cli>);
chomp(my $tinyurl   = <$cli>);
close $cli;

# check generated echo url
is(g($url)->dom->at('#message')->text, 'ßänkju!', 'right text');

# check generated tiny url
SKIP: {
    skip "couldn't get tiny url", 1 if $tinyurl eq 'tiny url not available!';
    is(g($tinyurl)->dom->at('#message')->text, 'ßänkju!', 'right text');
}

__END__
