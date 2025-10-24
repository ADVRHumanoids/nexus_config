cmake_minimum_required(VERSION 3.0.2)
project(nexus_config)
find_package(catkin REQUIRED)
catkin_package()

# Install all YAMLs that live in this folder (fixes your invalid 'FILES DIRECTORY' line)
install(DIRECTORY .
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
  FILES_MATCHING PATTERN "*.yaml"
)

# Install subdirs used at runtime
install(DIRECTORY gui hal
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
)
