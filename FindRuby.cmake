# +-----------------------------------------------------------------------------+
# |   Copyright 2004-2009 Kitware, Inc.                                         |
# |   Copyright 2008-2009 Alexander Neundorf <neundorf@kde.org>                 |
# |   Copyright 2012      Lars B"ahren <lbaehren@gmail.com>                     |
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

# - Check for the presence of Ruby
#
# This CMake search module heavily relies on the original module distributed
# as part of CMake itself, as provided by Kitware Inc. and Alexander Neundorf.
# While the original script appears to be working fine on most systems, problems
# where notes in case multiple versions of Ruby were installed on a systems and
# some user-defined selection was required.
#
# The following variables are set when Ruby is found:
#
#  RUBY_FOUND      = Set to true, if all components of Ruby have been found.
#  RUBY_EXECUTABLE = Full path to the Ruby executable
#  RUBY_VERSION    = Version of Ruby (major.minor.patch)
#  RUBY_INCLUDES   = Include path for the header files of Ruby
#  RUBY_LIBRARIES  = Link these to use RUBY
#
# The following variables can be used to direct the search
#
# RUBY_FIND_VERSION_MAJOR = Major version of Ruby
# RUBY_FIND_VERSION_MINOR = Minor version of Ruby

if (NOT RUBY_FOUND)

  if (NOT RUBY_ROOT_DIR)
    set (RUBY_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RUBY_ROOT_DIR)

  if (APPLE)
    set (CMAKE_FIND_FRAMEWORK "LAST")
  endif ()

  ##_____________________________________________________________________________
  ## Handle presets to direct the search

  ## Default list of possible names, under which executable and libraries can
  ## be found.

  set (_RUBY_POSSIBLE_EXECUTABLE_NAMES ruby ruby1.9 ruby19 ruby1.8 ruby18)
  set (_RUBY_POSSIBLE_LIBRARY_NAMES    ruby ruby1.9 ruby19 ruby1.8 ruby18)

  if (RUBY_FIND_VERSION_MAJOR AND RUBY_FIND_VERSION_MINOR)
    ## Assemble version strings
    set (RUBY_FIND_VERSION_SHORT       "${RUBY_FIND_VERSION_MAJOR}.${RUBY_FIND_VERSION_MINOR}")
    set (RUBY_FIND_VERSION_SHORT_NODOT "${RUBY_FIND_VERSION_MAJOR}${RUBY_FIND_VERSION_MINOR}")
    ## Set possible names for Ruby executable
    list (INSERT _RUBY_POSSIBLE_EXECUTABLE_NAMES 0 "ruby${RUBY_FIND_VERSION_SHORT}"       )
    list (INSERT _RUBY_POSSIBLE_EXECUTABLE_NAMES 0 "ruby${RUBY_FIND_VERSION_SHORT_NODOT}" )
    ## Set possible names for Ruby library
    list (INSERT _RUBY_POSSIBLE_LIBRARY_NAMES    0 "ruby${RUBY_FIND_VERSION_SHORT}"       )
    list (INSERT _RUBY_POSSIBLE_LIBRARY_NAMES    0 "ruby${RUBY_FIND_VERSION_SHORT_NODOT}" )
  endif ()

  ##_____________________________________________________________________________
  ## System inspection to derive path names

  STRING (TOLOWER ${CMAKE_SYSTEM_NAME} _RUBY_SYSTEM_NAME)

  string (REGEX REPLACE "\\." ";" _RUBY_SYSTEM_VERSION ${CMAKE_SYSTEM_VERSION})
  list (GET _RUBY_SYSTEM_VERSION 0 _RUBY_SYSTEM_VERSION_MAYOR)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (RUBY_EXECUTABLE
    NAMES ${_RUBY_POSSIBLE_EXECUTABLE_NAMES}
    HINTS ${RUBY_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  if (RUBY_EXECUTABLE)
    get_filename_component (_RUBY_BIN_DIR ${RUBY_EXECUTABLE} PATH)
    string (REPLACE "/bin" "" _RUBY_BASE_DIR ${_RUBY_BIN_DIR})
  endif ()

  if (RUBY_EXECUTABLE AND NOT RUBY_VERSION_MAJOR)

    function (_RUBY_CONFIG_VAR RBVAR OUTVAR)
    EXECUTE_PROCESS(COMMAND ${RUBY_EXECUTABLE} -r rbconfig -e "print RbConfig::CONFIG['${RBVAR}']"
      RESULT_VARIABLE _RUBY_SUCCESS
      OUTPUT_VARIABLE _RUBY_OUTPUT
      ERROR_QUIET)
    IF(_RUBY_SUCCESS OR NOT _RUBY_OUTPUT)
      EXECUTE_PROCESS(COMMAND ${RUBY_EXECUTABLE} -r rbconfig -e "print Config::CONFIG['${RBVAR}']"
        RESULT_VARIABLE _RUBY_SUCCESS
        OUTPUT_VARIABLE _RUBY_OUTPUT
        ERROR_QUIET)
    ENDIF(_RUBY_SUCCESS OR NOT _RUBY_OUTPUT)
    SET(${OUTVAR} "${_RUBY_OUTPUT}" PARENT_SCOPE)
    endfunction (_RUBY_CONFIG_VAR)

    # query the ruby version
    _RUBY_CONFIG_VAR ("MAJOR" RUBY_VERSION_MAJOR)
    _RUBY_CONFIG_VAR ("MINOR" RUBY_VERSION_MINOR)
    _RUBY_CONFIG_VAR ("TEENY" RUBY_VERSION_PATCH)
    set (RUBY_VERSION "${RUBY_VERSION_MAJOR}.${RUBY_VERSION_MINOR}.${RUBY_VERSION_PATCH}")

    # query the different directories
    _RUBY_CONFIG_VAR ("archdir"    RUBY_ARCH_DIR)
    _RUBY_CONFIG_VAR ("arch"       RUBY_ARCH)
    _RUBY_CONFIG_VAR ("rubyhdrdir" RUBY_HDR_DIR)
    _RUBY_CONFIG_VAR ("libdir"     RUBY_POSSIBLE_LIB_DIR)
    _RUBY_CONFIG_VAR ("rubylibdir" RUBY_RUBY_LIB_DIR)

  endif ()

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (RUBY_INCLUDES
    NAMES ruby.h rubyio.h rubysig.h dlconfig.h
    HINTS ${RUBY_ROOT_DIR} ${RUBY_ARCH_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib/ruby/${RUBY_FIND_VERSION_SHORT}/${RUBY_ARCH} lib/${RUBY_FIND_VERSION_SHORT} lib
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (RUBY_LIBRARIES
    NAMES ${_RUBY_POSSIBLE_LIBRARY_NAMES}
    HINTS ${RUBY_ROOT_DIR} ${_RUBY_BASE_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  find_library (RUBY_STATIC_LIBRARY
    NAMES ruby${RUBY_FIND_VERSION_SHORT}-static ruby-static
    HINTS ${RUBY_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (RUBY DEFAULT_MSG RUBY_EXECUTABLE RUBY_LIBRARIES RUBY_INCLUDES)

  if (RUBY_FOUND)
    if (NOT RUBY_FIND_QUIETLY)
      message (STATUS "Found components for Ruby")
      message (STATUS "RUBY_ROOT_DIR   = ${RUBY_ROOT_DIR}"   )
      message (STATUS "RUBY_EXECUTABLE = ${RUBY_EXECUTABLE}" )
      message (STATUS "RUBY_VERSION    = ${RUBY_VERSION}"    )
      message (STATUS "RUBY_ARCH       = ${RUBY_ARCH}"       )
      message (STATUS "RUBY_INCLUDES   = ${RUBY_INCLUDES}"   )
      message (STATUS "RUBY_LIBRARIES  = ${RUBY_LIBRARIES}"  )
    endif (NOT RUBY_FIND_QUIETLY)
  else (RUBY_FOUND)
    if (RUBY_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find Ruby!")
    endif (RUBY_FIND_REQUIRED)
  endif (RUBY_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    RUBY_ROOT_DIR
    RUBY_EXECUTABLE
    RUBY_VERSION
    RUBY_ARCH
    RUBY_INCLUDES
    RUBY_LIBRARIES
    )

endif (NOT RUBY_FOUND)
