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

# - Check for the presence of POPT
#
# The following variables are set when POPT is found:
#  POPT_FOUND      = Set to true, if all components of POPT have been found.
#  POPT_INCLUDES   = Include path for the header files of POPT
#  POPT_LIBRARIES  = Link these to use POPT
#  POPT_LFLAGS     = Linker flags (optional)

if (NOT POPT_FOUND)

  if (NOT POPT_ROOT_DIR)
    set (POPT_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT POPT_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (POPT_INCLUDES popt.h
    HINTS ${POPT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (POPT_LIBRARIES popt
    HINTS ${POPT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (POPT DEFAULT_MSG POPT_LIBRARIES POPT_INCLUDES)

  if (POPT_FOUND)
    if (NOT POPT_FIND_QUIETLY)
      message (STATUS "Found components for POPT")
      message (STATUS "POPT_ROOT_DIR  = ${POPT_ROOT_DIR}")
      message (STATUS "POPT_INCLUDES  = ${POPT_INCLUDES}")
      message (STATUS "POPT_LIBRARIES = ${POPT_LIBRARIES}")
    endif (NOT POPT_FIND_QUIETLY)
  else (POPT_FOUND)
    if (POPT_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find POPT!")
    endif (POPT_FIND_REQUIRED)
  endif (POPT_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    POPT_ROOT_DIR
    POPT_INCLUDES
    POPT_LIBRARIES
    )

endif (NOT POPT_FOUND)
