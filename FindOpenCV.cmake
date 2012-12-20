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

# OpenCV (Open Source Computer Vision Library) is a library of programming
# functions mainly aimed at real-time computer vision, developed by Intel, and
# now supported by Willow Garage and Itseez. It is free for use under the open
# source BSD license. The library is cross-platform. It focuses mainly on
# real-time image processing. If the library finds Intel's Integrated Performance
# Primitives on the system, it will use these proprietary optimized routines to
# accelerate itself.
#
# The following variables are set when OPENCV is found:
#  OPENCV_FOUND      = Set to true, if all components of OPENCV have been found.
#  OPENCV_INCLUDES   = Include path for the header files of OPENCV
#  OPENCV_LIBRARIES  = Link these to use OPENCV
#  OPENCV_LFLAGS     = Linker flags (optional)

if (NOT OPENCV_FOUND)

  if (NOT OPENCV_ROOT_DIR)
    set (OPENCV_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT OPENCV_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the header files

  find_path (OPENCV1_INCLUDES
    NAMES cvaux.h cxcore.h
    HINTS ${OPENCV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include include/opencv opencv
    )
  if (OPENCV1_INCLUDES)
    list (APPEND OPENCV_INCLUDES ${OPENCV1_INCLUDES})
  endif (OPENCV1_INCLUDES)

  find_path (OPENCV2_INCLUDES
    NAMES opencv2/core/core.hpp opencv2/imgproc/imgproc.hpp
    HINTS ${OPENCV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES include
    )
  if (OPENCV2_INCLUDES)
    list (APPEND OPENCV_INCLUDES ${OPENCV2_INCLUDES})
  endif (OPENCV2_INCLUDES)

  ##_____________________________________________________________________________
  ## Check for the library

  foreach (OPENCV_LIBRARY
      opencv_calib3d
      opencv_contrib
      opencv_core
      opencv_features2d
      opencv_flann
      opencv_gpu
      opencv_highgui
      opencv_imgproc
      opencv_legacy
      opencv_ml
      opencv_nonfree
      opencv_objdetect
      opencv_photo
      opencv_stitching
      opencv_ts
      opencv_video
      opencv_videostab
      )
    ## Convert library name to upper-case
    string (TOUPPER ${OPENCV_LIBRARY} varLibrary)
    ## Search for library
    find_library (OPENCV_${varLibrary}_LIBRARY ${OPENCV_LIBRARY}
      HINTS ${OPENCV_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES lib
      )
    ## Add to overall list
    if (OPENCV_${varLibrary}_LIBRARY)
      list (APPEND OPENCV_LIBRARIES ${OPENCV_${varLibrary}_LIBRARY})
      mark_as_advanced (OPENCV_${varLibrary}_LIBRARY)
    endif (OPENCV_${varLibrary}_LIBRARY)
  endforeach (OPENCV_LIBRARY)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  find_package_handle_standard_args (OPENCV DEFAULT_MSG OPENCV_LIBRARIES OPENCV_INCLUDES)

  if (OPENCV_FOUND)
    if (NOT OPENCV_FIND_QUIETLY)
      message (STATUS "Found components for openCV")
      message (STATUS "OPENCV_ROOT_DIR  = ${OPENCV_ROOT_DIR}")
      message (STATUS "OPENCV_INCLUDES  = ${OPENCV_INCLUDES}")
      message (STATUS "OPENCV_LIBRARIES = ${OPENCV_LIBRARIES}")
    endif (NOT OPENCV_FIND_QUIETLY)
  else (OPENCV_FOUND)
    if (OPENCV_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find openCV!")
    endif (OPENCV_FIND_REQUIRED)
  endif (OPENCV_FOUND)

  ##_____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    OPENCV_ROOT_DIR
    OPENCV_INCLUDES
    OPENCV_LIBRARIES
    )

endif (NOT OPENCV_FOUND)
