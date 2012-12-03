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
