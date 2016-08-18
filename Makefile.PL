use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
    VERSION   => '0.01',
    PREREQ_PM => {
        'Mojolicious'       => '7.0',
        'Text::Markdown'    => '1.0',
    },
    test      => {TESTS => 't/*.t'}
);
