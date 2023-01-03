SCAD = OpenSCAD
STLFLAGS = --export-format binstl

%_prepared.png: %.scad
	$(SCAD) -o $@ --render --imgsize=1280,720 -D 'quick=false' -D 'prepare=true' $(PARAMFLAGS) $<

%.png: %.scad
	$(SCAD) -o $@ --colorscheme=BeforeDawn --render --imgsize=1280,720 -D 'quick=false' -D 'prepare=false' $(PARAMFLAGS) $<

%_prepared.stl: %.scad
	$(SCAD) $(STLFLAGS) -o $@ -D 'quick=false' -D 'prepare=true' $(PARAMFLAGS) $<

%.stl: %.scad
	$(SCAD) $(STLFLAGS) -o $@ -D 'quick=false' -D 'prepare=false' $(PARAMFLAGS) $<
