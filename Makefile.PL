use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  VERSION   => '0.01',
  PREREQ_PM => {
      'Mojolicious'             => '2.62',
      'WWW::Shorten::Simple'    => '0.01',
  },
  test      => {TESTS => 't/*.t'}
);
