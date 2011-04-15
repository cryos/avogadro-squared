
set(openbabel_source "${AvogadroSquared_SOURCE_DIR}/openbabel")
set(openbabel_build "${AvogadroSquared_BINARY_DIR}/openbabel")

ExternalProject_Add(openbabel
  SOURCE_DIR ${openbabel_source}
  BINARY_DIR ${openbabel_build}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${AvogadroSquared_BINARY_DIR}/prefix
    ${avogadro_build_vars}
    -DENABLE_TESTS:BOOL=OFF
	-DOB_USE_PREBUILT_BINARIES:BOOL=OFF
  DEPENDS zlib libxml2)

ExternalProject_Add_Step(openbabel forcebuild
  COMMAND ${CMAKE_COMMAND} -E remove
    ${CMAKE_CURRENT_BUILD_DIR}/openbabel-prefix/src/openbabel-stamp/openbabel-build
  DEPENDEES configure
  DEPENDERS build
  ALWAYS 1
  )

set(OPENBABEL2_INCLUDE_DIR "${zlib_install}/include/openbabel-2.0")
if(WIN32)
  set(OPENBABEL2_LIBRARIES "${zlib_install}/bin/openbabel-2.lib")
else()
  set(OPENBABEL2_LIBRARIES "${zlib_install}/lib/libopenbabel.${link_library_suffix}")
endif()
