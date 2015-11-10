#include <stdio.h>
#include <stdint.h>

#include "euclid.h"


int main () {
	int cm = 2520, i = 10;

	while (20 >= ++i) {
		cm = LCM_EUCLID(cm, i);
	}

	printf ("%lu\n", cm);

	return 0;
}

// vim: set ts=4 sw=4 noet syn=c:
