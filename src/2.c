#include <stdio.h>
#include <stdbool.h>

typedef unsigned long long int ulli_t;
typedef unsigned int ui_t;

#define BUFF_SIZE

#define FIB_0 2U
#define FIB_1 1U
#define FIB_MAX 4000000ULL
#define ITR_FIB(fib_buf) { \
	ui_t fib_n = fib_buf[0] + fib_buf[1]; \
	fib_buf[1] = fib_buf[0]; \
	fib_buf[0] = fib_n; \
}

#define HFMT "%13s%10s\n"
#define FMT "%3d%10d%10d\n"

#define HEAD() { \
	dprintf (2, HFMT, "SUM", "FIB[i]"); \
}
#define STATUS(i, sum, fib_buf) { \
	dprintf (2, FMT, i, sum, *fib_buf); \
}

int main () {
	HEAD();

	ui_t fib_buf[2] = { FIB_0, FIB_1 };

	int i = 0;
	ulli_t sum = 0;

	ui_t ugh = FIB_1;

	STATUS(i++, sum, &ugh);

	do {
		if (FIB_MAX <= fib_buf[0])
			break;

		if (! (fib_buf[0] & 0x1))
			sum += fib_buf[0];

		STATUS(i++, sum, fib_buf);
		ITR_FIB(fib_buf);
	} while (true);

	printf ("%d\n", sum);

	return 0;
}


// vim: set ts=4 sw=4 noet syn=c:
