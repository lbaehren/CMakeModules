
#-------------------------------------------------------------------------------
# Copyright (c) 2013-2013, Lars Baehren <lbaehren@gmail.com>
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

# - Check for the presence of Python modules
#
# The following variables are set when PYTHON_MODULES is found:
#  PYTHON_MODULES_FOUND       = Set to true, if all components of PYTHON_MODULES
#                               have been found.
#  PYTHON_MODULE_<name>_FOUND = Set to TRUE, if the module <name> was found.

if (NOT PYTHON_MODULES_FOUND)

    ## Name mapping
    set (PYTHON_MODULES_FIND_QUIETLY ${PYTHONMODULES_FIND_QUIETLY}  )
    set (PythonModules_LIST          io logging os pdb sys unittest )
    set (PYTHON_MODULES_FOUND        TRUE                           )

    if (NOT PYTHON_MODULES_ROOT_DIR)
        set (PYTHON_MODULES_ROOT_DIR ${CMAKE_INSTALL_PREFIX})
    endif (NOT PYTHON_MODULES_ROOT_DIR)
    
    if (NOT PYTHON_EXECUTABLE)
        find_package (PythonInterp)
    endif ()
    
    if (PythonModules_FIND_COMPONENTS)
        list (APPEND PythonModules_LIST ${PythonModules_FIND_COMPONENTS})
    endif (PythonModules_FIND_COMPONENTS)

    ##__________________________________________________________________________
    ## Process input parameters

    foreach (_pythonModule ${PythonModules_LIST})

        if (NOT PYTHON_MODULES_FIND_QUIETLY)
            message (STATUS "Searching Python package ${_pythonModule}")
        endif (NOT PYTHON_MODULES_FIND_QUIETLY)

        string (TOUPPER ${_pythonModule} _pythonModuleVar)

        execute_process (
            COMMAND ${PYTHON_EXECUTABLE} -c "import ${_pythonModule};"
            WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
            RESULT_VARIABLE TestPythonModuleResult
            OUTPUT_VARIABLE TestPythonModuleOutput
            ERROR_VARIABLE TestPythonModuleError
            )

        if (TestPythonModuleResult)
            if (NOT PYTHON_MODULES_FIND_QUIETLY)
                message (STATUS "Searching Python package ${_pythonModule} - failed")
            endif (NOT PYTHON_MODULES_FIND_QUIETLY)
            set (PYTHON_MODULE_${_pythonModuleVar}_FOUND FALSE)
            set (PYTHON_MODULES_FOUND                    FALSE)
        else (TestPythonModuleResult)
            if (NOT PYTHON_MODULES_FIND_QUIETLY)
                message (STATUS "Searching Python package ${_pythonModule} - found")
            endif (NOT PYTHON_MODULES_FIND_QUIETLY)
            set (PYTHON_MODULE_${_pythonModuleVar}_FOUND TRUE)
        endif (TestPythonModuleResult)

    endforeach (_pythonModule)

    ##__________________________________________________________________________
    ## Actions taken when all components have been found

  if (PYTHON_MODULES_FOUND)
    if (NOT PYTHON_MODULES_FIND_QUIETLY)
      message (STATUS "Found components for PYTHON_MODULES")
      message (STATUS "PYTHON_MODULES_ROOT_DIR  = ${PYTHON_MODULES_ROOT_DIR}")
      message (STATUS "PYTHON_MODULES_INCLUDES  = ${PYTHON_MODULES_INCLUDES}")
      message (STATUS "PYTHON_MODULES_LIBRARIES = ${PYTHON_MODULES_LIBRARIES}")
    endif (NOT PYTHON_MODULES_FIND_QUIETLY)
  else (PYTHON_MODULES_FOUND)
    if (PYTHON_MODULES_FIND_REQUIRED)
      message (FATAL_ERROR "Could not find PYTHON_MODULES!")
    endif (PYTHON_MODULES_FIND_REQUIRED)
  endif (PYTHON_MODULES_FOUND)

  ##____________________________________________________________________________
  ## Mark advanced variables

  mark_as_advanced (
    PYTHON_MODULES_ROOT_DIR
    PYTHON_MODULES_INCLUDES
    PYTHON_MODULES_LIBRARIES
    )

endif (NOT PYTHON_MODULES_FOUND)
