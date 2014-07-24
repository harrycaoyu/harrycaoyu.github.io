USER       = brizi
SERVER     = flybrizi.com
LOCAL_DIR  = ./_site
REMOTE_DIR = /home/brizi/public_html

LESS_FILES = $(wildcard ./less/*.less ./less/bootstrap/bootstrap.less)
CSS_FILES  = $(subst .less,.css,$(subst /less/,/css/,$(LESS_FILES)))

RFLAGS   = --recursive --verbose -e ssh
SRC_ONLY = $(shell find $(LOCAL_DIR) -depth 1 -not \( -path '$(LOCAL_DIR)/images' -prune \) -not \( -path '$(LOCAL_DIR)/fonts' \))

help:
	@echo ""
	@echo "USER:       $(USER)"
	@echo "SERVER:     $(SERVER)"
	@echo "LOCAL_DIR:  $(LOCAL_DIR)"
	@echo "REMOTE_DIR: $(REMOTE_DIR)"
	@echo ""
	@echo "Usage:"
	@echo "    make login     - logs in to the server"
	@echo "    make build     - builds the CSS and the site"
	@echo "    make clean     - removes all generated files"
	@echo "    make css/*.css - generates the CSS file from its corresponding LESS file"
	@echo ""
	@echo "    make copy_all  - copies everything over using scp to $(REMOTE_DIR) on the server"
	@echo "    make copy_src  - like copy_all, but only copies source files (no images or fonts)"
	@echo "    make sync      - uses rsync to synchronise the local $(LOCAL_DIR) with $(REMOTE_DIR) on the server"
	@echo ""

build: $(CSS_FILES)
	jekyll build

css/main.css: css/bootstrap/bootstrap.css less/bootstrap/bootstrap.less
css/bootstrap/bootstrap.css: $(filter-out ./less/bootstrap/bootstrap.less, $(wildcard ./less/bootstrap/*.less))

css/%.css: less/%.less
	lessc $< > $@

copy_src copy_all sync_src sync_all: build

copy_src:
	scp -r $(SRC_ONLY) $(USER)@$(SERVER):$(REMOTE_DIR)/

copy_all:
	scp -r $(LOCAL_DIR)/* $(USER)@$(SERVER):$(REMOTE_DIR)/

sync:
	rsync $(RFLAGS) $(LOCAL_DIR)/ $(USER)@$(SERVER):$(REMOTE_DIR)/

login:
	ssh $(USER)@$(SERVER)

serve:
	jekyll serve --watch

clean:
	$(RM) -r $(LOCAL_DIR)/*
	$(RM) css/*.css
	$(RM) css/*/*.css

.PHONY: clean build serve login copy_src copy_all sync_src sync_all sync build
