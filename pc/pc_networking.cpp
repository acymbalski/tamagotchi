#include "networking.h"
#include <time.h>

void initWifi() {
    /* no-op on PC */
}

tm getTime() {
    time_t now = time(nullptr);
    tm result = {};
#ifdef _WIN32
    localtime_s(&result, &now);
#else
    localtime_r(&now, &result);
#endif
    return result;
}
