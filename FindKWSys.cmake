
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

# - Check for the presence of KWSYS
#
# The following variables are set when KWSYS is found:
#  KWSYS_FOUND      = Set to true, if all components of KWSYS have been found.
#  KWSYS_INCLUDES   = Include path for the header files of KWSYS
#  KWSYS_LIBRARIES  = Link these to use KWSYS
#  KWSYS_LFLAGS     = Linker flags (optional)

if (NOT KWSYS_FOUND)

  if (NOT KWSYS_ROOT_DIR)
    set (KWSYS_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT KWSYS_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (KWSYS_INCLUDES kwsys/SystemTools.hxx kwsys/SystemInformation.hxx
    HINTS ${KWSYS_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (KWSYS_KWSYS_LIBRARY kwsys
    HINTS ${KWSYS_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (KWSYS_KWSYS_LIBRARY)
    list (APPEND KWSYS_LIBRARIES ${KWSYS_KWSYS_LIBRARY})
  endif (KWSYS_KWSYS_LIBRARY)

  find_library (KWSYS_KWSYS_C_LIBRARY kwsys_c
    HINTS ${KWSYS_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (KWSYS_KWSYS_C_LIBRARY)
    list (APPEND KWSYS_LIBRARIES ${KWSYS_KWSYS_C_LIBRARY})
  endif (KWSYS_KWSYS_C_LIBRARY)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (KWSYS_INCLUDES AND KWSYS_LIBRARIES)
    set (KWSYS_FOUND TRUE)
  else (KWSYS_INCLUDES AND KWSYS_LIBRARIES)
    set (KWSYS_FOUND FALSE)
    if (NOT KWSYS_FIND_QUIETLY)
      if (NOT KWSYS_INCLUDES)
	message (STATUS "Unable to find KWSYS header files!")
      endif (NOT KWSYS_INCLUDES)
      if (NOT KWSYS_LIBRARIES)
	message (STATUS "Unable to find KWSYS library files!")
      endif (NOT KWSYS_LIBRARIES)
    endif (NOT KWSYS_FIND_QUIETLY)
  endif (KWSYS_INCLUDES AND KWSYS_LIBRARIES)

  if (KWSYS_FOUND)
    if (NOT KWSYS_FIND_QUIETLY)
      message (STATUS "Found components for KWSYS")
      message (STATUS "KWSYS_ROOT_DIR  = ${KWSYS_ROOT_DIR}")
      message (STATUS "KWSYS_INCLUDES  = ${KWSYS_INCLUDES}")
      message (STATUS "KWSYS_LIBRARIES = ${KWSYS_LIBRARIES}")
    endif (NOT KWSYS_FIND_QUIETLY)
  else (KWSYS_FOUND)
    if (KWSYS_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find KWSYS!")
    endif (KWSYS_FIND_REQUIRED)
  endif (KWSYS_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    KWSYS_ROOT_DIR
    KWSYS_INCLUDES
    KWSYS_LIBRARIES
    )

endif (NOT KWSYS_FOUND)
