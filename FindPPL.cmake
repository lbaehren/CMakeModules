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

# - Check for the presence of PPL
#
# The following variables are set when PPL is found:
#  PPL_FOUND      = Set to true, if all components of PPL have been found.
#  PPL_INCLUDES   = Include path for the header files of PPL
#  PPL_LIBRARIES  = Link these to use PPL
#  PPL_LFLAGS     = Linker flags (optional)

if (NOT PPL_FOUND)

  if (NOT PPL_ROOT_DIR)
    set (PPL_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT PPL_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (PPL_INCLUDES
    NAMES ppl_c.h
    HINTS ${PPL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  set (PPL_LIBRARIES "")

  ## libppl

  find_library (PPL_PPL_LIBRARY ppl
    HINTS ${PPL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (PPL_PPL_LIBRARY)
    list (APPEND PPL_LIBRARIES ${PPL_PPL_LIBRARY})
  endif (PPL_PPL_LIBRARY)

  ## libppl_c

  find_library (PPL_PPL_C_LIBRARY ppl_c
    HINTS ${PPL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (PPL_PPL_C_LIBRARY)
    list (APPEND PPL_LIBRARIES ${PPL_PPL_C_LIBRARY})
  endif (PPL_PPL_C_LIBRARY)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (PPL_EXECUTABLE <package name>
    HINTS ${PPL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (PPL DEFAULT_MSG PPL_LIBRARIES PPL_INCLUDES)

  if (PPL_FOUND)
    if (NOT PPL_FIND_QUIETLY)
      message (STATUS "Found components for PPL")
      message (STATUS "PPL_ROOT_DIR  = ${PPL_ROOT_DIR}")
      message (STATUS "PPL_INCLUDES  = ${PPL_INCLUDES}")
      message (STATUS "PPL_LIBRARIES = ${PPL_LIBRARIES}")
    endif (NOT PPL_FIND_QUIETLY)
  else (PPL_FOUND)
    if (PPL_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find PPL!")
    endif (PPL_FIND_REQUIRED)
  endif (PPL_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    PPL_ROOT_DIR
    PPL_INCLUDES
    PPL_LIBRARIES
    )

endif (NOT PPL_FOUND)
