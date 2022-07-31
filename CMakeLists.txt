cmake_minimum_required(VERSION 3.14 FATAL_ERROR)

project (RCMake VERSION 0.0.1)
message(STATUS "[Project] ${PROJECT_NAME} ${PROJECT_VERSION}")

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
include(Init)

InitProject(CXX_STANDARD 20)

AddSubDirs(src)

Export(
  DIRECTORIES
    "cmake"
)
