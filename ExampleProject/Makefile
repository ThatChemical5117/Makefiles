# ==== Workspace Global Make file ====
# Put this make file in the root directory of your project

# configuration default
ifndef config
	config = debug
endif

# Core should be the name of the directory the project is stored in
# IF multiple projects, add the name of it's directory and set equal to config ( release, optimze, debug )
ifeq ($(config),release)
	Core = release
	Application = release
else ifeq ($(config),optimize)
	Core = optimize
	Application = optimize
else ifeq ($(config),debug)
	Core = debug
	Application = debug
endif	

#Add All project names, Project name should be the same as the Directory it is in
# keep adding aditional project names after 
PROJECTS := Core Application 
.PHONY: all clean $(PROJECTS) uninstall install 

all: $(PROJECTS)

# Add idividule rules for each project with the same format,
# Rule can be copied, replace the name before the seperator.
# add Static and Shared libs as dependencies.
Core: 
	@echo "==== Building ($@) ($(Core)) ===="
	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(Core)


Application: Core
	@echo "==== Building ($@) ($(Application)) ==== "
	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(Application)

#add Extra rules with the same format, Use name of diretory that project is in 

install: all
	@$(MAKE) --no-print-directory -C Application -f Makefile install config=$(Core)

uninstall:
	@$(MAKE) --no-print-directory -C Application -f Makefile uninstall

# add a line for each project, use Directory name
clean:
	@${MAKE} --no-print-directory -C Core -f Makefile clean
	@${MAKE} --no-print-directory -C Application -f Makefile clean
