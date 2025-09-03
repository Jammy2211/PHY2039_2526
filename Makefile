CODE := $(shell grep code config.yml | awk -F ' ' '{print $$2}' | head -n 1)
YEAR := $(shell grep year config.yml | awk -F ' ' '{print $$2}' | head -n 1)
BASE_DIR := $(shell grep base_dir config.yml | awk -F ' ' '{print $$2}' | head -n 1)
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	OPENCMD := open 
else
	OPENCMD := xdg-open
endif
ifeq ($(strip $(CODE)),)
$(error CODE is empty)
endif
ifeq ($(strip $(BASE_DIR)),)
BASE_DIR := module
endif
ifeq ($(strip $(YEAR)),)
$(error YEAR is empty)
endif

build: config.yml $(shell find . -type f -name \*.tex) $(shell find . -type f -name \*.md)
	chirun -vv

local: build
	$(OPENCMD) file://$(shell pwd)/build/index.html

upload: build cleanremote
	ssh webedit@mas-coursebuild.ncl.ac.uk "mkdir -p /srv/www/mas-coursebuild.ncl.ac.uk443/$(BASE_DIR)/$(CODE)/$(YEAR)"
	scp -r ./build/* webedit@mas-coursebuild.ncl.ac.uk:/srv/www/mas-coursebuild.ncl.ac.uk443/$(BASE_DIR)/$(CODE)/$(YEAR)

cleanremote:
	ssh webedit@mas-coursebuild.ncl.ac.uk "rm -rf /srv/www/mas-coursebuild.ncl.ac.uk443/$(BASE_DIR)/$(CODE)/$(YEAR)"

clean:
	rm -rf build tmp
	find . \( -name 'oembed-cache.json' -o -name '*.log' -o -name '*.aux' -o -name '*.out' -o -name '*.nav' -o -name '*.snm' -o -name '*.toc' -o -name '*.fls' \) -exec rm {} \;

all: clean upload
