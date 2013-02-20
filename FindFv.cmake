
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

# - Check for the presence of FV
#
# The following variables are set when FV is found:
#  FV_FOUND      = Set to true, if all components of FV have been found.
#  FV_EXECUTABLE = FITS View program executable.

if (NOT FV_FOUND)

  if (NOT FV_ROOT_DIR)
    set (FV_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT FV_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (FV_EXECUTABLE fv
    HINTS ${FV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (FV DEFAULT_MSG FV_EXECUTABLE)

  if (FV_FOUND)
    if (NOT FV_FIND_QUIETLY)
      message (STATUS "Found components for FV")
      message (STATUS "FV_ROOT_DIR   = ${FV_ROOT_DIR}")
      message (STATUS "FV_EXECUTABLE = ${FV_EXECUTABLE}")
    endif (NOT FV_FIND_QUIETLY)
  else (FV_FOUND)
    if (FV_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find FV!")
    endif (FV_FIND_REQUIRED)
  endif (FV_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    FV_ROOT_DIR
    FV_EXECUTABLE
    )

endif (NOT FV_FOUND)
