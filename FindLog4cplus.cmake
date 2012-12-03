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

# - Check for the presence of LOG4CPLUS
#
# The following variables are set when LOG4CPLUS is found:
#  LOG4CPLUS_FOUND      = Set to true, if all components of LOG4CPLUS have been found.
#  LOG4CPLUS_INCLUDES   = Include path for the header files of LOG4CPLUS
#  LOG4CPLUS_LIBRARIES  = Link these to use LOG4CPLUS

if (NOT LOG4CPLUS_FOUND)

  if (NOT LOG4CPLUS_ROOT_DIR)
    set (LOG4CPLUS_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT LOG4CPLUS_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (LOG4CPLUS_INCLUDES
    NAMES log4cplus/config.hxx log4cplus/appender.h log4cplus/loglevel.h
    HINTS ${LOG4CPLUS_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (LOG4CPLUS_LIBRARIES log4cplus
    HINTS ${LOG4CPLUS_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (LOG4CPLUS DEFAULT_MSG LOG4CPLUS_LIBRARIES LOG4CPLUS_INCLUDES)

  if (LOG4CPLUS_FOUND)
    if (NOT LOG4CPLUS_FIND_QUIETLY)
      message (STATUS "Found components for log4cplus")
      message (STATUS "LOG4CPLUS_ROOT_DIR  = ${LOG4CPLUS_ROOT_DIR}")
      message (STATUS "LOG4CPLUS_INCLUDES  = ${LOG4CPLUS_INCLUDES}")
      message (STATUS "LOG4CPLUS_LIBRARIES = ${LOG4CPLUS_LIBRARIES}")
    endif (NOT LOG4CPLUS_FIND_QUIETLY)
  else (LOG4CPLUS_FOUND)
    if (LOG4CPLUS_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find log4cplus!")
    endif (LOG4CPLUS_FIND_REQUIRED)
  endif (LOG4CPLUS_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    LOG4CPLUS_ROOT_DIR
    LOG4CPLUS_INCLUDES
    LOG4CPLUS_LIBRARIES
    )

endif (NOT LOG4CPLUS_FOUND)
