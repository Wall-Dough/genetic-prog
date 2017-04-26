#!/usr/bin/perl

use strict;
use warnings;

#
# Returns a reference to an expression hash for the function
#     name given in the first parameter.
#     Function expression hashes have the following keys:
#         - type == "func"
#         - func_name - the name of the function (string)
#         - left - the left expression (set using set_left)
#         - right - the right expression (set using set_right)
#
sub mk_func {
	my %expr;
	$expr{type} = "func";
	$expr{func_name} = $_[0];
	return \%expr;
}

#
# Sets the left expression for the given expression hash
#
sub set_left {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;

	$expr{left} = $_[1];
	return \%expr;
}

sub set_arg {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;
	$expr{args}[$_[1]] = $_[2];
	return \%expr;
}

#
# Sets the right expression for the given expression hash
#
sub set_right {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;

	$expr{right} = $_[1];
	return \%expr;
}

#
# Returns a reference to an expression hash for the given
#     integer literal.
#     Integer literal expression hashes have the following keys:
#         - type == "int"
#         - value - the integer value of the literal
#
sub mk_int {
	my %expr;
	$expr{type} = "int";
	$expr{value} = $_[0];
	return \%expr;
}

#
# Returns a reference to an expression hash for the given
#     variable symbol.
#     Variable expression hashes have the following keys:
#         - type == "var"
#         - var_name - the string name for the symbol
#
sub mk_var {
	my %expr;
	$expr{type} = "var";
	$expr{var_name} = $_[0];
	return \%expr;
}

#
# Evaluates the given expression
#
sub eval_expr {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;

	my $binding_ref = $_[1];
	my %binding = %$binding_ref;

	if ($expr{type} eq "func") {
        my $func = get_function_ref($expr{func_name});
        my $argc = get_arg_count($expr{func_name});
		my @eval_args;
		for my $argi (0..($argc - 1)) {
			push @eval_args, eval_expr($expr{args}[$argi], $binding_ref);
		}
		return $func->(@eval_args);
	}
	elsif ($expr{type} eq "int") {
		return $expr{value};
	}
	elsif ($expr{type} eq "var") {
		return $binding{$expr{var_name}};
	}
}

1;
