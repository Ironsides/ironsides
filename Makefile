FORMS=$(wildcard *.commonform)
COMMONFORM=node_modules/.bin/commonform

all: $(FORMS:.commonform=.docx)

$(COMMONFORM):
	npm i

%.docx: %.commonform %.options %.signatures.json $(COMMONFORM)
	$(COMMONFORM) render --format docx --signatures $*.signatures.json $(shell cat $*.options) < $< > $@

%.docx: %.commonform %.options $(COMMONFORM)
	$(COMMONFORM) render --format docx $(shell cat $*.options) < $< > $@

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
		echo $$form \ ;
		$(COMMONFORM) critique < $$form; \
	done

clean:
	rm -rf *.docx
