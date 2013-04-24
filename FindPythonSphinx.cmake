
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

# - Check for the presence of PYTHON_SPHINX
#
# The following variables are set when PYTHON_SPHINX is found:
#  PYTHON_SPHINX_FOUND      = Set to true, if all components of PYTHON_SPHINX have been found.
#  PYTHON_SPHINX_INCLUDES   = Include path for the header files of PYTHON_SPHINX
#  PYTHON_SPHINX_LIBRARIES  = Link these to use PYTHON_SPHINX
#  PYTHON_SPHINX_LFLAGS     = Linker flags (optional)

if (NOT PYTHON_SPHINX_FOUND)

  if (NOT PYTHON_SPHINX_ROOT_DIR)
    set (PYTHON_SPHINX_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT PYTHON_SPHINX_ROOT_DIR)

  ##____________________________________________________________________________
  ## Check for the executable

  find_program (PYTHON_SPHINX_EXECUTABLE sphinx-build
    HINTS ${PYTHON_SPHINX_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (PYTHON_SPHINX DEFAULT_MSG PYTHON_SPHINX_EXECUTABLE)

  if (PYTHON_SPHINX_FOUND)
    if (NOT PYTHON_SPHINX_FIND_QUIETLY)
      message (STATUS "Found components for PYTHON_SPHINX")
      message (STATUS "PYTHON_SPHINX_ROOT_DIR   = ${PYTHON_SPHINX_ROOT_DIR}")
      message (STATUS "PYTHON_SPHINX_EXECUTABLE = ${PYTHON_SPHINX_EXECUTABLE}")
    endif (NOT PYTHON_SPHINX_FIND_QUIETLY)
  else (PYTHON_SPHINX_FOUND)
    if (PYTHON_SPHINX_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find PYTHON_SPHINX!")
    endif (PYTHON_SPHINX_FIND_REQUIRED)
  endif (PYTHON_SPHINX_FOUND)

  ##____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    PYTHON_SPHINX_ROOT_DIR
    PYTHON_SPHINX_EXECUTABLE
    )

endif (NOT PYTHON_SPHINX_FOUND)
