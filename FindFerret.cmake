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

# - Check for the presence of FERRET
#
# The following variables are set when FERRET is found:
#  FERRET_FOUND             = Set to true, if all components of FERRET have been
#                             found.
#  FERRET_FERRET_RB         = Location of ferret.rb
#  FERRET_FERRET_VERSION_RB = Location of ferret_version.rb

if (NOT FERRET_FOUND)

  if (NOT FERRET_ROOT_DIR)
    set (FERRET_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT FERRET_ROOT_DIR)

  find_package (Ruby)
  find_package (Gem)

  ##_____________________________________________________________________________
  ## Check if Ferret is installed as a Gem

  if (GEM_EXECUTABLE)
    execute_process (
      COMMAND ${GEM_EXECUTABLE} list ferret
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE GEM_RESULT_VARIABLE
      OUTPUT_VARIABLE GEM_OUTPUT_VARIABLE
      ERROR_VARIABLE GEM_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    if (GEM_OUTPUT_VARIABLE)
      string (REGEX REPLACE "[a-z\(\)]" "" FERRET_VERSION ${GEM_OUTPUT_VARIABLE})
    endif (GEM_OUTPUT_VARIABLE)

  endif (GEM_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Check for installed Ruby sources

  find_file (FERRET_FERRET_RB ferret.rb
    HINTS ${FERRET_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES ruby ruby/site_ruby
    )

  find_file (FERRET_FERRET_VERSION_RB ferret_version.rb
    HINTS ${FERRET_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES ruby ruby/site_ruby
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (FERRET_FOUND)
    if (NOT FERRET_FIND_QUIETLY)
      message (STATUS "Found components for FERRET")
      message (STATUS "FERRET_ROOT_DIR          = ${FERRET_ROOT_DIR}")
      message (STATUS "FERRET_FERRET_RB         = ${FERRET_FERRET_RB}")
      message (STATUS "FERRET_FERRET_VERSION_RB = ${FERRET_FERRET_VERSION_RB}")
    endif (NOT FERRET_FIND_QUIETLY)
  else (FERRET_FOUND)
    if (FERRET_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find FERRET!")
    endif (FERRET_FIND_REQUIRED)
  endif (FERRET_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    FERRET_ROOT_DIR
    FERRET_FERRET_RB
    FERRET_FERRET_VERSION_RB
    FERRET_VERSION
    )

endif (NOT FERRET_FOUND)
