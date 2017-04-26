#!/usr/bin/perl

use strict;
use warnings;
use Math::Trig;

#
# Adds the second argument to the first argument
#
sub add {
	return $_[0] + $_[1];
};

#
# Subtracts the second argument from the first argument
#
sub subtract {
	return $_[0] - $_[1];
};

#
# Multiplies the first argument by the second argument
#
sub multiply {
	return $_[0] * $_[1];
};

#
# Divides the first argument by the second argument
#     Dies if the denominator is 0
#
sub divide {
	if ($_[1] == 0) {
		die "Error: Divide by zero\n";
	}
	return $_[0] / $_[1];
};

sub sine {
	return sin($_[0]);
}

sub cosine {
	return cos($_[0]);
}

sub tangent {
	return tan($_[0]);
}

#
# A hash of function names and their corresponding function references
#
my %functions;

sub add_function {
	$functions{$_[0]}{fref} = $_[1];
	$functions{$_[0]}{fargc} = $_[2];
};

add_function("+", \&add, 2);
add_function("-", \&subtract, 2);
add_function("*", \&multiply, 2);
add_function("/", \&divide, 2);
add_function("sin", \&sine, 1);
add_function("cos", \&cosine, 1);
add_function("tan", \&tangent, 1);

sub get_function_ref {
	return $functions{$_[0]}{fref};
};

sub get_function_names {
	return keys %functions;
};

sub get_arg_count {
	return $functions{$_[0]}{fargc};
}

1;
