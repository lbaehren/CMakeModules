# +-----------------------------------------------------------------------------+
# |   Copyright (C) 2012                                                        |
# |   Lars B"ahren (lbaehren@gmail.com)                                         |
# |                                                                             |
# |   This program is free software; you can redistribute it and/or modify      |
# |   it under the terms of the GNU General Public License as published by      |
# |   the Free Software Foundation; either version 2 of the License, or         |
# |   (at your option) any later version.                                       |
# |                                                                             |
# |   This program is distributed in the hope that it will be useful,           |
# |   but WITHOUT ANY WARRANTY; without even the implied warranty of            |
# |   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             |
# |   GNU General Public License for more details.                              |
# |                                                                             |
# |   You should have received a copy of the GNU General Public License         |
# |   along with this program; if not, write to the                             |
# |   Free Software Foundation, Inc.,                                           |
# |   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.                 |
# +-----------------------------------------------------------------------------+

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
