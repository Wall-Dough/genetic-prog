#!/usr/bin/perl

use strict;
use warnings;

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

sub rep_int {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;
	my %new_expr;
	$new_expr{type} = $expr{type};
	$new_expr{value} = $expr{value};
	return \%new_expr;
}

sub rep_var {
	my $expr_ref = $_[0];
	my %expr = %$expr_ref;
	my %new_expr;
	$new_expr{type} = $expr{type};
	$new_expr{var_name} = $expr{var_name};
	return \%new_expr;
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

1;
