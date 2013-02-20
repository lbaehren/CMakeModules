
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

# - Check for the presence of TEEM
#
# The following variables are set when TEEM is found:
#  TEEM_FOUND      = Set to true, if all components of TEEM have been found.
#  TEEM_INCLUDES   = Include path for the header files of TEEM
#  TEEM_LIBRARIES  = Link these to use TEEM
#  TEEM_LFLAGS     = Linker flags (optional)

if (NOT TEEM_FOUND)

  if (NOT TEEM_ROOT_DIR)
    set (TEEM_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT TEEM_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (TEEM_INCLUDES
    NAMES tenMacros.h nrrdDefines.h
    HINTS ${TEEM_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/teem
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (TEEM_LIBRARIES teem
    HINTS ${TEEM_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the executable

  foreach (_teemProgram
      nrrdSanity
      overrgb
      ilk
      mrender
      miter
      vprobe
      gprobe
      unu
      tend
      )
    ## Convert name to upper case
    string(TOUPPER ${_teemProgram} _var)
    ## Find executable
    find_program (TEEM_${_var}_EXECUTABLE ${_teemProgram}
      HINTS ${TEEM_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES bin
      )
  endforeach (_teemProgram)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (TEEM DEFAULT_MSG TEEM_LIBRARIES TEEM_INCLUDES)

  if (TEEM_FOUND)
    if (NOT TEEM_FIND_QUIETLY)
      message (STATUS "Found components for TEEM")
      message (STATUS "TEEM_ROOT_DIR  = ${TEEM_ROOT_DIR}")
      message (STATUS "TEEM_INCLUDES  = ${TEEM_INCLUDES}")
      message (STATUS "TEEM_LIBRARIES = ${TEEM_LIBRARIES}")
    endif (NOT TEEM_FIND_QUIETLY)
  else (TEEM_FOUND)
    if (TEEM_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find TEEM!")
    endif (TEEM_FIND_REQUIRED)
  endif (TEEM_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    TEEM_ROOT_DIR
    TEEM_INCLUDES
    TEEM_LIBRARIES
    )

endif (NOT TEEM_FOUND)
