USER        = ubuntu
SERVER      = 54.86.162.76
LOCAL_SITE  = _site
REMOTE_SITE = /usr/share/nginx/html

LESS_FILES = $(wildcard ./less/*.less ./less/bootstrap/bootstrap.less)
CSS_FILES  = $(subst .less,.css,$(subst /less/,/css/,$(LESS_FILES)))

build: $(CSS_FILES)
	jekyll build

css/main.css: css/bootstrap/bootstrap.css less/bootstrap/bootstrap.less
css/bootstrap/bootstrap.css: $(filter-out ./less/bootstrap/bootstrap.less, $(wildcard ./less/bootstrap/*.less))

css/%.css: less/%.less
	lessc $< > $@

sync_src: build
	-scp -i brizi.pem $(LOCAL_SITE)/* $(USER)@$(SERVER):$(REMOTE_SITE)
	scp -i brizi.pem -r $(LOCAL_SITE)/[!i]* $(USER)@$(SERVER):$(REMOTE_SITE)
	# tar -cvf - $(LOCAL_SITE)/ | ssh $(USER)@$(SERVER) tar -xf - -C $(REMOTE_SITE)

sync_all: build
	# Individual photos: for testing purposes only!
	# scp -i brizi.pem BRIZI-IMG/output.jpg ubuntu@54.86.162.76:/usr/share/nginx/html/images
	scp -i brizi.pem -r $(LOCAL_SITE)/* $(USER)@$(SERVER):$(REMOTE_SITE)
	ssh -i brizi.pem $(USER)@$(SERVER) "chmod 775 /usr/share/nginx/html/images/* && exit"
	# /usr/bin/rsync --dry-run --recursive --verbose -e ssh $(LOCAL_SITE)/ $(USER)@$(SERVER):$(REMOTE_SITE)

login:
	ssh -i brizi.pem $(USER)@$(SERVER)

serve:
	jekyll serve --watch

nuke:
	ssh -i brizi.pem $(USER)@$(SERVER) "cd $(REMOTE_SITE) && rm -r ./*"

clean:
	$(RM) -r $(LOCAL_SITE)/*
	$(RM) css/*.css
	$(RM) css/*/*.css

.PHONY: clean build
