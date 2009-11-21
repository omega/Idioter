package Idioter::Schema::ResultSet::Idiot;
use Moose;

extends 'DBIx::Class::ResultSet';


sub find_or_create_by_name {
    my ($self, $name) = @_;
    
    # This could become more inteligent in locating idiots later
    return $self->find_or_create({ name => $name});
}

1;
