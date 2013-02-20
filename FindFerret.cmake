
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

# - Check for the presence of FERRET
#
# The following variables are set when FERRET is found:
#  FERRET_FOUND             = Set to true, if all components of FERRET have been
#                             found.
#  FERRET_FERRET_RB         = Location of ferret.rb
#  FERRET_FERRET_VERSION_RB = Location of ferret_version.rb

if (NOT FERRET_FOUND)

  if (NOT FERRET_ROOT_DIR)
    set (FERRET_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT FERRET_ROOT_DIR)

  find_package (Ruby)
  find_package (Gem)

  ##_____________________________________________________________________________
  ## Check if Ferret is installed as a Gem

  if (GEM_EXECUTABLE)
    execute_process (
      COMMAND ${GEM_EXECUTABLE} list ferret
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE GEM_RESULT_VARIABLE
      OUTPUT_VARIABLE GEM_OUTPUT_VARIABLE
      ERROR_VARIABLE GEM_ERROR_VARIABLE
      OUTPUT_STRIP_TRAILING_WHITESPACE
      )

    if (GEM_OUTPUT_VARIABLE)
      string (REGEX REPLACE "[a-z\(\)]" "" FERRET_VERSION ${GEM_OUTPUT_VARIABLE})
    endif (GEM_OUTPUT_VARIABLE)

  endif (GEM_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Check for installed Ruby sources

  find_file (FERRET_FERRET_RB ferret.rb
    HINTS ${FERRET_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES ruby ruby/site_ruby
    )

  find_file (FERRET_FERRET_VERSION_RB ferret_version.rb
    HINTS ${FERRET_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES ruby ruby/site_ruby
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (FERRET_FOUND)
    if (NOT FERRET_FIND_QUIETLY)
      message (STATUS "Found components for FERRET")
      message (STATUS "FERRET_ROOT_DIR          = ${FERRET_ROOT_DIR}")
      message (STATUS "FERRET_FERRET_RB         = ${FERRET_FERRET_RB}")
      message (STATUS "FERRET_FERRET_VERSION_RB = ${FERRET_FERRET_VERSION_RB}")
    endif (NOT FERRET_FIND_QUIETLY)
  else (FERRET_FOUND)
    if (FERRET_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find FERRET!")
    endif (FERRET_FIND_REQUIRED)
  endif (FERRET_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    FERRET_ROOT_DIR
    FERRET_FERRET_RB
    FERRET_FERRET_VERSION_RB
    FERRET_VERSION
    )

endif (NOT FERRET_FOUND)
