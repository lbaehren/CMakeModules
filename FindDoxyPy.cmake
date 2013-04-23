
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

# - Check for the presence of DOXYPY
#
# The following variables are set when DOXYPY is found:
#  DOXYPY_FOUND      = Set to true, if all components of DoxyPy have been found.
#  DOXYPY_EXECUTABLE = DoxyPy executable, a Python script.

if (NOT DOXYPY_FOUND)

  if (NOT DOXYPY_ROOT_DIR)
    set (DOXYPY_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT DOXYPY_ROOT_DIR)

  ##____________________________________________________________________________
  ## Check for the executable

  find_program (DOXYPY_EXECUTABLE doxypy.py
    HINTS ${DOXYPY_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (DOXYPY DEFAULT_MSG DOXYPY_EXECUTABLE)

  if (DOXYPY_FOUND)
    if (NOT DOXYPY_FIND_QUIETLY)
      message (STATUS "Found components for DOXYPY")
      message (STATUS "DOXYPY_ROOT_DIR   = ${DOXYPY_ROOT_DIR}")
      message (STATUS "DOXYPY_EXECUTABLE = ${DOXYPY_EXECUTABLE}")
    endif (NOT DOXYPY_FIND_QUIETLY)
  else (DOXYPY_FOUND)
    if (DOXYPY_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find DoxyPy!")
    endif (DOXYPY_FIND_REQUIRED)
  endif (DOXYPY_FOUND)

  ##____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    DOXYPY_ROOT_DIR
    DOXYPY_EXECUTABLE
    )

endif (NOT DOXYPY_FOUND)
