package Idioter::Types;

use MooseX::Types -declare => [qw/
    IdiotSchema
/];


use MooseX::Types::Moose qw/HashRef/;

class_type IdiotSchema, { class => 'Idioter::Schema' };

coerce IdiotSchema,
    from HashRef,
    via {
        Class::MOP::load_class('Idioter::Schema');
        Idioter::Schema->connect($_);
    }
;