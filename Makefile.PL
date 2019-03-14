use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    VERSION             => '0.01',
    MIN_PERL_VERSION    => 5.20.1,
    PREREQ_PM           => {
        'Mojolicious'           => '7.51',
        'Text::Markdown'        => '1.0',
        'Gzip::Faster'          => '0.14',
        'Image::PNG::QRCode'    => '0.10',
    },
    test                => {TESTS => 't/*.t'}
);
