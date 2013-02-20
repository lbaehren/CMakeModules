
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

# - Check for the presence of NEON
#
# The following variables are set when NEON is found:
#  NEON_FOUND      = Set to true, if all components of NEON have been found.
#  NEON_INCLUDES   = Include path for the header files of NEON
#  NEON_LIBRARIES  = Link these to use NEON
#  NEON_LFLAGS     = Linker flags (optional)

if (NOT NEON_FOUND)

  if (NOT NEON_ROOT_DIR)
    set (NEON_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT NEON_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (NEON_INCLUDES neon.h
    HINTS ${NEON_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (NEON_LIBRARIES neon
    HINTS ${NEON_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (NEON DEFAULT_MSG NEON_LIBRARIES NEON_INCLUDES)

  if (NEON_FOUND)
    if (NOT NEON_FIND_QUIETLY)
      message (STATUS "Found components for Neon")
      message (STATUS "NEON_ROOT_DIR  = ${NEON_ROOT_DIR}")
      message (STATUS "NEON_INCLUDES  = ${NEON_INCLUDES}")
      message (STATUS "NEON_LIBRARIES = ${NEON_LIBRARIES}")
    endif (NOT NEON_FIND_QUIETLY)
  else (NEON_FOUND)
    if (NEON_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find Neon!")
    endif (NEON_FIND_REQUIRED)
  endif (NEON_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    NEON_ROOT_DIR
    NEON_INCLUDES
    NEON_LIBRARIES
    )

endif (NOT NEON_FOUND)
