################################################################################
##
## The University of Illinois/NCSA
## Open Source License (NCSA)
##
## Copyright (c) 2014-2016, Advanced Micro Devices, Inc. All rights reserved.
##
## Developed by:
##
##                 AMD Research and AMD HSA Software Development
##
##                 Advanced Micro Devices, Inc.
## 
##                 www.amd.com
##
## Permission is hereby granted, free of charge, to any person obtaining a copy
## of this software and associated documentation files (the "Software"), to
## deal with the Software without restriction, including without limitation
## the rights to use, copy, modify, merge, publish, distribute, sublicense,
## and#or sell copies of the Software, and to permit persons to whom the
## Software is furnished to do so, subject to the following conditions:
##
##  - Redistributions of source code must retain the above copyright notice,
##    this list of conditions and the following disclaimers.
##  - Redistributions in binary form must reproduce the above copyright
##    notice, this list of conditions and the following disclaimers in
##    the documentation and#or other materials provided with the distribution.
##  - Neither the names of Advanced Micro Devices, Inc,
##    nor the names of its contributors may be used to endorse or promote
##    products derived from this Software without specific prior written
##    permission.
##
## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
## IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
## FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
## THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
## OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
## ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
## DEALINGS WITH THE SOFTWARE.
##
################################################################################

#
# HSA Build compiler definitions common between components.
#

set(IS64BIT 0)
set(ONLY64STR "32")
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
  set(IS64BIT 1)
  set(ONLY64STR "64")
endif()

if(UNIX)
  set(PS ":")
  set(CMAKE_CXX_FLAGS "-Wall -std=c++11 ${EXTRA_CFLAGS}")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpic")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wl,--unresolved-symbols=ignore-in-shared-libs")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-strict-aliasing")
  if ( IS64BIT )
    set( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m64  -msse -msse2" )
  else ()
    set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -m32" )
  endif ()
  if ( "${CMAKE_BUILD_TYPE}" STREQUAL Debug )
    set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O0 -ggdb" )
  endif ()
  add_definitions(-D __STDC_LIMIT_MACROS)
  add_definitions(-D __STDC_CONSTANT_MACROS)
  add_definitions(-D __STDC_FORMAT_MACROS)
  add_definitions (-DLITTLEENDIAN_CPU=1)
else()
  set (PS "\;")
endif()

if(MSVC)
  set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
  set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
endif()
