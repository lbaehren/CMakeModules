# +-----------------------------------------------------------------------------+
# |   Copyright (C) 2012                                                        |
# |   Lars B"ahren (lbaehren@gmail.com)                                         |
# |                                                                             |
# |   This program is free software; you can redistribute it and/or modify      |
# |   it under the terms of the GNU General Public License as published by      |
# |   the Free Software Foundation; either version 2 of the License, or         |
# |   (at your option) any later version.                                       |
# |                                                                             |
# |   This program is distributed in the hope that it will be useful,           |
# |   but WITHOUT ANY WARRANTY; without even the implied warranty of            |
# |   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             |
# |   GNU General Public License for more details.                              |
# |                                                                             |
# |   You should have received a copy of the GNU General Public License         |
# |   along with this program; if not, write to the                             |
# |   Free Software Foundation, Inc.,                                           |
# |   59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.                 |
# +-----------------------------------------------------------------------------+

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
