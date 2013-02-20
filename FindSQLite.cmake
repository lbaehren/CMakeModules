
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

# - Check for the presence of SQLITE
#
# The following variables are set when SQLITE is found:
#  SQLITE_FOUND      = Set to true, if all components of SQLITE have been found.
#  SQLITE_INCLUDES   = Include path for the header files of SQLITE
#  SQLITE_LIBRARIES  = Link these to use SQLITE
#  SQLITE_LFLAGS     = Linker flags (optional)

if (NOT SQLITE_FOUND)
    
  if (NOT SQLITE_ROOT_DIR)
    set (SQLITE_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT SQLITE_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files
  
  find_path (SQLITE_INCLUDES sqlite3.h sqlite3ext.h
    HINTS ${SQLITE_ROOT_DIR}
    PATH_SUFFIXES include
    )
  
  ##_____________________________________________________________________________
  ## Check for the library
  
  find_library (SQLITE_LIBRARIES sqlite3
    HINTS ${SQLITE_ROOT_DIR}
    PATH_SUFFIXES lib
    )
  
  ##_____________________________________________________________________________
  ## Check for the program executables
  
  find_program (SQLITE_LIBRARIES sqlite3
    HINTS ${SQLITE_ROOT_DIR}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (SQLITE_INCLUDES AND SQLITE_LIBRARIES)
    set (SQLITE_FOUND TRUE)
  else (SQLITE_INCLUDES AND SQLITE_LIBRARIES)
    set (SQLITE_FOUND FALSE)
    if (NOT SQLITE_FIND_QUIETLY)
      if (NOT SQLITE_INCLUDES)
	message (STATUS "Unable to find SQLITE header files!")
      endif (NOT SQLITE_INCLUDES)
      if (NOT SQLITE_LIBRARIES)
	message (STATUS "Unable to find SQLITE library files!")
      endif (NOT SQLITE_LIBRARIES)
    endif (NOT SQLITE_FIND_QUIETLY)
  endif (SQLITE_INCLUDES AND SQLITE_LIBRARIES)
  
  if (SQLITE_FOUND)
    if (NOT SQLITE_FIND_QUIETLY)
      message (STATUS "Found components for SQLITE")
      message (STATUS "SQLITE_ROOT_DIR  = ${SQLITE_ROOT_DIR}")
      message (STATUS "SQLITE_INCLUDES  = ${SQLITE_INCLUDES}")
      message (STATUS "SQLITE_LIBRARIES = ${SQLITE_LIBRARIES}")
    endif (NOT SQLITE_FIND_QUIETLY)
  else (SQLITE_FOUND)
    if (SQLITE_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find SQLITE!")
    endif (SQLITE_FIND_REQUIRED)
  endif (SQLITE_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    SQLITE_INCLUDES
    SQLITE_LIBRARIES
    )
  
endif (NOT SQLITE_FOUND)
