# ==== Project Makefile Configuration ====
# Console Application Version
#
# gets passed from main make file
ifeq ($(config),Optimize)
	CXXFLAGS += -O3
else ifeq ($(config),Release)
	CXXFLAGS += -O3
	CXXFLAGS += -s
else
	config=Debug
	CXXFLAGS += -g
endif

# Compiler and Compiler options, EDIT as needed
CXX = g++
CXXFLAGS += -Wall -I./include -I../Core/include
LDFLAGS = -L../$(config) -lCore

# Directory used to install Application
INSTALLDIR =/usr/local/bin

# Desired Name of the final Executable
APPNAME = application

# Source and Destination Directory for all files
BIN = ../$(config)/$(APPNAME)
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
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

# Generates Dependency Files
$(DEPDIR)/%.d: $(SRCDIR)/%.cpp
	@mkdir -p $(@D)
	@$(CPP) $(CXXFLAGS) $< -MM -MT $(@:$(DEPDIR)/%.d=$(OBJDIR)/%.o) >$@

# Tell make to use dependency file
-include $(DEP)

# Compiles all translation units, does each one individually
$(OBJDIR)/%.o: $(SRCDIR)/%.cpp
	@mkdir -p $(@D)
	$(CXX) $(CXXFLAGS) -o $@ -c $<
