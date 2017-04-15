project (eddy)
cmake_minimum_required (VERSION 2.8)
cmake_policy (VERSION 2.6)

include (GNUInstallDirs)
set (DATADIR ${CMAKE_INSTALL_FULL_DATAROOTDIR})
set (PKGDATADIR "${DATADIR}/${CMAKE_PROJECT_NAME}")
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

# Definitions
add_definitions ("-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\"")
add_definitions (-DI_KNOW_THE_PACKAGEKIT_GLIB2_API_IS_SUBJECT_TO_CHANGE)

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
    packagekit-glib2
    polkit-gobject-1
)

find_package(PkgConfig)
pkg_check_modules(DEPS REQUIRED ${DEPS_PACKAGES})

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
    src/AptProxy.vala
    src/Constants.vala
    src/DebianPackage.vala
    src/DebianPackageManager.vala
    src/DetailedView.vala
    src/PackageListView.vala
    src/PackageRow.vala
    src/MessageDialog.vala
PACKAGES
    ${DEPS_PACKAGES}
OPTIONS
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

add_subdirectory (data)