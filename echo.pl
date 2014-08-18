#!/usr/bin/env perl

use Mojolicious::Lite;
use Mojo::ByteStream 'b';
use Text::Markdown 'markdown';

get '/' => 'form';

post '/' => sub {
    my $self = shift;
    my $text = $self->param('text');
    my $code = b($text)->encode('UTF-8')->b64_encode->trim;
    my $surl = $self->url_for('show', base64 => $code);
    $self->redirect_to($surl->query(md => $self->param('md')));
} => 'encode';

get '/*base64' => sub {
    my $self = shift;
    my $code = $self->param('base64');
    my $ismd = $self->param('md');
    my $text = b($code)->b64_decode->decode('UTF-8')->to_string;
    my $html = $ismd ? markdown($text) : undef;
    $self->stash(
        message => $text,
        html    => $html,
    );
} => 'show';

app->start;

__DATA__

@@ form.html.ep
% layout 'default';
%= form_for encode => begin
    %= text_area 'text', cols => 40, rows => 5
    %= t 'br'
    %= check_box md => 1 => id => 'md'
    %= t 'label', for => md => 'markdown'
    %= submit_button 'echo!'
% end

@@ show.html.ep
% layout 'default';
% if (stash('html')) {
    <div id="md"><%== $html =%></div>
% } else {
    %= t p => (id => 'single') => $message
% }

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
label { font-size: .5em }
#single { font-weight: bold; font-size: 3em }
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
