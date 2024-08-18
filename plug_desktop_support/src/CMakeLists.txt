# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(flutter_serial_communication_desktop_support_library VERSION 0.0.1 LANGUAGES C)

add_library(flutter_serial_communication_desktop_support SHARED
  "flutter_serial_communication_desktop_support.c"
  "third_party/libserialport/macosx.c"
  "third_party/libserialport/serialport.c"
)

set_target_properties(flutter_serial_communication_desktop_support PROPERTIES
  PUBLIC_HEADER third_party/libserialport/libserialport.h
  OUTPUT_NAME "flutter_serial_communication_desktop_support"
)

target_compile_definitions(flutter_serial_communication_desktop_support PUBLIC DART_SHARED_LIB)


