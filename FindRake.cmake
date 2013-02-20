
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

# - Check for the presence of RAKE
#
# The following variables are set when RAKE is found:
#  RAKE_FOUND      = Set to true, if all components of RAKE
#                         have been found.
#  RAKE_INCLUDES   = Include path for the header files of RAKE
#  RAKE_LIBRARIES  = Link these to use RAKE
#  RAKE_LFLAGS     = Linker flags (optional)

if (NOT RAKE_FOUND)
    
  if (NOT RAKE_ROOT_DIR)
    set (RAKE_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RAKE_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  find_program (RAKE_EXECUTABLE rake
    HINTS ${RAKE_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Extract program version

  if (RAKE_EXECUTABLE)

    ## Run rake to display version number
    execute_process(
      COMMAND ${RAKE_EXECUTABLE} --version
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE RAKE_RESULT_VARIABLE
      OUTPUT_VARIABLE RAKE_OUTPUT_VARIABLE
      ERROR_VARIABLE RAKE_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    ## Process output in order to extract version number. Rake returns status 0
    ## if run successfully.
    if (NOT RAKE_RESULT_VARIABLE)

      string(REGEX REPLACE "rake, version " "" RAKE_VERSION ${RAKE_OUTPUT_VARIABLE})

      if (RAKE_VERSION)
	## Convert string to list of numbers
	string (REGEX REPLACE "\\." ";" RAKE_VERSION_LIST ${RAKE_VERSION})
	## Retrieve individual elements in the list
	list(GET RAKE_VERSION_LIST 0 RAKE_VERSION_MAJOR)
	list(GET RAKE_VERSION_LIST 1 RAKE_VERSION_MINOR)
	list(GET RAKE_VERSION_LIST 2 RAKE_VERSION_PATCH)
      endif (RAKE_VERSION)
      
    endif (NOT RAKE_RESULT_VARIABLE)
    
  endif (RAKE_EXECUTABLE)
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (RAKE_EXECUTABLE)
    set (RAKE_FOUND TRUE)
  else (RAKE_EXECUTABLE)
    set (RAKE_FOUND FALSE)
    if (NOT RAKE_FIND_QUIETLY)
      if (NOT RAKE_INCLUDES)
	message (STATUS "Unable to find RAKE header files!")
      endif (NOT RAKE_INCLUDES)
      if (NOT RAKE_LIBRARIES)
	message (STATUS "Unable to find RAKE library files!")
      endif (NOT RAKE_LIBRARIES)
    endif (NOT RAKE_FIND_QUIETLY)
  endif (RAKE_EXECUTABLE)
  
  if (RAKE_FOUND)
    if (NOT RAKE_FIND_QUIETLY)
      message (STATUS "Found components for RAKE")
      message (STATUS "RAKE_ROOT_DIR   = ${RAKE_ROOT_DIR}"   )
      message (STATUS "RAKE_EXECUTABLE = ${RAKE_EXECUTABLE}" )
      message (STATUS "RAKE_VERSION    = ${RAKE_VERSION}"    )
    endif (NOT RAKE_FIND_QUIETLY)
  else (RAKE_FOUND)
    if (RAKE_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find RAKE!")
    endif (RAKE_FIND_REQUIRED)
  endif (RAKE_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    RAKE_ROOT_DIR
    RAKE_INCLUDES
    RAKE_LIBRARIES
    )
  
endif (NOT RAKE_FOUND)
