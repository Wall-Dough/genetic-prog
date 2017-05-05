#!/usr/bin/perl

use strict;
use warnings;

#
# Prints the results of get_expr_string for the given expression
#
sub print_expr {
	my $expr_ref = $_[0];
	my $expr_string = get_expr_string($expr_ref);
	print "$expr_string\n";
}

1;
