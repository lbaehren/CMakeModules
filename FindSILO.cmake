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

# - Check for the presence of SILO
#
# The following variables are set when SILO is found:
#  SILO_FOUND      = Set to true, if all components of SILO have been found.
#  SILO_INCLUDES   = Include path for the header files of SILO
#  SILO_LIBRARIES  = Link these to use SILO
#  SILO_LFLAGS     = Linker flags (optional)

if (NOT SILO_FOUND)

  if (NOT SILO_ROOT_DIR)
    set (SILO_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT SILO_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for configuration settings
  
  find_file (SILO_SETTINGS libsiloh5.settings
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (SILO_INCLUDES
    NAMES silo.h pmpio.h
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (SILO_LIBRARIES siloh5
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (SILO_SILOFILE_EXECUTABLE silofile
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  find_program (SILO_SILODIFF_EXECUTABLE silodiff
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  find_program (SILO_SILOCK_EXECUTABLE silock
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (SILO DEFAULT_MSG SILO_LIBRARIES SILO_INCLUDES)

  if (SILO_FOUND)
    if (NOT SILO_FIND_QUIETLY)
      message (STATUS "Found components for SILO")
      message (STATUS "SILO_ROOT_DIR  = ${SILO_ROOT_DIR}")
      message (STATUS "SILO_INCLUDES  = ${SILO_INCLUDES}")
      message (STATUS "SILO_LIBRARIES = ${SILO_LIBRARIES}")
    endif (NOT SILO_FIND_QUIETLY)
  else (SILO_FOUND)
    if (SILO_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find SILO!")
    endif (SILO_FIND_REQUIRED)
  endif (SILO_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    SILO_ROOT_DIR
    SILO_SETTINGS
    SILO_INCLUDES
    SILO_LIBRARIES
    )

endif (NOT SILO_FOUND)
