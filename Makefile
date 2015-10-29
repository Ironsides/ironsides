TEMPLATES=$(wildcard *.cform.m4)
FORMS=$(TEMPLATES:.cform.m4=.cform)
COMMONFORM=node_modules/.bin/commonform
DOCX=$(FORMS:.cform=.docx)
PDF=$(FORMS:.cform=.pdf)

all: $(DOCX)

pdf: $(PDF)

$(COMMONFORM):
	npm i

%.pdf: %.docx
	doc2pdf $<

%.docx: %.cform %.options %.sigs.json $(COMMONFORM)
	$(COMMONFORM) render --format docx --signatures $*.sigs.json $(shell cat $*.options) < $< > $@

%.docx: %.cform %.options $(COMMONFORM)
	$(COMMONFORM) render --format docx $(shell cat $*.options) < $< > $@

%.cform: %.cform.m4
	m4 < $< > $@

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
	rm -rf $(DOCX) $(PDF) $(FORMS)
