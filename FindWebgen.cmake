
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

# - Check for the presence of WEBGEN
#
# The following variables are set when WEBGEN is found:
#  WEBGEN_FOUND      = Set to true, if all components of WEBGEN have been found.
#  WEBGEN_INCLUDES   = Include path for the header files of WEBGEN
#  WEBGEN_LIBRARIES  = Link these to use WEBGEN
#  WEBGEN_LFLAGS     = Linker flags (optional)

if (NOT WEBGEN_FOUND)

  if (NOT WEBGEN_ROOT_DIR)
    set (WEBGEN_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT WEBGEN_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (WEBGEN_EXECUTABLE webgen
    HINTS ${WEBGEN_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Extract program version

  if (WEBGEN_EXECUTABLE)

    ## Run webgen to display version number
    execute_process(
      COMMAND ${WEBGEN_EXECUTABLE} --version
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE WEBGEN_RESULT_VARIABLE
      OUTPUT_VARIABLE WEBGEN_OUTPUT_VARIABLE
      ERROR_VARIABLE WEBGEN_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    ## Process output in order to extract version number. Webgen returns status 0
    ## if run successfully.
    if (NOT WEBGEN_RESULT_VARIABLE)

      string(REGEX REPLACE "webgen " "" WEBGEN_VERSION ${WEBGEN_OUTPUT_VARIABLE})

      if (WEBGEN_VERSION)
	## Convert string to list of numbers
	string (REGEX REPLACE "\\." ";" WEBGEN_VERSION_LIST ${WEBGEN_VERSION})
	## Retrieve individual elements in the list
	list(GET WEBGEN_VERSION_LIST 0 WEBGEN_VERSION_MAJOR)
	list(GET WEBGEN_VERSION_LIST 1 WEBGEN_VERSION_MINOR)
	list(GET WEBGEN_VERSION_LIST 2 WEBGEN_VERSION_PATCH)
      endif (WEBGEN_VERSION)

    endif (NOT WEBGEN_RESULT_VARIABLE)

  endif (WEBGEN_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (WEBGEN_EXECUTABLE)
    set (WEBGEN_FOUND TRUE)
  else (WEBGEN_EXECUTABLE)
    set (WEBGEN_FOUND FALSE)
    if (NOT WEBGEN_FIND_QUIETLY)
      if (NOT WEBGEN_INCLUDES)
	message (STATUS "Unable to find Webgen header files!")
      endif (NOT WEBGEN_INCLUDES)
      if (NOT WEBGEN_LIBRARIES)
	message (STATUS "Unable to find Webgen library files!")
      endif (NOT WEBGEN_LIBRARIES)
    endif (NOT WEBGEN_FIND_QUIETLY)
  endif (WEBGEN_EXECUTABLE)

  if (WEBGEN_FOUND)
    if (NOT WEBGEN_FIND_QUIETLY)
      message (STATUS "Found components for Webgen")
      message (STATUS "WEBGEN_ROOT_DIR   = ${WEBGEN_ROOT_DIR}"   )
      message (STATUS "WEBGEN_EXECUTABLE = ${WEBGEN_EXECUTABLE}" )
      message (STATUS "WEBGEN_VERSION    = ${WEBGEN_VERSION}"    )
    endif (NOT WEBGEN_FIND_QUIETLY)
  else (WEBGEN_FOUND)
    if (WEBGEN_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find Webgen!")
    endif (WEBGEN_FIND_REQUIRED)
  endif (WEBGEN_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    WEBGEN_ROOT_DIR
    WEBGEN_INCLUDES
    WEBGEN_LIBRARIES
    )

endif (NOT WEBGEN_FOUND)
