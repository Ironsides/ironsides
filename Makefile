TEMPLATES=$(wildcard *.cform.m4)
FORMS=$(filter-out purchase-agreement.cform,$(TEMPLATES:.cform.m4=.cform)) purchase-agreement-single.cform purchase-agreement-double.cform
COMMONFORM=node_modules/.bin/commonform
MUSTACHE=node_modules/.bin/mustache
DOCX=$(FORMS:.cform=.docx)
PDF=$(FORMS:.cform=.pdf)

all: $(DOCX)

pdf: $(PDF)

$(COMMONFORM):
	npm i

$(MUSTACHE):
	npm i

%.pdf: %.docx
	doc2pdf $<

%.docx: %.cform %.options %.sigs.json $(COMMONFORM)
	$(COMMONFORM) render --format docx --signatures $*.sigs.json $(shell cat $*.options) < $< > $@

%.docx: %.cform %.options $(COMMONFORM)
	$(COMMONFORM) render --format docx $(shell cat $*.options) < $< > $@

%.cform: %.cform.m4
	m4 < $< > $@

%.cform.m4: purchase-agreement.cform.m4 %.json
	$(MUSTACHE) $*.json $< > $@

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
