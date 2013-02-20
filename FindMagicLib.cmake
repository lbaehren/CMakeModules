
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

# - Check for the presence of MAGIC
#
# The following variables are set when MAGIC is found:
#  MAGIC_FOUND      = Set to true, if all components of MAGIC have been found.
#  MAGIC_INCLUDES   = Include path for the header files of MAGIC
#  MAGIC_LIBRARIES  = Link these to use MAGIC
#  MAGIC_LFLAGS     = Linker flags (optional)

if (NOT MAGIC_FOUND)
    
  if (NOT MAGIC_ROOT_DIR)
    set (MAGIC_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT MAGIC_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the header files
  
  find_path (MAGIC_INCLUDES magic.h
    HINTS ${MAGIC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )
  
  ##_____________________________________________________________________________
  ## Check for the library
  
  find_library (MAGIC_LIBRARIES magic
    HINTS ${MAGIC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (MAGIC_INCLUDES AND MAGIC_LIBRARIES)
    set (MAGIC_FOUND TRUE)
  else (MAGIC_INCLUDES AND MAGIC_LIBRARIES)
    set (MAGIC_FOUND FALSE)
    if (NOT MAGIC_FIND_QUIETLY)
      if (NOT MAGIC_INCLUDES)
	message (STATUS "Unable to find MAGIC header files!")
      endif (NOT MAGIC_INCLUDES)
      if (NOT MAGIC_LIBRARIES)
	message (STATUS "Unable to find MAGIC library files!")
      endif (NOT MAGIC_LIBRARIES)
    endif (NOT MAGIC_FIND_QUIETLY)
  endif (MAGIC_INCLUDES AND MAGIC_LIBRARIES)
  
  if (MAGIC_FOUND)
    if (NOT MAGIC_FIND_QUIETLY)
      message (STATUS "Found components for MAGIC")
      message (STATUS "MAGIC_ROOT_DIR  = ${MAGIC_ROOT_DIR}")
      message (STATUS "MAGIC_INCLUDES  = ${MAGIC_INCLUDES}")
      message (STATUS "MAGIC_LIBRARIES = ${MAGIC_LIBRARIES}")
    endif (NOT MAGIC_FIND_QUIETLY)
  else (MAGIC_FOUND)
    if (MAGIC_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find MAGIC!")
    endif (MAGIC_FIND_REQUIRED)
  endif (MAGIC_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    MAGIC_ROOT_DIR
    MAGIC_INCLUDES
    MAGIC_LIBRARIES
    )
  
endif (NOT MAGIC_FOUND)
