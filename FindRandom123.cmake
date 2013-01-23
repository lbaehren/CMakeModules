# +-----------------------------------------------------------------------------+
# |   Copyright (C) 2013                                                        |
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

# - Check for the presence of RANDOM123
#
# The following variables are set when RANDOM123 is found:
#  RANDOM123_FOUND      = Set to true, if all components of RANDOM123 have been found.
#  RANDOM123_INCLUDES   = Include path for the header files of RANDOM123

if (NOT RANDOM123_FOUND)

  if (NOT RANDOM123_ROOT_DIR)
    set (RANDOM123_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RANDOM123_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (RANDOM123_INCLUDES
    NAMES Random123/threefry.h Random123/u01.h
    HINTS ${RANDOM123_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  ## Package is include files only.

  ##_____________________________________________________________________________
  ## Check for the executable

  ## Only executables are test programs.

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (RANDOM123 DEFAULT_MSG RANDOM123_INCLUDES)

  if (RANDOM123_FOUND)
    if (NOT RANDOM123_FIND_QUIETLY)
      message (STATUS "Found components for RANDOM123")
      message (STATUS "RANDOM123_ROOT_DIR  = ${RANDOM123_ROOT_DIR}")
      message (STATUS "RANDOM123_INCLUDES  = ${RANDOM123_INCLUDES}")
    endif (NOT RANDOM123_FIND_QUIETLY)
  else (RANDOM123_FOUND)
    if (RANDOM123_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find RANDOM123!")
    endif (RANDOM123_FIND_REQUIRED)
  endif (RANDOM123_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    RANDOM123_ROOT_DIR
    RANDOM123_INCLUDES
    )

endif (NOT RANDOM123_FOUND)
