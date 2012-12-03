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

# - Check for the presence of CPPUNIT
#
# The following variables are set when CPPUNIT is found:
#  CPPUNIT_FOUND      = Set to true, if all components of CPPUNIT have been found.
#  CPPUNIT_INCLUDES   = Include path for the header files of CPPUNIT
#  CPPUNIT_LIBRARIES  = Link these to use CPPUNIT
#  CPPUNIT_LFLAGS     = Linker flags (optional)

if (NOT CPPUNIT_FOUND)

  if (NOT CPPUNIT_ROOT_DIR)
    set (CPPUNIT_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT CPPUNIT_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (CPPUNIT_INCLUDES
    NAMES cppunit/TestAssert.h cppunit/Exception.h
    HINTS ${CPPUNIT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (CPPUNIT_LIBRARIES cppunit
    HINTS ${CPPUNIT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (CPPUNIT DEFAULT_MSG CPPUNIT_LIBRARIES CPPUNIT_INCLUDES)

  if (CPPUNIT_FOUND)
    if (NOT CPPUNIT_FIND_QUIETLY)
      message (STATUS "Found components for CPPUNIT")
      message (STATUS "CPPUNIT_ROOT_DIR  = ${CPPUNIT_ROOT_DIR}")
      message (STATUS "CPPUNIT_INCLUDES  = ${CPPUNIT_INCLUDES}")
      message (STATUS "CPPUNIT_LIBRARIES = ${CPPUNIT_LIBRARIES}")
    endif (NOT CPPUNIT_FIND_QUIETLY)
  else (CPPUNIT_FOUND)
    if (CPPUNIT_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find CPPUNIT!")
    endif (CPPUNIT_FIND_REQUIRED)
  endif (CPPUNIT_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    CPPUNIT_ROOT_DIR
    CPPUNIT_INCLUDES
    CPPUNIT_LIBRARIES
    )

endif (NOT CPPUNIT_FOUND)
