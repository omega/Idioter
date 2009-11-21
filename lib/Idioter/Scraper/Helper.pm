package Idioter::Scraper::Helper;
use Moose::Role;
use URI;

with 'MooseX::SimpleConfig';
use Idioter::Types qw/IdiotSchema/;

has 'url' => (is => 'ro', isa => 'Str', required => 0, predicate => 'has_url');
has 'activity' => (is => 'ro', isa => 'Str');
has 'web_scraper' => (is => 'ro', isa => 'Object', lazy => 1, builder => 'get_scraper');

requires 'get_scraper';

has 'schema' => (is => 'ro', isa => IdiotSchema, coerce => 1, required => 0, predicate => 'has_schema',
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
    
    # Should find our activity
    my $act = $self->resultset('Activity')->find_or_create({ name => $self->activity });
    
    foreach my $i (@$idiots) {
        # Now we should find or create
        
        my $idiot = $self->resultset('Idiot')->find_or_create_by_name($i);
        
        $idiot->add_to_activites($act) unless $idiot->has_activity($act);
    }
}
sub scrape {
    my ($self) = @_;
    die "No url" unless $self->has_url;
    
    $self->web_scraper->scrape(URI->new($self->url));
}

1;