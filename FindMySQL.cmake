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

# - Check for the presence of MYSQL
#
# The following variables are set when MYSQL is found:
#  MYSQL_FOUND      = Set to true, if all components of MYSQL
#                         have been found.
#  MYSQL_INCLUDES   = Include path for the header files of MYSQL
#  MYSQL_LIBRARIES  = Link these to use MYSQL
#  MYSQL_LFLAGS     = Linker flags (optional)

if (NOT MYSQL_FOUND)
    
  if (NOT MYSQL_ROOT_DIR)
    set (MYSQL_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT MYSQL_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the header files
  
  find_path (MYSQL_INCLUDES mysql.h
    HINTS ${MYSQL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include mysql include/mysql mysql5/mysql
    )
  
  ##_____________________________________________________________________________
  ## Check for the library
  
  find_library (MYSQL_LIBRARIES mysqlclient
    HINTS ${MYSQL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib mysql lib/mysql mysql5/mysql
    )
  
  ## Extract the library path
  if (MYSQL_LIBRARIES)
    get_filename_component (MYSQL_LIBRARY_PATH ${MYSQL_LIBRARIES} PATH)
  endif (MYSQL_LIBRARIES)
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (MYSQL_INCLUDES AND MYSQL_LIBRARIES)
    set (MYSQL_FOUND TRUE)
  else (MYSQL_INCLUDES AND MYSQL_LIBRARIES)
    set (MYSQL_FOUND FALSE)
    if (NOT MYSQL_FIND_QUIETLY)
      if (NOT MYSQL_INCLUDES)
	message (STATUS "Unable to find MYSQL header files!")
      endif (NOT MYSQL_INCLUDES)
      if (NOT MYSQL_LIBRARIES)
	message (STATUS "Unable to find MYSQL library files!")
      endif (NOT MYSQL_LIBRARIES)
    endif (NOT MYSQL_FIND_QUIETLY)
  endif (MYSQL_INCLUDES AND MYSQL_LIBRARIES)
  
  if (MYSQL_FOUND)
    if (NOT MYSQL_FIND_QUIETLY)
      message (STATUS "Found components for MYSQL")
      message (STATUS "MYSQL_ROOT_DIR  = ${MYSQL_ROOT_DIR}")
      message (STATUS "MYSQL_INCLUDES  = ${MYSQL_INCLUDES}")
      message (STATUS "MYSQL_LIBRARIES = ${MYSQL_LIBRARIES}")
    endif (NOT MYSQL_FIND_QUIETLY)
  else (MYSQL_FOUND)
    if (MYSQL_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find MYSQL!")
    endif (MYSQL_FIND_REQUIRED)
  endif (MYSQL_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    MYSQL_ROOT_DIR
    MYSQL_INCLUDES
    MYSQL_LIBRARIES
    )
  
endif (NOT MYSQL_FOUND)
