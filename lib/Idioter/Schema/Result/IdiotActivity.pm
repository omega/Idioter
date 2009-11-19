package Idioter::Schema::Result::IdiotActivity;
use Moose;

extends 'DBIx::Class';
__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('idiot_activity');

__PACKAGE__->add_columns(
    'idiot'        => { data_type => 'integer', is_nullable => 0 },
    'activity'     => { data_type => 'integer', is_nullable => 0 },
);

__PACKAGE__->set_primary_key(qw/idiot activity/);

__PACKAGE__->belongs_to('idiot' => 'Idioter::Schema::Result::Idiot');
__PACKAGE__->belongs_to('activity' => 'Idioter::Schema::Result::Activity');

1;