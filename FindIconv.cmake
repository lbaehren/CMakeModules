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

# - Check for the presence of ICONV
#
# The following variables are set when ICONV is found:
#  ICONV_FOUND      = Set to true, if all components of ICONV
#                         have been found.
#  ICONV_INCLUDES   = Include path for the header files of ICONV
#  ICONV_LIBRARIES  = Link these to use ICONV
#  ICONV_LFLAGS     = Linker flags (optional)

if (NOT ICONV_FOUND)
  
  if (NOT ICONV_ROOT_DIR)
    ## We need some extra instruction here, in case inspection is done on
    ## Mac OS X: apparently the default /usr/lib/libiconv is missing some of
    ## the symbols, hence we prefer using the library version as installed
    ## via MacPorts.
    if (APPLE)
      set (ICONV_ROOT_DIR /opt/local)
    else (APPLE)
      set (ICONV_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
    endif (APPLE)
  endif (NOT ICONV_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the header files
  
  find_path (ICONV_INCLUDES iconv.h
    HINTS ${ICONV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/iconv
    )
  
  ##_____________________________________________________________________________
  ## Check for the library
  
  find_library (ICONV_LIBRARIES iconv
    HINTS ${ICONV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ## Extract library path and library name
  if (ICONV_LIBRARIES)
    get_filename_component (ICONV_LIBRARY_NAME ${ICONV_LIBRARIES} NAME)
    get_filename_component (ICONV_LIBRARY_PATH ${ICONV_LIBRARIES} PATH)
  endif (ICONV_LIBRARIES)
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  find_program (ICONV_EXECUTABLE iconv
    HINTS ${ICONV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (ICONV_INCLUDES AND ICONV_LIBRARIES)
    set (ICONV_FOUND TRUE)
  else (ICONV_INCLUDES AND ICONV_LIBRARIES)
    set (ICONV_FOUND FALSE)
    if (NOT ICONV_FIND_QUIETLY)
      if (NOT ICONV_INCLUDES)
	message (STATUS "Unable to find ICONV header files!")
      endif (NOT ICONV_INCLUDES)
      if (NOT ICONV_LIBRARIES)
	message (STATUS "Unable to find ICONV library files!")
      endif (NOT ICONV_LIBRARIES)
    endif (NOT ICONV_FIND_QUIETLY)
  endif (ICONV_INCLUDES AND ICONV_LIBRARIES)
  
  if (ICONV_FOUND)
    if (NOT ICONV_FIND_QUIETLY)
      message (STATUS "Found components for ICONV")
      message (STATUS "ICONV_ROOT_DIR   = ${ICONV_ROOT_DIR}")
      message (STATUS "ICONV_INCLUDES   = ${ICONV_INCLUDES}")
      message (STATUS "ICONV_LIBRARIES  = ${ICONV_LIBRARIES}")
      message (STATUS "ICONV_EXECUTABLE = ${ICONV_EXECUTABLE}")
    endif (NOT ICONV_FIND_QUIETLY)
  else (ICONV_FOUND)
    if (ICONV_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find ICONV!")
    endif (ICONV_FIND_REQUIRED)
  endif (ICONV_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    ICONV_ROOT_DIR
    ICONV_INCLUDES
    ICONV_LIBRARIES
    ICONV_LIBRARY_PATH
    ICONV_EXECUTABLE
    )
  
endif (NOT ICONV_FOUND)
