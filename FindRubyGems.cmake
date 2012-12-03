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

# - Check for the presence of RUBYGEMS
#
# The following variables are set when RUBYGEMS is found:
#  RUBYGEMS_FOUND          = Set to true, Ruby Gem has been found.
#  RUBYGEM_<PACKAGE>_FOUND = Set true, if the individual <PACKAGE> has been
#                            found.

if (NOT RUBYGEMS_FOUND)

  if (NOT RUBYGEMS_ROOT_DIR)
    set (RUBYGEMS_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
  endif (NOT RUBYGEMS_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Required: find Ruby Gem first

  if (NOT GEM_EXECUTABLE)
    find_package (Gem)
  endif (NOT GEM_EXECUTABLE)

  set (RUBYGEMS_FOUND ${GEM_FOUND})

  ##_____________________________________________________________________________
  ## Set up the list of Gems to search for

  set (RUBYGEMS_GEMS
      apache_image_resizer
      apache_secure_download
      ar_mailer
      blackwinter-gnuplot
      capistrano
      exifr
      fastercsv
      gruff
      highline
      hpricot
      jekyll
      jekyll-localization
      jekyll-pagination
      jekyll-tagging
      json
      libxml-ext
      libxml-ruby
      lockfile
      mail
      mime-types
      mongrel
      mongrel_cluster
      mysql
      oauth
      pdf-reader
      piston
      rake
      redcarpet
      ruby-backports
      ruby-debug
      ruby-filemagic
      ruby-hmac
      ruby-nuggets
      unicode
      wadl
      yard
    )

  ##_____________________________________________________________________________
  ## Check for the executable

  if (GEM_EXECUTABLE)

    ## Get the list of install Ruby gems
    execute_process (
      COMMAND ${GEM_EXECUTABLE} list --local
      WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
      RESULT_VARIABLE GEM_LIST_RESULT
      OUTPUT_VARIABLE GEM_LIST_OUTPUT
      ERROR_VARIABLE GEM_LIST_ERROR
      )

    ## If not empty, process the output of the previous query
    if (GEM_LIST_OUTPUT)

      ## Go through the list of expected Gems and check if they are installed
      foreach (VAR_GEM ${RUBYGEMS_GEMS})

	string (TOUPPER ${VAR_GEM} VAR_GEM_UPPER)

	## Is the gem in the list?
	string (REGEX MATCH
	  ${VAR_GEM} ${VAR_GEM}_FOUND ${GEM_LIST_OUTPUT}
	  )

    if (${VAR_GEM}_FOUND)
	  set (RUBYGEM_${VAR_GEM_UPPER}_FOUND TRUE)
	else (${VAR_GEM}_FOUND)
	  set (RUBYGEM_${VAR_GEM_UPPER}_FOUND FALSE)
	endif (${VAR_GEM}_FOUND)

	if (NOT RUBYGEMS_FIND_QUIETLY)
	  message (STATUS "Ruby gem ${VAR_GEM} found? - ${RUBYGEM_${VAR_GEM_UPPER}_FOUND}")
	endif (NOT RUBYGEMS_FIND_QUIETLY)

      endforeach (VAR_GEM)

    endif (GEM_LIST_OUTPUT)

  endif (GEM_EXECUTABLE)

  ##_____________________________________________________________________________
  ## Actions taken when all components have been found

  if (RUBYGEMS_FOUND)
    if (NOT RUBYGEMS_FIND_QUIETLY)
      message (STATUS "Found components for RUBYGEMS")
      message (STATUS "RUBYGEMS_ROOT_DIR  = ${RUBYGEMS_ROOT_DIR}")
    endif (NOT RUBYGEMS_FIND_QUIETLY)
  else (RUBYGEMS_FOUND)
    if (RUBYGEMS_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find RUBYGEMS!")
    endif (RUBYGEMS_FIND_REQUIRED)
  endif (RUBYGEMS_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    RUBYGEMS_ROOT_DIR
    )
  
endif (NOT RUBYGEMS_FOUND)
