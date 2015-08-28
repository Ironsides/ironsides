FORMS=$(wildcard *.commonform)
COMMONFORM=node_modules/.bin/commonform
MUSTACHE=node_modules/.bin/mustache
BLANKS=blanks.json

all: $(FORMS:.commonform=.docx)

$(CF):
	npm i --save commonform-cli

$(MUSTACHE):
	npm i --save mustache

%.title: %.title-mustache $(BLANKS) $(MUSTACHE)
	$(MUSTACHE) $(BLANKS) $*.title-mustache > $@

%.docx: %.commonform %.title $(BLANKS) $(COMMONFORM)
	commonform render --format docx --blanks $(BLANKS) --title "$(shell cat $*.title)" < $*.commonform > $@

.PHONY: test

test:
	@for form in $(FORMS); do \
		echo $$form; \
		$(COMMONFORM) lint < $$form && echo 'No structural errors'; \
	done
