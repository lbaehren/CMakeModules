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

# - Check for the presence of RAILS
#
# The following variables are set when RAILS is found:
#  RAILS_FOUND      = Set to true, if all components of RAILS
#                         have been found.
#  RAILS_INCLUDES   = Include path for the header files of RAILS
#  RAILS_LIBRARIES  = Link these to use RAILS
#  RAILS_LFLAGS     = Linker flags (optional)

if (NOT RAILS_FOUND)
    
  if (NOT RAILS_ROOT_DIR)
    set (RAILS_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RAILS_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Package dependencies
  
  if (NOT RUBY_FOUND)
    set (RUBY_FIND_REQUIRED ${RAILS_FIND_REQUIRED})
    find_package (Ruby)
  endif (NOT RUBY_FOUND)
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  find_program (RAILS_EXECUTABLE rails
    HINTS ${RAILS_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Extract program version

  if (RAILS_EXECUTABLE)

    ## Run rails to display version number
    execute_process(
      COMMAND ${RAILS_EXECUTABLE} --version
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE RAILS_RESULT_VARIABLE
      OUTPUT_VARIABLE RAILS_OUTPUT_VARIABLE
      ERROR_VARIABLE RAILS_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )
    
    ## Process output in order to extract version number. Rails returns status 0
    ## if run successfully.
    if (NOT RAILS_RESULT_VARIABLE)

      ## If the Rails installation is incomplete, the '--version' inspection will
      ## fail and produce a message asking the user to install Rails; this output
      ## does not contain a version number, hence we need to catch that case.
      string(REGEX MATCH "install" RAILS_INSTALL_MISSING ${RAILS_OUTPUT_VARIABLE})
      
      if (NOT RAILS_INSTALL_MISSING)
	
	string(REGEX REPLACE "Rails " "" RAILS_VERSION ${RAILS_OUTPUT_VARIABLE})
	
	if (RAILS_VERSION)
	  ## Convert string to list of numbers
	  string (REGEX REPLACE "\\." ";" RAILS_VERSION_LIST ${RAILS_VERSION})
	  ## Retrieve individual elements in the list
	  list(GET RAILS_VERSION_LIST 0 RAILS_VERSION_MAJOR)
	  list(GET RAILS_VERSION_LIST 1 RAILS_VERSION_MINOR)
	  list(GET RAILS_VERSION_LIST 2 RAILS_VERSION_PATCH)
	endif (RAILS_VERSION)
	
      endif (NOT RAILS_INSTALL_MISSING)
      
    endif (NOT RAILS_RESULT_VARIABLE)
    
  endif (RAILS_EXECUTABLE)
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (RAILS_EXECUTABLE)
    set (RAILS_FOUND TRUE)
  else (RAILS_EXECUTABLE)
    set (RAILS_FOUND FALSE)
    if (NOT RAILS_FIND_QUIETLY)
      if (NOT RAILS_EXECUTABLE)
	message (STATUS "Unable to find RAILS executable files!")
      endif (NOT RAILS_EXECUTABLE)
    endif (NOT RAILS_FIND_QUIETLY)
  endif (RAILS_EXECUTABLE)
  
  if (RAILS_FOUND)
    if (NOT RAILS_FIND_QUIETLY)
      message (STATUS "Found components for RAILS")
      message (STATUS "RAILS_ROOT_DIR   = ${RAILS_ROOT_DIR}")
      message (STATUS "RAILS_EXECUTABLE = ${RAILS_EXECUTABLE}")
    endif (NOT RAILS_FIND_QUIETLY)
  else (RAILS_FOUND)
    if (RAILS_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find RAILS!")
    endif (RAILS_FIND_REQUIRED)
  endif (RAILS_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    RAILS_ROOT_DIR
    RAILS_INCLUDES
    RAILS_LIBRARIES
    )
  
endif (NOT RAILS_FOUND)
