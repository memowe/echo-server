use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    VERSION             => '0.4',
    MIN_PERL_VERSION    => 5.20.1,
    AUTHOR              => 'Mirko Westermeier <mirko@westermeier.de>',
    LICENSE             => 'mit',
    META_MERGE          => {
        resources   => {
            bugtracker  => 'http://github.com/memowe/echo/issues',
            repository  => 'http://github.com/memowe/echo',
        },
    },
    PREREQ_PM           => {
        'Mojolicious'           => '7.51',
        'Text::Markdown'        => '1.0',
        'Gzip::Faster'          => '0.14',
        'Image::PNG::QRCode'    => '0.10',
    },
    test                => {TESTS => 't/*.t'}
);
