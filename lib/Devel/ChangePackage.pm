use strict;
use warnings;

package Devel::ChangePackage;
BEGIN {
  $Devel::ChangePackage::AUTHORITY = 'cpan:FLORA';
}
BEGIN {
  $Devel::ChangePackage::VERSION = '0.03';
}
# ABSTRACT: Change the package code is currently being compiled in

use XSLoader;
use Sub::Exporter -setup => {
    exports => ['change_package'],
    groups  => { default => ['change_package'] },
};


XSLoader::load(
    __PACKAGE__,
    # we need to be careful not to touch $VERSION at compile time, otherwise
    # DynaLoader will assume it's set and check against it, which will cause
    # fail when being run in the checkout without dzil having set the actual
    # $VERSION
    exists $Devel::ChangePackage::{VERSION}
        ? ${ $Devel::ChangePackage::{VERSION} } : (),
);

1;

__END__
=pod

=encoding utf-8

=head1 NAME

Devel::ChangePackage - Change the package code is currently being compiled in

=head1 SYNOPSIS

    package Foo;

    use Devel::ChangePackage;

    BEGIN { change_package 'Bar' }

    warn __PACKAGE__; # Bar

=head1 FUNCTIONS

=head2 change_package

    my $previous_package = change_package $new_package;

Changes the package code is being compiled in to C<$new_package>. The name of
the package things were compiled in before is returned.

=head1 AUTHOR

Florian Ragwitz <rafl@debian.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Florian Ragwitz.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

