cmake_minimum_required(VERSION 3.17)

project(@PROJECT_NAME@ VERSION @PROJECT_VERSION@ LANGUAGES CXX)
set(CMAKE_CXX_STANDARD @CPP_VERSION@)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 默认使用Release构建
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

# 查找Qt库
#!!! Edit $COMPONENTS$
find_package(QT NAMES Qt5 Qt6 REQUIRED COMPONENTS $COMPONENTS$)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS $COMPONENTS$)

###############
# 配置第三方库 #
###############

include(FetchContent)
set(3RDPARTY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty)

# 配置Easy Translate库
FetchContent_Declare(
    easy_translate
    SOURCE_DIR ${3RDPARTY_DIR}/easy_translate
)
FetchContent_MakeAvailable(easy_translate)

###############
# 设置程序信息 #
###############

set(APP_ORGANIZATION "")
set(APP_ORGANIZATION_DOMAIN "")
set(APP_TITLE "")
set(APP_VERSION "")
set(APP_AUTHOR "")
set(APP_CONTACT_EMAIL "")
set(APP_COPYRIGHT_TEXT "")

###############
# 定义常用路径 #
###############

# CMake文件夹
set(CMAKE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
# CMake模板文件夹
set(CMAKE_TEMPLATE_DIR ${CMAKE_DIR}/template)
# 语言文件夹路径
set(LANGUAGES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/languages)
# 资源文件夹路径
set(RESOURCES_DIR ${CMAKE_CURRENT_SOURCE_DIR}/resources)
# 应用图标文件夹路径
set(APP_ICON_DIR ${CMAKE_CURRENT_SOURCE_DIR}/icon)

# 重定向目标文件输出目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin/${CMAKE_BUILD_TYPE})

#############
# 添加子目录 #
#############

add_subdirectory(src)
