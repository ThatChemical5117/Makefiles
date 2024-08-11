# ==== Workspace Global Make file ====
# Put this make file in the root directory of your project

# configuration default
ifndef config
	config = debug
endif

#Add All project names, Project name should be the same as the Directory it is in
# keep adding additional project names after 
PROJECTS := Application Core
.PHONY: all clean $(PROJECTS) uninstall install 

all: $(PROJECTS)

# Add individual rules for each project with the same format,
# Rule can be copied, replace the name before the separator.
# add Static and Shared libraries as dependencies.

# EXAMPLE: 
# !!! Core is also the name of the directory that the project is in !!! 
# Core: 
# 	@echo "==== Building ($@) ($(Core)) ===="
#	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(config)
#
# !!! NOTE: Application depends on Core to be built before compiling !!!
# Application: Core
# 	@echo "==== Building ($@) ($(Application)) ===="
#	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(config) WRKDIR=$(@)


Core:
	@echo "==== Building ($@) ($(config)) ===="
	@$(MAKE) --no-print-directory -f $(@)/Makefile config=$(config) WRKDIR=$(@)


Application: Core
	@echo "==== Building ($@) ($(config)) ===="
	@$(MAKE) --no-print-directory -f $(@)/Makefile config=$(config) WRKDIR=$(@)

#add Extra rules with the same format, Use name of directory that project is in 

install: all
	@$(MAKE) --no-print-directory -f Application/Makefile install config=$(config) WRKDIR=Application
	@$(MAKE) --no-print-directory -f Core/Makefile install config=$(config) WRKDIR=Core

uninstall:
	@$(MAKE) --no-print-directory -f Application/Makefile uninstall WRKDIR=Application
	@$(MAKE) --no-print-directory -f Core/Makefile uninstall WRKDIR=Core

# add a line for each project, use Directory name
clean:
	@${MAKE} --no-print-directory -f Application/Makefile clean WRKDIR=Application
	@${MAKE} --no-print-directory -f Core/Makefile clean WRKDIR=Core
