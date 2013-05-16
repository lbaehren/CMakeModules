
#-------------------------------------------------------------------------------
# Copyright (c) 2013-2013, Lars Baehren <lbaehren@gmail.com>
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
#-------------------------------------------------------------------------------

# - Check for the presence of CODA
#
# The following variables are set when CODA is found:
#  CODA_FOUND      = Set to true, if all components of CODA have been found.
#  CODA_INCLUDES   = Include path for the header files of CODA
#  CODA_LIBRARIES  = Link these to use CODA
#  CODA_LFLAGS     = Linker flags (optional)

if (NOT CODA_FOUND)

  if (NOT CODA_ROOT_DIR)
    set (CODA_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT CODA_ROOT_DIR)

  ##____________________________________________________________________________
  ## Check for the header files

  find_path (CODA_INCLUDES
    NAMES coda.h
    HINTS ${CODA_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##____________________________________________________________________________
  ## Check for the library

  find_library (CODA_LIBRARIES coda
    HINTS ${CODA_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##____________________________________________________________________________
  ## Determine library version

  if (CODA_INCLUDES AND CODA_LIBRARIES)

    find_file (HAVE_TESTCODA_CC TestCODALibraryVersion.cc
        HINTS ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_MODULE_PATH}
    )

    try_run (run_TestCODA compile_TestCODA
             ${PROJECT_BINARY_DIR}/TestCODA
             ${HAVE_TESTCODA_CC}
             CMAKE_FLAGS -DINCLUDE_DIRECTORIES=${CODA_INCLUDES} -DLINK_LIBRARIES=${CODA_LIBRARIES}
             RUN_OUTPUT_VARIABLE CODA_VERSION
             )

  endif (CODA_INCLUDES AND CODA_LIBRARIES)

  ##____________________________________________________________________________
  ## Check for the executables

  foreach (_codaExecutable
      codacheck
      codacmp
      codadump
      codaeval
      codafind
      codadd
    )

    string (TOUPPER ${_codaExecutable} _var)

    find_program (${_var}_EXECUTABLE ${_codaExecutable}
        HINTS ${CODA_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
        PATH_SUFFIXES bin
    )

  endforeach (_codaExecutable)

  ##____________________________________________________________________________
  ## Update CODA_ROOT

  if (CODA_INCLUDES)
    find_file (_codaHeader coda.h ${CODA_INCLUDES})
    get_filename_component (_codaHeaderFilename ${_codaHeader} NAME)
    string (REGEX REPLACE "/include/${_codaHeaderFilename}" "" CODA_ROOT_DIR ${_codaHeader})
  endif ()

  ##____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (CODA DEFAULT_MSG CODA_LIBRARIES CODA_INCLUDES)

  if (CODA_FOUND)
    if (NOT CODA_FIND_QUIETLY)
      message (STATUS "Found components for CODA")
      message (STATUS "CODA_ROOT_DIR        = ${CODA_ROOT_DIR}")
      message (STATUS "CODA_INCLUDES        = ${CODA_INCLUDES}")
      message (STATUS "CODA_LIBRARIES       = ${CODA_LIBRARIES}")
      message (STATUS "CODA_VERSION         = ${CODA_VERSION}"  )
      message (STATUS "CODACHECK_EXECUTABLE = ${CODACHECK_EXECUTABLE}")
      message (STATUS "CODACMP_EXECUTABLE   = ${CODACMP_EXECUTABLE}")
      message (STATUS "CODADUMP_EXECUTABLE  = ${CODADUMP_EXECUTABLE}")
    endif (NOT CODA_FIND_QUIETLY)
  else (CODA_FOUND)
    if (CODA_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find CODA!")
    endif (CODA_FIND_REQUIRED)
  endif (CODA_FOUND)

  ##____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    CODA_ROOT_DIR
    CODA_INCLUDES
    CODA_LIBRARIES
    )

endif (NOT CODA_FOUND)
