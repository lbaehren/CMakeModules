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

# - Check for the presence of <PACKAGE>
#
# The following variables are set when <PACKAGE> is found:
#  <PACKAGE>_FOUND      = Set to true, if all components of <PACKAGE> have been found.
#  <PACKAGE>_INCLUDES   = Include path for the header files of <PACKAGE>
#  <PACKAGE>_LIBRARIES  = Link these to use <PACKAGE>
#  <PACKAGE>_LFLAGS     = Linker flags (optional)

if (NOT <PACKAGE>_FOUND)

  if (NOT <PACKAGE>_ROOT_DIR)
    set (<PACKAGE>_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT <PACKAGE>_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (<PACKAGE>_INCLUDES
    NAMES <header file(s)>
    HINTS ${<PACKAGE>_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (<PACKAGE>_LIBRARIES <package name>
    HINTS ${<PACKAGE>_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (<PACKAGE>_EXECUTABLE <package name>
    HINTS ${<PACKAGE>_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (<PACKAGE> DEFAULT_MSG <PACKAGE>_LIBRARIES <PACKAGE>_INCLUDES)

  if (<PACKAGE>_FOUND)
    if (NOT <PACKAGE>_FIND_QUIETLY)
      message (STATUS "Found components for <PACKAGE>")
      message (STATUS "<PACKAGE>_ROOT_DIR  = ${<PACKAGE>_ROOT_DIR}")
      message (STATUS "<PACKAGE>_INCLUDES  = ${<PACKAGE>_INCLUDES}")
      message (STATUS "<PACKAGE>_LIBRARIES = ${<PACKAGE>_LIBRARIES}")
    endif (NOT <PACKAGE>_FIND_QUIETLY)
  else (<PACKAGE>_FOUND)
    if (<PACKAGE>_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find <PACKAGE>!")
    endif (<PACKAGE>_FIND_REQUIRED)
  endif (<PACKAGE>_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    <PACKAGE>_ROOT_DIR
    <PACKAGE>_INCLUDES
    <PACKAGE>_LIBRARIES
    )

endif (NOT <PACKAGE>_FOUND)
