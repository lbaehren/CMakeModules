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

# - Check for the presence of LIBCONFIG
#
# The following variables are set when LIBCONFIG is found:
#  LIBCONFIG_FOUND      = Set to true, if all components of LIBCONFIG have been found.
#  LIBCONFIG_INCLUDES   = Include path for the header files of LIBCONFIG
#  LIBCONFIG_LIBRARIES  = Link these to use LIBCONFIG
#  LIBCONFIG_LFLAGS     = Linker flags (optional)

if (NOT LIBCONFIG_FOUND)

  if (NOT LIBCONFIG_ROOT_DIR)
    set (LIBCONFIG_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT LIBCONFIG_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (LIBCONFIG_INCLUDES
    NAMES libconfig.h
    HINTS ${LIBCONFIG_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (LIBCONFIG_LIBRARIES config
    HINTS ${LIBCONFIG_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for package configuration

  find_file (LIBCONFIG_PC libconfig.pc
    HINTS ${LIBCONFIG_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib lib/pkgconfig
    )

  ##_____________________________________________________________________________
  ## Determine version of the library
  
  if (LIBCONFIG_PC)
    
    file (STRINGS ${LIBCONFIG_PC} LIBCONFIG_VERSION REGEX "Version")
    
    if (LIBCONFIG_VERSION)

      ## Dissect version number into individual parts
      string(REGEX REPLACE ".*([0-9]+).[0-9]+.[0-9]+.*" "\\1"
	LIBCONFIG_VERSION_MAJOR ${LIBCONFIG_VERSION})
      string(REGEX REPLACE ".*[0-9]+.([0-9]+).[0-9]+.*" "\\1"
	LIBCONFIG_VERSION_MINOR ${LIBCONFIG_VERSION})
      string(REGEX REPLACE ".*[0-9]+.[0-9]+.([0-9]+).*" "\\1"
	LIBCONFIG_VERSION_RELEASE ${LIBCONFIG_VERSION})

      ## Assemble version number
      set (LIBCONFIG_VERSION "${LIBCONFIG_VERSION_MAJOR}")
      set (LIBCONFIG_VERSION "${LIBCONFIG_VERSION}.${LIBCONFIG_VERSION_MINOR}")
      set (LIBCONFIG_VERSION "${LIBCONFIG_VERSION}.${LIBCONFIG_VERSION_RELEASE}")

    endif (LIBCONFIG_VERSION)

  endif (LIBCONFIG_PC)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (LIBCONFIG DEFAULT_MSG LIBCONFIG_LIBRARIES LIBCONFIG_INCLUDES)

  if (LIBCONFIG_FOUND)
    if (NOT LIBCONFIG_FIND_QUIETLY)
      message (STATUS "Found components for LibConfig")
      message (STATUS "LIBCONFIG_ROOT_DIR  = ${LIBCONFIG_ROOT_DIR}")
      message (STATUS "LIBCONFIG_INCLUDES  = ${LIBCONFIG_INCLUDES}")
      message (STATUS "LIBCONFIG_LIBRARIES = ${LIBCONFIG_LIBRARIES}")
      message (STATUS "LIBCONFIG_VERSION   = ${LIBCONFIG_VERSION}")
    endif (NOT LIBCONFIG_FIND_QUIETLY)
  else (LIBCONFIG_FOUND)
    if (LIBCONFIG_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find LIBCONFIG!")
    endif (LIBCONFIG_FIND_REQUIRED)
  endif (LIBCONFIG_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    LIBCONFIG_ROOT_DIR
    LIBCONFIG_INCLUDES
    LIBCONFIG_LIBRARIES
    )

endif (NOT LIBCONFIG_FOUND)
