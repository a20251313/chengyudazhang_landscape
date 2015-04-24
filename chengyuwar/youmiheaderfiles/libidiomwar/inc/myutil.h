#ifndef __UTIL_INC_MY_UTIL_H__
#define __UTIL_INC_MY_UTIL_H__

#include <cstdint>

namespace MyUtil
{
    // Very handy to generate one random val.
    // Not good to generate lots of random val. That will be very slow.
    uint32_t myrandom(uint32_t max_val);
    uint32_t myrandom32();
}

#endif /* __UTIL_INC_MY_UTIL_H__ */

