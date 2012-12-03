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

# - Check for the presence of AUTOTOOLS
#
# The following variables are set when AUTOTOOLS is found:
#  AUTOTOOLS_FOUND      = Set to true, if all components of AUTOTOOLS have been found.

if (NOT AUTOTOOLS_FOUND)

  if (NOT AUTOTOOLS_ROOT_DIR)
    set (AUTOTOOLS_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT AUTOTOOLS_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the executable

  foreach (_program
      autoupdate
      autoscan
      autoreconf
      autom4te
      autoheader
      autoconf
      )

    string (TOUPPER ${_program} _varProgram)

    find_program (${_varProgram}_EXECUTABLE ${_program}
      HINTS ${AUTOTOOLS_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES bin
      )

  endforeach (_program)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (AUTOTOOLS DEFAULT_MSG AUTOCONF_EXECUTABLE)

  if (AUTOTOOLS_FOUND)
    if (NOT AUTOTOOLS_FIND_QUIETLY)
      message (STATUS "Found components for AUTOTOOLS")
      message (STATUS "AUTOTOOLS_ROOT_DIR  = ${AUTOTOOLS_ROOT_DIR}"  )
      message (STATUS "AUTOCONF_EXECUTABLE = ${AUTOCONF_EXECUTABLE}" )
      message (STATUS "AUTOSCAN_EXECUTABLE = ${AUTOSCAN_EXECUTABLE}" )
    endif (NOT AUTOTOOLS_FIND_QUIETLY)
  else (AUTOTOOLS_FOUND)
    if (AUTOTOOLS_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find AUTOTOOLS!")
    endif (AUTOTOOLS_FIND_REQUIRED)
  endif (AUTOTOOLS_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    AUTOTOOLS_ROOT_DIR
    AUTOCONF_EXECUTABLE
    AUTOSCAN_EXECUTABLE
    )

endif (NOT AUTOTOOLS_FOUND)
