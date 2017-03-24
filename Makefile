YMLDIR := yaml
YMLS := $(wildcard $(YMLDIR)/*.yaml)

TEXDIR := tex
TEXS := $(patsubst $(YMLDIR)/%.yaml, $(TEXDIR)/%.tex, $(YMLS))

PDFDIR := tex
PDFS := $(patsubst $(YMLDIR)/%.yaml, $(PDFDIR)/%.pdf, $(YMLS))

.PHONY: clean prepare commit all

all: $(TEXS) $(PDFS)

prepare:
	go get -u github.com/protograph/protographer/cmd/protographer
	docker pull yukinying/latex

clean:
	rm -f $(TEXS)

commit:
	git add $(TEXS) $(PDFS)

$(TEXDIR)/%.tex: $(YMLDIR)/%.yaml
	protographer -outdir $(TEXDIR) $<

$(PDFDIR)/%.pdf: $(TEXDIR)/%.tex
	docker run -v ${CURDIR}/$(TEXDIR):/tex --workdir /tex --rm --name latex yukinying/latex pdflatex --halt-on-error "/$<"
