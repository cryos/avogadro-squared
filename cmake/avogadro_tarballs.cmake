# Specify the version and download URLs for some of the Titan external project
# source code tarballs. These can be downloaded and kept in the source tree,
# or the build tree dynamically at build time.

# Download directory, if our source is downloaded into the source tree.
set(avogadro_download_dir "${AvogadroSquared_SOURCE_DIR}/downloads")

# Boost
set(boost_version 1.41.0)
set(boost_url
  "http://www.vtk.org/files/support/boost-${boost_version}.cmake-kitware.tar.gz")
set(boost_md5 "f09997a2dad36627579b3e2215c25a48")

# Qt
set(qt_version 4.7.2)
set(qt_version_min 4.6)
set(qt_url
  "http://get.qt.nokia.com/qt/source/qt-everywhere-opensource-src-${qt_version}.tar.gz")
set(qt_md5 "66b992f5c21145df08c99d21847f4fdb")

# Zlib
set(zlib_version 1.2.8)
set(zlib_url "http://zlib.net/zlib-${zlib_version}.tar.gz")
set(zlib_md5 44d667c142d7cda120332623eab69f40)

# libxml2
set(libxml2_version 2.7.8)
set(libxml2_url "ftp://xmlsoft.org/libxml2/libxml2-${libxml2_version}.tar.gz")
set(libxml2_md5 8127a65e8c3b08856093099b52599c86)

# List of Titan TPLs with externally downloaded source
set(avogadro_external_sources libxml2 zlib qt)

# Iterate through our URLs, and create local filenames
foreach(source ${avogadro_external_sources})
  set(url ${${source}_url})
  string(REGEX MATCH "[^/]*$" fname "${url}")
  if(NOT "${fname}" MATCHES "\\.(tar|tgz|tar\\.gz)$")
    message(FATAL_ERROR "Could not extract tarball filename from url:\n ${url}")
  endif()
  if(EXISTS "${avogadro_download_dir}/${fname}")
    message(STATUS "Using tarball from source directory: ${fname}")
    set(${source}_file "${avogadro_download_dir}/${fname}")
  else()
    message(STATUS "Downloading file at build time: ${fname}")
    set(${source}_file ${${source}_url})
  endif()
  set(${source}_filename ${fname})
  list(APPEND avogadro_files ${fname})
endforeach()
