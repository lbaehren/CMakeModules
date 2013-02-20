
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

# - Check for the presence of YARD
#
# The following variables are set when YARD is found:
#  YARD_FOUND      = Set to true, if all components of YARD
#                         have been found.
#  YARD_INCLUDES   = Include path for the header files of YARD
#  YARD_LIBRARIES  = Link these to use YARD
#  YARD_LFLAGS     = Linker flags (optional)

if (NOT YARD_FOUND)

  if (NOT YARD_ROOT_DIR)
    set (YARD_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT YARD_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (YARD_EXECUTABLE yard
    HINTS ${YARD_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Extract program version

  if (YARD_EXECUTABLE)

    ## Run yard to display version number
    execute_process(
      COMMAND ${YARD_EXECUTABLE} --version
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE YARD_RESULT_VARIABLE
      OUTPUT_VARIABLE YARD_OUTPUT_VARIABLE
      ERROR_VARIABLE YARD_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    ## Process output in order to extract version number. Yard returns status 0
    ## if run successfully.
    if (NOT YARD_RESULT_VARIABLE)

      string(REGEX REPLACE "yard " "" YARD_VERSION ${YARD_OUTPUT_VARIABLE})

      if (YARD_VERSION)
	## Convert string to list of numbers
	string (REGEX REPLACE "\\." ";" YARD_VERSION_LIST ${YARD_VERSION})
	## Retrieve individual elements in the list
	list(GET YARD_VERSION_LIST 0 YARD_VERSION_MAJOR)
	list(GET YARD_VERSION_LIST 1 YARD_VERSION_MINOR)
	list(GET YARD_VERSION_LIST 2 YARD_VERSION_PATCH)
      endif (YARD_VERSION)

    endif (NOT YARD_RESULT_VARIABLE)

  endif (YARD_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (YARD DEFAULT_MSG YARD_LIBRARIES YARD_INCLUDES)

  if (YARD_FOUND)
    if (NOT YARD_FIND_QUIETLY)
      message (STATUS "Found components for YARD")
      message (STATUS "YARD_ROOT_DIR  = ${YARD_ROOT_DIR}")
      message (STATUS "YARD_INCLUDES  = ${YARD_INCLUDES}")
      message (STATUS "YARD_LIBRARIES = ${YARD_LIBRARIES}")
    endif (NOT YARD_FIND_QUIETLY)
  else (YARD_FOUND)
    if (YARD_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find YARD!")
    endif (YARD_FIND_REQUIRED)
  endif (YARD_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    YARD_ROOT_DIR
    YARD_INCLUDES
    YARD_LIBRARIES
    )

endif (NOT YARD_FOUND)
