#include <hdf5.h>
#include <iostream>

int main ()
{

    std::cout << H5_VERS_MAJOR << ";"
              << H5_VERS_MINOR << ";"
              << H5_VERS_RELEASE;

  return 0;
}
