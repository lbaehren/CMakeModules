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

# - Check for the presence of CAPISTRANO
#
# The following variables are set when CAPISTRANO is found:
#  CAPISTRANO_FOUND      = Set to true, if all components of CAPISTRANO have been found.
#  CAPISTRANO_EXECUTABLE = Application executable

if (NOT CAPISTRANO_FOUND)

  if (NOT CAPISTRANO_ROOT_DIR)
    set (CAPISTRANO_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT CAPISTRANO_ROOT_DIR)

  if (NOT RUBY_FOUND)
    find_package (Ruby)
  endif ()

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (CAPISTRANO_EXECUTABLE cap capistrano
    HINTS ${CAPISTRANO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATHS /var/lib/gems
    PATH_SUFFIXES bin ${RUBY_VERSION_MAJOR}.${RUBY_VERSION_MINOR}/bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (CAPISTRANO DEFAULT_MSG CAPISTRANO_EXECUTABLE)

  if (CAPISTRANO_FOUND)
    if (NOT CAPISTRANO_FIND_QUIETLY)
      message (STATUS "Found components for CAPISTRANO")
      message (STATUS "CAPISTRANO_ROOT_DIR   = ${CAPISTRANO_ROOT_DIR}")
      message (STATUS "CAPISTRANO_EXECUTABLE = ${CAPISTRANO_EXECUTABLE}")
    endif (NOT CAPISTRANO_FIND_QUIETLY)
  else (CAPISTRANO_FOUND)
    if (CAPISTRANO_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find CAPISTRANO!")
    endif (CAPISTRANO_FIND_REQUIRED)
  endif (CAPISTRANO_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    CAPISTRANO_ROOT_DIR
    CAPISTRANO_EXECUTABLE
    )

endif (NOT CAPISTRANO_FOUND)
