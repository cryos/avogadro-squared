
set(avogadro_source "${AvogadroSquared_SOURCE_DIR}/avogadro")
set(avogadro_build "${AvogadroSquared_BINARY_DIR}/avogadro")

ExternalProject_Add(avogadro
  SOURCE_DIR ${avogadro_source}
  BINARY_DIR ${avogadro_build}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${AvogadroSquared_BINARY_DIR}/prefix
    ${avogadro_build_vars}
    -DAvogadro_USE_SYSTEM_OPENQUBE:BOOL=ON
    -DENABLE_TESTS:BOOL=OFF
    -DENABLE_PYTHON:BOOL=OFF
  DEPENDS zlib openbabel openqube)

ExternalProject_Add_Step(avogadro forcebuild
  COMMAND ${CMAKE_COMMAND} -E remove
    ${CMAKE_CURRENT_BUILD_DIR}/avogadro-prefix/src/avogadro-stamp/avogadro-build
  DEPENDEES configure
  DEPENDERS build
  ALWAYS 1
  )
