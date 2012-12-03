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
