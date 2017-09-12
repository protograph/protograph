DIRS := crypto e2e fido oauth saml tls
SOURCES := $(foreach dir,$(DIRS),$(wildcard $(dir)/*.md))
OBJECTS := $(SOURCES:%.md=%.tex)
PDFS := $(SOURCES:%.md=%.pdf)
LOGS := $(SOURCES:%.md=%.aux) $(SOURCES:%.md=%.log) $(SOURCES:%.md=%.out)

%.tex: %.md
	@protographer -in $< -out $@

%.pdf: %.tex
	@docker run -v ${CURDIR}/$(dir $<):/tex --workdir /tex --rm --name latex yukinying/latex pdflatex --halt-on-error "$(notdir $<)" >/dev/null
	@echo "transformed $< to $@"

.PHONY: clean clean-logs prepare commit all

all: $(OBJECTS) $(PDFS)

prepare:
	go get -u github.com/protograph/protographer/cmd/protographer
	docker pull yukinying/latex

clean:
	rm -f $(LOGS)
	rm -f $(OBJECTS)
	rm -f $(PDFS)

commit:
	git add $(OBJECTS) $(PDFS)
	git commit -m 'generated TeX and PDF from Travis [skip ci]'
	git remote add deploy git@github.com:protograph/protograph.git
	GIT_SSH_COMMAND='ssh -i deploy.key' git push deploy HEAD:master
