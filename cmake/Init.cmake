message(STATUS "include Init.cmake")

include("${CMAKE_CURRENT_LIST_DIR}/Build.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Package.cmake")

set(CPM_USE_LOCAL_PACKAGES TRUE CACHE BOOL "" FORCE)
include("${CMAKE_CURRENT_LIST_DIR}/CPM.cmake")

function(Print_List)
  cmake_parse_arguments("ARG" "" "TITLE;PREFIX" "STRS" ${ARGN})
  list(LENGTH ARG_STRS strsLength)
  if(NOT strsLength)
    return()
  endif()
  if(NOT ${ARG_TITLE} STREQUAL "")
    message(STATUS ${ARG_TITLE})
  endif()
  foreach(str ${ARG_STRS})
    message(STATUS "${ARG_PREFIX}${str}")
  endforeach()
endfunction()

# ---------------------------------------------------------

macro(InitProject)
  set(CMAKE_DEBUG_POSTFIX "d")
  set(CMAKE_RELEASE_POSTFIX "")
  set(CMAKE_MINSIZEREL_POSTFIX "msr")
  set(CMAKE_RELWITHDEBINFO_POSTFIX "rd")
  
  set(CMAKE_CXX_STANDARD 20)
  set(CMAKE_CXX_STANDARD_REQUIRED True)

  if(NOT CMAKE_BUILD_TYPE)
    message(NOTICE "No default CMAKE_BUILD_TYPE, so UCMake set it to \"Release\"")
    set(CMAKE_BUILD_TYPE Release CACHE STRING
      "Choose the type of build, options are: None Debug Release RelWithDebInfo MinSizeRel." FORCE)
  endif()

  if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
  # using Clang
    message(STATUS "Compiler: Clang ${CMAKE_CXX_COMPILER_VERSION}")
    if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "10")
      message(FATAL_ERROR "clang (< 10) not support concept")
      return()
    endif()
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    message(STATUS "Compiler: GCC ${CMAKE_CXX_COMPILER_VERSION}")
    if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "10")
      message(FATAL_ERROR "gcc (< 10) not support concept")
      return()
    endif()
  # using GCC
  elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
  # using Visual Studio C++
    message(STATUS "Compiler: MSVC ${CMAKE_CXX_COMPILER_VERSION}")
    if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS "19.26")
      message(FATAL_ERROR "MSVC (< 1926 / 2019 16.6) not support concept")
      return()
    endif()
  else()
    message(WARNING "Unknown CMAKE_CXX_COMPILER_ID : ${CMAKE_CXX_COMPILER_ID}")
  endif()
  
  message(STATUS "CXX_STANDARD: ${CMAKE_CXX_STANDARD}")
  
  set("BuildTest_${PROJECT_NAME}" TRUE CACHE BOOL "build tests for ${PROJECT_NAME}")

  if(NOT RootProjectPath)
    set(RootProjectPath ${PROJECT_SOURCE_DIR})
  endif()

  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${RootProjectPath}/bin")
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${RootProjectPath}/lib")
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
  set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_ARCHIVE_OUTPUT_DIRECTORY})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${RootProjectPath}/bin")
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
  set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})

  set_property(GLOBAL PROPERTY USE_FOLDERS ON)
endmacro()