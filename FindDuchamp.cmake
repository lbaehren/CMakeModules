
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

# - Check for the presence of DUCHAMP
#
# The following variables are set when DUCHAMP is found:
#  DUCHAMP_FOUND      = Set to true, if all components of DUCHAMP have been found.
#  DUCHAMP_INCLUDES   = Include path for the header files of DUCHAMP
#  DUCHAMP_LIBRARIES  = Link these to use DUCHAMP
#  DUCHAMP_LFLAGS     = Linker flags (optional)

if (NOT DUCHAMP_FOUND)

  if (NOT DUCHAMP_ROOT_DIR)
    set (DUCHAMP_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT DUCHAMP_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (DUCHAMP_INCLUDES duchamp.hh duchamp/duchamp.hh
    HINTS ${DUCHAMP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (DUCHAMP_LIBRARIES duchamp
    HINTS ${DUCHAMP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (DUCHAMP_EXECUTABLE Duchamp
    HINTS ${DUCHAMP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (DUCHAMP DEFAULT_MSG DUCHAMP_EXECUTABLE DUCHAMP_LIBRARIES DUCHAMP_INCLUDES)

  if (DUCHAMP_FOUND)
    if (NOT DUCHAMP_FIND_QUIETLY)
      message (STATUS "Found components for DUCHAMP")
      message (STATUS "DUCHAMP_ROOT_DIR  = ${DUCHAMP_ROOT_DIR}")
      message (STATUS "DUCHAMP_INCLUDES  = ${DUCHAMP_INCLUDES}")
      message (STATUS "DUCHAMP_LIBRARIES = ${DUCHAMP_LIBRARIES}")
    endif (NOT DUCHAMP_FIND_QUIETLY)
  else (DUCHAMP_FOUND)
    if (DUCHAMP_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find DUCHAMP!")
    endif (DUCHAMP_FIND_REQUIRED)
  endif (DUCHAMP_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    DUCHAMP_ROOT_DIR
    DUCHAMP_INCLUDES
    DUCHAMP_LIBRARIES
    DUCHAMP_EXECUTABLE
    )

endif (NOT DUCHAMP_FOUND)
