#!/usr/bin/env perl

use Mojolicious::Lite -signatures;
use Mojo::Util qw(encode decode b64_encode b64_decode trim);
use Text::Markdown qw(markdown);
use Gzip::Faster;
use Image::PNG::QRCode 'qrpng';

# config
plugin Config => {default => {
    max_length  => 2000, #http://stackoverflow.com/a/417184/1184510
    hypnotoad   => {listen => ['http://*:4000']},
}};

# show form
get '/' => 'form';

# form submission: encode and redirect
post '/' => sub ($c) {

    # encode
    my $b64 = trim b64_encode gzip encode 'UTF-8' => $c->param('text');

    # check length
    $c->res->code(400) and return $c->render(text => 'Too long!')
        if length $b64 > $c->config('max_length');

    # redirect
    my $surl = $c->url_for('show', b64 => $b64)
        ->query(md => $c->param('md'), qr => $c->param('qr'));
    $c->redirect_to($surl);
} => 'encode';

# render request url as qr code
get '/qr/*b64' => sub ($c) {

    # prepare
    my $url = $c->url_for('show', b64 => $c->param('b64'))->to_abs
        ->query(md => $c->param('md'), qr => 1)->to_string;

    # render PNG data
    $c->render(format => 'png', data => qrpng(text => $url));
} => 'qr';

# encoded query: show as text
get '/*b64' => sub ($c) {

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
	%= t div => begin
		%= text_area text => (cols => 40, rows => 8)
	% end
	%= t p => begin
		%= check_box md => 1 => (id => 'md')
		%= label_for md => 'markdown'
		-
		%= check_box qr => 1 => (id => 'qr', checked => 'checked')
		%= label_for qr => 'QR'
		-
		%= submit_button 'echo!'
	% end
% end

@@ show.html.ep
% layout 'default';
% if (stash('html')) {
    <div id="md"><%== $html =%></div>
% } else {
    <p id="single"><%= $message %></p>
% }
% if (param('qr')) {
    <p id="qr"><%= image url_for 'qr' %></p>
% }

@@ layouts/default.html.ep
<!doctype html>
<html><head><title>echo</title>
%= stylesheet begin
    html, body { margin: 0; padding: 5%; height: 80% }
    table { height: 100%; width: 100% }
    td { text-align: center; vertical-align: middle; font-family: sans-serif }
    div#md { font-size: 2em }
    p#single { font-weight: bold; font-size: 3em }
    p#qr { margin-top: 5em }
% end
</head>
<body><table><tr><td><%== content %></td></tr></table></body></html>
<!-- View source: https://github.com/memowe/echo -->
