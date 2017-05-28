project (eddy)
cmake_minimum_required (VERSION 2.8)

include (GNUInstallDirs)
set (DATADIR ${CMAKE_INSTALL_FULL_DATAROOTDIR})
set (PKGDATADIR "${DATADIR}/${CMAKE_PROJECT_NAME}")
set (GETTEXT_PACKAGE ${CMAKE_PROJECT_NAME})
set (VERSION "1.1.4")
set (VERSION_INFO "Stable")
set (EXEC_NAME ${CMAKE_PROJECT_NAME})
set (PREFIX ${CMAKE_INSTALL_PREFIX})
set (DOLLAR "$")

list (APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)

# Definitions
add_definitions ("-DGETTEXT_PACKAGE=\"${GETTEXT_PACKAGE}\"")
add_definitions (-DI_KNOW_THE_PACKAGEKIT_GLIB2_API_IS_SUBJECT_TO_CHANGE)

# Hide C compiler warnings
add_definitions (-w)

set (DEPS_PACKAGES granite;packagekit-glib2)

option (USE_UNITY "Use Unity integration" ON)
if (USE_UNITY)
  message ("-- Unity integration enabled")
  set (DEPS_PACKAGES ${DEPS_PACKAGES};unity)
  set (UNITY_OPTIONS --define=HAVE_UNITY)
else ()
  message ("-- Unity integration disabled")
endif ()

find_package (PkgConfig)
pkg_check_modules (DEPS REQUIRED ${DEPS_PACKAGES})

pkg_check_modules(GRANITE0401 QUIET granite>=0.4.0.1)
if (GRANITE0401_FOUND)
    set (GRANITE_OPTIONS --define=HAS_GRANITE_4_1)
endif ()

add_definitions (${DEPS_CFLAGS})
link_libraries (${DEPS_LIBRARIES})
link_directories (${DEPS_LIBRARY_DIRS})

add_subdirectory (src)
add_subdirectory (data)
add_subdirectory (po)

# uninstall target
configure_file (
    "${CMAKE_SOURCE_DIR}/cmake/Uninstall.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/Uninstall.cmake"
    IMMEDIATE @ONLY)

add_custom_target (uninstall
    COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/Uninstall.cmake)