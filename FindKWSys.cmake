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

# - Check for the presence of KWSYS
#
# The following variables are set when KWSYS is found:
#  KWSYS_FOUND      = Set to true, if all components of KWSYS have been found.
#  KWSYS_INCLUDES   = Include path for the header files of KWSYS
#  KWSYS_LIBRARIES  = Link these to use KWSYS
#  KWSYS_LFLAGS     = Linker flags (optional)

if (NOT KWSYS_FOUND)

  if (NOT KWSYS_ROOT_DIR)
    set (KWSYS_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT KWSYS_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (KWSYS_INCLUDES kwsys/SystemTools.hxx kwsys/SystemInformation.hxx
    HINTS ${KWSYS_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (KWSYS_KWSYS_LIBRARY kwsys
    HINTS ${KWSYS_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (KWSYS_KWSYS_LIBRARY)
    list (APPEND KWSYS_LIBRARIES ${KWSYS_KWSYS_LIBRARY})
  endif (KWSYS_KWSYS_LIBRARY)

  find_library (KWSYS_KWSYS_C_LIBRARY kwsys_c
    HINTS ${KWSYS_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (KWSYS_KWSYS_C_LIBRARY)
    list (APPEND KWSYS_LIBRARIES ${KWSYS_KWSYS_C_LIBRARY})
  endif (KWSYS_KWSYS_C_LIBRARY)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (KWSYS_INCLUDES AND KWSYS_LIBRARIES)
    set (KWSYS_FOUND TRUE)
  else (KWSYS_INCLUDES AND KWSYS_LIBRARIES)
    set (KWSYS_FOUND FALSE)
    if (NOT KWSYS_FIND_QUIETLY)
      if (NOT KWSYS_INCLUDES)
	message (STATUS "Unable to find KWSYS header files!")
      endif (NOT KWSYS_INCLUDES)
      if (NOT KWSYS_LIBRARIES)
	message (STATUS "Unable to find KWSYS library files!")
      endif (NOT KWSYS_LIBRARIES)
    endif (NOT KWSYS_FIND_QUIETLY)
  endif (KWSYS_INCLUDES AND KWSYS_LIBRARIES)

  if (KWSYS_FOUND)
    if (NOT KWSYS_FIND_QUIETLY)
      message (STATUS "Found components for KWSYS")
      message (STATUS "KWSYS_ROOT_DIR  = ${KWSYS_ROOT_DIR}")
      message (STATUS "KWSYS_INCLUDES  = ${KWSYS_INCLUDES}")
      message (STATUS "KWSYS_LIBRARIES = ${KWSYS_LIBRARIES}")
    endif (NOT KWSYS_FIND_QUIETLY)
  else (KWSYS_FOUND)
    if (KWSYS_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find KWSYS!")
    endif (KWSYS_FIND_REQUIRED)
  endif (KWSYS_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    KWSYS_ROOT_DIR
    KWSYS_INCLUDES
    KWSYS_LIBRARIES
    )

endif (NOT KWSYS_FOUND)
