#!/usr/bin/env perl

use strict;
use warnings;
use utf8;

use Test::More;
use Test::Mojo;
use FindBin '$Bin';
use Mojo::UserAgent;

# load echo app
require "$Bin/../echo.pl";

# load tester for echo app
my $t = Test::Mojo->new;
$t->ua->max_redirects(1); # we use 302 redirects
$t->app->log->level('fatal'); # silence

subtest 'Echo form' => sub {
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
};

subtest 'Simple echo' => sub {
    $t->post_ok('/', form => {text => 'foo'})->status_is(200);
    $t->text_is('#single', 'foo');
};

subtest 'UTF-8 echo' => sub {
    $t->post_ok('/', form => {text => 'привет'})->status_is(200);
    $t->text_is('#single', 'привет');
};

subtest 'Long echo' => sub {
    my $message = '.' x 4217;
    $t->post_ok('/', form => {text => $message})->status_is(200);
    $t->text_is('#single', $message);
};

subtest 'Slash in base64' => sub {
    $t->post_ok('/', form => {text => 'ßänkju!'})->status_is(200);
    $t->text_is('#single', 'ßänkju!');
};

subtest 'Length limit' => sub {
    my @c       = ('a' .. 'z', 'A' .. 'Z', 0 .. 9);
    my $input   = join '' => map $c[rand @c] => 1 .. 10_000;
    $t->post_ok('/', form => {text => $input})->status_is(400);
    $t->content_is('Too long!');
};

subtest 'Markdown' => sub {

    # create
    my $markdown = "a  \nи\n\n**d**";
    $t->post_ok('/', form => {text => $markdown, md => 1})->status_is(200);

    # inspect
    my $md_dom = $t->tx->res->dom->at('#md');
    ok defined $md_dom, 'found markdown dom result';
    my $md_dom_ps = $md_dom->children;
    is $md_dom_ps->size, 2, 'right markdown html paragraph count';
    (my $md_dom_first_str = $md_dom_ps->first) =~ s/\s//g;
    is $md_dom_first_str, '<p>a<br>и</p>', 'first paragraph';
    (my $md_dom_second_str = $md_dom_ps->last) =~ s/\s//g;
    is $md_dom_second_str, '<p><strong>d</strong></p>', 'second paragraph';
};

subtest 'QR image' => sub {
    $t->post_ok('/', form => {text => 'foo', md => 0, qr => 1})->status_is(200);
    $t->element_exists('p#qr img', 'QR image');
    my $url = $t->tx->req->url->to_abs;

    subtest 'Check image content' => sub {
        plan skip_all => 'set QR_CONTENT to enable this test (remote requests)'
            unless $ENV{QR_CONTENT};
        diag "Checking QR content via zxing.org, this may take a while...";

        # request image data
        my $img_url = $t->tx->res->dom->at('p#qr img')->attr('src');
        my $img     = $t->get_ok($img_url)->status_is(200)->tx->res->body;

        # send to external qr parsing service
        my $action  = 'https://zxing.org/w/decode';
        my $ua      = Mojo::UserAgent->new; $ua->proxy->detect;
        my $res     = $ua->post($action, form => {f => {content => $img}})->res;

        # extract
        is $res->code => 200, "Decoding via $action succeeded";
        my $seltor  = 'table#result tr:first-child td:nth-child(2) pre';
        my $decoded = $res->dom->at($seltor)->text;
        is $decoded => $url, 'Correct encoded URL';
    };
};

done_testing;

__END__
