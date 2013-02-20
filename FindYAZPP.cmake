
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

# - Check for the presence of YAZPP
#
# The following variables are set when YAZPP is found:
#  YAZPP_FOUND      = Set to true, if all components of YAZPP have been found.
#  YAZPP_INCLUDES   = Include path for the header files of YAZPP
#  YAZPP_LIBRARIES  = Link these to use YAZPP
#  YAZPP_LFLAGS     = Linker flags (optional)

if (NOT YAZPP_FOUND)

  if (NOT YAZPP_ROOT_DIR)
    set (YAZPP_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT YAZPP_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (YAZPP_INCLUDES
    NAMES yazpp/z-assoc.h yazpp/z-query.h yazpp/socket-observer.h
    HINTS ${YAZPP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  set (YAZPP_LIBRARIES "")

  ## libyazpp
  find_library (YAZPP_YAZPP_LIBRARY yazpp
    HINTS ${YAZPP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (YAZPP_YAZPP_LIBRARY)
    list (APPEND YAZPP_LIBRARIES ${YAZPP_YAZPP_LIBRARY})
  endif (YAZPP_YAZPP_LIBRARY)

  ## libzoompp
  find_library (YAZPP_ZOOMPP_LIBRARY zoompp
    HINTS ${YAZPP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  if (YAZPP_ZOOMPP_LIBRARY)
    list (APPEND YAZPP_LIBRARIES ${YAZPP_ZOOMPP_LIBRARY})
  endif (YAZPP_ZOOMPP_LIBRARY)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (YAZPP_CONFIG_EXECUTABLE yazpp-config
    HINTS ${YAZPP_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  if (YAZPP_CONFIG_EXECUTABLE)
    execute_process (
      COMMAND ${YAZPP_CONFIG_EXECUTABLE} --version
      WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
      RESULT_VARIABLE YAZPP_RESULT_VARIABLE
      OUTPUT_VARIABLE YAZPP_VERSION
      ERROR_VARIABLE YAZPP_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )
  endif (YAZPP_CONFIG_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (YAZPP DEFAULT_MSG YAZPP_LIBRARIES YAZPP_INCLUDES)

  if (YAZPP_FOUND)
    if (NOT YAZPP_FIND_QUIETLY)
      message (STATUS "Found components for YAZPP")
      message (STATUS "YAZPP_ROOT_DIR  = ${YAZPP_ROOT_DIR}")
      message (STATUS "YAZPP_INCLUDES  = ${YAZPP_INCLUDES}")
      message (STATUS "YAZPP_LIBRARIES = ${YAZPP_LIBRARIES}")
    endif (NOT YAZPP_FIND_QUIETLY)
  else (YAZPP_FOUND)
    if (YAZPP_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find YAZPP!")
    endif (YAZPP_FIND_REQUIRED)
  endif (YAZPP_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    YAZPP_ROOT_DIR
    YAZPP_INCLUDES
    YAZPP_LIBRARIES
    )

endif (NOT YAZPP_FOUND)
