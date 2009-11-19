package 
t::Test;

use strict;
use warnings;
use Idioter::Schema;
use utf8;

our $S;
sub import {
    my ($exp, @imports) = @_;
    
    # create the db
    $S = Idioter::Schema->connect('dbi:SQLite:t/runDB' . $$, undef, undef, { unicode => 1 });
    $S->deploy();
    
    # deploy some data?
    
    foreach my $i ( @imports ) {
        if (my $f = __PACKAGE__->can("import_" . $i)) {
            $f->();
        }
    }
    
    {
        my ($c, $f, $n) = caller();
        
        no strict 'refs';
        *{ $c . '::S' } = \${ $exp . '::S'};
        
    }
}

sub import_idiots {
    $S->resultset('Idiot')->populate([
        ['name'],
        ['Ape Jens'],
        ['Truse Jan'],
        ['Idiot Per'],
        ['Håpløse Jens'],
    ]);
}

END {
    unlink 't/runDB' . $$;
}
1;