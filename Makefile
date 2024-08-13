# ==== Workspace Global Make file ====
# Put this make file in the root directory of your project

# configuration default
ifndef config
	config = debug
endif

#Add All project names, Project name should be the same as the Directory it is in
# keep adding additional project names after 
PROJECTS := "REPLACEAPPNAME" 
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
#	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(config)

"REPLACEAPPNAME": 
	@echo "==== Building ($@) ($(config)) ===="
	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(config)

#add Extra rules with the same format, Use name of directory that project is in 

install: all
	@$(MAKE) --no-print-directory -C "REPLACEAPPNAME" -f Makefile install config=$(config)

uninstall:
	@$(MAKE) --no-print-directory -C "REPLACEAPPNAME" -f Makefile uninstall 

# add a line for each project, use Directory name
clean:
	@${MAKE} --no-print-directory -C "REPLACEAPPNAME" -f Makefile clean
