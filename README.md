# CMakeModules

Collection of CMake find script to search for components of installed packages.

## Summary

Having worked with CMake for a number of years, I have been enjoying the growing
functionality of the ecosystem surrounding the cross-platform Makefile generator.
However, mainly coming from an astronomy background, more but once I ran into the
issue of missing search scripts for domain-specific packages (such as e.g. CFITSIO
or WCSLIB), thereby starting to write them myself. As a result of this over time
I have been accumulating a number of search modules, which not only I started
moving around between different software projects, but which also might be useful
to a wider audience.

## Testing

You can test the provided modules via the provided CMakeLists.txt script,
which will set up a simple project including the modules:

    mkdir build
    cd build
    cmake ..

By default all find modules will be included and tested; if however you want to
restrict testing to an individual module you can use the command line option
`MODULE_SELECTION` to select a specific module, e.g.

    cmake -DMODULE_SELECTION=FindRuby.cmake ..

## Links

* CMake (www.cmake.org)

## Authors

* Lars Baehren <lbaehren@gmail.com>
