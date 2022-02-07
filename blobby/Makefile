BASE := blobby
PREVIEWS := $(BASE).png $(BASE)_prepared.png $(BASE)_layout.png
STLS := $(BASE).stl $(BASE)_prepared.stl $(BASE)_layout.stl

PARAMFLAGS := -D "seed=42"

include ../patterns.mk

all: previews stls

clean:
	rm -f $(PREVIEWS) $(STLS)

previews: $(PREVIEWS)

stls: $(STLS)

.PHONY: clean previews stls