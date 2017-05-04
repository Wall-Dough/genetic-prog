#!/usr/bin/perl

use strict;
use warnings;

sub mut_func {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;
	my $depth = $_[1];
	my $vars_ref = $_[2];

	# Mutate function name
	if (rand() < 0.25) {
		$expr{func_name} = get_random_func_name();
	}

	my $arg_count = get_arg_count($expr{func_name});
	my $num_args = $expr{args};

	# Add arguments if necessary
	if ($num_args < $arg_count) {
		foreach my $i ($num_args..($arg_count - 1)) {
			set_arg($expr_ref, $i, get_random_expr($depth - 1, $vars_ref));
		}
	}

	# Pluck off arguments if necessary
	while ($arg_count < $num_args) {
		remove_arg($expr_ref, $arg_count);
		$num_args = $expr{args};
	}

	# Mutate arguments
	foreach my $i (0..($arg_count - 1)) {
		if (rand() < 0.25) {
			set_arg($expr_ref, $i, mut_expr($depth - 1, $vars_ref));
		}
	}
}

sub mut_int {
	my $expr_ref = $_[0];

	# Mutate int (return new random integer)
	if (rand() < 0.25) {
		return get_random_int();
	}

	return $expr_ref;
}


sub mut_var {
	my $expr_ref = $_[0];
	my $vars_ref = $_[1];

	if (rand() < 0.25) {
		return get_random_var($vars_ref);
	}

	return $expr_ref;
}

sub mut_expr {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;
	my $depth = $_[1];
	my $vars_ref = $_[2];


	# Small chance to get a completely new random expression
	if (rand() < 0.10) {
		return get_random_expr($depth, $vars_ref);
	}

	if ($expr{type} eq "func") {
		return mut_func($expr_ref, $depth, $vars_ref);
	}
	elsif ($expr{type} eq "int") {
		return mut_int($expr_ref);
	}
	elsif ($expr{type} eq "var") {
		return mut_var($expr_ref, $vars_ref);
	}
	return $expr_ref;
}
