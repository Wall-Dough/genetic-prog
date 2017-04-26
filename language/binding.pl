#!/usr/bin/perl

use strict;
use warnings;

#
# Prints variables and their bound values
#
sub print_binding {
	my $binding_ref = $_[0];
	my %binding = %$binding_ref;

	foreach my $var (keys %binding) {
		printf("%s => %d\n", $var, $binding{$var});
	}
}



sub add_binding {
	my $binding_ref = $_[0];
	my $name = $_[1];
	my $value = $_[2];
	my %binding = %$binding_ref;

	$binding{$name} = $value;
	return \%binding;
}
