
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

# - Check for the presence of RDOC
#
# The following variables are set when RDOC is found:
#  RDOC_FOUND      = Set to true, if all components of RDOC
#                         have been found.
#  RDOC_INCLUDES   = Include path for the header files of RDOC
#  RDOC_LIBRARIES  = Link these to use RDOC
#  RDOC_LFLAGS     = Linker flags (optional)

if (NOT RDOC_FOUND)
    
  if (NOT RDOC_ROOT_DIR)
    set (RDOC_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RDOC_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  find_program (RDOC_EXECUTABLE rdoc
    HINTS ${RDOC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Extract program version

  if (RDOC_EXECUTABLE)
    ## Run rdoc to display version number
    execute_process(
      COMMAND ${RDOC_EXECUTABLE} --version
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE RDOC_RESULT_VARIABLE
      OUTPUT_VARIABLE RDOC_OUTPUT_VARIABLE
      ERROR_VARIABLE RDOC_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )
    ## Process output in order to extract version number. Rdoc returns status 0
    ## if run successfully.
    if (NOT RDOC_RESULT_VARIABLE)
      string(REGEX REPLACE "rdoc " "" RDOC_VERSION ${RDOC_OUTPUT_VARIABLE})
      string(REGEX REPLACE "RDoc " "" RDOC_VERSION ${RDOC_VERSION})
    endif (NOT RDOC_RESULT_VARIABLE)
  endif (RDOC_EXECUTABLE)
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (RDOC_EXECUTABLE)
    set (RDOC_FOUND TRUE)
  else (RDOC_EXECUTABLE)
    set (RDOC_FOUND FALSE)
    if (NOT RDOC_FIND_QUIETLY)
      if (NOT RDOC_INCLUDES)
	message (STATUS "Unable to find RDOC header files!")
      endif (NOT RDOC_INCLUDES)
      if (NOT RDOC_LIBRARIES)
	message (STATUS "Unable to find RDOC library files!")
      endif (NOT RDOC_LIBRARIES)
    endif (NOT RDOC_FIND_QUIETLY)
  endif (RDOC_EXECUTABLE)
  
  if (RDOC_FOUND)
    if (NOT RDOC_FIND_QUIETLY)
      message (STATUS "Found components for RDOC")
      message (STATUS "RDOC_ROOT_DIR   = ${RDOC_ROOT_DIR}"   )
      message (STATUS "RDOC_EXECUTABLE = ${RDOC_EXECUTABLE}" )
      message (STATUS "RDOC_VERSION    = ${RDOC_VERSION}"    )
    endif (NOT RDOC_FIND_QUIETLY)
  else (RDOC_FOUND)
    if (RDOC_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find RDOC!")
    endif (RDOC_FIND_REQUIRED)
  endif (RDOC_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    RDOC_ROOT_DIR
    RDOC_INCLUDES
    RDOC_LIBRARIES
    )
  
endif (NOT RDOC_FOUND)
