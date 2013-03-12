
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

# - Check for the presence of GSL
#
# The following variables are set when GSL is found:
#  GSL_FOUND      = Set to true, if all components of GSL have been found.
#  GSL_INCLUDES   = Include path for the header files of GSL
#  GSL_LIBRARIES  = Link these to use GSL
#  GSL_LFLAGS     = Linker flags (optional)

if (NOT GSL_FOUND)

  if (NOT GSL_ROOT_DIR)
    set (GSL_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT GSL_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (GSL_INCLUDES
    NAMES  gsl_version.h gsl_sys.h gsl_nan.h
    HINTS ${GSL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/gsl
    )

  ##_____________________________________________________________________________
  ## Check for the library

  set (GSL_LIBRARIES "")

  find_library (GSL_GSL_LIBRARY gsl
    HINTS ${GSL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (GSL_GSL_LIBRARY)
    list (APPEND GSL_LIBRARIES ${GSL_GSL_LIBRARY})
  endif (GSL_GSL_LIBRARY)

  find_library (GSL_GSLCBLAS_LIBRARY gslcblas
    HINTS ${GSL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (GSL_GSLCBLAS_LIBRARY)
    list (APPEND GSL_LIBRARIES ${GSL_GSLCBLAS_LIBRARY})
  endif (GSL_GSLCBLAS_LIBRARY)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (GSL_CONFIG_EXECUTABLE gsl-config
    HINTS ${GSL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin bin/gsl gsl/bin
    )

  ##_____________________________________________________________________________
  ## Deteemine version number

  if (GSL_CONFIG_EXECUTABLE)

    execute_process (
      COMMAND ${GSL_CONFIG_EXECUTABLE} --version
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE GSL_CONFIG_RESULT
      OUTPUT_VARIABLE GSL_VERSION
      ERROR_VARIABLE GSL_CONFIG_ERROR
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    string(REGEX REPLACE ".*([0-9]+).[0-9]+.[0-9]+.*" "\\1"
      GSL_VERSION_MAJOR ${GSL_VERSION})
    string(REGEX REPLACE ".*[0-9]+.([0-9]+).[0-9]+.*" "\\1"
      GSL_VERSION_MINOR ${GSL_VERSION})
    string(REGEX REPLACE ".*[0-9]+.[0-9]+.([0-9]+).*" "\\1"
      GSL_VERSION_PATCH ${GSL_VERSION})

  endif (GSL_CONFIG_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (GSL DEFAULT_MSG GSL_LIBRARIES GSL_INCLUDES)

  if (GSL_FOUND)
    if (NOT GSL_FIND_QUIETLY)
      message (STATUS "Found components for GSL")
      message (STATUS "GSL_ROOT_DIR  = ${GSL_ROOT_DIR}")
      message (STATUS "GSL_INCLUDES  = ${GSL_INCLUDES}")
      message (STATUS "GSL_LIBRARIES = ${GSL_LIBRARIES}")
      message (STATUS "GSL_VERSION   = ${GSL_VERSION}")
    endif (NOT GSL_FIND_QUIETLY)
  else (GSL_FOUND)
    if (GSL_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find GSL!")
    endif (GSL_FIND_REQUIRED)
  endif (GSL_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    GSL_ROOT_DIR
    GSL_INCLUDES
    GSL_LIBRARIES
    )

endif (NOT GSL_FOUND)
