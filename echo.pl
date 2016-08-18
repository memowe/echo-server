#!/usr/bin/env perl

use Mojolicious::Lite;
use Mojo::Util qw(encode decode b64_encode b64_decode trim);
use Text::Markdown qw(markdown);
use Gzip::Faster;

# show form
get '/' => 'form';

# form submission: encode and redirect
post '/' => sub {
    my $self = shift;

    # encode
    my $b64 = trim b64_encode gzip encode 'UTF-8' => $self->param('text');

    # redirect
    my $surl = $self->url_for('show', b64 => $b64);
    $self->redirect_to($surl->query(md => $self->param('md')));
} => 'encode';

# encoded query: show
get '/*b64' => sub {
    my $self = shift;

    # decode
    my $text = decode 'UTF-8' => gunzip b64_decode $self->param('b64');
    my $html = $self->param('md') ? markdown($text) : undef;

    # done
    $self->stash(message => $text, html => $html);
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
