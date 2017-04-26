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
	my $argc = get_arg_count($name);
	my $string_rep = sprintf("(%s", $name);
	for my $argi (0..($argc - 1)) {
		$string_rep .= sprintf(" %s", get_expr_string($expr{args}[$argi]));
	}
	
	return $string_rep . ")";
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
