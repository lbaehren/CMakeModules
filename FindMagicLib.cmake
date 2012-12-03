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

# - Check for the presence of MAGIC
#
# The following variables are set when MAGIC is found:
#  MAGIC_FOUND      = Set to true, if all components of MAGIC have been found.
#  MAGIC_INCLUDES   = Include path for the header files of MAGIC
#  MAGIC_LIBRARIES  = Link these to use MAGIC
#  MAGIC_LFLAGS     = Linker flags (optional)

if (NOT MAGIC_FOUND)
    
  if (NOT MAGIC_ROOT_DIR)
    set (MAGIC_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT MAGIC_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the header files
  
  find_path (MAGIC_INCLUDES magic.h
    HINTS ${MAGIC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )
  
  ##_____________________________________________________________________________
  ## Check for the library
  
  find_library (MAGIC_LIBRARIES magic
    HINTS ${MAGIC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (MAGIC_INCLUDES AND MAGIC_LIBRARIES)
    set (MAGIC_FOUND TRUE)
  else (MAGIC_INCLUDES AND MAGIC_LIBRARIES)
    set (MAGIC_FOUND FALSE)
    if (NOT MAGIC_FIND_QUIETLY)
      if (NOT MAGIC_INCLUDES)
	message (STATUS "Unable to find MAGIC header files!")
      endif (NOT MAGIC_INCLUDES)
      if (NOT MAGIC_LIBRARIES)
	message (STATUS "Unable to find MAGIC library files!")
      endif (NOT MAGIC_LIBRARIES)
    endif (NOT MAGIC_FIND_QUIETLY)
  endif (MAGIC_INCLUDES AND MAGIC_LIBRARIES)
  
  if (MAGIC_FOUND)
    if (NOT MAGIC_FIND_QUIETLY)
      message (STATUS "Found components for MAGIC")
      message (STATUS "MAGIC_ROOT_DIR  = ${MAGIC_ROOT_DIR}")
      message (STATUS "MAGIC_INCLUDES  = ${MAGIC_INCLUDES}")
      message (STATUS "MAGIC_LIBRARIES = ${MAGIC_LIBRARIES}")
    endif (NOT MAGIC_FIND_QUIETLY)
  else (MAGIC_FOUND)
    if (MAGIC_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find MAGIC!")
    endif (MAGIC_FIND_REQUIRED)
  endif (MAGIC_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    MAGIC_ROOT_DIR
    MAGIC_INCLUDES
    MAGIC_LIBRARIES
    )
  
endif (NOT MAGIC_FOUND)
