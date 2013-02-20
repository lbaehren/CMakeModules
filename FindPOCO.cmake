
#--------------------------------------------------------------------------------
# Copyright (c) 2013, Lars Baehren <lbaehren@gmail.com>
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
