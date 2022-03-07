LATEX=pdflatex
LATEXOPT=--shell-escape -output-directory=tmp 
NONSTOP=--interaction=batchmode # non verbose output

LATEXMK=latexmk
LATEXMKOPT=-pdf -output-directory=tmp
CONTINUOUS=-pvc

PROJPATH = $(PWD)
PROJNAME = $(notdir $(PROJPATH))
INEXT    = tex
OUTEXT   = pdf
TARGET  := $(PROJNAME)
TSTTGT  := testapp$(EXT)
OUTPUT  := $(TARGET).$(OUTEXT)
INPUT   := $(TARGET).$(INEXT)

SOURCES=$(INPUT) Makefile $(wildcard *.$(INEXT))

all:$(OUTPUT)

.refresh:
	touch .refresh

$(OUTPUT): $(INPUT) .refresh $(SOURCES)
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS)\
		-pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(TARGET)
		cp tmp/$(OUTPUT) .

force:
	touch .refresh
	rm $(OUTPUT)
	$(LATEXMK) $(LATEXMKOPT) $(CONTINUOUS) \
		-pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(TARGET)

clean:
	$(LATEXMK) -C $(TARGET)
	rm -f $(TARGET).pdfsync
	rm -rf tmp/*

once:
	$(LATEXMK) $(LATEXMKOPT) -pdflatex="$(LATEX) $(LATEXOPT) %O %S" $(TARGET)

debug:
	$(LATEX) $(LATEXOPT) $(TARGET)

.PHONY: clean force once all

