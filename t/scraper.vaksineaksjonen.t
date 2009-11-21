#!/usr/bin/perl -w

use strict;
use Test::More tests => 6;
use Idioter::Scraper::Command::VaksineAksjonen;
use Test::MockObject;
use t::Test;
use utf8;
my $usage = Test::MockObject->new();
my $app = Test::MockObject->new();
$app->set_isa('MooseX::App::Cmd');


my $scraper = Idioter::Scraper::Command::VaksineAksjonen->new( 
    url => 'file:t/scraper/vaksineaksjonen.no',
    usage => $usage,
    app => $app,
    schema => $S,
);

my $res = $scraper->scrape();

use Data::Dump qw/dump/;
is(scalar(@{ $res->{idiots}}), 20, "right number of people");

{
    is($res->{idiots}->[0], 'Birgitte Carlsen');
    is($res->{idiots}->[3], 'Jon-Eirik Holm-Johansen');
    is($res->{idiots}->[8], 'Bjørnsen Jane Høitomt'); # this one is wrong, but best we can do
}

# lets test DB integration

$scraper->update_database($res);

{
    my $i = $S->resultset('Idiot')->find({name => 'Birgitte Carlsen'});
    is($i->name, $res->{idiots}->[0]);
}
{
    my $i = $S->resultset('Idiot')->find({name => 'Bjørnsen Jane Høitomt'});
    is($i->name, $res->{idiots}->[8]);
}