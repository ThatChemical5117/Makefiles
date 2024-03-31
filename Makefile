# ==== Workspace Global Make file ====
# Put this make file in the root directory of your project

# configuration default
ifndef config
	config = debug
endif

# "REPLACEAPPNAME" should be the name of the directory the project is stored in
# IF multiple projects, add the name of it's directory and set equal to config ( release, optimze, debug )
ifeq ($(config),release)
	"REPLACEAPPNAME" = release
else ifeq ($(config),optimize)
	"REPLACEAPPNAME" = optimize
else ifeq ($(config),debug)
	"REPLACEAPPNAME" = debug
endif	

#Add All project names, Project name should be the same as the Directory it is in
# keep adding aditional project names after 
PROJECTS := "REPLACEAPPNAME" 
.PHONY: all clean $(PROJECTS) uninstall install 

all: $(PROJECTS)

# Add idividule rules for each project with the same format,
# Rule can be copied, replace the name before the seperator.
# add Static and Shared libs as dependencies.

# EXAMPLE: 
# !!! Core is also the name of the directory that the project is in !!! 
# Core: 
# 	@echo "==== Building ($@) ($(Core)) ===="
#	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(Core)
#
# !!! NOTE: Application depends on Core to be built before compiling !!!
# Application: Core
# 	@echo "==== Building ($@) ($(Application)) ===="
#	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$(Application)

"REPLACEAPPNAME": 
	@echo "==== Building ($@) ($("REPLACEAPPNAME")) ===="
	@$(MAKE) --no-print-directory -C $@ -f Makefile config=$("REPLACEAPPNAME")

#add Extra rules with the same format, Use name of diretory that project is in 

install: all
	@$(MAKE) --no-print-directory -C "REPLACEAPPNAME" -f Makefile install config=$("REPLACEAPPNAME")

uninstall:
	@$(MAKE) --no-print-directory -C "REPLACEAPPNAME" -f Makefile uninstall

# add a line for each project, use Directory name
clean:
	@${MAKE} --no-print-directory -C "REPLACEAPPNAME" -f Makefile clean
