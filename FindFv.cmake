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

# - Check for the presence of FV
#
# The following variables are set when FV is found:
#  FV_FOUND      = Set to true, if all components of FV have been found.
#  FV_EXECUTABLE = FITS View program executable.

if (NOT FV_FOUND)

  if (NOT FV_ROOT_DIR)
    set (FV_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT FV_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (FV_EXECUTABLE fv
    HINTS ${FV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (FV DEFAULT_MSG FV_EXECUTABLE)

  if (FV_FOUND)
    if (NOT FV_FIND_QUIETLY)
      message (STATUS "Found components for FV")
      message (STATUS "FV_ROOT_DIR   = ${FV_ROOT_DIR}")
      message (STATUS "FV_EXECUTABLE = ${FV_EXECUTABLE}")
    endif (NOT FV_FIND_QUIETLY)
  else (FV_FOUND)
    if (FV_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find FV!")
    endif (FV_FIND_REQUIRED)
  endif (FV_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    FV_ROOT_DIR
    FV_EXECUTABLE
    )

endif (NOT FV_FOUND)
