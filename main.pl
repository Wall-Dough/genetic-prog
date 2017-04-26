#!/usr/bin/perl

use strict;
use warnings;

require "./include.pl";

my @vars = ("x", "y", "z");
my @test_cases;


my $expr = get_random_expr(10, \@vars);
my $binding = get_random_binding(\@vars);
my $result = eval_expr($expr, $binding);
print_expr($expr);
print "$result\n";
