#!/usr/bin/env perl

use Mojolicious::Lite;
use Mojo::Util qw(encode decode b64_encode b64_decode trim);
use Text::Markdown qw(markdown);
use Gzip::Faster;

# show form
get '/' => 'form';

# form submission: encode and redirect
post '/' => sub {
    my $c = shift;

    # encode
    my $b64 = trim b64_encode gzip encode 'UTF-8' => $c->param('text');

    # check length (http://stackoverflow.com/a/417184/1184510)
    $c->res->code(400) and return $c->render(text => 'Too long!')
        if length $b64 > 2000;

    # redirect
    my $surl = $c->url_for('show', b64 => $b64);
    $c->redirect_to($surl->query(md => $c->param('md')));
} => 'encode';

# encoded query: show
get '/*b64' => sub {
    my $c = shift;

    # decode
    my $text = decode 'UTF-8' => gunzip b64_decode $c->param('b64');
    my $html = $c->param('md') ? markdown($text) : undef;

    # done
    $c->stash(message => $text, html => $html);
} => 'show';

app->start;

__DATA__

@@ form.html.ep
% layout 'default';
%= form_for encode => begin
    %= text_area text => (cols => 40, rows => 8)
    <br>
    %= check_box md => 1 => (id => 'md')
    %= t label => (for => 'md') => 'markdown'
    <br>
    %= submit_button 'echo!'
% end

@@ show.html.ep
% layout 'default';
% if (stash('html')) {
    <div id="md"><%== $html =%></div>
% } else {
    <p id="single"><%= $message %></p>
% }

@@ layouts/default.html.ep
<!doctype html>
<html><head><title>echo</title>
%= stylesheet begin
    html, body { margin: 0; padding: 5%; height: 80% }
    table { height: 100%; width: 100% }
    td { text-align: center; vertical-align: middle; font-family: sans-serif }
    #md { font-size: 2em }
    #single { font-weight: bold; font-size: 3em }
% end
</head>
<body><table><tr><td><%== content %></td></tr></table></body></html>

<!--
    O HAI. This echo is written in Perl using Mojolicious::Lite
    View source: http://github.com/memowe/echo
    (c) Mirko "memowe" Westermeier
-->
