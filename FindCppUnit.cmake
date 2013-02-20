
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

# - Check for the presence of CPPUNIT
#
# The following variables are set when CPPUNIT is found:
#  CPPUNIT_FOUND      = Set to true, if all components of CPPUNIT have been found.
#  CPPUNIT_INCLUDES   = Include path for the header files of CPPUNIT
#  CPPUNIT_LIBRARIES  = Link these to use CPPUNIT
#  CPPUNIT_LFLAGS     = Linker flags (optional)

if (NOT CPPUNIT_FOUND)

  if (NOT CPPUNIT_ROOT_DIR)
    set (CPPUNIT_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT CPPUNIT_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (CPPUNIT_INCLUDES
    NAMES cppunit/TestAssert.h cppunit/Exception.h
    HINTS ${CPPUNIT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )

  ##_____________________________________________________________________________
  ## Check for the library

  find_library (CPPUNIT_LIBRARIES cppunit
    HINTS ${CPPUNIT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (CPPUNIT DEFAULT_MSG CPPUNIT_LIBRARIES CPPUNIT_INCLUDES)

  if (CPPUNIT_FOUND)
    if (NOT CPPUNIT_FIND_QUIETLY)
      message (STATUS "Found components for CPPUNIT")
      message (STATUS "CPPUNIT_ROOT_DIR  = ${CPPUNIT_ROOT_DIR}")
      message (STATUS "CPPUNIT_INCLUDES  = ${CPPUNIT_INCLUDES}")
      message (STATUS "CPPUNIT_LIBRARIES = ${CPPUNIT_LIBRARIES}")
    endif (NOT CPPUNIT_FIND_QUIETLY)
  else (CPPUNIT_FOUND)
    if (CPPUNIT_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find CPPUNIT!")
    endif (CPPUNIT_FIND_REQUIRED)
  endif (CPPUNIT_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    CPPUNIT_ROOT_DIR
    CPPUNIT_INCLUDES
    CPPUNIT_LIBRARIES
    )

endif (NOT CPPUNIT_FOUND)
