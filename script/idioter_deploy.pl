#!/usr/bin/perl
 
use strict;
use warnings;
 
use FindBin;
use lib "$FindBin::Bin/../lib";
 
use Idioter;
 
my $cfg = Idioter->config->{'Model::DB'};

if (shift eq '--deploy') {
    my $schema = Idioter->model('DB')->schema;
    $schema->deploy();
} else {
    print <<END
please specify one of the following:
--deploy To deploy a new db to what is set in the config-file
END
}