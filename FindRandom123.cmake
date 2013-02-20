
#--------------------------------------------------------------------------------
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
#--------------------------------------------------------------------------------

# - Check for the presence of RANDOM123
#
# The following variables are set when RANDOM123 is found:
#  RANDOM123_FOUND      = Set to true, if all components of RANDOM123 have been found.
#  RANDOM123_INCLUDES   = Include path for the header files of RANDOM123

if (NOT RANDOM123_FOUND)

  if (NOT RANDOM123_ROOT_DIR)
    set (RANDOM123_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RANDOM123_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (RANDOM123_INCLUDES
    NAMES Random123/threefry.h Random123/u01.h
    HINTS ${RANDOM123_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  ## Package is include files only.

  ##_____________________________________________________________________________
  ## Check for the executable

  ## Only executables are test programs.

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (RANDOM123 DEFAULT_MSG RANDOM123_INCLUDES)

  if (RANDOM123_FOUND)
    if (NOT RANDOM123_FIND_QUIETLY)
      message (STATUS "Found components for RANDOM123")
      message (STATUS "RANDOM123_ROOT_DIR  = ${RANDOM123_ROOT_DIR}")
      message (STATUS "RANDOM123_INCLUDES  = ${RANDOM123_INCLUDES}")
    endif (NOT RANDOM123_FIND_QUIETLY)
  else (RANDOM123_FOUND)
    if (RANDOM123_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find RANDOM123!")
    endif (RANDOM123_FIND_REQUIRED)
  endif (RANDOM123_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    RANDOM123_ROOT_DIR
    RANDOM123_INCLUDES
    )

endif (NOT RANDOM123_FOUND)
