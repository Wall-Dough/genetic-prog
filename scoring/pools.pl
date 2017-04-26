#!/usr/bin/perl

use strict;
use warnings;

#
# Returns a set of random expressions
#
sub make_pool {
	my @pool;
	my $pop_size = $_[0];
	my $vars_ref = $_[1];
	my $max_depth = 5;
	foreach my $i (0..($pop_size - 1)) {
		$pool[$i] = get_random_expr($max_depth, $vars_ref);
	}
	return \@pool;
}

#
# Prints the expression pool and their evaluation result
#
sub print_pool {
	my $pool_ref = $_[0];
	my $binding_ref = $_[1];
	my @pool = @$pool_ref;
	foreach my $i (0..$#pool) {
		print "-> ";
		print_expr($pool[$i]);
		my $result = eval_expr($pool[$i], $binding_ref);
		print "$result\n";
	}
}

sub test_pool {
	my $pool_ref = $_[0];
	my @pool = @$pool_ref;
	my $test_cases_ref = $_[1];
	my @test_cases = @$test_cases_ref;

	my @results = ();

	foreach my $pool_i (0..$#pool) {
		foreach my $test_i (0..$#test_cases) {
			my $result = eval_expr($pool[$pool_i], $test_cases[$test_i]{binding});
			$results[$pool_i][$test_i] = ($result == $test_cases[$test_i]{result});
		}
	}
	return \@results;
}

sub print_test_results {
	my $pool_ref = $_[0];
	my @pool = @$pool_ref;
	my $test_cases_ref = $_[1];
	my @test_cases = @$test_cases_ref;

	my $results_ref = test_pool($pool_ref, $test_cases_ref);
	my @results = @$results_ref;

	foreach my $pool_i (0..$#pool) {
		foreach my $test_i (0..$#test_cases) {
			print $results[$pool_i][$test_i] . "\n";
		}
	}

}

sub add_test_case {
	my $test_cases_ref = $_[0];
	my @test_cases = @$test_cases_ref;
	my $binding_ref = $_[1];
	my $result = $_[2];

	$test_cases[$#test_cases + 1]{binding} = $binding_ref;
	$test_cases[$#test_cases]{result} = $result;

	return \@test_cases;
}

sub mk_test_case {
	my %test_case;
}

1;
