set(openqube_source "${AvogadroSquared_SOURCE_DIR}/openqube")
set(openqube_build "${AvogadroSquared_BINARY_DIR}/openqube")

ExternalProject_Add(openqube
  SOURCE_DIR ${openqube_source}
  BINARY_DIR ${openqube_build}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${AvogadroSquared_BINARY_DIR}/prefix
    ${avogadro_build_vars}
    -DENABLE_TESTS:BOOL=OFF)
