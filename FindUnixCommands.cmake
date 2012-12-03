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

##
##  Check for the presence of various Unix command line tools
##

foreach (_command
  bash
  cat
  cp
  date
  grep
  gzip
  mv
  rm
  tar
  tree
  zip
  )

  ## Configuration status feedback
  if (CONFIGURE_VERBOSE)
    message (STATUS "Checking for Unix command ${_command}")
  endif (CONFIGURE_VERBOSE)

  ## Convert tool-name to variable prefix
  string (TOUPPER ${_command} _varCommand)

  find_program (${_varCommand}_EXECUTABLE ${_command}
    HINTS ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
  )

  ## Configuration status feedback
  if (CONFIGURE_VERBOSE)
    if (${_varCommand}_EXECUTABLE)
      message (STATUS "Checking for Unix command ${_command} - found")
    else (${_varCommand}_EXECUTABLE)
      message (STATUS "Checking for Unix command ${_command} - missing")
    endif (${_varCommand}_EXECUTABLE)
  endif (CONFIGURE_VERBOSE)

endforeach (_command)
