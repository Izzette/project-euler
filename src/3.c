#include <stdio.h>
#include "primes.h"

typedef unsigned long long ulli_t;

int main () {
	ulli_t n = 600851475143ULL;
	dprintf (2, "%s = %llu\n", "n", n);

	int i = NPRIMES - 1;

	ulli_t m;
	m = (ulli_t)primes[i];
	m *= m;

	if (m < n) {
		dprintf (2, "%s\n", "fatal: insufficent primes array");
		return 1;
	} else if (m == n) {
		printf ("%d\n", primes[i]);
	}
	
	do {
		m = (ulli_t)primes[--i];
		m *= m;
	} while (n > m);

	if (NPRIMES - 1 != i) 
		dprintf (2, "%s %llu ... %llu\n", "skipping primes", primes[NPRIMES - 1], primes[i]);

	for (/*i=i*/; 0 <= i; --i) {
		if (0 == n % primes[i]) {
			printf ("%d\n", primes[i]);
			return 0;
		}
	}
}

// vim: set ts=4 sw=4 noet syn=c:
