#!/usr/bin/perl

use strict;
use warnings;

#
# Returns a set of random expressions
#
sub make_pool {
	my $pool_size = $_[0];
	my $vars_ref = $_[1];

	my @pool;
	foreach my $i (0..($pool_size - 1)) {
		$pool[$i] = get_random_expr(10, $vars_ref);
	}

	return \@pool;
}

#
# Prints the expression pool and their evaluation result
#
sub print_pool {

}

sub test_pool {

}

sub print_test_results {


}

sub add_test_case {

}

sub mk_test_case {

}

1;
