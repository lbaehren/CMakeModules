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

## Macro to handle standard arguments

include (FindPackageHandleStandardArgs)

## Test driver

include (CTest)
enable_testing()

## Add local directory to module path

set (CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}" CACHE PATH
  "CMake module path"
  FORCE
  )

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
##  Configuration summary
##
## ==============================================================================

message (STATUS "------------------------------------------------------------"   )
message (STATUS "[prometheus-sumo] Configuration summary."                       )
message (STATUS "------------------------------------------------------------ "  )

message (STATUS " System configuration:"                                         )
message (STATUS " .. Processor type .............. = ${CMAKE_SYSTEM_PROCESSOR}"  )
message (STATUS " .. CMake executable ............ = ${CMAKE_COMMAND}"           )
message (STATUS " .. CMake version ............... = ${CMAKE_VERSION}"           )
message (STATUS " .. System name ................. = ${CMAKE_SYSTEM}"            )
message (STATUS " .. Operating system name ....... = ${CMAKE_OS_NAME}"           )
message (STATUS " .. C++ compiler ................ = ${CMAKE_CXX_COMPILER}"      )
message (STATUS " .. C compiler .................. = ${CMAKE_C_COMPILER}"        )
message (STATUS " .. size(void*) ................. = ${CMAKE_SIZEOF_VOID_P}"     )

message (STATUS "------------------------------------------------------------"   )
