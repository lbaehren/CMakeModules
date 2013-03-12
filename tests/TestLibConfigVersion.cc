
#include <iostream>
#include <libconfig.h>

int main ()
{

//! Display major version number
#ifdef LIBCONFIG_VER_MAJOR
  std::cout << "LIBCONFIG_VER_MAJOR = " << LIBCONFIG_VER_MAJOR << std::endl;
#endif

//! Display minor version number
#ifdef LIBCONFIG_VER_MINOR
std::cout << "LIBCONFIG_VER_MINOR = " << LIBCONFIG_VER_MINOR << std::endl;
#endif

//! Display revision number
#ifdef LIBCONFIG_VER_REVISION
std::cout << "LIBCONFIG_VER_REVISION = " << LIBCONFIG_VER_REVISION << std::endl;
#endif

 return 0;
}
