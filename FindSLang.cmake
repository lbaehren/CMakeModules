
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

# - Check for the presence of SLANG
#
# The following variables are set when SLANG is found:
#  SLANG_FOUND      = Set to true, if all components of SLANG have been found.
#  SLANG_INCLUDES   = Include path for the header files of SLANG
#  SLANG_LIBRARIES  = Link these to use SLANG
#  SLANG_LFLAGS     = Linker flags (optional)

if (NOT SLANG_FOUND)

  if (NOT SLANG_ROOT_DIR)
    set (SLANG_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT SLANG_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (SLANG_INCLUDES
    NAMES slang.h slcurses.h
    HINTS ${SLANG_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (SLANG_LIBRARIES slang
    HINTS ${SLANG_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (SLANG_EXECUTABLE slsh
    HINTS ${SLANG_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (SLANG DEFAULT_MSG SLANG_EXECUTABLE SLANG_LIBRARIES SLANG_INCLUDES)

  if (SLANG_FOUND)
    if (NOT SLANG_FIND_QUIETLY)
      message (STATUS "Found components for SLANG")
      message (STATUS "SLANG_ROOT_DIR  = ${SLANG_ROOT_DIR}")
      message (STATUS "SLANG_INCLUDES  = ${SLANG_INCLUDES}")
      message (STATUS "SLANG_LIBRARIES = ${SLANG_LIBRARIES}")
      message (STATUS "SLANG_EXECUTABLE = ${SLANG_EXECUTABLE}")
    endif (NOT SLANG_FIND_QUIETLY)
  else (SLANG_FOUND)
    if (SLANG_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find SLANG!")
    endif (SLANG_FIND_REQUIRED)
  endif (SLANG_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    SLANG_ROOT_DIR
    SLANG_INCLUDES
    SLANG_LIBRARIES
    SLANG_EXECUTABLE
    )

endif (NOT SLANG_FOUND)
