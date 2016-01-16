TEMPLATES = $(wildcard *.cftemplate)
PURCHASE_AGREEMENTS = $(addsuffix .cform,$(addprefix purchase-agreement-,single-cash single-ip single-mixed double-cash double-ip double-mixed))
FORMS = $(filter-out purchase-agreement.cform,$(TEMPLATES:.cftemplate=.cform)) $(PURCHASE_AGREEMENTS)
COMMONFORM = node_modules/.bin/commonform
CFTEMPLATE = node_modules/.bin/cftemplate
DOCX = $(FORMS:.cform=.docx)
PDF = $(FORMS:.cform=.pdf)

all: $(DOCX)

pdf: $(PDF)

$(COMMONFORM) $(CFTEMPLATE):
	npm i

%.pdf: %.docx
	doc2pdf $<

%.docx: %.cform %.options %.sigs.json $(COMMONFORM)
	$(COMMONFORM) render --format docx --signatures $*.sigs.json $(shell cat $*.options) < $< > $@

%.docx: %.cform %.options $(COMMONFORM)
	$(COMMONFORM) render --format docx $(shell cat $*.options) < $< > $@

%.cform: $(CFTEMPLATE) %.cftemplate %.json
	$^ > $@

purchase-agreement-%.sigs.json: purchase-agreement.sigs.json
	cp $< $@

purchase-agreement-%.json: generate-options.js
	node $< $@ > $@

purchase-agreement-%.cftemplate: purchase-agreement.cftemplate
	cp $< $@

purchase-agreement-%.options: purchase-agreement.options
	cp $< $@

%.json:
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
