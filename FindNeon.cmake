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
