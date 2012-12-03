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

# - Check for the presence of PODOFO
#
# The following variables are set when PODOFO is found:
#  PODOFO_FOUND      = Set to true, if all components of PODOFO
#                         have been found.
#  PODOFO_INCLUDES   = Include path for the header files of PODOFO
#  PODOFO_LIBRARIES  = Link these to use PODOFO
#  PODOFO_LFLAGS     = Linker flags (optional)

if (NOT PODOFO_FOUND)

  if (NOT PODOFO_ROOT_DIR)
    set (PODOFO_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT PODOFO_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (PODOFO_INCLUDES podofo/podofo.h podofo/base/PdfDefines.h
    HINTS ${PODOFO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (PODOFO_LIBRARIES podofo
    HINTS ${PODOFO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the executable

  foreach (_podofoProgram
      podofobox
      podofocolor
      podofocountpages
      podofocrop
      podofoencrypt
      podofogc
      podofoimg2pdf
      podofoimgextract
      podofoimpose
      podofoincrementalupdates
      podofomerge
      podofopages
      podofopdfinfo
      podofotxt2pdf
      podofotxtextract
      podofouncompress
      podofoxmp
      )

    ## Name of cache variable
    string(TOUPPER ${_podofoProgram} _podofoVar)

    ## Search for the program executable
    find_program (PODOFO_${_podofoVar}_EXECUTABLE ${_podofoProgram}
      HINTS ${PODOFO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES bin
      )

  endforeach ()

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (PODOFO_INCLUDES AND PODOFO_LIBRARIES)
    set (PODOFO_FOUND TRUE)
  else (PODOFO_INCLUDES AND PODOFO_LIBRARIES)
    set (PODOFO_FOUND FALSE)
    if (NOT PODOFO_FIND_QUIETLY)
      if (NOT PODOFO_INCLUDES)
	message (STATUS "Unable to find PODOFO header files!")
      endif (NOT PODOFO_INCLUDES)
      if (NOT PODOFO_LIBRARIES)
	message (STATUS "Unable to find PODOFO library files!")
      endif (NOT PODOFO_LIBRARIES)
    endif (NOT PODOFO_FIND_QUIETLY)
  endif (PODOFO_INCLUDES AND PODOFO_LIBRARIES)

  if (PODOFO_FOUND)
    if (NOT PODOFO_FIND_QUIETLY)
      message (STATUS "Found components for PODOFO")
      message (STATUS "PODOFO_ROOT_DIR  = ${PODOFO_ROOT_DIR}")
      message (STATUS "PODOFO_INCLUDES  = ${PODOFO_INCLUDES}")
      message (STATUS "PODOFO_LIBRARIES = ${PODOFO_LIBRARIES}")
    endif (NOT PODOFO_FIND_QUIETLY)
  else (PODOFO_FOUND)
    if (PODOFO_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find PODOFO!")
    endif (PODOFO_FIND_REQUIRED)
  endif (PODOFO_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    PODOFO_ROOT_DIR
    PODOFO_INCLUDES
    PODOFO_LIBRARIES
    )

endif (NOT PODOFO_FOUND)
