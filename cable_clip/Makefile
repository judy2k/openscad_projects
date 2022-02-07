BASE := cable_clip
PREVIEWS := $(BASE).png
STLS := $(BASE).stl 3x3mm.stl 4x3mm.stl 5x3mm.stl 3x4mm.stl 4x4mm.stl 5x4mm.stl

include ../patterns.mk

all: previews stls

clean:
	rm -f $(PREVIEWS) $(STLS)

previews: $(PREVIEWS)

stls: $(STLS)

3x3mm.stl: cable_clip.scad
	$(SCAD) $(STLFLAGS) -o $@ -D "g_cable_loops=3" -D "g_cable_d=3" $<

4x3mm.stl: cable_clip.scad
	$(SCAD) $(STLFLAGS) -o $@ -D "g_cable_loops=4" -D "g_cable_d=3" $<

5x3mm.stl: cable_clip.scad
	$(SCAD) $(STLFLAGS) -o $@ -D "g_cable_loops=5" -D "g_cable_d=3" $<

3x4mm.stl: cable_clip.scad
	$(SCAD) $(STLFLAGS) -o $@ -D "g_cable_loops=3" -D "g_cable_d=4" $<

4x4mm.stl: cable_clip.scad
	$(SCAD) $(STLFLAGS) -o $@ -D "g_cable_loops=4" -D "g_cable_d=4" $<

5x4mm.stl: cable_clip.scad
	$(SCAD) $(STLFLAGS) -o $@ -D "g_cable_loops=5" -D "g_cable_d=4" $<

.PHONY: clean previews stls