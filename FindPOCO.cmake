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

# - Check for the presence of POCO
#
# The following variables are set when POCO is found:
#  POCO_FOUND      = Set to true, if all components of POCO have been found.
#  POCO_INCLUDES   = Include path for the header files of POCO
#  POCO_LIBRARIES  = Link these to use POCO
#  POCO_LFLAGS     = Linker flags (optional)

if (NOT POCO_FOUND)

  if (NOT POCO_ROOT_DIR)
    set (POCO_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT POCO_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (POCO_INCLUDES
    NAMES
    Poco/Foundation.h
    Poco/Poco.h
    Poco/Version.h
    HINTS ${POCO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  foreach (_pocoLibrary
      PocoCrypto
      PocoCryptod
      PocoData
      PocoDataMySQL
      PocoDataMySQLd
      PocoDataSQLite
      PocoDataSQLited
      PocoDatad
      PocoFoundation
      PocoFoundationd
      PocoNet
      PocoNetSSL
      PocoNetSSLd
      PocoNetd
      PocoUtil
      PocoUtild
      PocoXML
      PocoXMLd
      PocoZip
      PocoZipd
      )
    
    string (TOUPPER ${_pocoLibrary} _pocoLibraryUpper)

    find_library (POCO_${_pocoLibraryUpper}_LIBRARY ${_pocoLibrary}
      HINTS ${POCO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES lib
      )

    if (POCO_${_pocoLibraryUpper}_LIBRARY)
      list (APPEND POCO_LIBRARIES ${POCO_${_pocoLibraryUpper}_LIBRARY})
    endif (POCO_${_pocoLibraryUpper}_LIBRARY)
    
  endforeach (_pocoLibrary)

  ##_____________________________________________________________________________
  ## Check for the executable

  foreach (_pocoExecutable
      f2cpspd
      f2cpsp
      cpspcd
      cpspc
      )

    string (TOUPPER ${_pocoExecutable} _pocoExecutableUpper)

    find_program (${_pocoExecutableUpper}_EXECUTABLE ${_pocoExecutable}
      HINTS ${POCO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES bin
      )

  endforeach (_pocoExecutable)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (POCO DEFAULT_MSG POCO_LIBRARIES POCO_INCLUDES)

  if (POCO_FOUND)
    if (NOT POCO_FIND_QUIETLY)
      message (STATUS "Found components for POCO")
      message (STATUS "POCO_ROOT_DIR  = ${POCO_ROOT_DIR}")
      message (STATUS "POCO_INCLUDES  = ${POCO_INCLUDES}")
      message (STATUS "POCO_LIBRARIES = ${POCO_LIBRARIES}")
    endif (NOT POCO_FIND_QUIETLY)
  else (POCO_FOUND)
    if (POCO_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find POCO!")
    endif (POCO_FIND_REQUIRED)
  endif (POCO_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    POCO_ROOT_DIR
    POCO_INCLUDES
    POCO_LIBRARIES
    )

endif (NOT POCO_FOUND)
