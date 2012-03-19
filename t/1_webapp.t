#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use Test::More tests => 22;
use Test::Mojo;
use FindBin '$Bin';

# load echo app
require "$Bin/../echo.pl";

# load tester for echo app
my $t = Test::Mojo->new;
$t->ua->max_redirects(1); # we use 302 redirects

# get echo form
$t->get_ok('/')->status_is(200)->text_is(title => 'echo');

# inspect echo form
my $form = $t->tx->res->dom->at('form');
ok(defined($form), 'found echo form');
is($form->{method}, 'post', 'right form method');
is($form->{action}, '/', 'right form action');

my $text_field = $form->at('input[name="text"]');
ok(defined($text_field), 'found text field');
is($text_field->{type}, 'text', 'text field isa text field');

my $submit_button = $form->at('input[type="submit"]');
ok(defined($submit_button), 'found submit button');

# simple echo
$t->post_form_ok('/', {text => 'foo'})->status_is(200)
  ->text_is('#message', 'foo');

# UTF-8 echo
$t->post_form_ok('/', {text => 'привет'})->status_is(200)
  ->text_is('#message', 'привет');

# long echo
my $message = '.' x 1000;
$t->post_form_ok('/', {text => $message})->status_is(200)
  ->text_is('#message', $message);

# echo with slash in base64
$t->post_form_ok('/', {text => 'ßänkju!'})->status_is(200);
like($t->tx->req->url, qr|/w5/DpG5ranUh$|, 'right url (with slash)');
$t->text_is('#message', 'ßänkju!');

__END__
