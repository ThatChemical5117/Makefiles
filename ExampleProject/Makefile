# ==== Workspace Global Make file ====
# Put this make file in the root directory of your project

# configuration default
ifndef config
	config = Debug
endif

#Add All project names, Project name should be the same as the Directory it is in
# keep adding additional project names after 
PROJECTS := Application Core
.PHONY: all clean $(PROJECTS) uninstall install 

all: $(PROJECTS)

# Add individual rules for each project with the same format,
# Rule can be copied, replace the name before the separator.
# add Static and Shared libraries as dependencies.

Core:
	@echo "==== Building ($@) ($(config)) ===="
	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(config)


Application: Core
	@echo "==== Building ($@) ($(config)) ===="
	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(config)

#add Extra rules with the same format, Use name of directory that project is in 

install: all
	@$(MAKE) --no-print-directory -C Application -f Makefile install config=$(config)
	@$(MAKE) --no-print-directory -C Core -f Makefile install config=$(config)

uninstall:
	@$(MAKE) --no-print-directory -C Application -f Makefile uninstall 
	@$(MAKE) --no-print-directory -C Core -f Makefile uninstall 

# add a line for each project, use Directory name
clean:
	@${MAKE} --no-print-directory -C Application -f Makefile clean
	@${MAKE} --no-print-directory -C Core -f Makefile clean
