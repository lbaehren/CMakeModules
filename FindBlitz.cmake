# +-----------------------------------------------------------------------------+
# |   Copyright (C) 2011                                                        |
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

# - Check for the presence of BLITZ
#
# The following variables are set when BLITZ is found:
#  BLITZ_FOUND      = Set to true, if all components of BLITZ have been found.
#  BLITZ_INCLUDES   = Include path for the header files of BLITZ
#  BLITZ_LIBRARIES  = Link these to use BLITZ
#  BLITZ_LFLAGS     = Linker flags (optional)

if (NOT BLITZ_FOUND)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (BLITZ_INCLUDES blitz.h tinymat.h
    HINTS ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/blitz
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (BLITZ_LIBRARIES blitz
    HINTS ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (BLITZ_INCLUDES AND BLITZ_LIBRARIES)
    set (BLITZ_FOUND TRUE)
  else (BLITZ_INCLUDES AND BLITZ_LIBRARIES)
    set (BLITZ_FOUND FALSE)
    if (NOT BLITZ_FIND_QUIETLY)
      if (NOT BLITZ_INCLUDES)
	message (STATUS "Unable to find BLITZ header files!")
      endif (NOT BLITZ_INCLUDES)
      if (NOT BLITZ_LIBRARIES)
	message (STATUS "Unable to find BLITZ library files!")
      endif (NOT BLITZ_LIBRARIES)
    endif (NOT BLITZ_FIND_QUIETLY)
  endif (BLITZ_INCLUDES AND BLITZ_LIBRARIES)

  if (BLITZ_FOUND)
    if (NOT BLITZ_FIND_QUIETLY)
      message (STATUS "Found components for BLITZ")
      message (STATUS "BLITZ_INCLUDES  = ${BLITZ_INCLUDES}")
      message (STATUS "BLITZ_LIBRARIES = ${BLITZ_LIBRARIES}")
    endif (NOT BLITZ_FIND_QUIETLY)
  else (BLITZ_FOUND)
    if (BLITZ_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find BLITZ!")
    endif (BLITZ_FIND_REQUIRED)
  endif (BLITZ_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    BLITZ_INCLUDES
    BLITZ_LIBRARIES
    )

endif (NOT BLITZ_FOUND)
