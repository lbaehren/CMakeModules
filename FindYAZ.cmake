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

# - Check for the presence of YAZ
#
# The following variables are set when YAZ is found:
#  YAZ_FOUND      = Set to true, if all components of YAZ have been found.
#  YAZ_INCLUDES   = Include path for the header files of YAZ
#  YAZ_LIBRARIES  = Link these to use YAZ
#  YAZ_LFLAGS     = Linker flags (optional)

if (NOT YAZ_FOUND)

  if (NOT YAZ_ROOT_DIR)
    set (YAZ_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT YAZ_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (YAZ_INCLUDES
    NAMES yaz/yconfig.h yaz/backend.h
    HINTS ${YAZ_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  set (YAZ_LIBRARIES "")

  find_library (YAZ_YAZ_LIBRARY yaz
    HINTS ${YAZ_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (YAZ_YAZ_LIBRARY)
    list (APPEND YAZ_LIBRARIES ${YAZ_YAZ_LIBRARY})
  endif (YAZ_YAZ_LIBRARY)

  find_library (YAZ_YAZ_ICU_LIBRARY yaz_icu
    HINTS ${YAZ_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (YAZ_YAZ_ICU_LIBRARY)
    list (APPEND YAZ_LIBRARIES ${YAZ_YAZ_ICU_LIBRARY})
  endif (YAZ_YAZ_ICU_LIBRARY)

  find_library (YAZ_YAZ_SERVER_LIBRARY yaz_server
    HINTS ${YAZ_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (YAZ_YAZ_SERVER_LIBRARY)
    list (APPEND YAZ_LIBRARIES ${YAZ_YAZ_SERVER_LIBRARY})
  endif (YAZ_YAZ_SERVER_LIBRARY)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (YAZ_CLIENT_EXECUTABLE yaz-client
    HINTS ${YAZ_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  find_program (YAZ_CONFIG_EXECUTABLE yaz-config
    HINTS ${YAZ_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  if (YAZ_CONFIG_EXECUTABLE)
    execute_process (
      COMMAND ${YAZ_CONFIG_EXECUTABLE} --version
      WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
      RESULT_VARIABLE YAZ_RESULT_VARIABLE
      OUTPUT_VARIABLE YAZ_VERSION
      ERROR_VARIABLE YAZ_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    if (YAZ_VERSION)
      ## Convert string to list of numbers
      string (REGEX REPLACE "\\." ";" YAZ_VERSION_LIST ${YAZ_VERSION})
      ## Retrieve individual elements in the list
      list (GET YAZ_VERSION_LIST 0 YAZ_VERSION_MAJOR)
      list (GET YAZ_VERSION_LIST 1 YAZ_VERSION_MINOR)
      list (GET YAZ_VERSION_LIST 2 YAZ_VERSION_PATCH)
      ## Assemble version string, which can be used for comparison
      math (EXPR YAZ_VERSION_STRING_MAJOR "${YAZ_VERSION_MAJOR}*100")
      math (EXPR YAZ_VERSION_STRING_MINOR "${YAZ_VERSION_MINOR}*100")
      math (EXPR YAZ_VERSION_STRING_PATCH "${YAZ_VERSION_PATCH}*100")
      set (YAZ_VERSION_STRING "${YAZ_VERSION_STRING_MAJOR}${YAZ_VERSION_STRING_MINOR}${YAZ_VERSION_STRING_PATCH}")
    endif (YAZ_VERSION)

  endif (YAZ_CONFIG_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (YAZ DEFAULT_MSG YAZ_LIBRARIES YAZ_INCLUDES)

  if (YAZ_INCLUDES AND YAZ_LIBRARIES)
    set (YAZ_FOUND TRUE)
  else (YAZ_INCLUDES AND YAZ_LIBRARIES)
    set (YAZ_FOUND FALSE)
    if (NOT YAZ_FIND_QUIETLY)
      if (NOT YAZ_INCLUDES)
	message (STATUS "Unable to find YAZ header files!")
      endif (NOT YAZ_INCLUDES)
      if (NOT YAZ_LIBRARIES)
	message (STATUS "Unable to find YAZ library files!")
      endif (NOT YAZ_LIBRARIES)
    endif (NOT YAZ_FIND_QUIETLY)
  endif (YAZ_INCLUDES AND YAZ_LIBRARIES)

  if (YAZ_FOUND)
    if (NOT YAZ_FIND_QUIETLY)
      message (STATUS "Found components for YAZ")
      message (STATUS "YAZ_ROOT_DIR  = ${YAZ_ROOT_DIR}")
      message (STATUS "YAZ_INCLUDES  = ${YAZ_INCLUDES}")
      message (STATUS "YAZ_LIBRARIES = ${YAZ_LIBRARIES}")
    endif (NOT YAZ_FIND_QUIETLY)
  else (YAZ_FOUND)
    if (YAZ_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find YAZ!")
    endif (YAZ_FIND_REQUIRED)
  endif (YAZ_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    YAZ_ROOT_DIR
    YAZ_INCLUDES
    YAZ_LIBRARIES
    YAZ_YAZ_LIBRARY
    YAZ_YAZ_ICU_LIBRARY
    YAZ_YAZ_SERVER_LIBRARY
    YAZ_VERSION
    YAZ_VERSION_STRING
    )

endif (NOT YAZ_FOUND)
