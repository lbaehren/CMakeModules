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

# - Check for the presence of YASM
#
# The following variables are set when YASM is found:
#  YASM_FOUND      = Set to true, if all components of YASM have been found.
#  YASM_INCLUDES   = Include path for the header files of YASM
#  YASM_LIBRARIES  = Link these to use YASM

if (NOT YASM_FOUND)

  if (NOT YASM_ROOT_DIR)
    set (YASM_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT YASM_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (YASM_INCLUDES
    NAMES libyasm.h libyasm/valparam.h
    HINTS ${YASM_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/libyasm include/yasm
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (YASM_LIBRARIES yasm
    HINTS ${YASM_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (YASM_EXECUTABLE yasm
    HINTS ${YASM_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (YASM DEFAULT_MSG YASM_LIBRARIES YASM_INCLUDES)

  if (YASM_FOUND)
    if (NOT YASM_FIND_QUIETLY)
      message (STATUS "Found components for YASM")
      message (STATUS "YASM_ROOT_DIR  = ${YASM_ROOT_DIR}")
      message (STATUS "YASM_INCLUDES  = ${YASM_INCLUDES}")
      message (STATUS "YASM_LIBRARIES = ${YASM_LIBRARIES}")
    endif (NOT YASM_FIND_QUIETLY)
  else (YASM_FOUND)
    if (YASM_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find YASM!")
    endif (YASM_FIND_REQUIRED)
  endif (YASM_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    YASM_ROOT_DIR
    YASM_INCLUDES
    YASM_LIBRARIES
    )

endif (NOT YASM_FOUND)
