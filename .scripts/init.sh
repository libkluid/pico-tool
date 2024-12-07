#!/usr/bin/env zsh

if [ -z $1 ]; then
    echo "Usage: mise run init <project_name>"
    exit 1
fi

mkdir $1
cat <<- EOF > $1/CMakeLists.txt
cmake_minimum_required(VERSION 3.10)

# initialize the SDK based on PICO_SDK_PATH
# note: this must happen before project()
include(\$ENV{PICO_SDK_PATH}/external/pico_sdk_import.cmake)

set(PROJECT_NAME $1)

project(\${PROJECT_NAME})

# initialize the Raspberry Pi Pico SDK
pico_sdk_init()

# rest of your project
add_executable(\${PROJECT_NAME}
    main.cpp
)

# Add pico_stdlib library which aggregates commonly used features
target_link_libraries(\${PROJECT_NAME} pico_stdlib)

#enable usb output, disable uart output
pico_enable_stdio_usb(\${PROJECT_NAME} 1)
pico_enable_stdio_uart(\${PROJECT_NAME} 0)

# create map/bin/hex file etc.
pico_add_extra_outputs(\${PROJECT_NAME})
EOF

cat <<- EOF > $1/main.cpp
#include <stdio.h>
#include <stdlib.h>
#include "pico/stdlib.h"

#ifdef __cplusplus
extern "C" {
#endif

int main() {
    stdio_init_all();
    printf("Hello, world!\n");
    return EXIT_SUCCESS;
}

#ifdef __cplusplus
}
#endif
EOF
