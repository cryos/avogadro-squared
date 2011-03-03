
set(openbabel_source "${AvogadroSquared_SOURCE_DIR}/openbabel")
set(openbabel_build "${AvogadroSquared_BINARY_DIR}/openbabel")

ExternalProject_Add(openbabel
  SOURCE_DIR ${openbabel_source}
  BINARY_DIR ${openbabel_build}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${AvogadroSquared_BINARY_DIR}/prefix
    ${avogadro_build_vars}
    -DENABLE_TESTS:BOOL=OFF
  DEPENDS zlib libxml2)


set(OPENBABEL2_INCLUDE_DIR "${zlib_install}/include/openbabel-2.0")
if(WIN32)
  set(OPENBABEL2_LIBRARIES "${zlib_install}/bin/openbabel-2.lib")
else()
  set(OPENBABEL2_LIBRARIES "${zlib_install}/lib/libopenbabel.${link_library_suffix}")
endif()
