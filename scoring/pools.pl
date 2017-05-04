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
# Tests the pool against the binding and expected result
#
sub test_pool {
	my $pool_ref = $_[0];
	my @pool = @$pool_ref;
	my $pool_size = @pool;
	my $test_case_ref = $_[1];
	my %test_case = %$test_case_ref;
	my $binding_ref = $test_case{binding};
	my $expected_result = $test_case{expected};

	foreach my $i (0..($pool_size - 1)) {
		my $result = eval_expr($pool[$i], $binding_ref);
		print "$i> ";
		print_expr($pool[$i]);
		print "    expected : $expected_result\n";
		print "    actual   : $result\n";
		if ($result == $expected_result) {
			print "    !! PASSED !!\n";
		}
		else {
			print "    !! FAILED !!\n";
		}
	}
}

sub make_test_case {
	my $vars_ref = $_[0];
	my %test_case;
	$test_case{binding} = get_random_binding($vars_ref);
	$test_case{expected} = int(rand() * 10);
	return \%test_case;
}

sub make_test_cases {
	my $num_test_cases = $_[0];
	my $vars_ref = $_[1];
	my @test_cases;

	foreach my $i (0..($num_test_cases - 1)) {
		$test_cases[$i] = make_test_case($vars_ref);
	}

	return \@test_cases;
}

sub run_test_cases {
	my $pool_ref = $_[0];
	my $test_cases_ref = $_[1];
	my @test_cases = @$test_cases_ref;
	my $num_test_cases = @test_cases;
	foreach my $i (0..($num_test_cases - 1)) {
		test_pool($pool_ref, $test_cases[$i]);
	}
}
1;
