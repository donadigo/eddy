find_package (Vala REQUIRED)
include (ValaVersion)
ensure_vala_version ("0.26.2" MINIMUM)
include (ValaPrecompile)

configure_file (${CMAKE_CURRENT_SOURCE_DIR}/config.vala.cmake ${CMAKE_CURRENT_SOURCE_DIR}/config.vala)
vala_precompile (VALA_C ${EXEC_NAME}
    Eddy.vala
    EddyWindow.vala
    config.vala
    AptProxy.vala
    Constants.vala
    DebianPackage.vala
    DebianPackageManager.vala
    DetailedView.vala
    PackageListView.vala
    PackageRow.vala
    MessageDialog.vala
PACKAGES
    ${DEPS_PACKAGES}
OPTIONS
    --target-glib=2.32
)

add_executable(${EXEC_NAME} ${VALA_C})
install (TARGETS ${EXEC_NAME} RUNTIME DESTINATION bin)
