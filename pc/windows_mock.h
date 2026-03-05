#ifndef WINDOWS_MOCK_H
#define WINDOWS_MOCK_H

#include <stdint.h>

typedef void* HANDLE;
typedef uint32_t DWORD;
typedef union _LARGE_INTEGER {
    struct {
        uint32_t LowPart;
        int32_t HighPart;
    } u;
    int64_t QuadPart;
} LARGE_INTEGER;

#define STD_INPUT_HANDLE (HANDLE)-10
HANDLE GetStdHandle(DWORD n);
int PeekNamedPipe(HANDLE h, void* buf, DWORD n, DWORD* nread, DWORD* avail, DWORD* nleft);
uint32_t GetModuleFileNameA(void* h, char* buf, uint32_t n);
int GetFullPathNameA(const char* lpFileName, uint32_t nBufferLength, char* lpBuffer, char** lpFilePart);

#endif
