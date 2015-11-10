#include <stdint.h>

#define LCM_EUCLID(a, b) ({ \
	uint64_t _a = a, _b = b; \
	_a * (_b / euclid(_a, _b)); \
})

uint64_t euclid (const uint64_t a, const uint64_t b);

// vim: set ts=4 sw=4 noet syn=c:
