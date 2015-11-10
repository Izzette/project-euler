#include <stdio.h>

int main () {
	int sum = 0;
	int i;
	for (i = 3; 1000 > i; i += 3) {
		sum += i;
	}

	for (i = 5; 1000 > i; i += 5) {
		if (0 == i % 3)
			continue;
		sum += i;
	}
	printf ("%d\n", sum);
	return 0;
}

// vim: set ts=4 sw=4 noet syn=c:
