
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

# - Check for the presence of PANDORA
#
# The following variables are set when PANDORA is found:
#  PANDORA_FOUND      = Set to true, if all components of PANDORA have been found.
#  PANDORA_INCLUDES   = Include path for the header files of PANDORA
#  PANDORA_LIBRARIES  = Link these to use PANDORA
#  PANDORA_LFLAGS     = Linker flags (optional)

if (NOT PANDORA_FOUND)
    
  if (NOT PANDORA_ROOT_DIR)
    find_path (PANDORA_ROOT_DIR
      NAMES
      app/models/account.rb
      app/models/xml_source.rb
      config/database.yml.sample
      config/mongrel_cluster.yml.sample
      config/api.yml.sample
      PATHS
      ${PROJECT_SOURCE_DIR}
      ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES
      pandora
      data/repositories/pandora
      )
  endif (NOT PANDORA_ROOT_DIR)

  ##_____________________________________________________________________________
  ## Check for the library
  
  find_path (PANDORA_LIBRARY_DIR 
    NAMES authenticated_system.rb read_image_uri.rb
    HINTS ${PANDORA_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES lib
    )
  
  ##_____________________________________________________________________________
  ## Check for the executable
  
  find_program (PANDORA_FERRET_START_EXECUTABLE ferret_start
    HINTS ${PANDORA_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES script bin
    )
  
  find_program (PANDORA_FERRET_STOP_EXECUTABLE ferret_stop
    HINTS ${PANDORA_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES script bin
    )
  
  find_program (PANDORA_SERVER_EXECUTABLE server
    HINTS ${PANDORA_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES script bin
    )

  ##_____________________________________________________________________________
  ## Check for the data directories (images, database dumps, index)
  
  if (NOT PANDORA_DATA_DIR)
    find_path (PANDORA_DATA_DIR
      NAMES 
      data/amtub.xml
      data/arachne.xml
      data/archgiessen.xml
      shared/vgbk_list.yaml
      shared/index_terms.marshal
      shared/config/apache2.conf
      shared/config/database.conf
      HINTS
      ${PANDORA_ROOT_DIR}
      ${CMAKE_INSTALL_PREFIX}
      PATH_SUFFIXES 
      data
      data/pandora
      )
  endif (NOT PANDORA_DATA_DIR)
  
  ##_____________________________________________________________________________
  ## Actions taken when all components have been found
  
  if (PANDORA_LIBRARY_DIR)
    set (PANDORA_FOUND TRUE)
  endif (PANDORA_LIBRARY_DIR)
  
  if (PANDORA_FOUND)
    if (NOT PANDORA_FIND_QUIETLY)
      message (STATUS "Found components for PANDORA")
      message (STATUS "Pandora root dir        = ${PANDORA_ROOT_DIR}"           )
      message (STATUS "Pandora library dir     = ${PANDORA_LIBRARY_DIR}"        )
      message (STATUS "Pandora data dir        = ${PANDORA_DATA_DIR}"           )
      message (STATUS "Executable server       = ${PANDORA_SERVER_EXECUTABLE}"  )
      message (STATUS "Executable ferret_start = ${PANDORA_FERRET_START_EXECUTABLE}" )
      message (STATUS "Executable ferret_stop  = ${PANDORA_FERRET_STOP_EXECUTABLE}" )
    endif (NOT PANDORA_FIND_QUIETLY)
  else (PANDORA_FOUND)
    if (PANDORA_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find PANDORA!")
    endif (PANDORA_FIND_REQUIRED)
  endif (PANDORA_FOUND)
  
  ##_____________________________________________________________________________
  ## Mark advanced variables
  
  mark_as_advanced (
    PANDORA_ROOT_DIR
    PANDORA_INCLUDES
    PANDORA_LIBRARIES
    )
  
endif (NOT PANDORA_FOUND)
