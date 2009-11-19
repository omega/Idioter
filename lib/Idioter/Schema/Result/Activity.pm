package Idioter::Schema::Result::Activity;
use Moose;

extends 'DBIx::Class';
__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('activity');

__PACKAGE__->add_columns(
    'id'        => { data_type => 'integer', is_auto_increment => 1 },
    'name'      => { data_type => 'varchar', size => 255, is_nullable => 0 },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->utf8_columns(qw/name/);

__PACKAGE__->has_many('_idiot_activities' => 'Idioter::Schema::Result::IdiotActivity', 'activity');
__PACKAGE__->many_to_many('idiots' => '_idiot_activites', 'idiot');

1;