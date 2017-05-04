#!/usr/bin/perl

use strict;
use warnings;

#
# Returns a random integer expression
#
sub get_random_int {
	my $val = int(rand(10)) + 1;
	return mk_int($val);
}

sub get_random_func_name {
	my @func_names = get_function_names();
	return $func_names[int(rand($#func_names + 1))];
}

#
# Returns a random function expression
#
sub get_random_func {
	my $depth = $_[0];
	my $vars_ref = $_[1];
	my $name = get_random_func_name();
	my $expr_ref = mk_func($name);
    my $argc = get_arg_count($name);
	for my $argi (0..($argc - 1)) {
		$expr_ref = set_arg($expr_ref, $argi, get_random_expr($depth - 1, $vars_ref));
	}
	return $expr_ref;
}


#
# Returns a random variable expression
#     from the set of variables given
#
sub get_random_var {
	my $vars_ref = $_[0];
	my @vars = @$vars_ref;
	my $var = $vars[int(rand($#vars + 1))];
	return mk_var($var);
}

#
# Returns a random expression with a set depth limit
#
sub get_random_expr {
	my $depth = $_[0];
	my $vars_ref = $_[1];
	my $roll = rand();
	if (($depth <= 0) or ($roll < (1 / 3))) {
		return get_random_int();
	}
	elsif ($roll < (2 / 3)) {
		return get_random_func($depth, $vars_ref);
	}
	else {
		return get_random_var($vars_ref);
	}
}

#
# Returns a binding of variables to random integers
#
sub get_random_binding {
	my $vars_ref = $_[0];
	my @vars = @$vars_ref;
	my %binding;
	foreach my $var (@vars) {
		$binding{$var} = int(rand(10)) + 1;
	}
	return \%binding;
}

1;
