
#--------------------------------------------------------------------------------
# Copyright (c) 2012-2013, Lars Baehren <lbaehren@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#--------------------------------------------------------------------------------

## ==============================================================================
##
##  CMake project settings
##
## ==============================================================================

## Name of the project handled by CMake
project (CMakeModules)

## Minimum required version of CMake to configure the project
cmake_minimum_required (VERSION 2.8.2)

## Enforced CMake policy
cmake_policy (VERSION 2.8.2)

## ==============================================================================
##
##  Configuration options
##
## ==============================================================================

# MODULE_SELECTION - Command line option to select a single module.

## ==============================================================================
##
##  CMake modules
##
## ==============================================================================

## Standard modules

include (FindPackageHandleStandardArgs)
include (CTest)

enable_testing()

## Custom modules

set (CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}" CACHE PATH
  "CMake module path"
  FORCE
  )

include (DetectOS)

## ==============================================================================
##
##  Test instructions for modules
##
## ==============================================================================

file (GLOB cmake_find_modules Find*.cmake)

if (MODULE_SELECTION)
  set (cmake_find_modules ${MODULE_SELECTION})
endif ()

foreach (cmake_find_module ${cmake_find_modules})

  get_filename_component (_filename ${cmake_find_module} NAME)
  get_filename_component (_modulename ${cmake_find_module} NAME_WE)

  string (REGEX REPLACE "Find" "" _modulename ${_modulename})

  ## Display filename
  message (STATUS "CMake find module ${_modulename}")

  ## Load module
  find_package (${_modulename})

endforeach ()

## ==============================================================================
##
##  Test builds
##
## ==============================================================================

add_subdirectory (tests)

## ==============================================================================
##
##  Configuration summary
##
## ==============================================================================

message (STATUS "------------------------------------------------------------"  )
message (STATUS "[prometheus-sumo] Configuration summary."                      )
message (STATUS "------------------------------------------------------------ " )

message (STATUS " System configuration:"                                       )
message (STATUS " .. Processor type ............ = ${CMAKE_SYSTEM_PROCESSOR}"  )
message (STATUS " .. CMake executable .......... = ${CMAKE_COMMAND}"           )
message (STATUS " .. CMake version ............. = ${CMAKE_VERSION}"           )
message (STATUS " .. System/OS name ............ = ${CMAKE_SYSTEM_NAME} / ${CMAKE_OS_NAME}")
message (STATUS " .. System version ............ = ${CMAKE_SYSTEM_VERSION}"    )
message (STATUS " .. C++ compiler .............. = ${CMAKE_CXX_COMPILER}"      )
message (STATUS " .. C compiler ................ = ${CMAKE_C_COMPILER}"        )
message (STATUS " .. size(void*) ............... = ${CMAKE_SIZEOF_VOID_P}"     )

message (STATUS " Package listing:")
message (STATUS " .. Autotools ................. = ${AUTOTOOLS_FOUND}"         )
message (STATUS " .. Blitz++ ................... = ${BLITZ_FOUND}"             )
message (STATUS " .. CFITSIO ................... = ${CFITSIO_FOUND}"           )
message (STATUS " .. FFTW3 ..................... = ${FFTW3_FOUND}"             )
message (STATUS " .. LLVM ...................... = ${LLVM_FOUND}"              )
message (STATUS " .. PIL ....................... = ${PIL_FOUND}"               )
message (STATUS " .. POPT ...................... = ${POPT_FOUND}"              )
message (STATUS " .. Rails ..................... = ${RAILS_FOUND}"             )
message (STATUS " .. Rake ...................... = ${RAKE_FOUND}"              )
message (STATUS " .. Ruby ...................... = ${RUBY_FOUND}"              )
message (STATUS " .. WCSLIB .................... = ${WCSLIB_FOUND}"            )
message (STATUS " .. Webgen .................... = ${WEBGEN_FOUND}"            )
message (STATUS " .. Yasm ...................... = ${YASM_FOUND}"              )
message (STATUS " .. YAZ ....................... = ${YAZ_FOUND}"               )
message (STATUS " .. YAZ++ ..................... = ${YAZPP_FOUND}"             )

message (STATUS "------------------------------------------------------------" )
