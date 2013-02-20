
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

# - Check for the presence of SILO
#
# The following variables are set when SILO is found:
#  SILO_FOUND      = Set to true, if all components of SILO have been found.
#  SILO_INCLUDES   = Include path for the header files of SILO
#  SILO_LIBRARIES  = Link these to use SILO
#  SILO_LFLAGS     = Linker flags (optional)

if (NOT SILO_FOUND)

  if (NOT SILO_ROOT_DIR)
    set (SILO_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT SILO_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for configuration settings
  
  find_file (SILO_SETTINGS libsiloh5.settings
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (SILO_INCLUDES
    NAMES silo.h pmpio.h
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (SILO_LIBRARIES siloh5
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (SILO_SILOFILE_EXECUTABLE silofile
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  find_program (SILO_SILODIFF_EXECUTABLE silodiff
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  find_program (SILO_SILOCK_EXECUTABLE silock
    HINTS ${SILO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (SILO DEFAULT_MSG SILO_LIBRARIES SILO_INCLUDES)

  if (SILO_FOUND)
    if (NOT SILO_FIND_QUIETLY)
      message (STATUS "Found components for SILO")
      message (STATUS "SILO_ROOT_DIR  = ${SILO_ROOT_DIR}")
      message (STATUS "SILO_INCLUDES  = ${SILO_INCLUDES}")
      message (STATUS "SILO_LIBRARIES = ${SILO_LIBRARIES}")
    endif (NOT SILO_FIND_QUIETLY)
  else (SILO_FOUND)
    if (SILO_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find SILO!")
    endif (SILO_FIND_REQUIRED)
  endif (SILO_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    SILO_ROOT_DIR
    SILO_SETTINGS
    SILO_INCLUDES
    SILO_LIBRARIES
    )

endif (NOT SILO_FOUND)
