
set(avogadro_source "${AvogadroSquared_SOURCE_DIR}/avogadro")
set(avogadro_build "${AvogadroSquared_BINARY_DIR}/avogadro")

ExternalProject_Add(avogadro
  SOURCE_DIR ${avogadro_source}
  BINARY_DIR ${avogadro_build}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${AvogadroSquared_BINARY_DIR}/prefix
    ${avogadro_build_vars}
    -DENABLE_TESTS:BOOL=OFF
    -DENABLE_PYTHON:BOOL=OFF
  DEPENDS zlib openbabel openqube)
