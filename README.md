# Makefiles

This project creates template Makefiles to quickly setup one or multiple "Project"/s in one directory similarly to Visual Studio Workspaces and Projects

A Project contains all the source and headers files to create either a executable, static library, or shared (dynamic) library.
These Makefiles allow for auto detection of source files and auto generation of dependency file (.d) if needed.

#### Features

- Automatic source detection
- Automatic dependency generation
- Minimal setup for multiple Projects that depend on each other
- Easy copy and paste

#### Why would I use this?

I made these Makefiles to streamline the process of setting up simple projects, eventually it evolved to include more features, including, install, uninstall, dependency generation, and project linking

This makefile project is Linux only currently
I currently wish to make this project available for multiple platforms

If needed use bear to create a compile_commands.json file for clangd ( This is what I do for NeoVim )

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

There are two project, Application and Core. Both projects have a Makefile that is capable of compiling each project.

Application/Makefile and Core/Makefile are copies of Makefile.prj and Makefile.prj.a respectively

The "workspace Makefile" is just a copy of Makefile.wrk.


Here is the workspace Makefile config
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

Each recipe in this Makefile corresponds to the Directory name each project is in. The recipe can then find it's corresponding Makefile and generate a binary from that.
Since Core is a static library, we make Application dependent on Core in our recipe to make sure libCore.a Exists before building Application.

Under install, uninstall, and clean recipes an entry is used per project within the working directory to call the respective recipe inside the project Makefiles

```Makefile
# ExampleProject/Application/Makefile
# from external file
ifeq ($(config),optimize)
	CXXFLAGS += -O3
else ifeq ($(config),dist)
	CXXFLAGS += -O3
	CXXFLAGS += -s
else
	config=debug
	CXXFLAGS += -g
	CXXFLAGS += -DDEBUG
endif
# Directory used to install Application
INSTALLDIR =/usr/local/bin

# Desired Name of the final Executable
APPNAME = App

# Source and Destination Directory for all files
BINDIR = ../bin/$(config)
BIN = $(BINDIR)/$(APPNAME)
OBJDIR = .obj
DEPDIR = .dep
SRCDIR = src
#
# Finds the locations for Sources, Object, and dependency files
SRC = $(wildcard $(SRCDIR)/*.cpp)
OBJ = $(SRC:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)
DEP = $(OBJ:$(OBJDIR)/%.o=$(DEPDIR)/%.d)


# Compiler and Compiler options
CXX = g++
CXXFLAGS += -Wall -I./include -I../Core/include
LDFLAGS = -L../bin/$(config) -lCore

```

In Application/Makefile the first portion is used to setup compiler flags for optimization, and defines the config options for release, dist, and debug
Alongside that, the debug config defines a DEBUG macro to help include or strip out debug code

We also define the name of the application. Only this needs to be changed before compiling

Optionally a location for binaries can be defined by BINDIR if the default location does not work, or needs to be different for you. 

Finally we define the include and library flags for g++. Note that we need to use -L flag to show where libCore.a is since it's not in our path.
Alternatively, you could use the install recipe to make the library available in $PATH. Same needs to be done for the header files from Core

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
