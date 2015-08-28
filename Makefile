FORMS=$(wildcard *.commonform)
COMMONFORM=node_modules/.bin/commonform
MUSTACHE=node_modules/.bin/mustache
BLANKS=blanks.json

all:

docx: $(FORMS:.commonform=.docx)

html: $(FORMS:.commonform=.html)

$(COMMONFORM):
	npm i

$(MUSTACHE):
	npm i

%.title: %.title-template $(BLANKS) $(MUSTACHE)
	$(MUSTACHE) $(BLANKS) $*.title-template > $@

%.docx: %.commonform %.title $(BLANKS) $(COMMONFORM) $(MUSTACHE)
	$(MUSTACHE) $(BLANKS) $*.commonform | \
	$(COMMONFORM) render --format docx --number outline --blanks $(BLANKS) --title "$(shell cat $*.title)" > $@

%.html: %.commonform %.title $(BLANKS) $(COMMONFORM)
	$(MUSTACHE) $(BLANKS) $*.commonform | \
	$(COMMONFORM) render --format html5 --blanks $(BLANKS) --title "$(shell cat $*.title)" > $@

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
