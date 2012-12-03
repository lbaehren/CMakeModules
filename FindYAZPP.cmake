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

# - Check for the presence of YAZPP
#
# The following variables are set when YAZPP is found:
#  YAZPP_FOUND      = Set to true, if all components of YAZPP have been found.
#  YAZPP_INCLUDES   = Include path for the header files of YAZPP
#  YAZPP_LIBRARIES  = Link these to use YAZPP
#  YAZPP_LFLAGS     = Linker flags (optional)

if (NOT YAZPP_FOUND)

  if (NOT YAZPP_ROOT_DIR)
    set (YAZPP_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT YAZPP_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (YAZPP_INCLUDES
    NAMES yazpp/z-assoc.h yazpp/z-query.h yazpp/socket-observer.h
    HINTS ${YAZPP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  set (YAZPP_LIBRARIES "")

  ## libyazpp
  find_library (YAZPP_YAZPP_LIBRARY yazpp
    HINTS ${YAZPP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (YAZPP_YAZPP_LIBRARY)
    list (APPEND YAZPP_LIBRARIES ${YAZPP_YAZPP_LIBRARY})
  endif (YAZPP_YAZPP_LIBRARY)

  ## libzoompp
  find_library (YAZPP_ZOOMPP_LIBRARY zoompp
    HINTS ${YAZPP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (YAZPP_ZOOMPP_LIBRARY)
    list (APPEND YAZPP_LIBRARIES ${YAZPP_ZOOMPP_LIBRARY})
  endif (YAZPP_ZOOMPP_LIBRARY)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (YAZPP_CONFIG_EXECUTABLE yazpp-config
    HINTS ${YAZPP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  if (YAZPP_CONFIG_EXECUTABLE)
    execute_process (
      COMMAND ${YAZPP_CONFIG_EXECUTABLE} --version
      WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
      RESULT_VARIABLE YAZPP_RESULT_VARIABLE
      OUTPUT_VARIABLE YAZPP_VERSION
      ERROR_VARIABLE YAZPP_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )
  endif (YAZPP_CONFIG_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (YAZPP_INCLUDES AND YAZPP_LIBRARIES)
    set (YAZPP_FOUND TRUE)
  else (YAZPP_INCLUDES AND YAZPP_LIBRARIES)
    set (YAZPP_FOUND FALSE)
    if (NOT YAZPP_FIND_QUIETLY)
      if (NOT YAZPP_INCLUDES)
	message (STATUS "Unable to find YAZPP header files!")
      endif (NOT YAZPP_INCLUDES)
      if (NOT YAZPP_LIBRARIES)
	message (STATUS "Unable to find YAZPP library files!")
      endif (NOT YAZPP_LIBRARIES)
    endif (NOT YAZPP_FIND_QUIETLY)
  endif (YAZPP_INCLUDES AND YAZPP_LIBRARIES)

  if (YAZPP_FOUND)
    if (NOT YAZPP_FIND_QUIETLY)
      message (STATUS "Found components for YAZPP")
      message (STATUS "YAZPP_ROOT_DIR  = ${YAZPP_ROOT_DIR}")
      message (STATUS "YAZPP_INCLUDES  = ${YAZPP_INCLUDES}")
      message (STATUS "YAZPP_LIBRARIES = ${YAZPP_LIBRARIES}")
    endif (NOT YAZPP_FIND_QUIETLY)
  else (YAZPP_FOUND)
    if (YAZPP_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find YAZPP!")
    endif (YAZPP_FIND_REQUIRED)
  endif (YAZPP_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    YAZPP_ROOT_DIR
    YAZPP_INCLUDES
    YAZPP_LIBRARIES
    )

endif (NOT YAZPP_FOUND)
