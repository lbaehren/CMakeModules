
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

# - Check for the presence of Python
#
# The following variables are set when PYTHON is found:
#  PYTHON_FOUND      = Set to true, if all components of PYTHON have been found.
#  PYTHON_INCLUDES   = Include path for the header files of PYTHON
#  PYTHON_LIBRARIES  = Link these to use PYTHON
#  PYTHON_LFLAGS     = Linker flags (optional)

if (NOT PYTHON_FOUND)

  if (NOT PYTHON_ROOT_DIR)
    set (PYTHON_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT PYTHON_ROOT_DIR)

  ##____________________________________________________________________________
  ## Wrapper around the standard CMake modules.
  ## Always try to locate the Python interpreter first.

  find_package (PythonInterp)

  ##____________________________________________________________________________
  ## Extract version number

  if (NOT PYTHON_VERSION_STRING)
    if (PYTHON_EXECUTABLE)
      ## Capture the output of 'python --version' into PYTHON_VERSION_STRING
      execute_process (
        COMMAND ${PYTHON_EXECUTABLE} --version
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        RESULT_VARIABLE PYTHON_VERSION_RESULT
        OUTPUT_VARIABLE PYTHON_VERSION_OUTPUT
        ERROR_VARIABLE PYTHON_VERSION_STRING
        OUTPUT_STRIP_TRAILING_WHITESPACE
        ERROR_STRIP_TRAILING_WHITESPACE
      )
    endif (PYTHON_EXECUTABLE)
  endif (NOT PYTHON_VERSION_STRING)

  ## Process output from version query
  if (PYTHON_VERSION_STRING)
    string (REGEX REPLACE "Python " "" PYTHON_VERSION ${PYTHON_VERSION_STRING})
    string (REGEX REPLACE "\\." ";" PYTHON_VERSION ${PYTHON_VERSION})
    ## Extract major, minor and patch version
    list (GET PYTHON_VERSION 0 PYTHON_VERSION_MAJOR)
    list (GET PYTHON_VERSION 1 PYTHON_VERSION_MINOR)
    list (GET PYTHON_VERSION 2 PYTHON_VERSION_PATCH)
    ## Assemble version number(s)
    ## - Release series in 'major.minor' format
    ## - Full version string in 'major.minor.patch' format
    set (PYTHON_VERSION_SERIES "${PYTHON_VERSION_MAJOR}.${PYTHON_VERSION_MINOR}")
    set (PYTHON_VERSION "${PYTHON_VERSION_SERIES}.${PYTHON_VERSION_PATCH}")
  endif (PYTHON_VERSION_STRING)

  ##____________________________________________________________________________
  ## Installation prefix

  if (PYTHON_EXECUTABLE)
      execute_process(
      COMMAND ${PYTHON_EXECUTABLE} -c import\ distutils.sysconfig\;\ print\ distutils.sysconfig.get_config_vars\(\)['prefix']
      RESULT_VARIABLE PYTHON_PREFIX_ERROR
      OUTPUT_VARIABLE PYTHON_PREFIX
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  endif (PYTHON_EXECUTABLE)

  ##____________________________________________________________________________
  ## Check for the header files.
  ##  If possible get the information directly from the Python interpreter -
  ##  if this does not work either try using the result from the CMake standard
  ##  module. If all else fails, try looking for the header files directly.

  if (PYTHON_EXECUTABLE)
    execute_process(
      COMMAND ${PYTHON_EXECUTABLE} -c import\ distutils.sysconfig\;\ print\ distutils.sysconfig.get_python_inc\(\)
      RESULT_VARIABLE PYTHON_INC_ERROR
      OUTPUT_VARIABLE PYTHON_INCLUDES
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  else (PYTHON_EXECUTABLE)
    if (PYTHON_INCLUDE_DIRS)
      set (PYTHON_INCLUDES ${PYTHON_INCLUDE_DIRS})
    else (PYTHON_INCLUDE_DIRS)
      find_path (PYTHON_INCLUDES
        NAMES Python.h
        HINTS ${PYTHON_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
        PATH_SUFFIXES include
        )
    endif (PYTHON_INCLUDE_DIRS)
  endif (PYTHON_EXECUTABLE)

  ##____________________________________________________________________________
  ## Check for the library.
  ##  If possible get the information directly from the Python interpreter.

  if (NOT PYTHON_LIBRARIES)
    find_library (PYTHON_LIBRARIES
      NAMES python${PYTHON_VERSION_SERIES} python
      PATHS ${PYTHON_PREFIX} ${PYTHON_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES lib
	  NO_DEFAULT_PATH
      )
  endif (NOT PYTHON_LIBRARIES)

  ##____________________________________________________________________________
  ## Python platform identifier

  if (PYTHON_EXECUTABLE)
    execute_process(
      COMMAND ${PYTHON_EXECUTABLE} -c import\ sysconfig\;\ print\ sysconfig.get_platform\(\)
      RESULT_VARIABLE PYTHON_PLATFORM_ERROR
      OUTPUT_VARIABLE PYTHON_PLATFORM
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  endif (PYTHON_EXECUTABLE)

  ##____________________________________________________________________________
  ## Location of the site packages

  if (PYTHON_EXECUTABLE)
    execute_process(
      COMMAND ${PYTHON_EXECUTABLE} -c import\ distutils.sysconfig\;\ print\ distutils.sysconfig.get_python_lib\(\)
      RESULT_VARIABLE PYTHON_SITE_PACKAGES_ERROR
      OUTPUT_VARIABLE PYTHON_SITE_PACKAGES
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  endif (PYTHON_EXECUTABLE)

  ##____________________________________________________________________________
  ## Python path

  if (PYTHON_PYTHONPATH)
      set (PYTHON_PYTHONPATH "${PYTHON_PYTHONPATH}:$ENV{PYTHONPATH}")
  else (PYTHON_PYTHONPATH)
      set (PYTHON_PYTHONPATH "$ENV{PYTHONPATH}")
  endif (PYTHON_PYTHONPATH)

  string(REGEX REPLACE "::" ":" PYTHON_PYTHONPATH ${PYTHON_PYTHONPATH})

  ##____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (PYTHON DEFAULT_MSG
    PYTHON_EXECUTABLE
    PYTHON_LIBRARIES
    PYTHON_INCLUDES
    )

  if (PYTHON_FOUND)
    ## Update PYTHON_ROOT DIR
    get_filename_component (PYTHON_EXECUTABLE_FILENAME ${PYTHON_EXECUTABLE} NAME)
    string (REGEX REPLACE "/bin/${PYTHON_EXECUTABLE_FILENAME}" "" PYTHON_ROOT_DIR ${PYTHON_EXECUTABLE})
    ## Feedback
    if (NOT PYTHON_FIND_QUIETLY)
      message (STATUS "Found components for Python:")
      message (STATUS "PYTHON_ROOT_DIR       = ${PYTHON_ROOT_DIR}"       )
      message (STATUS "PYTHON_EXECUTABLE     = ${PYTHON_EXECUTABLE}"     )
      message (STATUS "PYTHON_VERSION_SERIES = ${PYTHON_VERSION_SERIES}" )
      message (STATUS "PYTHON_VERSION        = ${PYTHON_VERSION}"        )
      message (STATUS "PYTHON_INCLUDES       = ${PYTHON_INCLUDES}"       )
      message (STATUS "PYTHON_LIBRARIES      = ${PYTHON_LIBRARIES}"      )
      message (STATUS "PYTHON_SITE_PACKAGES  = ${PYTHON_SITE_PACKAGES}"  )
      message (STATUS "PYTHON_PYTHONPATH     = ${PYTHON_PYTHONPATH}"     )
    endif (NOT PYTHON_FIND_QUIETLY)
  else (PYTHON_FOUND)
    if (PYTHON_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find PYTHON!")
    endif (PYTHON_FIND_REQUIRED)
  endif (PYTHON_FOUND)

  ##____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    PYTHON_ROOT_DIR
    PYTHON_INCLUDES
    PYTHON_LIBRARIES
    PYTHON_VERSION_SERIES
    PYTHON_SITE_PACKAGES
    )

endif (NOT PYTHON_FOUND)
