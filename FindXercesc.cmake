
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

# - Check for the presence of XERCESC
#
# The following variables are set when XERCESC is found:
#  XERCESC_FOUND      = Set to true, if all components of XERCESC have been found.
#  XERCESC_INCLUDES   = Include path for the header files of XERCESC
#  XERCESC_LIBRARIES  = Link these to use XERCESC
#  XERCESC_LFLAGS     = Linker flags (optional)

if (NOT XERCESC_FOUND)
    
  if (NOT XERCESC_ROOT_DIR)
    set (XERCESC_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT XERCESC_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the header files
  
  find_path (XERCESC_INCLUDES
    NAMES
    xercesc/util/PlatformUtils.hpp
    xercesc/framwork/URLInputSource.hpp
    xercesc/framwork/XMLErrorCodes.hpp
    HINTS ${XERCESC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )
  
  ##_____________________________________________________________________________
  ## Check for the library
  
  find_library (XERCESC_LIBRARIES xerces-c
    HINTS ${XERCESC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  foreach (varProgram
      SEnumVal
      SCMPrint
      SAXPrint
      SAXCount
      SAX2Print
      SAX2Count
      Redirect
      PSVIWriter
      PParse
      MemParse
      EnumVal
      DOMPrint
      DOMCount
      CreateDOMDocument
      XInclude
      StdInParse
      )
    ## convert program name to upper-case
    string (TOUPPER ${varProgram} varProgramUpper)
    ## search for the program executable
    find_program (XERCESC_${varProgramUpper}_EXECUTABLE varProgram
      HINTS ${XERCESC_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES bin
      )
    ## Mark the variable as advanced
    mark_as_advanced (
      XERCESC_${varProgramUpper}_EXECUTABLE
      )
  endforeach (varProgram)
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (XERCESC DEFAULT_MSG XERCESC_LIBRARIES XERCESC_INCLUDES)

  if (XERCESC_FOUND)
    if (NOT XERCESC_FIND_QUIETLY)
      message (STATUS "Found components for XERCES")
      message (STATUS "XERCESC_ROOT_DIR  = ${XERCESC_ROOT_DIR}")
      message (STATUS "XERCESC_INCLUDES  = ${XERCESC_INCLUDES}")
      message (STATUS "XERCESC_LIBRARIES = ${XERCESC_LIBRARIES}")
    endif (NOT XERCESC_FIND_QUIETLY)
  else (XERCESC_FOUND)
    if (XERCESC_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find XERCES!")
    endif (XERCESC_FIND_REQUIRED)
  endif (XERCESC_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    XERCESC_ROOT_DIR
    XERCESC_INCLUDES
    XERCESC_LIBRARIES
    )
  
endif (NOT XERCESC_FOUND)
