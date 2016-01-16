TEMPLATES = $(wildcard *.cftemplate)
PURCHASE_AGREEMENTS = $(addsuffix .cform,$(addprefix purchase-agreement-,single-cash single-ip single-mixed double-cash double-ip double-mixed))
FORMS = $(filter-out purchase-agreement.cform,$(TEMPLATES:.cftemplate=.cform)) $(PURCHASE_AGREEMENTS)
COMMONFORM = node_modules/.bin/commonform
CFTEMPLATE = node_modules/.bin/cftemplate
DOCX = $(FORMS:.cform=.docx)
PDF = $(FORMS:.cform=.pdf)
VERSION = $(strip $(shell git tag -l --points-at HEAD))

all: $(DOCX)

pdf: $(PDF)

$(COMMONFORM) $(CFTEMPLATE):
	npm i

%.pdf: %.docx
	doc2pdf $<

%.docx: %.cform %.options_with_version %.sigs.json $(COMMONFORM)
	$(COMMONFORM) render --format docx --signatures $*.sigs.json $(shell cat $*.options_with_version) < $< > $@

%.docx: %.cform %.options_with_version $(COMMONFORM)
	$(COMMONFORM) render --format docx $(shell cat $*.options_with_version) < $< > $@

%.cform: $(CFTEMPLATE) %.cftemplate %.options.json
	$^ > $@

purchase-agreement-%.sigs.json: purchase-agreement.sigs.json
	cp $< $@

purchase-agreement-%.options.json: generate-options.js
	node $< $@ > $@

purchase-agreement-%.cftemplate: purchase-agreement.cftemplate
	cp $< $@

purchase-agreement-%.options: purchase-agreement.options
	cp $< $@

%.options_with_version: %.options
ifeq ($(VERSION),)
	cat $< | sed 's/VERSION/Ironsides Development Draft/' > $@
else
	cat $< | sed 's/VERSION/Ironsides $(VERSION)/' > $@
endif

%.options.json:
	echo "{}" > $@

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
