#-------------------------------------------------------------------------------
# Copyright (c) 2013-2013, Lars Baehren <lbaehren@gmail.com>
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
#-------------------------------------------------------------------------------

# - Check for the presence of ROOT
#
# The following variables are set when ROOT is found:
#  ROOT_FOUND      = Set to true, if all components of ROOT have been found.
#  ROOT_INCLUDES   = Include path for the header files of ROOT
#  ROOT_LIBRARIES  = Link these to use ROOT
#  ROOT_LFLAGS     = Linker flags (optional)

if (NOT ROOT_FOUND)

  if (NOT ROOT_ROOT_DIR)
    set (ROOT_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT ROOT_ROOT_DIR)

  ##____________________________________________________________________________
  ## Check for configuration tool

  find_program (ROOT_CONFIG_EXECUTABLE root-config
    HINTS ${ROOT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    ENV ROOTSYS
    PATH_SUFFIXES bin
    )

  if (ROOT_CONFIG_EXECUTABLE)
    ##  Root directory of installation
    execute_process (COMMAND ${ROOT_CONFIG_EXECUTABLE} --prefix
                     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                     OUTPUT_VARIABLE ROOT_ROOT_DIR
                     OUTPUT_STRIP_TRAILING_WHITESPACE
                     )
    ## Release version
    execute_process (COMMAND ${ROOT_CONFIG_EXECUTABLE} --version
                     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                     OUTPUT_VARIABLE ROOT_VERSION
                     OUTPUT_STRIP_TRAILING_WHITESPACE
                     )
    ## Available features
    execute_process (COMMAND ${ROOT_CONFIG_EXECUTABLE} --features
                     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                     OUTPUT_VARIABLE ROOT_FEATURES
                     OUTPUT_STRIP_TRAILING_WHITESPACE
                     )
  endif (ROOT_CONFIG_EXECUTABLE)

  ##____________________________________________________________________________
  ## Check for the header files

  if (ROOT_CONFIG_EXECUTABLE)
    execute_process (COMMAND ${ROOT_CONFIG_EXECUTABLE} --incdir
                     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                     RESULT_VARIABLE ROOT_CONFIG_INCDIR_RESULT
                     OUTPUT_VARIABLE ROOT_INCLUDES
                     OUTPUT_STRIP_TRAILING_WHITESPACE
                     )
  else (ROOT_CONFIG_EXECUTABLE)
    find_path (ROOT_INCLUDES
      NAMES TGlobal.h TGrid.h TObject.h
      HINTS ${ROOT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      ENV ROOTSYS
      PATH_SUFFIXES include include/root root/include
      )
  endif (ROOT_CONFIG_EXECUTABLE)

  ##____________________________________________________________________________
  ## Check for the library

  if (ROOT_CONFIG_EXECUTABLE)
    execute_process (COMMAND ${ROOT_CONFIG_EXECUTABLE} --glibs
                     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
                     OUTPUT_VARIABLE _rootLibs
                     OUTPUT_STRIP_TRAILING_WHITESPACE
                     )
    ## Convert output to list
    string (REGEX REPLACE " -l" ";" _rootLibs ${_rootLibs})
    ## ... and remove the first entry
    list (REMOVE_AT _rootLibs 0)
  else (ROOT_CONFIG_EXECUTABLE)
    set (_rootLibs Gui Core Cint RIO Net Hist Graf Graf3d Gpad Tree Rint Postscript Matrix Physics MathCore Thread)
  endif (ROOT_CONFIG_EXECUTABLE)

  foreach (_lib ${_rootLibs})
    message (STATUS "Searching for ${_lib} ...")
    ## Convert to upper-case
    string (TOUPPER ${_lib} _libUpper)
    ## Search for library
    find_library (ROOT_${_libUpper}_LIBRARY ${_libUpper}
      HINTS ${ROOT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES lib lib/root root/lib
      )
    ## Add individual library to overall list
    if (ROOT_${_libUpper}_LIBRARY)
      list (APPEND ROOT_LIBRARIES ${ROOT_${_libUpper}_LIBRARY})
    endif (ROOT_${_libUpper}_LIBRARY)
  endforeach (_lib)

  ##____________________________________________________________________________
  ## Check for the executables

  find_program (ROOT_EXECUTABLE root
    HINTS ${ROOT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (ROOT DEFAULT_MSG ROOT_LIBRARIES ROOT_INCLUDES)

  if (ROOT_FOUND)
    if (NOT ROOT_FIND_QUIETLY)
      message (STATUS "Found components for ROOT")
      message (STATUS "ROOT_VERSION   = ${ROOT_VERSION}")
      message (STATUS "ROOT_ROOT_DIR  = ${ROOT_ROOT_DIR}")
      message (STATUS "ROOT_INCLUDES  = ${ROOT_INCLUDES}")
      message (STATUS "ROOT_LIBRARIES = ${ROOT_LIBRARIES}")
      message (STATUS "ROOT_FEATURES  = ${ROOT_FEATURES}")
    endif (NOT ROOT_FIND_QUIETLY)
  else (ROOT_FOUND)
    if (ROOT_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find ROOT!")
    endif (ROOT_FIND_REQUIRED)
  endif (ROOT_FOUND)

  ##____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    ROOT_ROOT_DIR
    ROOT_INCLUDES
    ROOT_LIBRARIES
    ROOT_FEATURES
    )

endif (NOT ROOT_FOUND)
