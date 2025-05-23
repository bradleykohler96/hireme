BUILDDIR = build
IMAGEDIR = images
IMAGES = $(IMAGEDIR)/*

ifeq ($(OS),Windows_NT)
    CV = awesome-cv-win.cls
	GS = gswin64c.exe
else
    CV = awesome-cv-linux.cls
	GS = gs
endif

all: personal_bio personal_resume

personal_bio: personal_bio.tex ./personal_bio/*.tex
	cp $(CV) awesome-cv.cls
	latexmk -xelatex personal_bio.tex \
	-output-directory=build
	rm -f $(IMAGEDIR)/personal_bio-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/personal_bio-%03d.jpg \
	$(BUILDDIR)/personal_bio.pdf -dBATCH

personal_resume: personal_resume.tex ./personal_resume/*.tex
	cp $(CV) awesome-cv.cls
	latexmk -xelatex personal_resume.tex \
	-output-directory=build
	rm -f $(IMAGEDIR)/personal_resume-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/personal_resume-%03d.jpg \
	$(BUILDDIR)/personal_resume.pdf -dBATCH

clean:
	rm -rf $(BUILDDIR)
	rm -f $(IMAGEDIR)/coop_*.jpg
	rm -f $(IMAGEDIR)/personal_*.jpg
