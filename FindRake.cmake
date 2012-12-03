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

# - Check for the presence of RAKE
#
# The following variables are set when RAKE is found:
#  RAKE_FOUND      = Set to true, if all components of RAKE
#                         have been found.
#  RAKE_INCLUDES   = Include path for the header files of RAKE
#  RAKE_LIBRARIES  = Link these to use RAKE
#  RAKE_LFLAGS     = Linker flags (optional)

if (NOT RAKE_FOUND)
    
  if (NOT RAKE_ROOT_DIR)
    set (RAKE_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RAKE_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  find_program (RAKE_EXECUTABLE rake
    HINTS ${RAKE_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Extract program version

  if (RAKE_EXECUTABLE)

    ## Run rake to display version number
    execute_process(
      COMMAND ${RAKE_EXECUTABLE} --version
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE RAKE_RESULT_VARIABLE
      OUTPUT_VARIABLE RAKE_OUTPUT_VARIABLE
      ERROR_VARIABLE RAKE_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    ## Process output in order to extract version number. Rake returns status 0
    ## if run successfully.
    if (NOT RAKE_RESULT_VARIABLE)

      string(REGEX REPLACE "rake, version " "" RAKE_VERSION ${RAKE_OUTPUT_VARIABLE})

      if (RAKE_VERSION)
	## Convert string to list of numbers
	string (REGEX REPLACE "\\." ";" RAKE_VERSION_LIST ${RAKE_VERSION})
	## Retrieve individual elements in the list
	list(GET RAKE_VERSION_LIST 0 RAKE_VERSION_MAJOR)
	list(GET RAKE_VERSION_LIST 1 RAKE_VERSION_MINOR)
	list(GET RAKE_VERSION_LIST 2 RAKE_VERSION_PATCH)
      endif (RAKE_VERSION)
      
    endif (NOT RAKE_RESULT_VARIABLE)
    
  endif (RAKE_EXECUTABLE)
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (RAKE_EXECUTABLE)
    set (RAKE_FOUND TRUE)
  else (RAKE_EXECUTABLE)
    set (RAKE_FOUND FALSE)
    if (NOT RAKE_FIND_QUIETLY)
      if (NOT RAKE_INCLUDES)
	message (STATUS "Unable to find RAKE header files!")
      endif (NOT RAKE_INCLUDES)
      if (NOT RAKE_LIBRARIES)
	message (STATUS "Unable to find RAKE library files!")
      endif (NOT RAKE_LIBRARIES)
    endif (NOT RAKE_FIND_QUIETLY)
  endif (RAKE_EXECUTABLE)
  
  if (RAKE_FOUND)
    if (NOT RAKE_FIND_QUIETLY)
      message (STATUS "Found components for RAKE")
      message (STATUS "RAKE_ROOT_DIR   = ${RAKE_ROOT_DIR}"   )
      message (STATUS "RAKE_EXECUTABLE = ${RAKE_EXECUTABLE}" )
      message (STATUS "RAKE_VERSION    = ${RAKE_VERSION}"    )
    endif (NOT RAKE_FIND_QUIETLY)
  else (RAKE_FOUND)
    if (RAKE_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find RAKE!")
    endif (RAKE_FIND_REQUIRED)
  endif (RAKE_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    RAKE_ROOT_DIR
    RAKE_INCLUDES
    RAKE_LIBRARIES
    )
  
endif (NOT RAKE_FOUND)
