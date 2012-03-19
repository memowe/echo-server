#!/usr/bin/env perl

use Mojolicious::Lite;
use Mojo::ByteStream 'b';

plugin charset => {Charset => 'UTF-8'};

get '/' => 'form';

post '/' => sub {
    my $self = shift;
    my $text = $self->param('text');
    my $code = b($text)->encode('UTF-8')->b64_encode->trim;
    $self->redirect_to('show', base64 => $code);
} => 'encode';

get '/*base64' => [base64 => qr/.*/s] => sub {
    my $self = shift;
    my $code = $self->param('base64');
    my $text = b($code)->b64_decode->decode('UTF-8')->to_string;
    $self->stash(message => $text);
} => 'show';

app->start;

__DATA__

@@ form.html.ep
% layout 'default';
<form action="<%= url_for 'encode' %>" method="post"><p>
    <input type="text" name="text" size="20">
    <input type="submit" value="echo">
</p></form>

@@ show.html.ep
% layout 'default';
<p id="message"><%= $message %></p>

@@ layouts/default.html.ep
<!doctype html>
<html>
<head>
<title>echo</title>
<style type="text/css">
html, body { margin: 0; padding: 5%; height: 80% }
table { height: 100%; width: 100% }
td {
    text-align      : center;
    vertical-align  : middle;
    font-size       : 2em;
    font-family     : Helvetica, sans-serif;
}
input { font-size: inherit }
#message { font-weight: bold; font-size: 3em }
</style>
</head>
<body>
<table><tr><td>
%== content
</td></tr></table>
</body>
</html>

<!--
    O HAI. This echo is written in Perl using Mojolicious::Lite
    View source: http://github.com/memowe/echo
    (c) Mirko "memowe" Westermeier
-->

