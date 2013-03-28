
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

# - Check for the presence of <PACKAGE>
#
# The following variables are set when <PACKAGE> is found:
#  <PACKAGE>_FOUND      = Set to true, if all components of <PACKAGE> have been found.
#  <PACKAGE>_INCLUDES   = Include path for the header files of <PACKAGE>
#  <PACKAGE>_LIBRARIES  = Link these to use <PACKAGE>
#  <PACKAGE>_LFLAGS     = Linker flags (optional)

if (NOT <PACKAGE>_FOUND)

  if (NOT <PACKAGE>_ROOT_DIR)
    set (<PACKAGE>_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT <PACKAGE>_ROOT_DIR)

  ##____________________________________________________________________________
  ## Check for the header files

  find_path (<PACKAGE>_INCLUDES
    NAMES <header file(s)>
    HINTS ${<PACKAGE>_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##____________________________________________________________________________
  ## Check for the library

  find_library (<PACKAGE>_LIBRARIES <package name>
    HINTS ${<PACKAGE>_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##____________________________________________________________________________
  ## Check for the executable

  find_program (<PACKAGE>_EXECUTABLE <package name>
    HINTS ${<PACKAGE>_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (<PACKAGE> DEFAULT_MSG <PACKAGE>_LIBRARIES <PACKAGE>_INCLUDES)

  if (<PACKAGE>_FOUND)
    if (NOT <PACKAGE>_FIND_QUIETLY)
      message (STATUS "Found components for <PACKAGE>")
      message (STATUS "<PACKAGE>_ROOT_DIR  = ${<PACKAGE>_ROOT_DIR}")
      message (STATUS "<PACKAGE>_INCLUDES  = ${<PACKAGE>_INCLUDES}")
      message (STATUS "<PACKAGE>_LIBRARIES = ${<PACKAGE>_LIBRARIES}")
    endif (NOT <PACKAGE>_FIND_QUIETLY)
  else (<PACKAGE>_FOUND)
    if (<PACKAGE>_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find <PACKAGE>!")
    endif (<PACKAGE>_FIND_REQUIRED)
  endif (<PACKAGE>_FOUND)

  ##____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    <PACKAGE>_ROOT_DIR
    <PACKAGE>_INCLUDES
    <PACKAGE>_LIBRARIES
    )

endif (NOT <PACKAGE>_FOUND)
