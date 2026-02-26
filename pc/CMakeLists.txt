cmake_minimum_required(VERSION 3.16)
project(tamagotchi_pc CXX C)

# C++20: MSVC needs it for designated struct initializers.
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_C_STANDARD 11)

# ---- SDL2 discovery ----
# If SDL2_ROOT is explicitly set, use it directly — skip find_package entirely.
# SDL2 VC zip layout:  include/SDL.h   lib/x64/SDL2.lib   lib/x64/SDL2.dll
# SDL2 MinGW layout:   include/SDL2/SDL.h  lib/libSDL2.a
if(DEFINED SDL2_ROOT)
    message(STATUS "SDL2_ROOT specified: ${SDL2_ROOT}")
    if(MSVC)
        set(SDL2_INCLUDE_DIRS "${SDL2_ROOT}/include")
        if(CMAKE_SIZEOF_VOID_P EQUAL 8)
            set(SDL2_LIBRARIES
                "${SDL2_ROOT}/lib/x64/SDL2.lib"
                "${SDL2_ROOT}/lib/x64/SDL2main.lib")
            set(SDL2_DLL "${SDL2_ROOT}/lib/x64/SDL2.dll")
        else()
            set(SDL2_LIBRARIES
                "${SDL2_ROOT}/lib/x86/SDL2.lib"
                "${SDL2_ROOT}/lib/x86/SDL2main.lib")
            set(SDL2_DLL "${SDL2_ROOT}/lib/x86/SDL2.dll")
        endif()
    else()
        # MinGW: headers are in include/SDL2/
        set(SDL2_INCLUDE_DIRS "${SDL2_ROOT}/include/SDL2")
        set(SDL2_LIBRARIES
            "${SDL2_ROOT}/lib/libSDL2.a"
            "${SDL2_ROOT}/lib/libSDL2main.a")
    endif()
else()
    # No SDL2_ROOT given — try CMake package search
    find_package(SDL2 CONFIG QUIET)
    if(NOT SDL2_FOUND)
        find_package(SDL2 QUIET)
    endif()
    if(NOT SDL2_FOUND)
        message(FATAL_ERROR
            "SDL2 not found.\n"
            "Download the SDL2 VC dev package and pass -DSDL2_ROOT=C:/path/to/SDL2-x.y.z\n"
            "  e.g. cmake .. -G Ninja -DSDL2_ROOT=C:/SDL2/SDL2-2.32.10")
    endif()
endif()

message(STATUS "SDL2_INCLUDE_DIRS: ${SDL2_INCLUDE_DIRS}")
message(STATUS "SDL2_LIBRARIES:    ${SDL2_LIBRARIES}")

# CMAKE_SOURCE_DIR = <repo>/pc  (CMakeLists.txt lives there)
set(SOURCES
    ${CMAKE_SOURCE_DIR}/main.cpp
    ${CMAKE_SOURCE_DIR}/pc_input.cpp
    ${CMAKE_SOURCE_DIR}/pc_savestate.cpp
    ${CMAKE_SOURCE_DIR}/pc_networking.cpp
    ${CMAKE_SOURCE_DIR}/../src/cpu.c
    ${CMAKE_SOURCE_DIR}/../src/hw.c
    ${CMAKE_SOURCE_DIR}/../src/tamalib.c
    ${CMAKE_SOURCE_DIR}/../src/memory.cpp
    ${CMAKE_SOURCE_DIR}/../src/babysitter.cpp
)
# src/main.cpp, src/input.cpp, src/networking.cpp, src/savestate.cpp excluded.

add_executable(tamagotchi_pc ${SOURCES})

target_include_directories(tamagotchi_pc PRIVATE
    ${CMAKE_SOURCE_DIR}        # FIRST: stub headers shadow src/ ones
    ${CMAKE_SOURCE_DIR}/../src # core headers
    ${SDL2_INCLUDE_DIRS}
)

# Force-include Arduino compat header. MSVC uses /FI; GCC/Clang use -include.
if(MSVC)
    target_compile_options(tamagotchi_pc PRIVATE
        "/FI${CMAKE_SOURCE_DIR}/arduino_compat.h"
        /wd4996   # suppress 'localtime' deprecation
        /wd4200   # suppress zero-length array extension warning
    )
else()
    target_compile_options(tamagotchi_pc PRIVATE
        -include ${CMAKE_SOURCE_DIR}/arduino_compat.h
    )
endif()

target_compile_definitions(tamagotchi_pc PRIVATE
    TAMA_DISPLAY_FRAMERATE=3
    NOMINMAX
    _CRT_SECURE_NO_WARNINGS
)

target_link_libraries(tamagotchi_pc PRIVATE ${SDL2_LIBRARIES})

# Copy SDL2.dll next to the exe after build
if(DEFINED SDL2_DLL AND EXISTS "${SDL2_DLL}")
    add_custom_command(TARGET tamagotchi_pc POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E copy_if_different
            "${SDL2_DLL}" $<TARGET_FILE_DIR:tamagotchi_pc>
        COMMENT "Copying SDL2.dll")
endif()
