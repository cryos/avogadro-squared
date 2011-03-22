cmake_minimum_required(VERSION 2.8)

project(AvogadroSquared)

set(CMAKE_MODULE_PATH "${AvogadroSquared_SOURCE_DIR}/cmake"
  ${CMAKE_MODULE_PATH})

# Include the relevant CMake module and tarball file
include(ExternalProject)
include(avogadro_tarballs)
include(library_suffix)

# Clear our CMake variables to pass into external projects
set(avogadro_build_vars "")

# Now build zlib
include(External_zlib)
# Append the relevant variables to our initial cache
list(APPEND avogadro_build_vars
  "-DZLIB_INCLUDE_DIR:PATH=${ZLIB_INCLUDE_DIR}"
  "-DZLIB_LIBRARY:PATH=${ZLIB_LIBRARY}")

# Now build libxml2
include(External_libxml2)

list(APPEND avogadro_build_vars
  "-DLIBXML2_INCLUDE_DIR:PATH=${LIBXML2_INCLUDE_DIR}"
  "-DLIBXML2_LIBRARIES:PATH=${LIBXML2_LIBRARIES}")

# Problems compiling with Eigen, just don't pass it in for now
include(External_openbabel)

list(APPEND avogadro_build_vars
  "-DEIGEN2_INCLUDE_DIR:PATH=${AvogadroSquared_SOURCE_DIR}/eigen"
  "-DOPENBABEL2_INCLUDE_DIR:PATH=${OPENBABEL2_INCLUDE_DIR}"
  "-DOPENBABEL2_LIBRARIES:FILEPATH=${OPENBABEL2_LIBRARIES}"
  "-DOPENBABEL2_VERSION_MET:BOOL=TRUE"
  "-DOPENBABEL_IS_NEWER_THAN_2_2_99:BOOL=TRUE")

include(External_openqube)

list(APPEND avogadro_build_vars
  "-DOpenQube_DIR:PATH=${AvogadroSquared_BINARY_DIR}/openqube")

include(External_avogadro)
