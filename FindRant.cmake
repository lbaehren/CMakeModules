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

# - Check for the presence of RANT
#
# The following variables are set when RANT is found:
#  RANT_FOUND      = Set to true, if all components of RANT
#                         have been found.
#  RANT_INCLUDES   = Include path for the header files of RANT
#  RANT_LIBRARIES  = Link these to use RANT
#  RANT_LFLAGS     = Linker flags (optional)

if (NOT RANT_FOUND)
    
  if (NOT RANT_ROOT_DIR)
    set (RANT_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RANT_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  find_program (RANT_EXECUTABLE rant
    HINTS ${RANT_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Extract program version

  find_file (RANT_INIT_RB rant/init.rb
    HINTS ${RANT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES
    lib/ruby
    lib/ruby/site_ruby/${REQUIRED_VERSION_RUBY}
    )

  if (RANT_INIT_RB)
    file (STRINGS ${RANT_INIT_RB} _rantVersion
      REGEX "VERSION ="
      )
    string (REGEX MATCH "[0-9]+.[0-9]+.[0-9]" RANT_VERSION ${_rantVersion})
  endif (RANT_INIT_RB)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (RANT_EXECUTABLE)
    set (RANT_FOUND TRUE)
  else (RANT_EXECUTABLE)
    set (RANT_FOUND FALSE)
    if (NOT RANT_FIND_QUIETLY)
      if (NOT RANT_INCLUDES)
	message (STATUS "Unable to find RANT header files!")
      endif (NOT RANT_INCLUDES)
      if (NOT RANT_LIBRARIES)
	message (STATUS "Unable to find RANT library files!")
      endif (NOT RANT_LIBRARIES)
    endif (NOT RANT_FIND_QUIETLY)
  endif (RANT_EXECUTABLE)
  
  if (RANT_FOUND)
    if (NOT RANT_FIND_QUIETLY)
      message (STATUS "Found components for RANT")
      message (STATUS "RANT_ROOT_DIR   = ${RANT_ROOT_DIR}"   )
      message (STATUS "RANT_EXECUTABLE = ${RANT_EXECUTABLE}" )
      message (STATUS "RANT_VERSION    = ${RANT_VERSION}"    )
    endif (NOT RANT_FIND_QUIETLY)
  else (RANT_FOUND)
    if (RANT_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find RANT!")
    endif (RANT_FIND_REQUIRED)
  endif (RANT_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    RANT_ROOT_DIR
    RANT_INCLUDES
    RANT_LIBRARIES
    )
  
endif (NOT RANT_FOUND)
