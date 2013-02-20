
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

# - Check for the presence of WCSLIB
#
# The following variables are set when WCSLIB is found:
#  WCSLIB_FOUND      = Set to true, if all components of WCSLIB have been found.
#  WCSLIB_INCLUDES   = Include path for the header files of WCSLIB
#  WCSLIB_LIBRARIES  = Link these to use WCSLIB
#  WCSLIB_LFLAGS     = Linker flags (optional)

if (NOT WCSLIB_FOUND)

  if (NOT WCSLIB_ROOT_DIR)
    set (WCSLIB_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT WCSLIB_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (WCSLIB_INCLUDES wcs.h
    HINTS ${WCSLIB_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/wcs include/wcslib include/wcslib-4.4.4
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (WCSLIB_LIBRARIES wcs
    HINTS ${WCSLIB_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (WCSLIB DEFAULT_MSG WCSLIB_LIBRARIES WCSLIB_INCLUDES)

  if (WCSLIB_FOUND)
    if (NOT WCSLIB_FIND_QUIETLY)
      message (STATUS "Found components for WCSLIB")
      message (STATUS "WCSLIB_ROOT_DIR  = ${WCSLIB_ROOT_DIR}")
      message (STATUS "WCSLIB_INCLUDES  = ${WCSLIB_INCLUDES}")
      message (STATUS "WCSLIB_LIBRARIES = ${WCSLIB_LIBRARIES}")
    endif (NOT WCSLIB_FIND_QUIETLY)
  else (WCSLIB_FOUND)
    if (WCSLIB_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find WCSLIB!")
    endif (WCSLIB_FIND_REQUIRED)
  endif (WCSLIB_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    WCSLIB_ROOT_DIR
    WCSLIB_INCLUDES
    WCSLIB_LIBRARIES
    )

endif (NOT WCSLIB_FOUND)
