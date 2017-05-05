#!/usr/bin/perl

# Trapping evals for errors
# - Perl Modules - .pm

use strict;
use warnings;

require "./include.pm";

my @vars = ("x", "y", "z");
my @test_cases;

my $pool = make_pool(10, \@vars);
my $test_cases = make_test_cases(10, \@vars);
run_test_cases($pool, $test_cases);
