cmake_minimum_required(VERSION 3.14)

project(QuickGas VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_PREFIX_PATH "C:/Qt/5.15.2/mingw81_64/lib/cmake")
#set(CMAKE_PREFIX_PATH "C:/Qt/5.15.2/msvc2019_64/lib/cmake")
#set(Vulkan_INCLUDE_DIR "C:/VulkanSDK/1.3.268.0/Include")

#set(Qt6_DIR "C:/Qt/6.3.2/msvc2019_64/lib/cmake/Qt6")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive")

find_package(PkgConfig REQUIRED)
find_package(OpenCV REQUIRED)
find_package(QT NAMES Qt5 REQUIRED COMPONENTS Core Quick Qml Widgets Multimedia MultimediaWidgets )
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick Qml Widgets Multimedia MultimediaWidgets )

#pkg_check_modules(GTK3 REQUIRED gtk+-3.0)
pkg_check_modules(GLIB REQUIRED glib-2.0)
pkg_check_modules(GOBJECT REQUIRED gobject-2.0)

pkg_check_modules(GST REQUIRED gstreamer-1.0 gstreamer-video-1.0 gstreamer-app-1.0 gstreamer-plugins-base-1.0 gstreamer-rtsp-server-1.0)

include_directories(${GLIB_INCLUDE_DIRS})
include_directories(${GOBJECT_INCLUDE_DIRS})
include_directories(${GST_INCLUDE_DIRS})
include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${OpenCV_INCLUDE_DIRS})


set(PROJECT_SOURCES
        main.cpp
        qml.qrc
        src/rtsp_decode.h
        src/rtsp_decode.cpp
        src/video_queue.cpp
        src/video_queue.h
        src/circular_queue.hpp
)


add_executable(QuickGas
        ${PROJECT_SOURCES}
        producer.h
        producer.cpp
        custom_video_surface.h
        custom_video_surface.cpp
        src/frame_provider.h src/frame_provider.cpp
        video_dlg.h
)


target_link_libraries(QuickGas
        PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick Qt${QT_VERSION_MAJOR}::Qml Qt${QT_VERSION_MAJOR}::Widgets Qt5::Multimedia Qt5::MultimediaWidgets ${GLIB_LIBRARIES} ${GOBJECT_LIBRARIES} ${GST_LIBRARIES} ${OpenCV_LIBS})

    set_target_properties(${PROJECT_NAME} PROPERTIES
        QT_QML_DEBUG true
    )
if(${QT_VERSION} VERSION_LESS 6.1.0)
    set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.quick_demo)
endif()
set_target_properties(QuickGas PROPERTIES
        ${BUNDLE_ID_OPTION}
        MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        MACOSX_BUNDLE TRUE
        WIN32_EXECUTABLE TRUE
)

include(GNUInstallDirs)
install(TARGETS QuickGas
        BUNDLE DESTINATION .
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(quick_demo)
    qt_finalize_executable(quick_demo)
endif()
