
## === LibConfig ===============================================================

if (LIBCONFIG_FOUND)

  add_executable (TestLibConfigVersion TestLibConfigVersion.cc)
  target_link_libraries (TestLibConfigVersion ${LIBCONFIG_LIBRARIES})
  
  set_target_properties (TestLibConfigVersion
    PROPERTIES
    COMPILE_FLAGS -I${LIBCONFIG_INCLUDES}
    LINK_FLAGS ${LIBCONFIG_LIBRARIES}
    )
  
endif (LIBCONFIG_FOUND)
