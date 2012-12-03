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

# - Check for the presence of YARD
#
# The following variables are set when YARD is found:
#  YARD_FOUND      = Set to true, if all components of YARD
#                         have been found.
#  YARD_INCLUDES   = Include path for the header files of YARD
#  YARD_LIBRARIES  = Link these to use YARD
#  YARD_LFLAGS     = Linker flags (optional)

if (NOT YARD_FOUND)
    
  if (NOT YARD_ROOT_DIR)
    set (YARD_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT YARD_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  find_program (YARD_EXECUTABLE yard
    HINTS ${YARD_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Extract program version

  if (YARD_EXECUTABLE)

    ## Run yard to display version number
    execute_process(
      COMMAND ${YARD_EXECUTABLE} --version
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE YARD_RESULT_VARIABLE
      OUTPUT_VARIABLE YARD_OUTPUT_VARIABLE
      ERROR_VARIABLE YARD_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    ## Process output in order to extract version number. Yard returns status 0
    ## if run successfully.
    if (NOT YARD_RESULT_VARIABLE)

      string(REGEX REPLACE "yard " "" YARD_VERSION ${YARD_OUTPUT_VARIABLE})

      if (YARD_VERSION)
	## Convert string to list of numbers
	string (REGEX REPLACE "\\." ";" YARD_VERSION_LIST ${YARD_VERSION})
	## Retrieve individual elements in the list
	list(GET YARD_VERSION_LIST 0 YARD_VERSION_MAJOR)
	list(GET YARD_VERSION_LIST 1 YARD_VERSION_MINOR)
	list(GET YARD_VERSION_LIST 2 YARD_VERSION_PATCH)
      endif (YARD_VERSION)
      
    endif (NOT YARD_RESULT_VARIABLE)

  endif (YARD_EXECUTABLE)
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (YARD_EXECUTABLE)
    set (YARD_FOUND TRUE)
  else (YARD_EXECUTABLE)
    set (YARD_FOUND FALSE)
    if (NOT YARD_FIND_QUIETLY)
      if (NOT YARD_INCLUDES)
	message (STATUS "Unable to find YARD header files!")
      endif (NOT YARD_INCLUDES)
      if (NOT YARD_LIBRARIES)
	message (STATUS "Unable to find YARD library files!")
      endif (NOT YARD_LIBRARIES)
    endif (NOT YARD_FIND_QUIETLY)
  endif (YARD_EXECUTABLE)
  
  if (YARD_FOUND)
    if (NOT YARD_FIND_QUIETLY)
      message (STATUS "Found components for YARD")
      message (STATUS "YARD_ROOT_DIR  = ${YARD_ROOT_DIR}")
      message (STATUS "YARD_INCLUDES  = ${YARD_INCLUDES}")
      message (STATUS "YARD_LIBRARIES = ${YARD_LIBRARIES}")
    endif (NOT YARD_FIND_QUIETLY)
  else (YARD_FOUND)
    if (YARD_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find YARD!")
    endif (YARD_FIND_REQUIRED)
  endif (YARD_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    YARD_ROOT_DIR
    YARD_INCLUDES
    YARD_LIBRARIES
    )
  
endif (NOT YARD_FOUND)
