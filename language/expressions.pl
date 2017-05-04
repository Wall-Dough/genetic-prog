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

sub rep_func {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;
	my %new_expr;
	$new_expr{type} = $expr{type};
	$new_expr{func_name} = $expr{func_name};
	if ($expr{args}) {
		foreach my $i (0..(get_arg_count($new_expr{func_name}))) {
			$new_expr{args}[$i] = rep_expr($expr{args}[$i]);
		}
	}
	return \%new_expr;
}

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

sub rep_int {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;
	my %new_expr;
	$new_expr{type} = $expr{type};
	$new_expr{value} = $expr{value};
	return \%new_expr;
}

sub mut_int {
	my $expr_ref = $_[0];

	# Mutate int (return new random integer)
	if (rand() < 0.25) {
		return get_random_int();
	}

	return $expr_ref;
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

sub rep_var {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;
	my %new_expr;
	$new_expr{type} = $expr{type};
	$new_expr{var_name} = $expr{var_name};
	return \%new_expr;
}

sub mut_var {
	my $expr_ref = $_[0];
	my $vars_ref = $_[1];

	if (rand() < 0.25) {
		return get_random_var($vars_ref);
	}

	return $expr_ref;
}

sub rep_expr {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;

	if ($expr{type} eq "func") {
		return rep_func($expr_ref);
	}
	elsif ($expr{type} eq "int") {
		return rep_int($expr_ref);
	}
	elsif ($expr{type} eq "var") {
		return rep_var($expr_ref);
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

sub run_expr {
	my $expr_ref = $_[0];
	my $binding_ref = $_[1];

	eval {
		my $result = eval_expr($expr_ref, $binding_ref);
	    print "-> ";
	    print_expr($expr_ref);
	    print "$result\n";
	}; warn $@ if $@;
}

1;
