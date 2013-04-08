
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

# - Check for the presence of HDF5
#
# The following variables are set when HDF5 is found:
#  HDF5_FOUND      = Set to true, if all components of HDF5 have been found.
#  HDF5_INCLUDES   = Include path for the header files of HDF5
#  HDF5_LIBRARIES  = Link these to use HDF5
#  HDF5_LFLAGS     = Linker flags (optional)

if (NOT HDF5_FOUND)

  if (NOT HDF5_ROOT_DIR)
    set (HDF5_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT HDF5_ROOT_DIR)

  ##____________________________________________________________________________
  ## Check for the header files

  find_path (HDF5_INCLUDES
    NAMES hdf5.h hdf5_hl.h
    HINTS ${HDF5_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##____________________________________________________________________________
  ## Check for the library

  set (HDF5_LIBRARIES "")

  foreach (_lib hdf5 hdf5_hl hdf5_cpp hdf5_hl_cpp)

    string (TOUPPER ${_lib} _libUpper)

    find_library (HDF5_${_libUpper}_LIBRARY ${_lib}
      HINTS ${HDF5_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES lib
      DOC "HDF5 ${_lib} library."
    )

    if (HDF5_${_libUpper}_LIBRARY)
      list (APPEND HDF5_LIBRARIES ${HDF5_${_libUpper}_LIBRARY})
    endif ()

  endforeach (_lib)

  ##____________________________________________________________________________
  ## Check for the executable

  find_program (HDF5_C_COMPILER_EXECUTABLE h5cc h5pcc
    HINTS ${HDF5_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    DOC "HDF5 wrapper compiler."
    )

  find_program (HDF5_CXX_COMPILER_EXECUTABLE h5c++ h5pc++
    HINTS ${HDF5_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    DOC "HDF5 C++ wrapper compiler."
    )

  find_program (HDF5_DIFF_EXECUTABLE h5diff
    HINTS ${HDF5_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  ##____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (HDF5 DEFAULT_MSG HDF5_LIBRARIES HDF5_INCLUDES)

  if (HDF5_FOUND)
    if (NOT HDF5_FIND_QUIETLY)
      message (STATUS "Found components for HDF5")
      message (STATUS "HDF5_ROOT_DIR                 = ${HDF5_ROOT_DIR}")
      message (STATUS "HDF5_C_COMPILER_EXECUTABLE    = ${HDF5_C_COMPILER_EXECUTABLE}")
      message (STATUS "HDF5_CXX_COMPILER_EXECUTABLE  = ${HDF5_CXX_COMPILER_EXECUTABLE}")
      message (STATUS "HDF5_INCLUDES                 = ${HDF5_INCLUDES}")
      message (STATUS "HDF5_HDF5_LIBRARY             = ${HDF5_HDF5_LIBRARY}")
      message (STATUS "HDF5_HDF5_HL_LIBRARY          = ${HDF5_HDF5_HL_LIBRARY}")
      message (STATUS "HDF5_HDF5_CPP_LIBRARY         = ${HDF5_HDF5_CPP_LIBRARY}")
      message (STATUS "HDF5_HDF5_HL_CPP_LIBRARY      = ${HDF5_HDF5_HL_CPP_LIBRARY}")
    endif (NOT HDF5_FIND_QUIETLY)
  else (HDF5_FOUND)
    if (HDF5_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find HDF5!")
    endif (HDF5_FIND_REQUIRED)
  endif (HDF5_FOUND)

  ##____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    HDF5_ROOT_DIR
    HDF5_INCLUDES
    HDF5_LIBRARIES
    HDF5_HDF5_LIBRARY
    HDF5_HDF5_HL_LIBRARY
    HDF5_HDF5_CPP_LIBRARY
    HDF5_HDF5_HL_CPP_LIBRARY
    )

endif (NOT HDF5_FOUND)
