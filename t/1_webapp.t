#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use Test::More;
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
ok defined $form, 'found echo form';
is $form->{method}, 'POST', 'right form method';
is $form->{action}, '/', 'right form action';

my $text_area = $form->at('textarea[name="text"]');
ok defined $text_area, 'found text area';

my $md_checkbox = $form->at('input[name="md"]');
ok defined $md_checkbox, 'found markdown checkbox';
is $md_checkbox->{type}, 'checkbox', 'right markdown checkbox type';

my $md_label = $form->at('label[for="md"]');
ok defined $md_label, 'found markdown label';
is $md_label->text, 'markdown', 'right markdown label text';

my $submit_button = $form->at('input[type="submit"]');
ok defined $submit_button, 'found submit button';
is $submit_button->{value}, 'echo!', 'right submit button text';

# simple echo
$t->post_ok('/', form => {text => 'foo'})->status_is(200)
  ->text_is('#single', 'foo');

# UTF-8 echo
$t->post_ok('/', form => {text => 'привет'})->status_is(200)
  ->text_is('#single', 'привет');

# long echo
my $message = '.' x 4217;
$t->post_ok('/', form => {text => $message})->status_is(200)
  ->text_is('#single', $message);

# echo with slash in base64
$t->post_ok('/', form => {text => 'ßänkju!'})->status_is(200);
like($t->tx->req->url, qr|/w5/DpG5ranUh|, 'right url (with slash)');
$t->text_is('#single', 'ßänkju!');

# markdown echo
my $markdown = "a  \nи\n\n**d**";
$t->post_ok('/', form => {text => $markdown, md => 1})->status_is(200);
my $md_dom = $t->tx->res->dom->at('#md');
ok defined $md_dom, 'found markdown dom result';
my $md_dom_ps = $md_dom->children;
is $md_dom_ps->size, 2, 'right markdown html paragraph count';
(my $md_dom_first_str = $md_dom_ps->first) =~ s/\s//g;
is $md_dom_first_str, '<p>a<br>и</p>', 'right first paragraph';
(my $md_dom_second_str = $md_dom_ps->last) =~ s/\s//g;
is $md_dom_second_str, '<p><strong>d</strong></p>', 'right second paragraph';

done_testing;

__END__
