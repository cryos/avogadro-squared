set(avogadrovtk_source "${AvogadroSquared_SOURCE_DIR}/avogadrovtk")
set(avogadrovtk_build "${AvogadroSquared_BINARY_DIR}/avogadrovtk")

ExternalProject_Add(avogadrovtk
  SOURCE_DIR ${avogadrovtk_source}
  BINARY_DIR ${avogadrovtk_build}
  CMAKE_ARGS
    -DCMAKE_INSTALL_PREFIX:PATH=${AvogadroSquared_BINARY_DIR}/prefix
    ${avogadro_build_vars}
  DEPENDS avogadro)

ExternalProject_Add_Step(avogadrovtk forcebuild
  COMMAND ${CMAKE_COMMAND} -E remove
    ${CMAKE_CURRENT_BUILD_DIR}/avogadrovtk-prefix/src/avogadrovtk-stamp/avogadrovtk-build
  DEPENDEES configure
  DEPENDERS build
  ALWAYS 1
  )
