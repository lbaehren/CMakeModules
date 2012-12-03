# +-----------------------------------------------------------------------------+
# |   Copyright (C) 2011-2012                                                   |
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

# - Check for the presence of SQLITE
#
# The following variables are set when SQLITE is found:
#  SQLITE_FOUND      = Set to true, if all components of SQLITE have been found.
#  SQLITE_INCLUDES   = Include path for the header files of SQLITE
#  SQLITE_LIBRARIES  = Link these to use SQLITE
#  SQLITE_LFLAGS     = Linker flags (optional)

if (NOT SQLITE_FOUND)
    
  if (NOT SQLITE_ROOT_DIR)
    set (SQLITE_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT SQLITE_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files
  
  find_path (SQLITE_INCLUDES sqlite3.h sqlite3ext.h
    HINTS ${SQLITE_ROOT_DIR}
    PATH_SUFFIXES include
    )
  
  ##_____________________________________________________________________________
  ## Check for the library
  
  find_library (SQLITE_LIBRARIES sqlite3
    HINTS ${SQLITE_ROOT_DIR}
    PATH_SUFFIXES lib
    )
  
  ##_____________________________________________________________________________
  ## Check for the program executables
  
  find_program (SQLITE_LIBRARIES sqlite3
    HINTS ${SQLITE_ROOT_DIR}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (SQLITE_INCLUDES AND SQLITE_LIBRARIES)
    set (SQLITE_FOUND TRUE)
  else (SQLITE_INCLUDES AND SQLITE_LIBRARIES)
    set (SQLITE_FOUND FALSE)
    if (NOT SQLITE_FIND_QUIETLY)
      if (NOT SQLITE_INCLUDES)
	message (STATUS "Unable to find SQLITE header files!")
      endif (NOT SQLITE_INCLUDES)
      if (NOT SQLITE_LIBRARIES)
	message (STATUS "Unable to find SQLITE library files!")
      endif (NOT SQLITE_LIBRARIES)
    endif (NOT SQLITE_FIND_QUIETLY)
  endif (SQLITE_INCLUDES AND SQLITE_LIBRARIES)
  
  if (SQLITE_FOUND)
    if (NOT SQLITE_FIND_QUIETLY)
      message (STATUS "Found components for SQLITE")
      message (STATUS "SQLITE_ROOT_DIR  = ${SQLITE_ROOT_DIR}")
      message (STATUS "SQLITE_INCLUDES  = ${SQLITE_INCLUDES}")
      message (STATUS "SQLITE_LIBRARIES = ${SQLITE_LIBRARIES}")
    endif (NOT SQLITE_FIND_QUIETLY)
  else (SQLITE_FOUND)
    if (SQLITE_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find SQLITE!")
    endif (SQLITE_FIND_REQUIRED)
  endif (SQLITE_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    SQLITE_INCLUDES
    SQLITE_LIBRARIES
    )
  
endif (NOT SQLITE_FOUND)
