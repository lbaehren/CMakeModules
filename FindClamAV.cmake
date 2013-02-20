
#--------------------------------------------------------------------------------
# Copyright (c) 2012-2013, Lars Baehren <lbaehren@gmail.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification,
# are permitted provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#--------------------------------------------------------------------------------

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
