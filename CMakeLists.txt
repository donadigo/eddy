project (eddy)
cmake_minimum_required (VERSION 2.8)
cmake_policy (VERSION 2.6)

set (DATADIR "${CMAKE_INSTALL_PREFIX}/share/${CMAKE_PROJECT_NAME}")
set (PKGDATADIR "${DATADIR}/eddy")
set (GETTEXT_PACKAGE "eddy")
set (VERSION "1.0")
set (VERSION_INFO "Release")
set (EXEC_NAME ${CMAKE_PROJECT_NAME})
set (PREFIX ${CMAKE_INSTALL_PREFIX})
set (DOLLAR "$")

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

file(GLOB_RECURSE sources src/*.vala)

# Some configuration
configure_file (${CMAKE_SOURCE_DIR}/src/config.vala.cmake ${CMAKE_SOURCE_DIR}/src/config.vala)

#GSettings
#include(GSettings)
#add_schema("net.launchpad.eddy.gschema.xml")

# Definitions
add_definitions ("-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\"")

# Hide C compiler warnings
add_definitions (-w)


set (BASIC_VALAC_OPTIONS
    --enable-experimental
    --disable-warnings
    --target-glib=2.32
    --thread
    -g
)

set (GLOBAL_VALAC_OPTIONS
    ${BASIC_VALAC_OPTIONS}
)

set (DEPS_PACKAGES
    gtk+-3.0
    granite
    gio-2.0
)

find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED granite gtk+-3.0 gio-2.0)

add_definitions(${DEPS_CFLAGS})
link_libraries(${DEPS_LIBRARIES})
link_directories(${DEPS_LIBRARY_DIRS})

find_package(Vala REQUIRED)
include(ValaVersion)
ensure_vala_version("0.26.2" MINIMUM)
include(ValaPrecompile)
vala_precompile(VALA_C ${EXEC_NAME}
    src/Eddy.vala
    src/EddyWindow.vala
    src/config.vala
    src/Constants.vala
    src/DebianPackage.vala
    src/DetailedView.vala
    src/PackageListView.vala
    src/PackageRow.vala
    src/ProgressView.vala
PACKAGES
    ${DEPS_PACKAGES}
OPTIONS
    --vapidir=${CMAKE_SOURCE_DIR}/vapi
    ${GLOBAL_VALAC_OPTIONS}
)

add_subdirectory (po)

add_executable(${EXEC_NAME} ${VALA_C})

# uninstall target
configure_file (
    "${CMAKE_SOURCE_DIR}/cmake/Uninstall.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/Uninstall.cmake"
    IMMEDIATE @ONLY)

add_custom_target (uninstall
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/Uninstall.cmake)

install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)
install (FILES ${CMAKE_CURRENT_SOURCE_DIR}/data/eddy.desktop DESTINATION share/applications)