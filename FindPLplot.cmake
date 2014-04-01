
#-------------------------------------------------------------------------------
# Copyright (c) 2014, Lars Baehren <lbaehren@gmail.com>
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

# - Check for the presence of PLPLOT
#
# The following variables are set when PLPLOT is found:
#  PLPLOT_FOUND      = Set to true, if all components of PLPLOT have been found.
#  PLPLOT_INCLUDES   = Include path for the header files of PLPLOT
#  PLPLOT_LIBRARIES  = Link these to use PLPLOT

if (NOT PLPLOT_FOUND)

    if (NOT PLPLOT_ROOT_DIR)
        set (PLPLOT_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
    endif (NOT PLPLOT_ROOT_DIR)

    ##__________________________________________________________________________
    ## Check for the header files

    find_path (PLPLOT_INCLUDES
      NAMES plplot/plplot.h plplot/plstream.h
      HINTS ${PLPLOT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES include
      )

    ##__________________________________________________________________________
    ## Check for the libraries

    find_library (PLPLOT_C_LIBRARY plplotd
        HINTS ${PLPLOT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
        PATH_SUFFIXES lib
        )
    if (PLPLOT_C_LIBRARY)
        list (APPEND PLPLOT_LIBRARIES ${PLPLOT_C_LIBRARY})
    endif (PLPLOT_C_LIBRARY)

    find_library (PLPLOT_CXX_LIBRARY plplotcxxd
      HINTS ${PLPLOT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES lib
      )
    if (PLPLOT_CXX_LIBRARY)
        list (APPEND PLPLOT_LIBRARIES ${PLPLOT_CXX_LIBRARY})
    endif (PLPLOT_CXX_LIBRARY)

    find_library (PLPLOT_TCLTK_LIBRARY plplottcltkd
      HINTS ${PLPLOT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES lib
      )
    if (PLPLOT_TCLTK_LIBRARY)
        list (APPEND PLPLOT_LIBRARIES ${PLPLOT_TCLTK_LIBRARY})
    endif (PLPLOT_TCLTK_LIBRARY)

    ##__________________________________________________________________________
    ## Actions taken when all components have been found

    find_package_handle_standard_args (PLPLOT DEFAULT_MSG PLPLOT_LIBRARIES PLPLOT_INCLUDES)

    if (PLPLOT_FOUND)
      if (NOT PLPLOT_FIND_QUIETLY)
        message (STATUS "Found components for PLPLOT")
        message (STATUS "PLPLOT_ROOT_DIR  = ${PLPLOT_ROOT_DIR}")
        message (STATUS "PLPLOT_INCLUDES  = ${PLPLOT_INCLUDES}")
        message (STATUS "PLPLOT_LIBRARIES = ${PLPLOT_LIBRARIES}")
      endif (NOT PLPLOT_FIND_QUIETLY)
    else (PLPLOT_FOUND)
      if (PLPLOT_FIND_REQUIRED)
        message (FATAL_ERROR "Could not find PLPLOT!")
      endif (PLPLOT_FIND_REQUIRED)
    endif (PLPLOT_FOUND)

    ##__________________________________________________________________________
    ## Mark advanced variables

    mark_as_advanced (
      PLPLOT_ROOT_DIR
      PLPLOT_INCLUDES
      PLPLOT_LIBRARIES
      )

endif (NOT PLPLOT_FOUND)
