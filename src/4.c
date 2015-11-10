#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

#include "divrem.h"

typedef unsigned int ui_t;

bool isPalin (const ui_t);

int main () {
	int i, j, n, m = 0;
	for (i = 999; 99 < i; --i)
		for (j = 999; 99 < j; --j) {
			n = i * j;
			if (m < n && isPalin(n))
				m = n;
		}

	printf ("%d\n", m);
}

#define MIRROR(i, x, m) { \
	m = x - i - 1; \
}

bool isPalin (const ui_t n) {
	int q, r, l_n = n;
	char buf[10];
	int x = 0;
	while (0 < l_n) {
		divrem (&q, &r, l_n, 10);
		l_n = q;
		buf[x++] = r;
	}

	if (0 >= x)
		return true;

	int m, i, h = x / 2;

	for (i = 0; h > i; ++i) {
		MIRROR(i, x, m);
		if (buf[i] != buf[m])
			return false;
	}

	return true;
}

// vim: set ts=4 sw=4 noet syn=c:
