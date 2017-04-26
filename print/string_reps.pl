#!/usr/bin/perl

use strict;
use warnings;

#
# A helper function for printing a function call
#     Returns a string with a function and its arguments
#
sub get_func_string {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;
	my $name = $expr{func_name};
	my $string_rep = sprintf("(%s", $name);
	if (get_arg_count($name) == 1) {
		return sprintf("(%s %s)", $name, get_expr_string($expr{left}));
	}
	return sprintf("(%s %s %s)", $name, get_expr_string($expr{left}), get_expr_string($expr{right}));
}

#
# A helper function for printing an integer literal
#     Returns the string form of an integer
#
sub get_int_string {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;

	return sprintf("%d", $expr{value});
}

#
# A helper function for printing a variable symbol
#     Returns the string name of the variable
#
sub get_var_string {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;

	return sprintf("%s", $expr{var_name});
}

#
# A function for printing an expression
#     Recursively builds the expression string
#
sub get_expr_string {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;
	if ($expr{type} eq "func") {
		return get_func_string($expr_ref);
	}
	elsif ($expr{type} eq "int") {
		return get_int_string($expr_ref);
	}
	elsif ($expr{type} eq "var") {
		return get_var_string($expr_ref);
	}
}

1;
