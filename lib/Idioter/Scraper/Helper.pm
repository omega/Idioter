package Idioter::Scraper::Helper;
use Moose::Role;
use URI;

has 'url' => (is => 'ro', isa => 'Str', required => 0, predicate => 'has_url');

has 'web_scraper' => (is => 'ro', isa => 'Object', lazy => 1, builder => 'get_scraper');

requires 'get_scraper';

has 'schema' => (is => 'ro', isa => 'Idioter::Schema', required => 0, predicate => 'has_schema',
    handles => [qw/resultset/]
);

sub execute {
    my ($self) = @_;
    
    $self->update_database($self->scrape());
}

sub update_database {
    my ($self, $res) = @_;
    
    my $idiots = $res->{idiots};
    
    die "No schema" unless $self->has_schema;
    
    foreach my $i (@$idiots) {
        # Now we should find or create
        
        my $idiot = $self->resultset('Idiot')->find_or_create_by_name($i);
    }
}
sub scrape {
    my ($self) = @_;
    die "No url" unless $self->has_url;
    
    $self->web_scraper->scrape(URI->new($self->url));
}

1;