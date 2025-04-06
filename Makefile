# Makefile for Cover Letter Template

# Compiler Tool
LATEXMK = latexmk
# Options for XeLaTeX
LATEXMK_OPTIONS = -xelatex -interaction=nonstopmode -shell-escape

# Class file (common dependency)
CLS_FILE = coverletter.cls

# --- Find ALL .tex files ---
ALL_TEX_SOURCES := $(wildcard *.tex)
# --- Create list of corresponding .pdf files for ALL sources ---
ALL_PDF_TARGETS := $(patsubst %.tex,%.pdf,$(ALL_TEX_SOURCES))

# --- Find non-example .tex files for the DEFAULT build ---
DEFAULT_TEX_SOURCES := $(filter-out example_letter.tex, $(ALL_TEX_SOURCES))
# --- Create list of corresponding .pdf files for DEFAULT build ---
DEFAULT_PDF_TARGETS := $(patsubst %.tex,%.pdf,$(DEFAULT_TEX_SOURCES))


# Default target: Build all non-example .pdf files
# Phony targets are labels, not actual files to be built/checked
.PHONY: default all example clean

# The target that runs when you just type 'make'
default: $(DEFAULT_PDF_TARGETS)

# Target to build ALL pdfs, including the example
all: $(ALL_PDF_TARGETS)

# Target to build the example letter specifically
example: example_letter.pdf

# Generic Pattern Rule for building any .pdf from a .tex file
# Depends on the .tex file and the common class file.
# Ensure required images are present for the specific .tex file being built.
%.pdf: %.tex $(CLS_FILE)
	@echo "--- Building $(@) from $(<) using latexmk ---"
	$(LATEXMK) $(LATEXMK_OPTIONS) $(<)
	@echo "--- Finished building $(@) ---"


# Clean up generated files
# Use latexmk's general clean (-C) and remove all generated PDFs
clean:
	@echo "--- Cleaning up generated files ---"
	$(LATEXMK) -C
	rm -f *.pdf
	@echo "--- Cleanup complete ---"

# Optional: Command to clean all latexmk generated files in the directory
# clean-all:
#	$(LATEXMK) -C 