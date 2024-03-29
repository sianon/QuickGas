cmake_minimum_required(VERSION 3.14)

project(quick_demo VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_PREFIX_PATH "C:/Qt/5.15.2/msvc2019_64/lib/cmake")
#set(Vulkan_INCLUDE_DIR "C:/VulkanSDK/1.3.268.0/Include")

#set(Qt6_DIR "C:/Qt/6.3.2/msvc2019_64/lib/cmake/Qt6")
find_package(QT NAMES Qt5 REQUIRED COMPONENTS Core Quick Qml Widgets Multimedia MultimediaWidgets )
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick Qml Widgets Multimedia MultimediaWidgets )

set(PROJECT_SOURCES
        main.cpp
        qml.qrc


)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(quick_demo
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
        producer.h producer.cpp
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET quick_demo APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(quick_demo SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(quick_demo
          ${PROJECT_SOURCES}
          producer.h
          producer.cpp
          custom_video_surface.h
          custom_video_surface.cpp
          frame_provider.h frame_provider.cpp
          video_dlg.h
        )
    endif()
endif()

target_link_libraries(quick_demo
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Qml Qt${QT_VERSION_MAJOR}::Widgets Qt5::Multimedia Qt5::MultimediaWidgets)

# Qt for iOS sets MACOSX_BUNDLE_GUI_IDENTIFIER automatically since Qt 6.1.
# If you are developing for iOS or macOS you should consider setting an
# explicit, fixed bundle identifier manually though.
if(${QT_VERSION} VERSION_LESS 6.1.0)
  set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.quick_demo)
endif()
set_target_properties(quick_demo PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS quick_demo
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(quick_demo)
    qt_finalize_executable(quick_demo)
endif()
