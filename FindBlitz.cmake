
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

# - Check for the presence of Blitz++
#
# The following variables are set when Blitz++ is found:
#  BLITZ_FOUND      = Set to true, if all components of BLITZ have been found.
#  BLITZ_INCLUDES   = Include path for the header files of BLITZ
#  BLITZ_LIBRARIES  = Link these to use BLITZ
#  BLITZ_LFLAGS     = Linker flags (optional)

if (NOT BLITZ_FOUND)

  if (NOT BLITZ_ROOT_DIR)
    set (BLITZ_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT BLITZ_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (BLITZ_INCLUDES blitz.h tinymat.h
    HINTS ${BLITZ_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/blitz
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (BLITZ_LIBRARIES blitz
    HINTS ${BLITZ_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (BLITZ DEFAULT_MSG BLITZ_LIBRARIES BLITZ_INCLUDES)

  if (BLITZ_FOUND)
    if (NOT BLITZ_FIND_QUIETLY)
      message (STATUS "Found components for Blitz++")
      message (STATUS "BLITZ_ROOT_DIR  = ${BLITZ_ROOT_DIR}")
      message (STATUS "BLITZ_INCLUDES  = ${BLITZ_INCLUDES}")
      message (STATUS "BLITZ_LIBRARIES = ${BLITZ_LIBRARIES}")
    endif (NOT BLITZ_FIND_QUIETLY)
  else (BLITZ_FOUND)
    if (BLITZ_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find Blitz++!")
    endif (BLITZ_FIND_REQUIRED)
  endif (BLITZ_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    BLITZ_ROOT_DIR
    BLITZ_INCLUDES
    BLITZ_LIBRARIES
    )

endif (NOT BLITZ_FOUND)
