
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

##
##  Check for the presence of various Unix command line tools
##

foreach (_command
  bash
  cat
  cp
  date
  grep
  gzip
  mv
  rm
  tar
  tree
  zip
  )

  ## Configuration status feedback
  if (CONFIGURE_VERBOSE)
    message (STATUS "Checking for Unix command ${_command}")
  endif (CONFIGURE_VERBOSE)

  ## Convert tool-name to variable prefix
  string (TOUPPER ${_command} _varCommand)

  find_program (${_varCommand}_EXECUTABLE ${_command}
    HINTS ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
  )

  ## Configuration status feedback
  if (CONFIGURE_VERBOSE)
    if (${_varCommand}_EXECUTABLE)
      message (STATUS "Checking for Unix command ${_command} - found")
    else (${_varCommand}_EXECUTABLE)
      message (STATUS "Checking for Unix command ${_command} - missing")
    endif (${_varCommand}_EXECUTABLE)
  endif (CONFIGURE_VERBOSE)

endforeach (_command)
