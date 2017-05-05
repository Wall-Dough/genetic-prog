# genetic-prog

This is a genetic programming project. The goal is to write an evolvable programming language.

I didn't exactly achieve the goal to completion.

I did successfully create a basis for a language, with arithmetic operations and trigonometric functions. Functions of any sort of content and length could be created, so long as their arguments are numbers or variables, and the result of the function is a number.

Expressions can be randomly generated and evaluated based on a binding of values to variables.

Included in the code is the ability to create pools of programs, test them against a set of test cases with expected results.

- main.pl
  - Requires the include file
  - Generates a pool of 10 expressions
  - Generates a set of 10 test cases
  - Tests the pool of expressions on the test cases
- include.pm
  - Links all of the separate perl modules
- language/
  - binding.pm
    - Some code written for the binding of values to variables. I don't think I actually use this anywhere in my code right now.
  - expressions.pm
    - The code for creating and evaluating expressions.
    - mk_func : accepts a function name and returns an expression for that function
    - set_arg : accepts a function expression, an argument number, and an expression and sets that argument number to that expression
    - mk_int : accepts a number value and returns an integer expression with that value
    - mk_var : accepts a variable name and returns a variable expression with that name
    - eval_expr : recursively evaluates an expression
    - run_expr : wraps the evaluation for the expression in an eval block
  initial_basis.pm
    - The set of functions available in the language, and some helper functions
    - Functions are stored in a hash, with the name as the key and a sub-hash of the reference to the function and the number of arguments
  mutate.pm
    - A set of functions that would effectively mutate an expression
    - I did not test this code, but I think it should work.
  random_expr.pm
    - A set of functions to generate a random expression
  replicate.pm
    - A set of functions to replicate an expression
    - I did not test this code
- print/
  - pretty_print.pm
    - A set of functions to print an expression
  - string_reps.pm
    - A set of functions that recursively return a string representation of an expression
- scoring/
  - pools.pm
    - A set of functions that generates a pool of expressions, and also generates a set of test cases.
    - All pool generation is random, and also is the test case generation at this point, simply as a proof of concept. The next step would have been to have a way to accept an input file of a specified format, with test cases to conform the program to.
