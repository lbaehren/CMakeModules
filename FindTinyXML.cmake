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

# - Check for the presence of TINYXML
#
# The following variables are set when TINYXML is found:
#  TINYXML_FOUND      = Set to true, if all components of TINYXML have been found.
#  TINYXML_INCLUDES   = Include path for the header files of TINYXML
#  TINYXML_LIBRARIES  = Link these to use TINYXML
#  TINYXML_LFLAGS     = Linker flags (optional)

if (NOT TINYXML_FOUND)

  if (NOT TINYXML_ROOT_DIR)
    set (TINYXML_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT TINYXML_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (TINYXML_INCLUDES
    NAMES tinyxml2.h
    HINTS ${TINYXML_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (TINYXML_LIBRARIES
    NAMES libtinyxml.a libtinyxml2.a tinyxml2
    HINTS ${TINYXML_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (TINYXML_INCLUDES AND TINYXML_LIBRARIES)
    set (TINYXML_FOUND TRUE)
  else (TINYXML_INCLUDES AND TINYXML_LIBRARIES)
    set (TINYXML_FOUND FALSE)
    if (NOT TINYXML_FIND_QUIETLY)
      if (NOT TINYXML_INCLUDES)
	message (STATUS "Unable to find TINYXML header files!")
      endif (NOT TINYXML_INCLUDES)
      if (NOT TINYXML_LIBRARIES)
	message (STATUS "Unable to find TINYXML library files!")
      endif (NOT TINYXML_LIBRARIES)
    endif (NOT TINYXML_FIND_QUIETLY)
  endif (TINYXML_INCLUDES AND TINYXML_LIBRARIES)

  if (TINYXML_FOUND)
    if (NOT TINYXML_FIND_QUIETLY)
      message (STATUS "Found components for TINYXML")
      message (STATUS "TINYXML_ROOT_DIR  = ${TINYXML_ROOT_DIR}")
      message (STATUS "TINYXML_INCLUDES  = ${TINYXML_INCLUDES}")
      message (STATUS "TINYXML_LIBRARIES = ${TINYXML_LIBRARIES}")
    endif (NOT TINYXML_FIND_QUIETLY)
  else (TINYXML_FOUND)
    if (TINYXML_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find TINYXML!")
    endif (TINYXML_FIND_REQUIRED)
  endif (TINYXML_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    TINYXML_ROOT_DIR
    TINYXML_INCLUDES
    TINYXML_LIBRARIES
    )

endif (NOT TINYXML_FOUND)
