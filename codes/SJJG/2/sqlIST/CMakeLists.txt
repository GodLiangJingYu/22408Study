cmake_minimum_required(VERSION 3.16)
project(sqlIST C)

set(CMAKE_C_STANDARD 11)

# 将所有编译产物(.exe, .obj 等)输出到 build 目录
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/build)

# 自动扫描所有 .c 文件，每个生成独立可执行文件
file(GLOB C_FILES "*.c")

foreach(c_file ${C_FILES})
    # 获取文件名（不含路径和扩展名）作为可执行文件名
    get_filename_component(exe_name ${c_file} NAME_WE)
    
    # 移除文件名中的点号以避免目标名冲突
    string(REPLACE "." "_" exe_name ${exe_name})
    
    # 为每个 .c 文件创建独立的可执行目标
    add_executable(${exe_name} ${c_file})
endforeach()
