set(CPACK_GENERATOR "TGZ;ZIP" CACHE STRING "Semicolon separated list of generators")

set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY 0)
set(CPACK_INSTALL_CMAKE_PROJECTS
    "${CMAKE_BINARY_DIR}"
    "${PROJECT_NAME}"
    ALL
    .
    )

set(CPACK_PROJECT_URL "https://github.com/gabime/spdlog")
set(CPACK_PACKAGE_VENDOR "Gabi Melman")
set(CPACK_PACKAGE_CONTACT "Gabi Melman <gmelman1@gmail.com>")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Fast C++ logging library")
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH})
if (PROJECT_VERSION_TWEAK)
    set(CPACK_PACKAGE_VERSION ${CPACK_PACKAGE_VERSION}.${PROJECT_VERSION_TWEAK})
endif ()
set(CPACK_PACKAGE_RELOCATABLE ON CACHE BOOL "Build relocatable package")

set(CPACK_RPM_PACKAGE_LICENSE "MIT")
set(CPACK_RPM_PACKAGE_GROUP "Development/Libraries")
set(CPACK_RPM_PACKAGE_URL ${CPACK_PROJECT_URL})
set(CPACK_RPM_PACKAGE_DESCRIPTION "Very fast, header-only/compiled, C++ logging library.")

set(CPACK_RPM_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
if (CPACK_RPM_PACKAGE_RELEASE)
   set(CPACK_RPM_FILE_NAME "${CPACK_RPM_FILE_NAME}-${CPACK_RPM_PACKAGE_RELEASE}")
endif ()
if (CPACK_RPM_PACKAGE_ARCHITECTURE)
   set(CPACK_RPM_FILE_NAME "${CPACK_RPM_FILE_NAME}.${CPACK_RPM_PACKAGE_ARCHITECTURE}")
endif ()
set(CPACK_RPM_FILE_NAME "${CPACK_RPM_FILE_NAME}.rpm")

if (NOT CPACK_PACKAGE_RELOCATABLE)
    # Depend on pkgconfig rpm to create the system pkgconfig folder
    set(CPACK_RPM_PACKAGE_REQUIRES pkgconfig)
    set(CPACK_RPM_EXCLUDE_FROM_AUTO_FILELIST_ADDITION "${CPACK_PACKAGING_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/pkgconfig")
endif ()

include(CPack)
