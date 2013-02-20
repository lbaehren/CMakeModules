
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

# - Check for the presence of LLVM
#
# The following variables are set when LLVM is found:
#  LLVM_FOUND      = Set to true, if all components of LLVM have been found.
#  LLVM_INCLUDES   = Include path for the header files of LLVM
#  LLVM_LIBRARIES  = Link these to use LLVM
#  LLVM_LFLAGS     = Linker flags (optional)

if (NOT LLVM_FOUND)
    
  if (NOT LLVM_ROOT_DIR)
    set (LLVM_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT LLVM_ROOT_DIR)
  
  ##_____________________________________________________________________________
  ## Check for the header files
  
  find_path (LLVM_INCLUDES
    NAMES llvm/LinkAllVMCore.h
    HINTS ${LLVM_ROOT_DIR}${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )
  
  ##_____________________________________________________________________________
  ## Check for the library
  
  find_library (LLVM_LIBRARIES
    NAMES LLVMCore LLVMAnalysis
    HINTS ${LLVM_ROOT_DIR}${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  find_program (CLANG_EXECUTABLE clang
    HINTS ${LLVM_ROOT_DIR}${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  find_program (CLANGXX_EXECUTABLE clang++
    HINTS ${LLVM_ROOT_DIR}${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  find_program (LLVM_RANLIB_EXECUTABLE llvm-ranlib
    HINTS ${LLVM_ROOT_DIR}${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  find_program (LLVM_AR_EXECUTABLE llvm-ar
    HINTS ${LLVM_ROOT_DIR}${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  find_program (LLVM_LD_EXECUTABLE llvm-ld
    HINTS ${LLVM_ROOT_DIR}${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  find_package_handle_standard_args (LLVM DEFAULT_MSG LLVM_LIBRARIES LLVM_INCLUDES)
  
  if (LLVM_FOUND)
    if (NOT LLVM_FIND_QUIETLY)
      message (STATUS "Found components for LLVM")
      message (STATUS "LLVM_ROOT_DIR  = ${LLVM_ROOT_DIR}")
      message (STATUS "LLVM_INCLUDES  = ${LLVM_INCLUDES}")
      message (STATUS "LLVM_LIBRARIES = ${LLVM_LIBRARIES}")
    endif (NOT LLVM_FIND_QUIETLY)
  else (LLVM_FOUND)
    if (LLVM_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find LLVM!")
    endif (LLVM_FIND_REQUIRED)
  endif (LLVM_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    LLVM_INCLUDES
    LLVM_LIBRARIES
    CLANG_EXECUTABLE
    CLANGXX_EXECUTABLE
    LLVM_RANLIB_EXECUTABLE
    LLVM_AR_EXECUTABLE
    )
  
endif (NOT LLVM_FOUND)
