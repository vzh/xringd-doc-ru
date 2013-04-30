.PHONY: all fmt view clean force help

manpage  := ru/xringd.8
conffile := ru/xringd.conf
readme   := ru/README

ru       := $(manpage) $(conffile) $(readme)

pofile   := $(ru/manpage:%=%.po)
addfile  := $(ru/manpage:%=%.add)

OPTIONS :=

all: $(ru)

force: OPTIONS := -k 0
force: $(manpage)

$(ru): $(pofile) $(addfile)
	po4a ${OPTIONS} po4a.conf

fmt: $(pofile)
	msgconv $< -o tmp.po && mv tmp.po $<

view: $(manpage)
	man -l $<

clean:
	-rm -f $(ru)

help:
	@echo "Translation of the xringd documentation into Russian"
	@echo ""
	@echo "Targets:"
	@echo "  all  :  make the Russian translation files"
	@echo "  force:  make the translation files regardless of the"
	@echo "            percent of the translation completeness"
	@echo "  fmt  :  format the ru.po template"
	@echo "  view :  view the translated man file"
	@echo "  clean:  remove unneeded files"
	@echo "  help :  this help"
