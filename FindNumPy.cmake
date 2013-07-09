
#-------------------------------------------------------------------------------
# Copyright (c) 2013, Lars Baehren <lbaehren@gmail.com>
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

# - Check for the presence of NumPy
#
# The following variables are set when NumPy is found:
#  NUMPY_FOUND      = Set to true, if all components of NUMPY have been found.
#  NUMPY_INCLUDES   = Include path for the header files of NUMPY
#  NUMPY_LIBRARIES  = Link these to use NUMPY
#  NUMPY_LFLAGS     = Linker flags (optional)

if (NOT NUMPY_FOUND)

    if (NOT NUMPY_ROOT_DIR)
        set (NUMPY_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
    endif (NOT NUMPY_ROOT_DIR)

    if (NOT PYTHON_FOUND)
        find_package (Python)
    endif (NOT PYTHON_FOUND)

  ##____________________________________________________________________________
  ## Check for the header files

    ## Use Python to determine the include directory
    execute_process (
        COMMAND ${PYTHON_EXECUTABLE} -c import\ numpy\;\ print\ numpy.get_include\(\)\;
        ERROR_VARIABLE NUMPY_FIND_ERROR
        RESULT_VARIABLE NUMPY_FIND_RESULT
        OUTPUT_VARIABLE NUMPY_FIND_OUTPUT
        OUTPUT_STRIP_TRAILING_WHITESPACE
        )
    ## process the output from the execution of the command
    if (NOT NUMPY_FIND_RESULT)
        set (NUMPY_INCLUDES ${NUMPY_FIND_OUTPUT})
    endif (NOT NUMPY_FIND_RESULT)

  ##____________________________________________________________________________
  ## Check for the library

  find_library (NUMPY_LIBRARIES numpy
    HINTS ${NUMPY_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (NUMPY DEFAULT_MSG NUMPY_INCLUDES)

  if (NUMPY_FOUND)
    if (NOT NUMPY_FIND_QUIETLY)
      message (STATUS "Found components for NumPy")
      message (STATUS "PYTHON_EXECUTABLE = ${PYTHON_EXECUTABLE}")
      message (STATUS "NUMPY_ROOT_DIR    = ${NUMPY_ROOT_DIR}")
      message (STATUS "NUMPY_INCLUDES    = ${NUMPY_INCLUDES}")
      message (STATUS "NUMPY_LIBRARIES   = ${NUMPY_LIBRARIES}")
    endif (NOT NUMPY_FIND_QUIETLY)
  else (NUMPY_FOUND)
    if (NUMPY_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find NUMPY!")
    endif (NUMPY_FIND_REQUIRED)
  endif (NUMPY_FOUND)

  ##____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    NUMPY_ROOT_DIR
    NUMPY_INCLUDES
    NUMPY_LIBRARIES
    )

endif (NOT NUMPY_FOUND)
