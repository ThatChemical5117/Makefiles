# ==== Project Makefile Configurtation ====
# ConsoleApplication Version

# Compiler and Compiler options
CXX = g++
CXXFLAGS = -Wall -I./include -I../Core/include 
LDFLAGS = -L../libs -lCore 

# Directory used to install Application
INSTALLDIR =/usr/local/bin

# Desired Name of the final Executable
APPNAME = app

# Default optimization
ifndef config
	config=debug
endif

# gets passed from main make file
ifeq ($(config),debug)
	CXXFLAGS += -g
else ifeq ($(config),optimize)
	CXXFLAGS += -O3
else ifeq ($(config),release)
	CXXFLAGS += -O3
	CXXFLAGS += -s
endif

# Source and Destination Directorys for all files
BIN = ../bin/$(APPNAME)
OBJDIR = .obj
DEPDIR = .dep
SRCDIR = src

# Finds the locations for Sources, Object, and dependency files
SRC = $(wildcard $(SRCDIR)/*.cpp)
OBJ = $(SRC:$(SRCDIR)/%.cpp=$(OBJDIR)/%.o)
DEP = $(OBJ:$(OBJDIR)/%.o=$(DEPDIR)/%.d)

# ALL rule
all: $(BIN)

#==== Utility Functions ===="
# Clean command, clears all executables and object files
clean:
	rm -f $(OBJ) $(DEP) $(BIN)

# Uninstall Step, remove if not needed
uninstall:
	@echo "==== Uninstalling ($(APPNAME))"
	rm -f $(INSTALLDIR)/$(APPNAME)

# install step, remove if not needed
install: all
	@echo "==== Installing ($(APPNAME)) ($(config))"
	cp -f $(BIN) $(INSTALLDIR)/$(APPNAME)
	chmod 755 $(INSTALLDIR)/$(APPNAME)

#==== Compilation Steps ===="

# FINAL Compilation step, produces final binary
$(BIN): $(OBJ)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

# Generates Dependency Files
$(DEPDIR)/%.d: $(SRCDIR)/%.cpp
	@$(CPP) $(CFLAGS) $< -MM -MT $(@:$(DEPDIR)/%.d=$(OBJDIR)/%.o) >$@

-include $(DEP)

# Compiles all translation units, does each one individually
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	$(CXX) $(CXXFLAGS) -o $@ -c $<
