BLANKS=blanks.json
FORMS=$(wildcard *.commonform)
COMMONFORM=node_modules/.bin/commonform
MUSTACHE=node_modules/.bin/mustache
JSON=node_modules/.bin/json
FOUNDERS=1 2
PER_COMPANY=action-of-incorporator board-resolutions bylaws certificate-of-incorporation incorporator-certificate-of-adoption indemnification-agreement indemnification-agreement-resolutions secretary-certificate-of-adption
PER_FOUNDER=stock-purchase-agreement assignment-of-other-assets stock-power receipt 83-b-election receipt-and-consent 83-b-statement-acknowledgement indemnification-agreement
FOUNDER=$(foreach form,$(PER_FOUNDER),$(foreach founder,$(FOUNDERS),$(form)-$(founder)))

all: pdfs.zip

pdfs.zip: pdf
	zip $@ *.pdf

docx: $(PER_COMPANY:=.docx) $(FOUNDER:=.docx)

html: $(PER_COMPANY:=.html) $(FOUNDER:=.html)

pdf: $(PER_COMPANY:=.pdf) $(FOUNDER:=.pdf)

$(COMMONFORM):
	npm i

$(MUSTACHE):
	npm i

$(JSON):
	npm i

%.pdf: %.docx
	doc2pdf $<

%.blanks.json: $(BLANKS) $(JSON)
	node -e "var j = require('./$(BLANKS)'); console.log(JSON.stringify(j), '\n', JSON.stringify(j['Stock Purchasers'][$* - 1]))"  | \
	$(JSON) --merge > $@

%-1.sigs.json: 1.blanks.json %.sigs $(MUSTACHE)
	$(MUSTACHE) 1.blanks.json $*.sigs > $@

%-2.sigs.json: 2.blanks.json %.sigs $(MUSTACHE)
	$(MUSTACHE) 2.blanks.json $*.sigs > $@

%.options: %.options-template $(BLANKS) $(MUSTACHE)
	$(MUSTACHE) $(BLANKS) $*.options-template > $@

%-1.docx: %.commonform %.options %-1.sigs.json 1.blanks.json $(COMMONFORM) $(MUSTACHE)
	$(COMMONFORM) render --format docx --blanks 1.blanks.json --signatures $*-1.sigs.json $(shell cat $*.options) < $< > $@

%-2.docx: %.commonform %.options %-2.sigs.json 2.blanks.json $(COMMONFORM) $(MUSTACHE)
	$(COMMONFORM) render --format docx --blanks 2.blanks.json --signatures $*-2.sigs.json $(shell cat $*.options) < $< > $@

%.sigs.json: %.sigs $(BLANKS) $(MUSTACHE)
	$(MUSTACHE) $(BLANKS) $*.sigs | sed 's/,]/]/' > $@

%.docx: %.commonform %.options %.sigs.json $(BLANKS) $(COMMONFORM) $(MUSTACHE)
	$(COMMONFORM) render --format docx --blanks $(BLANKS) --signatures $*.sigs.json $(shell cat $*.options) < $< > $@

%.docx: %.commonform %.options $(BLANKS) $(COMMONFORM) $(MUSTACHE)
	$(COMMONFORM) render --format docx --blanks $(BLANKS) $(shell cat $*.options) < $< > $@

%.html: %.commonform %.options $(BLANKS) $(COMMONFORM)
	$(COMMONFORM) render --format html5 --blanks $(BLANKS) $(shell cat $*.options) < $< > $@

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
	git clean -fdx
