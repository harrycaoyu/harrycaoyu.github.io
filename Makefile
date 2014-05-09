USER        = brizi
SERVER      = flybrizi.com
LOCAL_SITE  = _site
REMOTE_SITE = /home/brizi/public_html/new/

LESS_FILES = $(wildcard ./less/*.less ./less/bootstrap/bootstrap.less)
CSS_FILES  = $(subst .less,.css,$(subst /less/,/css/,$(LESS_FILES)))

build: $(CSS_FILES)
	jekyll build

css/main.css: css/bootstrap/bootstrap.css less/bootstrap/bootstrap.less
css/bootstrap/bootstrap.css: $(filter-out ./less/bootstrap/bootstrap.less, $(wildcard ./less/bootstrap/*.less))

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
	$(RM) css/*.css
	$(RM) css/*/*.css

.PHONY: clean sync build
