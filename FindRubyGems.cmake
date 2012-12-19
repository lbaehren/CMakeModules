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

# - Check for the presence of RubyGems
#
# The following variables are set when GEM is found:
#  RUBYGEMS_FOUND      = Set to true, if all components of GEM have been found.
#  GEM_EXECUTABLE      = Full path to the 'gem' executable
#  RUBYGEMS_PATH_HOME  = Path(s) used to search for gems

if (NOT RUBYGEMS_FOUND)

  if (NOT RUBYGEMS_ROOT_DIR)
    set (RUBYGEMS_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RUBYGEMS_ROOT_DIR)

  if (NOT RUBY_FOUND)
    if (RUBYGEMS_FIND_QUIETLY)
      set (RUBY_FIND_QUIETLY TRUE)
    endif ()
    ## Find the package
    find_package (Ruby)
    ## Decomposition of Ruby version number
    if (RUBY_VERSION)
      ## Convert string to list of numbers
      string (REGEX REPLACE "\\." ";" RUBY_VERSION_LIST ${RUBY_VERSION})
      ## Retrieve individual elements in the list
      list(GET RUBY_VERSION_LIST 0 RUBY_VERSION_MAJOR)
      list(GET RUBY_VERSION_LIST 1 RUBY_VERSION_MINOR)
      list(GET RUBY_VERSION_LIST 2 RUBY_VERSION_PATCH)
      ## Ruby release series
      set (RUBY_VERSION_SERIES "${RUBY_VERSION_MAJOR}.${RUBY_VERSION_MINOR}")
    else (RUBY_VERSION)
      message (STATUS "Found Ruby - failed to extract version number!")
    endif (RUBY_VERSION)

  endif (NOT RUBY_FOUND)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (GEM_EXECUTABLE gem
    HINTS ${RUBYGEMS_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Extract program version

  if (GEM_EXECUTABLE)

    ## Run gem to display the gem format version
    execute_process(
      COMMAND ${GEM_EXECUTABLE} --version
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE RUBYGEMS_RESULT_VARIABLE
      OUTPUT_VARIABLE RUBYGEMS_OUTPUT_VARIABLE
      ERROR_VARIABLE RUBYGEMS_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    ## Process output in order to extract version number. Gem returns status 0
    ## if run successfully.
    if (NOT RUBYGEMS_RESULT_VARIABLE)

      string(REGEX REPLACE "gem " "" RUBYGEMS_VERSION ${RUBYGEMS_OUTPUT_VARIABLE})

      if (RUBYGEMS_VERSION)
	## Convert string to list of numbers
	string (REGEX REPLACE "\\." ";" RUBYGEMS_VERSION_LIST ${RUBYGEMS_VERSION})
	## Retrieve individual elements in the list
	list(GET RUBYGEMS_VERSION_LIST 0 RUBYGEMS_VERSION_MAJOR)
	list(GET RUBYGEMS_VERSION_LIST 1 RUBYGEMS_VERSION_MINOR)
	list(GET RUBYGEMS_VERSION_LIST 2 RUBYGEMS_VERSION_PATCH)
      endif (RUBYGEMS_VERSION)

    endif (NOT RUBYGEMS_RESULT_VARIABLE)

  endif (GEM_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Check if installation and module paths are set

  if (GEM_EXECUTABLE)

    ## Run gem to display path used to search for gems
    execute_process(
      COMMAND ${GEM_EXECUTABLE} environment gempath
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE RUBYGEMS_RESULT_VARIABLE
      OUTPUT_VARIABLE RUBYGEMS_OUTPUT_VARIABLE
      ERROR_VARIABLE RUBYGEMS_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    if (NOT RUBYGEMS_RESULT_VARIABLE)
      ## Convert string to list of paths
      string (REGEX REPLACE "\\:" ";" RUBYGEMS_PATH_HOME ${RUBYGEMS_OUTPUT_VARIABLE})
    endif ()

  else (GEM_EXECUTABLE)

    ## Try to determine gempath otherwise
    find_path (RUBYGEMS_PATH_HOME
      NAMES
      ${CMAKE_INSTALL_PREFIX}/lib/ruby/gems/${RUBY_VERSION_SERIES}/gems
      /usr/lib/ruby/gems/${RUBY_VERSION_SERIES}/gems
      $ENV{RUBYGEMS_HOME}
      )

  endif (GEM_EXECUTABLE)

  ## Export path to environment: set( ENV{PATH} /home/martink )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (GEM_EXECUTABLE)
    set (RUBYGEMS_FOUND TRUE)
  else (GEM_EXECUTABLE)
    set (RUBYGEMS_FOUND FALSE)
  endif (GEM_EXECUTABLE)

  if (RUBYGEMS_FOUND)
    if (NOT RUBYGEMS_FIND_QUIETLY)
      message (STATUS "Found components for GEM")
      message (STATUS "RUBYGEMS_ROOT_DIR   = ${RUBYGEMS_ROOT_DIR}"   )
      message (STATUS "GEM_EXECUTABLE      = ${GEM_EXECUTABLE}"      )
      message (STATUS "RUBY_VERSION_SERIES = ${RUBY_VERSION_SERIES}" )
      message (STATUS "RUBYGEMS_PATH_HOME  = ${RUBYGEMS_PATH_HOME}"  )
    endif (NOT RUBYGEMS_FIND_QUIETLY)
  else (RUBYGEMS_FOUND)
    if (RUBYGEMS_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find Gem!")
    endif (RUBYGEMS_FIND_REQUIRED)
  endif (RUBYGEMS_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    RUBYGEMS_ROOT_DIR
    RUBYGEMS_INCLUDES
    RUBYGEMS_LIBRARIES
    )
  
endif (NOT RUBYGEMS_FOUND)
