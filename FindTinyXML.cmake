
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

# - Check for the presence of TINYXML
#
# The following variables are set when TINYXML is found:
#  TINYXML_FOUND      = Set to true, if all components of TINYXML have been found.
#  TINYXML_INCLUDES   = Include path for the header files of TINYXML
#  TINYXML_LIBRARIES  = Link these to use TINYXML
#  TINYXML_LFLAGS     = Linker flags (optional)

if (NOT TINYXML_FOUND)

  if (NOT TINYXML_ROOT_DIR)
    set (TINYXML_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT TINYXML_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (TINYXML_INCLUDES
    NAMES tinyxml2.h
    HINTS ${TINYXML_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (TINYXML_LIBRARIES
    NAMES libtinyxml.a libtinyxml2.a tinyxml2
    HINTS ${TINYXML_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (TINYXML_INCLUDES AND TINYXML_LIBRARIES)
    set (TINYXML_FOUND TRUE)
  else (TINYXML_INCLUDES AND TINYXML_LIBRARIES)
    set (TINYXML_FOUND FALSE)
    if (NOT TINYXML_FIND_QUIETLY)
      if (NOT TINYXML_INCLUDES)
	message (STATUS "Unable to find TINYXML header files!")
      endif (NOT TINYXML_INCLUDES)
      if (NOT TINYXML_LIBRARIES)
	message (STATUS "Unable to find TINYXML library files!")
      endif (NOT TINYXML_LIBRARIES)
    endif (NOT TINYXML_FIND_QUIETLY)
  endif (TINYXML_INCLUDES AND TINYXML_LIBRARIES)

  if (TINYXML_FOUND)
    if (NOT TINYXML_FIND_QUIETLY)
      message (STATUS "Found components for TINYXML")
      message (STATUS "TINYXML_ROOT_DIR  = ${TINYXML_ROOT_DIR}")
      message (STATUS "TINYXML_INCLUDES  = ${TINYXML_INCLUDES}")
      message (STATUS "TINYXML_LIBRARIES = ${TINYXML_LIBRARIES}")
    endif (NOT TINYXML_FIND_QUIETLY)
  else (TINYXML_FOUND)
    if (TINYXML_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find TINYXML!")
    endif (TINYXML_FIND_REQUIRED)
  endif (TINYXML_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    TINYXML_ROOT_DIR
    TINYXML_INCLUDES
    TINYXML_LIBRARIES
    )

endif (NOT TINYXML_FOUND)
