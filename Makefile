FORMS=$(wildcard *.commonform) stock-purchase-agreement.commonform assignment-of-other-assets.commonform indemnification-agreement.commonform
COMMONFORM=node_modules/.bin/commonform
DOCX=$(FORMS:.commonform=.docx)
PDF=$(FORMS:.commonform=.pdf)

all: $(DOCX)

pdf: $(PDF)

$(COMMONFORM):
	npm i

%.pdf: %.docx
	doc2pdf $<

%.docx: %.commonform %.options %.signatures.json $(COMMONFORM)
	$(COMMONFORM) render --format docx --signatures $*.signatures.json $(shell cat $*.options) < $< > $@

%.docx: %.commonform %.options $(COMMONFORM)
	$(COMMONFORM) render --format docx $(shell cat $*.options) < $< > $@

%.commonform: %.commonform.m4
	m4 -I includes < $< > $@

.PHONY: lint critique clean

lint: $(FORMS) $(COMMONFORM)
	for form in $(FORMS); do \
		echo ; \
		echo $$form; \
		$(COMMONFORM) lint < $$form; \
	done; \

critique: $(FORMS) $(COMMONFORM)
	for form in $(FORMS); do \
		echo ; \
		echo $$form ; \
		$(COMMONFORM) critique < $$form; \
	done

clean:
	rm -rf $(DOCX) $(PDF)
