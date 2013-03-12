
#--------------------------------------------------------------------------------
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
#--------------------------------------------------------------------------------

# - Check for the presence of NETCDF
#
# NetCDF is a set of software libraries and self-describing, machine-independent
# data formats that support the creation, access, and sharing of array-oriented
# scientific data. 
#
# The following variables are set when NETCDF is found:
#  NETCDF_FOUND      = Set to true, if all components of NETCDF have been found.
#  NETCDF_INCLUDES   = Include path for the header files of NETCDF
#  NETCDF_LIBRARIES  = Link these to use NETCDF
#  NETCDF_LFLAGS     = Linker flags (optional)

if (NOT NETCDF_FOUND)

  if (NOT NETCDF_ROOT_DIR)
    set (NETCDF_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT NETCDF_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (NETCDF_INCLUDES
    NAMES netcdf.h
    HINTS ${NETCDF_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (NETCDF_LIBRARIES netcdf
    HINTS ${NETCDF_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Check for the executable

  find_program (NETCDF_PC netcdf.pc
    HINTS ${NETCDF_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib lib/pkgconfig
    )

  ##_____________________________________________________________________________
  ## Determine version of the library
  
  if (NETCDF_PC)
    
    file (STRINGS ${NETCDF_PC} NETCDF_VERSION REGEX "Version:")
    
    if (NETCDF_VERSION)

      ## Dissect version number into individual parts
      string(REGEX REPLACE ".*([0-9]+).[0-9]+.[0-9]+.[0-9]+.*" "\\1"
	NETCDF_VERSION_MAJOR ${NETCDF_VERSION})
      string(REGEX REPLACE ".*[0-9]+.([0-9]+).[0-9]+.[0-9]+.*" "\\1"
	NETCDF_VERSION_MINOR ${NETCDF_VERSION})
      string(REGEX REPLACE ".*[0-9]+.[0-9]+.([0-9]+).*" "\\1"
	NETCDF_VERSION_PATCH ${NETCDF_VERSION})

      ## Assemble version number
      set (NETCDF_VERSION "${NETCDF_VERSION_MAJOR}")
      set (NETCDF_VERSION "${NETCDF_VERSION}.${NETCDF_VERSION_MINOR}")
      set (NETCDF_VERSION "${NETCDF_VERSION}.${NETCDF_VERSION_PATCH}")

    endif (NETCDF_VERSION)

  endif (NETCDF_PC)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (NETCDF DEFAULT_MSG NETCDF_LIBRARIES NETCDF_INCLUDES)

  if (NETCDF_FOUND)
    if (NOT NETCDF_FIND_QUIETLY)
      message (STATUS "Found components for NETCDF")
      message (STATUS "NETCDF_ROOT_DIR  = ${NETCDF_ROOT_DIR}")
      message (STATUS "NETCDF_INCLUDES  = ${NETCDF_INCLUDES}")
      message (STATUS "NETCDF_LIBRARIES = ${NETCDF_LIBRARIES}")
      message (STATUS "NETCDF_VERSION   = ${NETCDF_VERSION}")
    endif (NOT NETCDF_FIND_QUIETLY)
  else (NETCDF_FOUND)
    if (NETCDF_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find NETCDF!")
    endif (NETCDF_FIND_REQUIRED)
  endif (NETCDF_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    NETCDF_ROOT_DIR
    NETCDF_INCLUDES
    NETCDF_LIBRARIES
    )

endif (NOT NETCDF_FOUND)
