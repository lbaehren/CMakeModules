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

# - Check for the presence of XERCESC
#
# The following variables are set when XERCESC is found:
#  XERCESC_FOUND      = Set to true, if all components of XERCESC have been found.
#  XERCESC_INCLUDES   = Include path for the header files of XERCESC
#  XERCESC_LIBRARIES  = Link these to use XERCESC
#  XERCESC_LFLAGS     = Linker flags (optional)

if (NOT XERCESC_FOUND)
    
  if (NOT XERCESC_ROOT_DIR)
    set (XERCESC_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT XERCESC_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the header files
  
  find_path (XERCESC_INCLUDES
    NAMES
    xercesc/util/PlatformUtils.hpp
    xercesc/framwork/URLInputSource.hpp
    xercesc/framwork/XMLErrorCodes.hpp
    HINTS ${XERCESC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )
  
  ##_____________________________________________________________________________
  ## Check for the library
  
  find_library (XERCESC_LIBRARIES xerces-c
    HINTS ${XERCESC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  foreach (varProgram
      SEnumVal
      SCMPrint
      SAXPrint
      SAXCount
      SAX2Print
      SAX2Count
      Redirect
      PSVIWriter
      PParse
      MemParse
      EnumVal
      DOMPrint
      DOMCount
      CreateDOMDocument
      XInclude
      StdInParse
      )
    ## convert program name to upper-case
    string (TOUPPER ${varProgram} varProgramUpper)
    ## search for the program executable
    find_program (XERCESC_${varProgramUpper}_EXECUTABLE varProgram
      HINTS ${XERCESC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES bin
      )
    ## Mark the variable as advanced
    mark_as_advanced (
      XERCESC_${varProgramUpper}_EXECUTABLE
      )
  endforeach (varProgram)
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (XERCESC DEFAULT_MSG XERCESC_LIBRARIES XERCESC_INCLUDES)

  if (XERCESC_FOUND)
    if (NOT XERCESC_FIND_QUIETLY)
      message (STATUS "Found components for XERCES")
      message (STATUS "XERCESC_ROOT_DIR  = ${XERCESC_ROOT_DIR}")
      message (STATUS "XERCESC_INCLUDES  = ${XERCESC_INCLUDES}")
      message (STATUS "XERCESC_LIBRARIES = ${XERCESC_LIBRARIES}")
    endif (NOT XERCESC_FIND_QUIETLY)
  else (XERCESC_FOUND)
    if (XERCESC_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find XERCES!")
    endif (XERCESC_FIND_REQUIRED)
  endif (XERCESC_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    XERCESC_ROOT_DIR
    XERCESC_INCLUDES
    XERCESC_LIBRARIES
    )
  
endif (NOT XERCESC_FOUND)
