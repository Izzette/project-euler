#include <stdio.h>
#include <stdint.h>

#include "triangle.h"

uint64_t sum_of_squares (uint64_t);
uint64_t square_of_sums (uint64_t);

int main () {
	const uint64_t n = 100;
	uint64_t d_ss2 = square_of_sums (n) - sum_of_squares (n);
	printf ("%lu\n", d_ss2);
	return 0;
}

uint64_t sum_of_squares (uint64_t n) {
	return pyra_num (n);
}

uint64_t square_of_sums (uint64_t n) {
	uint64_t x = tri_num (n);
	return x * x;
}

// vim: set ts=4 sw=4 noet syn=c:
