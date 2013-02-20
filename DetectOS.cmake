
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

## ==============================================================================
##
##  Determine the operation system
##
## ==============================================================================

if (UNIX)

  if (APPLE)

    set (CMAKE_OS_NAME "OSX" CACHE STRING "Operating system name" FORCE)
    set (MACOSX_FOUND TRUE)

  else (APPLE)

    ## Check for Debian GNU/Linux ________________

    find_file (DEBIAN_FOUND debian_version debconf.conf
      PATHS /etc
      )
    if (DEBIAN_FOUND)
      set (CMAKE_OS_NAME "Debian" CACHE STRING "Operating system name" FORCE)
    endif (DEBIAN_FOUND)

    ##  Check for Fedora _________________________

    find_file (FEDORA_FOUND fedora-release
      PATHS /etc
      )
    if (FEDORA_FOUND)
      set (CMAKE_OS_NAME "Fedora" CACHE STRING "Operating system name" FORCE)
    endif (FEDORA_FOUND)

    ##  Check for RedHat _________________________

    find_file (REDHAT_FOUND redhat-release inittab.RH
      PATHS /etc
      )
    if (REDHAT_FOUND)
     set (CMAKE_OS_NAME "RedHat" CACHE STRING "Operating system name" FORCE)
    endif (REDHAT_FOUND)

    ## Extra check for Ubuntu ____________________

    if (DEBIAN_FOUND)

      ## At its core Ubuntu is a Debian system, with
      ## a slightly altered configuration; hence from
      ## a first superficial inspection a system will
      ## be considered as Debian, which signifies an
      ## extra check is required.

      find_file (UBUNTU_EXTRA legal issue
	PATHS /etc
	)

      if (UBUNTU_EXTRA)
	## Scan contents of file
	file (STRINGS ${UBUNTU_EXTRA} UBUNTU_FOUND
	  REGEX Ubuntu
	  )
	## Check result of string search
	if (UBUNTU_FOUND)
	  set (CMAKE_OS_NAME "Ubuntu" CACHE STRING "Operating system name" FORCE)
	  set (DEBIAN_FOUND FALSE)
	endif (UBUNTU_FOUND)

      endif (UBUNTU_EXTRA)

    endif (DEBIAN_FOUND)

  endif (APPLE)

endif (UNIX)

## ==============================================================================
##
##  Locate OS-specific system tools
##
## ==============================================================================

if (DEBIAN_FOUND OR UBUNTU_FOUND)

  find_program (APT_EXECUTABLE apt-get
    HINTS ${APT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

  find_program (DPKG_EXECUTABLE dpkg
    HINTS ${APT_ROOT_DIR} ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

endif (DEBIAN_FOUND OR UBUNTU_FOUND)

if (FEDORA_FOUND OR REDHAT_FOUND)

  find_program (YUM_EXECUTABLE yum
    HINTS ${YARD_ROOT_DIR}  ${CMAKE_INSTALL_PREFIX}
    PATH_SUFFIXES bin
    )

endif (FEDORA_FOUND OR REDHAT_FOUND)
