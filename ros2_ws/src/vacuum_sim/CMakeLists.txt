cmake_minimum_required(VERSION 3.8)
project(vacuum_sim)

find_package(ament_cmake REQUIRED)
find_package(ament_cmake_python REQUIRED)

# Install Python modules
ament_python_install_package(${PROJECT_NAME})

# Install launch files
install(DIRECTORY launch
  DESTINATION share/${PROJECT_NAME}/
)

# Install world files
install(DIRECTORY worlds
  DESTINATION share/${PROJECT_NAME}/
)

ament_package()
