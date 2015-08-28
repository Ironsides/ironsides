FORMS=$(wildcard *.commonform)
COMMONFORM=node_modules/.bin/commonform
MUSTACHE=node_modules/.bin/mustache
BLANKS=blanks.json

all: $(FORMS:.commonform=.docx)

$(COMMONFORM):
	npm i --save commonform/commonform-cli

$(MUSTACHE):
	npm i --save mustache

%.title: %.title-template $(BLANKS) $(MUSTACHE)
	$(MUSTACHE) $(BLANKS) $*.title-template > $@

%.docx: %.commonform %.title $(BLANKS) $(COMMONFORM)
	commonform render --format docx --blanks $(BLANKS) --title "$(shell cat $*.title)" < $*.commonform > $@

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
