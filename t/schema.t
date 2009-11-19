#!/usr/bin/perl -w

use strict;
use Test::More tests => 1;
use t::Test qw/idiots/;
use utf8;

{
    my $i = $S->resultset('Idiot')->search({ name => 'Håpløse Jens'});
    ok($i);
}
