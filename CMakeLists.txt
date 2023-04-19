cmake_minimum_required(VERSION 3.16)

project(EmojiPicker VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.4 REQUIRED COMPONENTS Quick)

qt_standard_project_setup()

qt_add_executable(appEmojiPicker
    main.cpp ${ANDROID_RCC_SRCS}
)



qt_add_qml_module(appEmojiPicker
    URI EmojiPicker
    VERSION 1.0
    QML_FILES
    Main.qml
    EmojiList.js
)

qt_add_resources(
    android_resources android_resources.qrc
)

target_sources(appEmojiPicker PRIVATE ${android_resources})

set_target_properties(appEmojiPicker PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appEmojiPicker
    PRIVATE Qt6::Quick
)

install(TARGETS appEmojiPicker
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})

#if (ANDROID)
#    set(ASSETS_DIR ${CMAKE_SOURCE_DIR}/)
#    set(ANDROID_ASSETS_DIR ${CMAKE_BINARY_DIR}/android/assets)
#    file(GLOB ASSETS_FILES "${ASSETS_DIR}/*")
#    file(COPY ${ASSETS_FILES} DESTINATION ${ANDROID_ASSETS_DIR})
#    # Set the target property for Android which tells QtCreator to automatically add these files to the APK.
#    set_target_properties(appEmojiPicker PROPERTIES ANDROID_DEPLOY_${appEmojiPicker}_INCLUDE_FILES "${ANDROID_ASSETS_DIR}/emojiList.js")
#endif()
