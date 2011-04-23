cmake_minimum_required(VERSION 2.8)

project(AvogadroSquared)

set(CMAKE_MODULE_PATH "${AvogadroSquared_SOURCE_DIR}/cmake"
  ${CMAKE_MODULE_PATH})

# Include the relevant CMake module and tarball file
include(ExternalProject)
include(avogadro_tarballs)
include(library_suffix)

# Add options to use system libraries for each of the dependencies
option(USE_SYSTEM_QT "Should we use the system Qt?" ON)
option(USE_SYSTEM_ZLIB "Should we use the system zlib?" OFF)
option(USE_SYSTEM_LIBXML2 "Should we use the system LIBXML2?" OFF)

# External Qt build if requested
if(USE_SYSTEM_QT)
  find_package(Qt4 ${qt_version_min} REQUIRED)
else()
  include(External_Qt)
endif()
set(avogadro_build_vars "-DQT_QMAKE_EXECUTABLE=${QT_QMAKE_EXECUTABLE}")

# Now build zlib
if(USE_SYSTEM_ZLIB)
  find_package(ZLIB REQUIRED)
else()
  include(External_zlib)
endif()
# Append the relevant variables to our initial cache
list(APPEND avogadro_build_vars
  "-DZLIB_INCLUDE_DIR:PATH=${ZLIB_INCLUDE_DIR}"
  "-DZLIB_LIBRARY:PATH=${ZLIB_LIBRARY}")

# Now build libxml2
if(USE_SYSTEM_LIBXML2)
  find_package(LIBXML2 REQUIRED)
else()
  include(External_libxml2)
endif()
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
  "-DOpenQube_DIR:PATH=${AvogadroSquared_BINARY_DIR}/openqube"
  "-DCMAKE_PREFIX_PATH:PATH=${AvogadroSquared_BINARY_DIR}/prefix")

include(External_avogadro)

list(APPEND avogadro_build_vars
  "-DAvogadro_DIR:PATH=${AvogadroSquared_BINARY_DIR}/avogadro")

# Should we use the optional VTK components? If so, find them and pass it down
option(Avogadro_USE_VTK "Use optional VTK components?" OFF)
if(Avogadro_USE_VTK)
  find_package(VTK REQUIRED)
  list(APPEND avogadro_build_vars
    "-DVTK_DIR:PATH=${VTK_DIR}")
  message("avogadro_build_vars: ${avogadro_build_vars}")

  include(External_avogadrovtk)
endif()
