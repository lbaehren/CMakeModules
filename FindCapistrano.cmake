
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

# - Check for the presence of CAPISTRANO
#
# The following variables are set when CAPISTRANO is found:
#  CAPISTRANO_FOUND      = Set to true, if all components of CAPISTRANO have been found.
#  CAPISTRANO_EXECUTABLE = Application executable

if (NOT CAPISTRANO_FOUND)

  if (NOT CAPISTRANO_ROOT_DIR)
    set (CAPISTRANO_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT CAPISTRANO_ROOT_DIR)

  if (NOT RUBY_FOUND)
    find_package (Ruby)
  endif ()

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (CAPISTRANO_EXECUTABLE cap capistrano
    HINTS ${CAPISTRANO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATHS /var/lib/gems
    PATH_SUFFIXES bin ${RUBY_VERSION_MAJOR}.${RUBY_VERSION_MINOR}/bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (CAPISTRANO DEFAULT_MSG CAPISTRANO_EXECUTABLE)

  if (CAPISTRANO_FOUND)
    if (NOT CAPISTRANO_FIND_QUIETLY)
      message (STATUS "Found components for CAPISTRANO")
      message (STATUS "CAPISTRANO_ROOT_DIR   = ${CAPISTRANO_ROOT_DIR}")
      message (STATUS "CAPISTRANO_EXECUTABLE = ${CAPISTRANO_EXECUTABLE}")
    endif (NOT CAPISTRANO_FIND_QUIETLY)
  else (CAPISTRANO_FOUND)
    if (CAPISTRANO_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find CAPISTRANO!")
    endif (CAPISTRANO_FIND_REQUIRED)
  endif (CAPISTRANO_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    CAPISTRANO_ROOT_DIR
    CAPISTRANO_EXECUTABLE
    )

endif (NOT CAPISTRANO_FOUND)
