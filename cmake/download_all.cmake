# This file takes care of downloading all of the source tarballs for Titan.

get_filename_component(_self_dir ${CMAKE_CURRENT_LIST_FILE} PATH)
set(AvogadroSquared_SOURCE_DIR "${_self_dir}/..")
include("${_self_dir}/avogadro_tarballs.cmake")

set(tarball_dir "${AvogadroSquared_SOURCE_DIR}/downloads")

# Download each file in turn, if it exists and the md5 matches, it will not be
# downloaded again. If the md5 differs, it will be deleted and downloaded.
foreach(source ${avogadro_external_sources})
  message(STATUS "Downlading ${source} source tarball...")
  file(DOWNLOAD
    ${${source}_url}
    ${tarball_dir}/${${source}_filename}
    TIMEOUT 3600
    STATUS status
    LOG log
    EXPECTED_MD5 ${${source}_md5}
    SHOW_PROGRESS)
endforeach()
