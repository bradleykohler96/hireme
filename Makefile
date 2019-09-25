BUILDDIR = build
IMAGEDIR = images
IMAGES = $(IMAGEDIR)/*

ifeq ($(OS),Windows_NT)
	GS = gswin64c.exe
else
	GS = gs
endif

all: coop_contribution coop_nominee_bio coop_personal_statement personal_resume personal_bio

coop_contribution: studentbrad_coop_contribution.tex
	latexmk -xelatex studentbrad_coop_contribution.tex \
	-output-directory=build
	rm $(IMAGEDIR)/studentbrad_coop_contribution-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/studentbrad_coop_contribution-%03d.jpg \
	$(BUILDDIR)/studentbrad_coop_contribution.pdf -dBATCH

coop_nominee_bio: studentbrad_coop_nominee_bio.tex
	latexmk -xelatex studentbrad_coop_nominee_bio.tex \
	-output-directory=build
	rm $(IMAGEDIR)/studentbrad_coop_nominee_bio-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/studentbrad_coop_nominee_bio-%03d.jpg \
	$(BUILDDIR)/studentbrad_coop_nominee_bio.pdf -dBATCH

coop_personal_statement: studentbrad_coop_personal_statement.tex
	latexmk -xelatex studentbrad_coop_personal_statement.tex \
	-output-directory=build
	rm $(IMAGEDIR)/studentbrad_coop_personal_statement-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/studentbrad_coop_personal_statement-%03d.jpg \
	$(BUILDDIR)/studentbrad_coop_personal_statement.pdf -dBATCH

personal_resume: studentbrad_resume.tex ./resume/*.tex
	latexmk -xelatex studentbrad_resume.tex \
	-output-directory=build
	rm $(IMAGEDIR)/studentbrad_resume-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/studentbrad_resume-%03d.jpg \
	$(BUILDDIR)/studentbrad_resume.pdf -dBATCH

personal_bio: studentbrad_personal_bio.tex ./biography/*.tex
	latexmk -xelatex studentbrad_personal_bio.tex \
	-output-directory=build
	rm $(IMAGEDIR)/studentbrad_personal_bio-*.jpg
	$(GS) -q -dNOPAUSE -sDEVICE=jpeg -r400 -dJPEGQ=60 \
	-sOutputFile=$(IMAGEDIR)/studentbrad_personal_bio-%03d.jpg \
	$(BUILDDIR)/studentbrad_personal_bio.pdf -dBATCH

clean:
	rm -rf $(BUILDDIR)
	rm $(IMAGEDIR)/studentbrad_*.jpg
