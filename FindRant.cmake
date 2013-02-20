
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

# - Check for the presence of RANT
#
# The following variables are set when RANT is found:
#  RANT_FOUND      = Set to true, if all components of RANT
#                         have been found.
#  RANT_INCLUDES   = Include path for the header files of RANT
#  RANT_LIBRARIES  = Link these to use RANT
#  RANT_LFLAGS     = Linker flags (optional)

if (NOT RANT_FOUND)
    
  if (NOT RANT_ROOT_DIR)
    set (RANT_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RANT_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  find_program (RANT_EXECUTABLE rant
    HINTS ${RANT_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Extract program version

  find_file (RANT_INIT_RB rant/init.rb
    HINTS ${RANT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES
    lib/ruby
    lib/ruby/site_ruby/${REQUIRED_VERSION_RUBY}
    )

  if (RANT_INIT_RB)
    file (STRINGS ${RANT_INIT_RB} _rantVersion
      REGEX "VERSION ="
      )
    string (REGEX MATCH "[0-9]+.[0-9]+.[0-9]" RANT_VERSION ${_rantVersion})
  endif (RANT_INIT_RB)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (RANT_EXECUTABLE)
    set (RANT_FOUND TRUE)
  else (RANT_EXECUTABLE)
    set (RANT_FOUND FALSE)
    if (NOT RANT_FIND_QUIETLY)
      if (NOT RANT_INCLUDES)
	message (STATUS "Unable to find RANT header files!")
      endif (NOT RANT_INCLUDES)
      if (NOT RANT_LIBRARIES)
	message (STATUS "Unable to find RANT library files!")
      endif (NOT RANT_LIBRARIES)
    endif (NOT RANT_FIND_QUIETLY)
  endif (RANT_EXECUTABLE)
  
  if (RANT_FOUND)
    if (NOT RANT_FIND_QUIETLY)
      message (STATUS "Found components for RANT")
      message (STATUS "RANT_ROOT_DIR   = ${RANT_ROOT_DIR}"   )
      message (STATUS "RANT_EXECUTABLE = ${RANT_EXECUTABLE}" )
      message (STATUS "RANT_VERSION    = ${RANT_VERSION}"    )
    endif (NOT RANT_FIND_QUIETLY)
  else (RANT_FOUND)
    if (RANT_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find RANT!")
    endif (RANT_FIND_REQUIRED)
  endif (RANT_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    RANT_ROOT_DIR
    RANT_INCLUDES
    RANT_LIBRARIES
    )
  
endif (NOT RANT_FOUND)
