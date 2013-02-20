
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

# - Check for the presence of VirtualBox
#
# The following variables are set when VirtualBox is found:
#  VIRTUALBOX_FOUND  = Set to true, if all components of VirtualBox have been found.

if (NOT VIRTUALBOX_FOUND)

  if (NOT VIRTUALBOX_ROOT_DIR)
    set (VIRTUALBOX_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT VIRTUALBOX_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the executable

  foreach (_program
    VirtualBox
    VBoxManage
    )
    string (TOUPPER ${_program} _varProgram)
    find_program (${_varProgram}_EXECUTABLE ${_program}
      HINTS ${${_varProgram}_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES bin
      )
  endforeach (_program)

  ##_____________________________________________________________________________
  ## Check for available virtual machines

  if (VBOXMANAGE_EXECUTABLE)

    ## Get the list of VMs available on the system
    execute_process(
      COMMAND ${VBOXMANAGE_EXECUTABLE} list vms
      WORKING_DIRECTORY ${PROJECT_BINARY_DIR}
      RESULT_VARIABLE VBOX_RESULT_VARIABLE
      OUTPUT_VARIABLE VBOX_OUTPUT_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

  endif (VBOXMANAGE_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (VIRTUALBOX_EXECUTABLE)
    set (VIRTUALBOX_FOUND TRUE)
  else (VIRTUALBOX_EXECUTABLE)
    set (VIRTUALBOX_FOUND FALSE)
  endif (VIRTUALBOX_EXECUTABLE)

  if (VIRTUALBOX_FOUND)
    if (NOT VIRTUALBOX_FIND_QUIETLY)
      message (STATUS "Found components for VirtualBox")
      message (STATUS "VIRTUALBOX_ROOT_DIR   = ${VIRTUALBOX_ROOT_DIR}")
      message (STATUS "VIRTUALBOX_EXECUTABLE = ${VIRTUALBOX_EXECUTABLE}")
      message (STATUS "VBOXMANAGE_EXECUTABLE = ${VBOXMANAGE_EXECUTABLE}")
    endif (NOT VIRTUALBOX_FIND_QUIETLY)
  else (VIRTUALBOX_FOUND)
    if (VIRTUALBOX_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find VirtualBox!")
    endif (VIRTUALBOX_FIND_REQUIRED)
  endif (VIRTUALBOX_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    VIRTUALBOX_ROOT_DIR
    VIRTUALBOX_EXECUTABLE
    VBOXMANAGE_EXECUTABLE
    )

endif (NOT VIRTUALBOX_FOUND)
