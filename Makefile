FORMS=$(wildcard *.commonform)
COMMONFORM=node_modules/.bin/commonform
MUSTACHE=node_modules/.bin/mustache
BLANKS=blanks.json

all: docx html

docx: $(FORMS:.commonform=.docx)

html: $(FORMS:.commonform=.html)

$(COMMONFORM):
	npm i --save commonform/commonform-cli

$(MUSTACHE):
	npm i --save mustache

%.title: %.title-template $(BLANKS) $(MUSTACHE)
	$(MUSTACHE) $(BLANKS) $*.title-template > $@

%.docx: %.commonform %.title $(BLANKS) $(COMMONFORM)
	$(COMMONFORM) render --format docx --blanks $(BLANKS) --title "$(shell cat $*.title)" < $*.commonform > $@

%.html: %.commonform %.title $(BLANKS) $(COMMONFORM)
	$(COMMONFORM) render --format html5 --blanks $(BLANKS) --title "$(shell cat $*.title)" < $*.commonform > $@

.PHONY: clean test

test: $(COMMONFORM)
	@for form in $(FORMS); do \
		echo $$form; \
		$(COMMONFORM) lint < $$form && echo 'No structural errors'; \
	done

clean:
	git clean -fdx

share: $(COMMONFORM)
	@for form in $(FORMS); do \
		echo $$form; \
		$(COMMONFORM) share < $$form; \
	done
