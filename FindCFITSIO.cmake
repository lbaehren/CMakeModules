
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

# - Check for the presence of CFITSIO
#
# The following variables are set when CFITSIO is found:
#  CFITSIO_FOUND      = Set to true, if all components of CFITSIO have been found.
#  CFITSIO_INCLUDES   = Include path for the header files of CFITSIO
#  CFITSIO_LIBRARIES  = Link these to use CFITSIO
#  CFITSIO_LFLAGS     = Linker flags (optional)

if (NOT CFITSIO_FOUND)

  if (NOT CFITSIO_ROOT_DIR)
    set (CFITSIO_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT CFITSIO_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (CFITSIO_INCLUDES fitsio.h fitsio2.h
    HINTS ${CFITSIO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/fitsio include/cfitsio
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (CFITSIO_LIBRARIES cfitsio
    HINTS ${CFITSIO_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (CFITSIO_INCLUDES AND CFITSIO_LIBRARIES)
    set (CFITSIO_FOUND TRUE)
  else (CFITSIO_INCLUDES AND CFITSIO_LIBRARIES)
    set (CFITSIO_FOUND FALSE)
    if (NOT CFITSIO_FIND_QUIETLY)
      if (NOT CFITSIO_INCLUDES)
	message (STATUS "Unable to find CFITSIO header files!")
      endif (NOT CFITSIO_INCLUDES)
      if (NOT CFITSIO_LIBRARIES)
	message (STATUS "Unable to find CFITSIO library files!")
      endif (NOT CFITSIO_LIBRARIES)
    endif (NOT CFITSIO_FIND_QUIETLY)
  endif (CFITSIO_INCLUDES AND CFITSIO_LIBRARIES)

  if (CFITSIO_FOUND)
    if (NOT CFITSIO_FIND_QUIETLY)
      message (STATUS "Found components for CFITSIO")
      message (STATUS "CFITSIO_INCLUDES  = ${CFITSIO_INCLUDES}")
      message (STATUS "CFITSIO_LIBRARIES = ${CFITSIO_LIBRARIES}")
    endif (NOT CFITSIO_FIND_QUIETLY)
  else (CFITSIO_FOUND)
    if (CFITSIO_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find CFITSIO!")
    endif (CFITSIO_FIND_REQUIRED)
  endif (CFITSIO_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    CFITSIO_INCLUDES
    CFITSIO_LIBRARIES
    )

endif (NOT CFITSIO_FOUND)
