TEMPLATES = $(wildcard *.cform.template)
PURCHASE_AGREEMENTS = $(addsuffix .cform,$(addprefix purchase-agreement-,single-cash single-ip single-mixed double-cash double-ip double-mixed))
FORMS = $(filter-out purchase-agreement.cform,$(TEMPLATES:.cform.template=.cform)) $(PURCHASE_AGREEMENTS)
COMMONFORM = node_modules/.bin/commonform
MUSTACHE = node_modules/.bin/mustache
PLAINTEMPLATE = node_modules/plaintemplate
DOCX = $(FORMS:.cform=.docx)
PDF = $(FORMS:.cform=.pdf)

all: $(DOCX)

pdf: $(PDF)

$(COMMONFORM) $(MUSTACHE) $(PLAINTEMPLATE):
	npm i

%.pdf: %.docx
	doc2pdf $<

%.docx: %.cform %.options %.sigs.json $(COMMONFORM)
	$(COMMONFORM) render --format docx --signatures $*.sigs.json $(shell cat $*.options) < $< > $@

%.docx: %.cform %.options $(COMMONFORM)
	$(COMMONFORM) render --format docx $(shell cat $*.options) < $< > $@

%.cform: %.cform.template preprocess $(PLAINTEMPLATE)
	./preprocess < $< > $@

%.cform.template: purchase-agreement.cform.template %.json $(MUSTACHE)
	$(MUSTACHE) $*.json $< > $@

$(PURCHASE_AGREEMENTS:.cform=.json): generate-options.js
	node $< $@ > $@

$(PURCHASE_AGREEMENTS:.cform=.options): purchase-agreement.options
	cp $< $@

$(PURCHASE_AGREEMENTS:.cform=.sigs.json): purchase-agreement.sigs.json
	cp $< $@

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
