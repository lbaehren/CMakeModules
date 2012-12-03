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

# - Check for the presence of CLAMAV
#
# The following variables are set when CLAMAV is found:
#  CLAMAV_FOUND      = Set to true, if all components of CLAMAV have been found.
#  CLAMAV_INCLUDES   = Include path for the header files of CLAMAV
#  CLAMAV_LIBRARIES  = Link these to use CLAMAV
#  CLAMAV_LFLAGS     = Linker flags (optional)

if (NOT CLAMAV_FOUND)

  if (NOT CLAMAV_ROOT_DIR)
    set (CLAMAV_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT CLAMAV_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (CLAMAV_INCLUDES clamav.h
    HINTS ${CLAMAV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/clamav
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (CLAMAV_CLAMAV_LIBRARY clamav
    HINTS ${CLAMAV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib lib/x86_64
    )
  if (CLAMAV_CLAMAV_LIBRARY)
    list (APPEND CLAMAV_LIBRARIES ${CLAMAV_CLAMAV_LIBRARY})
  endif (CLAMAV_CLAMAV_LIBRARY)

  find_library (CLAMAV_CLAMUNRAR_IFACE_LIBRARY clamunrar_iface
    HINTS ${CLAMAV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib lib/x86_64
    )
  if (CLAMAV_CLAMUNRAR_IFACE_LIBRARY)
    list (APPEND CLAMAV_LIBRARIES ${CLAMAV_CLAMUNRAR_IFACE_LIBRARY})
  endif (CLAMAV_CLAMUNRAR_IFACE_LIBRARY)

  find_library (CLAMAV_CLAMUNRAR_LIBRARY clamunrar
    HINTS ${CLAMAV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib lib/x86_64
    )
  if (CLAMAV_CLAMUNRAR_LIBRARY)
    list (APPEND CLAMAV_LIBRARIES ${CLAMAV_CLAMUNRAR_LIBRARY})
  endif (CLAMAV_CLAMUNRAR_LIBRARY)

  ##_____________________________________________________________________________
  ## Check for the executables

  find_program (CLAMAV_CONFIG_EXECUTABLE clamav-config
    HINTS ${CLAMAV_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  foreach (clamavProgram
      clambc
      clamconf
      clamdscan
      clamdtop
      clamscan
      freshclam
      sigtool
      )

    ## Conversion to upper case
    string (TOUPPER ${clamavProgram} clamavVar)

    ## Search for executable
    find_program (CLAMAV_${clamavVar}_EXECUTABLE ${clamavProgram}
      HINTS ${CLAMAV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES bin
      )

  endforeach (clamavProgram)

  ##_____________________________________________________________________________
  ## Check for the virus signature collections

  find_file (CLAMAV_BYTECODE_CVD bytecode.cvd
    HINTS ${CLAMAV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES etc etc/clamav share share/clamav
    )

  find_file (CLAMAV_DAILY_CVD daily.cvd
    HINTS ${CLAMAV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES etc etc/clamav share share/clamav
    )

  find_file (CLAMAV_MAIN_CVD main.cvd
    HINTS ${CLAMAV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES etc etc/clamav share share/clamav
    )

  find_file (CLAMAV_MIRRORS_DAT mirrors.dat
    HINTS ${CLAMAV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES etc etc/clamav share share/clamav
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (CLAMAV_INCLUDES AND CLAMAV_LIBRARIES)
    set (CLAMAV_FOUND TRUE)
  else (CLAMAV_INCLUDES AND CLAMAV_LIBRARIES)
    set (CLAMAV_FOUND FALSE)
    if (NOT CLAMAV_FIND_QUIETLY)
      if (NOT CLAMAV_INCLUDES)
	message (STATUS "Unable to find CLAMAV header files!")
      endif (NOT CLAMAV_INCLUDES)
      if (NOT CLAMAV_LIBRARIES)
	message (STATUS "Unable to find CLAMAV library files!")
      endif (NOT CLAMAV_LIBRARIES)
    endif (NOT CLAMAV_FIND_QUIETLY)
  endif (CLAMAV_INCLUDES AND CLAMAV_LIBRARIES)

  if (CLAMAV_FOUND)
    if (NOT CLAMAV_FIND_QUIETLY)
      message (STATUS "Found components for CLAMAV")
      message (STATUS "CLAMAV_ROOT_DIR     = ${CLAMAV_ROOT_DIR}")
      message (STATUS "CLAMAV_INCLUDES     = ${CLAMAV_INCLUDES}")
      message (STATUS "CLAMAV_LIBRARIES    = ${CLAMAV_LIBRARIES}")
      message (STATUS "CLAMAV_BYTECODE_CVD = ${CLAMAV_BYTECODE_CVD}")
      message (STATUS "CLAMAV_DAILY_CVD    = ${CLAMAV_DAILY_CVD}")
      message (STATUS "CLAMAV_MAIN_CVD     = ${CLAMAV_MAIN_CVD}")
      message (STATUS "CLAMAV_MIRRORS_DAT  = ${CLAMAV_MIRRORS_DAT}")
    endif (NOT CLAMAV_FIND_QUIETLY)
  else (CLAMAV_FOUND)
    if (CLAMAV_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find CLAMAV!")
    endif (CLAMAV_FIND_REQUIRED)
  endif (CLAMAV_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    CLAMAV_ROOT_DIR
    CLAMAV_INCLUDES
    CLAMAV_CLAMAV_LIBRARY
    CLAMAV_LIBRARIES
    CLAMAV_CLAMBC_EXECUTABLE
    CLAMAV_CLAMCONF_EXECUTABLE
    CLAMAV_CLAMDSCAN_EXECUTABLE
    CLAMAV_BYTECODE_CVD
    CLAMAV_DAILY_CVD
    CLAMAV_MAIN_CVD
    CLAMAV_MIRRORS_DAT
    )

endif (NOT CLAMAV_FOUND)
