
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

# Extract SHA1 version for the most recent commit

macro (get_commit_hash GIT_COMMIT_HASH)

    execute_process (COMMAND git log -n1 --graph
                     COMMAND grep "\\*[\ ]* commit"
                     WORKING_DIRECTORY ${PROJECT_SOURCE_DIR}
                     TIMEOUT 120
                     RESULT_VARIABLE COMMIT_HASH_RESULT_VARIABLE
                     OUTPUT_VARIABLE COMMIT_HASH_OUTPUT_VARIABLE
                     ERROR_VARIABLE  COMMIT_HASH_ERROR_VARIABLE
                     OUTPUT_STRIP_TRAILING_WHITESPACE
                     # [ERROR_STRIP_TRAILING_WHITESPACE]
                    )

    if (COMMIT_HASH_OUTPUT_VARIABLE)
        string (REGEX REPLACE "\\*[\ ]* commit " "" GIT_COMMIT_HASH ${COMMIT_HASH_OUTPUT_VARIABLE})
    else (COMMIT_HASH_OUTPUT_VARIABLE)
        message (STATUS "ERROR_VARIABLE  = ${COMMIT_HASH_ERROR_VARIABLE}")
        message (STATUS "RESULT_VARIABLE = ${COMMIT_HASH_RESULT_VARIABLE}")
        message (WARNING "Empty output from 'git log' query - unable to extract hash!")
    endif (COMMIT_HASH_OUTPUT_VARIABLE)

endmacro (get_commit_hash)
