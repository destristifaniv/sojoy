@echo off
"C:\\Users\\destr\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\cmake.exe" ^
  "-HC:\\src\\flutter\\packages\\flutter_tools\\gradle\\src\\main\\groovy" ^
  "-DCMAKE_SYSTEM_NAME=Android" ^
  "-DCMAKE_EXPORT_COMPILE_COMMANDS=ON" ^
  "-DCMAKE_SYSTEM_VERSION=21" ^
  "-DANDROID_PLATFORM=android-21" ^
  "-DANDROID_ABI=x86_64" ^
  "-DCMAKE_ANDROID_ARCH_ABI=x86_64" ^
  "-DANDROID_NDK=C:\\Users\\destr\\AppData\\Local\\Android\\sdk\\ndk\\25.2.9519653" ^
  "-DCMAKE_ANDROID_NDK=C:\\Users\\destr\\AppData\\Local\\Android\\sdk\\ndk\\25.2.9519653" ^
  "-DCMAKE_TOOLCHAIN_FILE=C:\\Users\\destr\\AppData\\Local\\Android\\sdk\\ndk\\25.2.9519653\\build\\cmake\\android.toolchain.cmake" ^
  "-DCMAKE_MAKE_PROGRAM=C:\\Users\\destr\\AppData\\Local\\Android\\sdk\\cmake\\3.22.1\\bin\\ninja.exe" ^
  "-DCMAKE_LIBRARY_OUTPUT_DIRECTORY=D:\\Kulyah\\Semester 4\\Workshop Pengembangan Perangkat Lunak Berbasis Agile\\sojoy\\android\\app\\build\\intermediates\\cxx\\Debug\\25q1k3r2\\obj\\x86_64" ^
  "-DCMAKE_RUNTIME_OUTPUT_DIRECTORY=D:\\Kulyah\\Semester 4\\Workshop Pengembangan Perangkat Lunak Berbasis Agile\\sojoy\\android\\app\\build\\intermediates\\cxx\\Debug\\25q1k3r2\\obj\\x86_64" ^
  "-DCMAKE_BUILD_TYPE=Debug" ^
  "-BD:\\Kulyah\\Semester 4\\Workshop Pengembangan Perangkat Lunak Berbasis Agile\\sojoy\\android\\app\\.cxx\\Debug\\25q1k3r2\\x86_64" ^
  -GNinja ^
  -Wno-dev ^
  --no-warn-unused-cli
