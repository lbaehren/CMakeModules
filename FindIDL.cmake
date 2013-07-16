
#-------------------------------------------------------------------------------
# Copyright (c) 2012-2013, Michael Galloy <mgalloy@gmail.com>
# Copyright (c) 2013, Lars Baehren <lbaehren@gmail.com>
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

# NAME:
#   FindIDL.cmake - Module to find the IDL distribution.
#
# SYNOPSIS:
#   find_package (IDL ...)
#
# Specify IDL_ROOT_DIR to indicate the location of an IDL distribution.
#
# This module will define the following variables:
#   IDL_FOUND           = whether IDL was found
#   IDL_VERSION         = IDL release version
#   IDL_PLATFORM_EXT    = DLM extension, i.e., darwin.x86_64, linux.x86, x86_64...
#   IDL_INCLUDES        = IDL include directory
#   IDL_LIBRARIES       = IDL shared library location
#   IDL_LIBRARY_PATH    = IDL shared library directory
#   IDL_EXECUTABLE      = IDL command
#   IDL_PATH_SEP        = character to separate IDL paths

if (NOT IDL_FOUND)

  if (NOT IDL_ROOT_DIR)
    set (IDL_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT IDL_ROOT_DIR)

  ##____________________________________________________________________________
  ## Platform-dependent base settings

  if ("${CMAKE_SYSTEM_NAME}" STREQUAL "Windows")
      set (_Idl_PROGRAM_FILES_DIR "C:/Program Files")
      set (_Idl_NAME "IDL")
      set (_IDL_OS "")
      set (_Idl_KNOWN_COMPANIES "Exelis" "ITT")
      set (IDL_PATH_SEP ";")
  elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL "CYGWIN")
      set (_Idl_PROGRAM_FILES_DIR "/cygdrive/c/Program Files")
      set (_Idl_NAME "IDL")
      set (_IDL_OS "")
      set (_Idl_KNOWN_COMPANIES "Exelis" "ITT")
      set (IDL_PATH_SEP ";")
      # Cygwin assumes Linux conventions, but IDL is a Windows application
      set (CMAKE_FIND_LIBRARY_SUFFIXES ".lib")
      set (CMAKE_FIND_LIBRARY_PREFIXES "")
  elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL "Darwin")
      set (_Idl_PROGRAM_FILES_DIR "/Applications")
      set (_Idl_NAME "idl")
      set (_IDL_OS "darwin.")
      set (_Idl_KNOWN_COMPANIES "exelis" "itt")
      set (IDL_PATH_SEP ":")
  elseif ("${CMAKE_SYSTEM_NAME}" STREQUAL "Linux")
      set (_Idl_PROGRAM_FILES_DIR "/usr/local")
      set (_Idl_NAME "idl")
      set (_IDL_OS "linux.")
      set (_Idl_KNOWN_COMPANIES "exelis" "itt")
      set (IDL_PATH_SEP ":")
  endif ()

  ## 32 vs. 64 bit
  if ("${CMAKE_SIZEOF_VOID_P}" STREQUAL "4")
      set(IDL_BIN_EXT "x86")
  elseif ("${CMAKE_SIZEOF_VOID_P}" STREQUAL "8")
      set(IDL_BIN_EXT "x86_64")
  else ()
      set (IDL_BIN_EXT "unknown")
  endif ()

  set (IDL_PLATFORM_EXT "${_IDL_OS}${IDL_BIN_EXT}")

  ##____________________________________________________________________________
  ## Find IDL based on version numbers; if you want a specific one, set
  ## it prior to running configure ('IDL_FIND_VERSION')

  if (NOT DEFINED IDL_FIND_VERSION)
      set(_Idl_KNOWN_VERSIONS "82" "81" "80" "71" "706")
      ## IDL 8.0 is in a different location than other versions on Windows
      ## (extra IDL directory in path)
      foreach (_Idl_COMPANY ${_Idl_KNOWN_COMPANIES})
          list(APPEND 
              _Idl_SEARCH_DIRS
              "${_Idl_PROGRAM_FILES_DIR}/${_Idl_COMPANY}/${_Idl_NAME}/${_Idl_NAME}80")
          list(APPEND 
              _Idl_SEARCH_DIRS
              "${_Idl_PROGRAM_FILES_DIR}/${_Idl_COMPANY}/${_Idl_NAME}/${_Idl_NAME}81")
          foreach (_Idl_KNOWN_VERSION ${_Idl_KNOWN_VERSIONS})
              list(APPEND _Idl_SEARCH_DIRS
                  "${_Idl_PROGRAM_FILES_DIR}/${_Idl_COMPANY}/${_Idl_NAME}${_Idl_KNOWN_VERSION}")
          endforeach (_Idl_KNOWN_VERSION ${_Idl_KNOWN_VERSIONS})
      endforeach (_Idl_COMPANY ${_Idl_KNOWN_COMPANIES})
  endif ()
  
  if (NOT "$ENV{IDL_DIR}" STREQUAL "")
      set(_Idl_SEARCH_DIRS "$ENV{IDL_DIR}")
  endif ()

  ##____________________________________________________________________________
  ## Check for the header files

  find_path (IDL_INCLUDES
    NAMES idl_export.h
    HINTS ${IDL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATHS ${_Idl_SEARCH_DIRS}
    PATH_SUFFIXES include external/include
    )

  ##____________________________________________________________________________
  ## Check for the library

  find_library (IDL_LIBRARIES idl
    HINTS ${IDL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATHS ${_Idl_SEARCH_DIRS}
    PATH_SUFFIXES lib bin/bin.${IDL_PLATFORM_EXT}
    )

  get_filename_component (Idl_LIBRARY_PATH "${IDL_LIBRARIES}" PATH)

  ##____________________________________________________________________________
  ## Check for the executable

  find_program (IDL_EXECUTABLE idl${CMAKE_EXECUTABLE_SUFFIX}
    HINTS ${IDL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATHS ${_Idl_SEARCH_DIRS}
    PATH_SUFFIXES bin bin/bin.${IDL_BIN_EXT}
    )

  ##____________________________________________________________________________
  ## Extract version number:
  ## An IDL version number consists of three fields: x.y.z, where the first
  ## is the major version number, the second is the minor number, and the
  ## third is the sub-release number (used primarily for bug fix releases).

  get_filename_component(IDL_ROOT_DIR "${IDL_INCLUDES}/../.." ABSOLUTE)

  if (IDL_INCLUDES)

      set (_testIDLVersion ${CMAKE_CURRENT_BINARY_DIR}/TestIDLVersion.c)

      file (WRITE  ${_testIDLVersion} "#include <stdio.h>\n")
      file (APPEND ${_testIDLVersion} "#include <idl_export.h>\n")
      file (APPEND ${_testIDLVersion} "int main ()\n")
      file (APPEND ${_testIDLVersion} "{\n")
      file (APPEND ${_testIDLVersion} "  printf (\"%i;%i;%i\", IDL_VERSION_MAJOR, IDL_VERSION_MINOR, IDL_VERSION_SUB);\n")
      file (APPEND ${_testIDLVersion} "  return 0;\n")
      file (APPEND ${_testIDLVersion} "}\n")

      try_run (run_TestIDL compile_TestIDL
          ${CMAKE_CURRENT_BINARY_DIR}
          ${_testIDLVersion}
          CMAKE_FLAGS -DINCLUDE_DIRECTORIES=${IDL_INCLUDES} -DLINK_LIBRARIES=${IDL_LIBRARIES}
          COMPILE_OUTPUT_VARIABLE IDL_VERSION_COMPILE_OUTPUT
          RUN_OUTPUT_VARIABLE IDL_VERSION
          )

  endif (IDL_INCLUDES)

  if (IDL_VERSION)
      list (GET IDL_VERSION 0 IDL_VERSION_MAJOR)
      list (GET IDL_VERSION 1 IDL_VERSION_MINOR)
      list (GET IDL_VERSION 2 IDL_VERSION_SUB)
      set (IDL_VERSION "${IDL_VERSION_MAJOR}.${IDL_VERSION_MINOR}.${IDL_VERSION_SUB}")
  else (IDL_VERSION)
      find_file (IDL_VERSION_TXT version.txt
          HINTS ${IDL_ROOT_DIR}
          )
      if (IDL_VERSION_TXT)
          file (READ "${IDL_VERSION_TXT}" _IDL_VERSION)
          string (STRIP "${_IDL_VERSION}" IDL_VERSION)
      endif (IDL_VERSION_TXT)
  endif (IDL_VERSION)

  ##____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (IDL DEFAULT_MSG IDL_LIBRARIES IDL_INCLUDES)

  if (IDL_FOUND)
    if (NOT IDL_FIND_QUIETLY)
      message (STATUS "Found components for IDL")
      message (STATUS "IDL_VERSION    = ${IDL_VERSION}")
      message (STATUS "IDL_ROOT_DIR   = ${IDL_ROOT_DIR}")
      message (STATUS "IDL_EXECUTABLE = ${IDL_EXECUTABLE}")
      message (STATUS "IDL_INCLUDES   = ${IDL_INCLUDES}")
      message (STATUS "IDL_LIBRARIES  = ${IDL_LIBRARIES}")
    endif (NOT IDL_FIND_QUIETLY)
  else (IDL_FOUND)
    if (IDL_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find IDL!")
    endif (IDL_FIND_REQUIRED)
  endif (IDL_FOUND)

  ##____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    IDL_ROOT_DIR
    IDL_INCLUDES
    IDL_LIBRARIES
    )

endif (NOT IDL_FOUND)
