FORMS=$(wildcard *.commonform)
COMMONFORM=node_modules/.bin/commonform
MUSTACHE=node_modules/.bin/mustache
BLANKS=blanks.json

all:

docx: $(FORMS:.commonform=.docx)

html: $(FORMS:.commonform=.html)

pdf: $(FORMS:.commonform=.pdf)

$(COMMONFORM):
	npm i

$(MUSTACHE):
	npm i

%.pdf: %.docx
	doc2pdf $<

%.options: %.options-template $(BLANKS) $(MUSTACHE)
	$(MUSTACHE) $(BLANKS) $*.options-template > $@

%.docx: %.commonform %.options $(BLANKS) $(COMMONFORM) $(MUSTACHE)
	$(MUSTACHE) $(BLANKS) $*.commonform | \
	$(COMMONFORM) render --format docx --blanks $(BLANKS) $(shell cat $*.options) > $@

%.html: %.commonform %.options $(BLANKS) $(COMMONFORM)
	$(MUSTACHE) $(BLANKS) $*.commonform | \
	$(COMMONFORM) render --format html5 --blanks $(BLANKS) $(shell cat $*.options) > $@

.PHONY: clean test variants

variants:
	rm -rf variants
	for form in $(FORMS); do \
		base=$$(basename $$form .commonform) ; \
		node generate-variants.js $$base; \
	done

test: variants $(COMMONFORM)
	for variant in variants/* ; do \
		echo ; \
		echo $$variant; \
		$(COMMONFORM) lint < $$variant; \
	done; \

clean:
	git clean -fdx

share: variants $(COMMONFORM)
	for variant in variants/* ; do \
		echo $$variant; \
		$(COMMONFORM) share < $$variant; \
	done
