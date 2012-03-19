#!/usr/bin/env perl

use feature 'say';
use ojo;
use WWW::Shorten::Simple;

my $input = shift;
die "whoops, whole text as one command line argument, please!\n"
    if length $input == 0 or @ARGV > 0;

# create webapp url
my $webapp  = 'http://netzverwaltung.info/echo.pl';
my $base64  = b($input)->b64_encode->trim;
my $url     = "$webapp/$base64";
say $url;

# create tinyurl
my $short_url = WWW::Shorten::Simple->new('TinyURL')->shorten($url);
say defined($short_url) ? $short_url : 'tiny url not available!';
