# Makefiles

This project creates template Makefiles to quickly setup one or multiple "Project"/s in one directory
similarly to Visual Studio Workspaces and Projects

A Project contains all the source and headers files to create either a executable, static library, or shared (dynamic) library.
The Makefiles allow for auto detection of source files and auto generation of dependencies.

#### Features

- Auto source detection
- Auto dependency generation
- Minimal setup for multiple Projects that depend on each other
- Great even with just standalone projects

#### Why would I use this?

I made these Makefiles to streamline the process of setting up simple projects, eventually it evolved to include more features like
install, uninstall, dependency generation, and project linking

I never liked using Cmake, and with Premake If I wanted to add more files rebuilding the Makefiles was annoying. So creating Makefiles that can be set and forgot about was important to me.

For other build systems I do recommend Premake to generate the build system

#### Usage

Using the make files is simple. Using the ExampleProject directory provided with this repo we can see the intended use

We see the structure of the project here
```bash
ExampleProject/
├── Application/
│   ├── Makefile
│   ├── include/
│   └── src/
│       └── main.cpp
├── Core/
│   ├── Makefile
│   ├── include/
│   │   └── MathLibrary.h
│   └── src/
│       └── MathLibrary.cpp
└── Makefile
```

We have two Project directories, Application and Core
Application generates the main executable while Core generates a static library that is used by Application

The Makefile in the root is the Working directory Makefile that sets the dependency of each Project to each other and allows for the running of all Project Makefiles

Application/Makefile is a copy of Makefile.prj while Core/Makefile is a copy of Makefile.prj.a found in this repo

``` Makefile
#ExampleProject/Makefile

Core:
    @echo "==== Building ($@) ($(config)) ===="
	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(config)


Application: Core
	@echo "==== Building ($@) ($(config)) ===="
	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(config)

install: all
	@$(MAKE) --no-print-directory -C Application -f Makefile install config=$(config)
	@$(MAKE) --no-print-directory -C Core -f Makefile install config=$(config)

uninstall:
	@$(MAKE) --no-print-directory -C Application -f Makefile uninstall 
	@$(MAKE) --no-print-directory -C Core -f Makefile uninstall 

clean:
	@${MAKE} --no-print-directory -C Application -f Makefile clean
	@${MAKE} --no-print-directory -C Core -f Makefile clean
```

Here we see how the projects are linked to each other in ExampleProject/Makefile. The recipe name is also the name of the directory of the project we then change to that directory and run the Makefile that is there
We also see for the clean recipe we need a line for each Project with the Directory name for the -C option

```Makefile
# ExampleProject/Application/Makefile

ifeq ($(config),Optimize)
	CXXFLAGS += -O3
else ifeq ($(config),Release)
	CXXFLAGS += -O3
	CXXFLAGS += -s
else
	config=Debug
	CXXFLAGS += -g
endif

CXX = g++
CXXFLAGS += -Wall -I./include -I../Core/include
LDFLAGS = -L../$(config) -lCore

INSTALLDIR =/usr/local/bin

APPNAME = application

```

We now see in Application/Makefile that we have some configuration options, though we only need to specify a name for the final executable
The Makefile supports changing of flags for Optimized, Released or Debug builds, custom install directory, and compilation flags.
We see that we can include the core static lib that is compiled along side the application. No further configuration is needed after this unless more compiler options are needed

#### Running 

To see the example project in action
```bash
cd ./ExampleProject
make
make clean
cd ./Core
make
cd ..
cd ./Application
make
```

We see that we can compile all projects, or each one individual, just keep in mind that Application requires libCore.a to be built and present
