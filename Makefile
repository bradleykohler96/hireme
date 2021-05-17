BUILDDIR = build
IMAGEDIR = images
IMAGES = $(IMAGEDIR)/*

ifeq ($(OS),Windows_NT)
	GS = gswin64c.exe
else
	GS = gs
endif

all: coop_nominee_bio coop_personal_statement personal_bio personal_resume

coop_nominee_bio: studentbrad_coop_nominee_bio.tex
	latexmk -xelatex studentbrad_coop_nominee_bio.tex \
	-output-directory=build
	rm -f $(IMAGEDIR)/studentbrad_coop_nominee_bio-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/studentbrad_coop_nominee_bio-%03d.jpg \
	$(BUILDDIR)/studentbrad_coop_nominee_bio.pdf -dBATCH

coop_personal_statement: studentbrad_coop_personal_statement.tex
	latexmk -xelatex studentbrad_coop_personal_statement.tex \
	-output-directory=build
	rm -f $(IMAGEDIR)/studentbrad_coop_personal_statement-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/studentbrad_coop_personal_statement-%03d.jpg \
	$(BUILDDIR)/studentbrad_coop_personal_statement.pdf -dBATCH

personal_bio: studentbrad_personal_bio.tex ./personal_bio/*.tex
	latexmk -xelatex studentbrad_personal_bio.tex \
	-output-directory=build
	rm -f $(IMAGEDIR)/studentbrad_personal_bio-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/studentbrad_personal_bio-%03d.jpg \
	$(BUILDDIR)/studentbrad_personal_bio.pdf -dBATCH

personal_resume: studentbrad_personal_resume.tex ./personal_resume/*.tex
	latexmk -xelatex studentbrad_personal_resume.tex \
	-output-directory=build
	rm -f $(IMAGEDIR)/studentbrad_personal_resume-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/studentbrad_personal_resume-%03d.jpg \
	$(BUILDDIR)/studentbrad_personal_resume.pdf -dBATCH

clean:
	rm -rf $(BUILDDIR)
	rm $(IMAGEDIR)/studentbrad_*.jpg
