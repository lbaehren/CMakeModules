
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

# - Check for the presence of PIL
#
# The following variables are set when PIL is found:
#  PIL_FOUND      = Set to true, if all components of PIL have been found.
#  PIL_INCLUDES   = Include path for the header files of PIL
#  PIL_LIBRARIES  = Link these to use PIL
#  PIL_LFLAGS     = Linker flags (optional)

if (NOT PIL_FOUND)

  if (NOT PIL_ROOT_DIR)
    set (PIL_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT PIL_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (PIL_INCLUDES pil.h
    HINTS ${PIL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/pil
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (PIL_LIBRARIES pil
    HINTS ${PIL_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (PIL DEFAULT_MSG PIL_LIBRARIES PIL_INCLUDES)

  if (PIL_FOUND)
    if (NOT PIL_FIND_QUIETLY)
      message (STATUS "Found components for PIL")
      message (STATUS "PIL_ROOT_DIR  = ${PIL_ROOT_DIR}")
      message (STATUS "PIL_INCLUDES  = ${PIL_INCLUDES}")
      message (STATUS "PIL_LIBRARIES = ${PIL_LIBRARIES}")
    endif (NOT PIL_FIND_QUIETLY)
  else (PIL_FOUND)
    if (PIL_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find PIL!")
    endif (PIL_FIND_REQUIRED)
  endif (PIL_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    PIL_ROOT_DIR
    PIL_INCLUDES
    PIL_LIBRARIES
    )

endif (NOT PIL_FOUND)
