SCAD = OpenSCAD
STLFLAGS = --export-format binstl

%_prepared.png: %.scad
	$(SCAD) -o $@ -D 'quick=false' -D 'prepare=true' $<

%.png: %.scad
	$(SCAD) -o $@ -D 'quick=false' -D 'prepare=false' $<

%_prepared.stl: %.scad
	$(SCAD) $(STLFLAGS) -o $@ -D 'quick=false' -D 'prepare=true' $<

%.stl: %.scad
	$(SCAD) $(STLFLAGS) -o $@ -D 'quick=false' -D 'prepare=false' $<
