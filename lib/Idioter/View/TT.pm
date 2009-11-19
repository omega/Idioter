package Idioter::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    DEFAULT_ENCODING => 'utf-8',
    WRAPPER => 'inc/wrap.tt',
);

=head1 NAME

Idioter::View::TT - TT View for Idioter

=head1 DESCRIPTION

TT View for Idioter.

=head1 SEE ALSO

L<Idioter>

=head1 AUTHOR

Andreas Marienborg

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
