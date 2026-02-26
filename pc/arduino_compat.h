#pragma once
/*
 * arduino_compat.h - Force-included into every translation unit to shim Arduino APIs
 * for the PC simulator build.
 */

#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <stdlib.h>

/* ---- Windows platform headers ---- */
#ifdef _WIN32
#ifndef NOMINMAX
#define NOMINMAX  /* prevent windows.h from defining min/max macros */
#endif
#include <windows.h>
#endif

/* ---- PROGMEM / pgmspace shims ---- */
#define PROGMEM
#define PSTR(s) (s)
#define F(s) (s)
#define pgm_read_byte_near(addr) (*(const uint8_t *)(addr))
#define pgm_read_word_near(addr) (*(const uint16_t *)(addr))
/* On PC, data is in normal RAM — read a full native pointer width */
#define pgm_read_ptr_near(addr)  (*(void * const *)(addr))
#define pgm_read_byte(addr)      (*(const uint8_t *)(addr))
#define pgm_read_word(addr)      (*(const uint16_t *)(addr))

/* ---- Time / delay shims ---- */
static inline uint64_t millis(void) {
#ifdef _WIN32
    return (uint64_t)GetTickCount64();
#else
    return 0;
#endif
}

static inline void delay(unsigned long ms) {
#ifdef _WIN32
    Sleep(ms);
#endif
}

static inline void delayMicroseconds(unsigned long us) {
#ifdef _WIN32
    Sleep(us / 1000 > 0 ? (DWORD)(us / 1000) : 1);
#endif
}

/* ---- Arduino constants ---- */
#ifndef HEX
#define HEX 16
#endif
#ifndef DEC
#define DEC 10
#endif
#ifndef INPUT
#define INPUT 0
#endif
#ifndef OUTPUT
#define OUTPUT 1
#endif
#ifndef LOW
#define LOW 0
#endif
#ifndef HIGH
#define HIGH 1
#endif

/* ---- Serial stub ---- */
#ifdef __cplusplus

#include <string>

struct SerialClass {
    void begin(unsigned long baud) { (void)baud; }

    void print(const char *s)    { fputs(s, stdout); fflush(stdout); }
    void print(const class String &s);   /* defined after String class below */
    void print(char c)           { fputc(c, stdout); fflush(stdout); }
    void print(int v, int base = DEC) {
        if (base == HEX) printf("%X", v);
        else             printf("%d", v);
        fflush(stdout);
    }
    void print(unsigned int v, int base = DEC) {
        if (base == HEX) printf("%X", v);
        else             printf("%u", v);
        fflush(stdout);
    }
    void print(long v, int base = DEC) {
        if (base == HEX) printf("%lX", v);
        else             printf("%ld", v);
        fflush(stdout);
    }
    void print(unsigned long v, int base = DEC) {
        if (base == HEX) printf("%lX", v);
        else             printf("%lu", v);
        fflush(stdout);
    }
    void print(float v)          { printf("%f", v); fflush(stdout); }
    void print(double v)         { printf("%f", v); fflush(stdout); }

    void println(const char *s)  { puts(s); fflush(stdout); }
    void println(char c)         { printf("%c\n", c); fflush(stdout); }
    void println()               { puts(""); fflush(stdout); }
    // String overload — must be declared before other numeric overloads to
    // avoid ambiguity when MSVC resolves println(String)
    void println(const class String &s);  /* defined after String class below */
    void println(int v, int base = DEC) {
        if (base == HEX) printf("%X\n", v);
        else             printf("%d\n", v);
        fflush(stdout);
    }
    void println(unsigned int v, int base = DEC) {
        if (base == HEX) printf("%X\n", v);
        else             printf("%u\n", v);
        fflush(stdout);
    }
    void println(long v, int base = DEC) {
        if (base == HEX) printf("%lX\n", v);
        else             printf("%ld\n", v);
        fflush(stdout);
    }
    void println(unsigned long v, int base = DEC) {
        if (base == HEX) printf("%lX\n", v);
        else             printf("%lu\n", v);
        fflush(stdout);
    }
    void println(float v)         { printf("%f\n", v); fflush(stdout); }
    void println(double v)        { printf("%f\n", v); fflush(stdout); }

    void printf(const char *fmt, ...) {
        va_list args;
        va_start(args, fmt);
        vprintf(fmt, args);
        va_end(args);
        fflush(stdout);
    }

    int available() { return 0; }
    int read()      { return -1; }

    std::string readStringUntil(char) { return ""; }
};

static SerialClass Serial;

/* ---- Arduino String class ---- */
class String {
public:
    std::string _s;

    String() {}
    String(const char *s) : _s(s ? s : "") {}
    String(int v, int base = DEC) {
        char buf[32];
        if (base == HEX) snprintf(buf, sizeof(buf), "%X", v);
        else             snprintf(buf, sizeof(buf), "%d", v);
        _s = buf;
    }
    String(unsigned int v, int base = DEC) {
        char buf[32];
        if (base == HEX) snprintf(buf, sizeof(buf), "%X", v);
        else             snprintf(buf, sizeof(buf), "%u", v);
        _s = buf;
    }
    String(long v, int base = DEC) {
        char buf[32];
        if (base == HEX) snprintf(buf, sizeof(buf), "%lX", v);
        else             snprintf(buf, sizeof(buf), "%ld", v);
        _s = buf;
    }
    String(unsigned long v, int base = DEC) {
        char buf[32];
        if (base == HEX) snprintf(buf, sizeof(buf), "%lX", v);
        else             snprintf(buf, sizeof(buf), "%lu", v);
        _s = buf;
    }
    String(float v)  { char buf[32]; snprintf(buf, sizeof(buf), "%f", v); _s = buf; }
    String(double v) { char buf[32]; snprintf(buf, sizeof(buf), "%f", v); _s = buf; }
    String(char c)   { _s = std::string(1, c); }
    String(const std::string &s) : _s(s) {}

    String operator+(const String &rhs) const { return String(_s + rhs._s); }
    String operator+(const char *rhs)   const { return String(_s + rhs); }
    String &operator+=(const String &rhs) { _s += rhs._s; return *this; }
    String &operator+=(const char *rhs)   { _s += rhs; return *this; }
    bool operator==(const String &rhs) const { return _s == rhs._s; }
    bool operator==(const char *rhs)    const { return _s == rhs; }
    char operator[](int idx)            const { return _s[idx]; }

    const char *c_str() const { return _s.c_str(); }
    int length()         const { return (int)_s.size(); }

    int toInt()     const { return atoi(_s.c_str()); }
    float toFloat() const { return (float)atof(_s.c_str()); }

    int indexOf(char c, int from = 0) const {
        auto p = _s.find(c, from);
        return (p == std::string::npos) ? -1 : (int)p;
    }
    int indexOf(const char *sub, int from = 0) const {
        auto p = _s.find(sub, from);
        return (p == std::string::npos) ? -1 : (int)p;
    }

    bool startsWith(const char *prefix) const {
        return _s.rfind(prefix, 0) == 0;
    }
    bool startsWith(const String &prefix) const {
        return _s.rfind(prefix._s, 0) == 0;
    }

    bool equalsIgnoreCase(const char *other) const {
        if (_s.size() != strlen(other)) return false;
        for (size_t i = 0; i < _s.size(); i++) {
            if (tolower((unsigned char)_s[i]) != tolower((unsigned char)other[i]))
                return false;
        }
        return true;
    }
    bool equalsIgnoreCase(const String &other) const {
        return equalsIgnoreCase(other._s.c_str());
    }

    String substring(int from, int to = -1) const {
        if (to < 0) return String(_s.substr(from));
        return String(_s.substr(from, to - from));
    }

    void trim() {
        size_t start = _s.find_first_not_of(" \t\r\n");
        if (start == std::string::npos) { _s = ""; return; }
        size_t end = _s.find_last_not_of(" \t\r\n");
        _s = _s.substr(start, end - start + 1);
    }
};

/* ---- Free operator+ so "literal" + String works ---- */
inline String operator+(const char *lhs, const String &rhs) {
    return String(std::string(lhs) + rhs._s);
}

/* ---- SerialClass members that depend on String (defined after String class) ---- */
inline void SerialClass::println(const String &s) {
    puts(s.c_str());
    fflush(stdout);
}
inline void SerialClass::print(const String &s) {
    fputs(s.c_str(), stdout);
    fflush(stdout);
}

/* ---- No-op pin functions ---- */
static inline void pinMode(int, int)            {}
static inline int  digitalRead(int)             { return LOW; }
static inline void digitalWrite(int, int)       {}
static inline void analogWrite(int, int)        {}

#endif /* __cplusplus */
