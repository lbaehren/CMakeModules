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

# - Check for the presence of GSL
#
# The following variables are set when GSL is found:
#  GSL_FOUND      = Set to true, if all components of GSL have been found.
#  GSL_INCLUDES   = Include path for the header files of GSL
#  GSL_LIBRARIES  = Link these to use GSL
#  GSL_LFLAGS     = Linker flags (optional)

if (NOT GSL_FOUND)

  if (NOT GSL_ROOT_DIR)
    set (GSL_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT GSL_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (GSL_INCLUDES
    NAMES  gsl_version.h gsl_sys.h gsl_nan.h
    HINTS ${GSL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/gsl
    )

  ##_____________________________________________________________________________
  ## Check for the library

  set (GSL_LIBRARIES "")

  find_library (GSL_GSL_LIBRARY gsl
    HINTS ${GSL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (GSL_GSL_LIBRARY)
    list (APPEND GSL_LIBRARIES ${GSL_GSL_LIBRARY})
  endif (GSL_GSL_LIBRARY)

  find_library (GSL_GSLCBLAS_LIBRARY gslcblas
    HINTS ${GSL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (GSL_GSLCBLAS_LIBRARY)
    list (APPEND GSL_LIBRARIES ${GSL_GSLCBLAS_LIBRARY})
  endif (GSL_GSLCBLAS_LIBRARY)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (GSL_CONFIG_EXECUTABLE gsl-config
    HINTS ${GSL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin bin/gsl gsl/bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (GSL DEFAULT_MSG GSL_LIBRARIES GSL_INCLUDES)

  if (GSL_FOUND)
    if (NOT GSL_FIND_QUIETLY)
      message (STATUS "Found components for GSL")
      message (STATUS "GSL_ROOT_DIR  = ${GSL_ROOT_DIR}")
      message (STATUS "GSL_INCLUDES  = ${GSL_INCLUDES}")
      message (STATUS "GSL_LIBRARIES = ${GSL_LIBRARIES}")
    endif (NOT GSL_FIND_QUIETLY)
  else (GSL_FOUND)
    if (GSL_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find GSL!")
    endif (GSL_FIND_REQUIRED)
  endif (GSL_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    GSL_ROOT_DIR
    GSL_INCLUDES
    GSL_LIBRARIES
    )

endif (NOT GSL_FOUND)
