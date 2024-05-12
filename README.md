# Makefiles

Example Makefiles for small and medium sized projects.
Starter configurations to generate binaries, static libraries, and Shared Object files

### Use cases
These make files are for use in c++ projects. Can be used in c but would need to be modified

For use in
- Small projects
- Multiple projects that share a working directory
- Multiple projects that need to link to each other

These make files scale with the projects with automatic source detection and dependency generation.

### Usage

Copy the file "Makefile" to the root project directory
Then separate projects into sub-directories and copy the file "Makefile.prj" into
the same sub-directories.

If you want a static library instead use "Makefile.prj.a" or "Makefile.prj.so" for a shared object file

### Instructions

Instructions can be found in each make file. An simple example project is set up
as a reference
