package Idioter::Scraper::Command::VaksineAksjonen;
use Moose;
extends qw(MooseX::App::Cmd::Command);
use Web::Scraper;


sub get_scraper {
    Class::MOP::load_class('URI');
    Class::MOP::load_class('Web::Scraper');
    
    scraper {
        process '//table[@width="500"]/tr[@class]/td[2]', 'idiots[]' => [ 'TEXT', \&filter ];
    };
}


sub filter {
    my ($name) = @_;
    utf8::decode($name);
    my @names = split(/\s+/, $name);
    
    push(@names, shift(@names));
    return join(" ", @names);
}

# Now we add the Helper role and tweak some defaults from it

with 'Idioter::Scraper::Helper';
has '+url' => (
    default => 'http://vaksineaksjon.no/index.php?option=com_petitions&view=petition&id=5&Itemid=29&limitstart=0&limit=0'
);

1;