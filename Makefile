USER        = brizi
SERVER      = flybrizi.com
LOCAL_SITE  = _site
REMOTE_SITE = /home/brizi/public_html/new/

LESS_FILES = $(wildcard ./less/*.less)
CSS_FILES  = $(subst .less,.css,$(subst /less/,/css/,$(LESS_FILES)))

build: $(CSS_FILES)
	jekyll build

css/%.css: less/%.less
	lessc $< > $@

sync: build
	scp -r $(LOCAL_SITE)/* $(USER)@$(SERVER):$(REMOTE_SITE)

serve:
	jekyll serve --watch

nuke:
	ssh $(USER)@$(SERVER) "cd $(REMOTE_SITE) && rm -r ./*"

clean:
	$(RM) -r $(LOCAL_SITE)/*
	$(RM) css/*

.PHONY: clean sync build
