BASE := croc_charm
PREVIEWS := $(BASE).png $(BASE)_prepared.png
STLS := $(BASE)_prepared.stl

include ../patterns.mk

all: previews stls

clean:
	rm -f $(PREVIEWS) $(STLS)

previews: $(PREVIEWS)

stls: $(STLS)

.PHONY: clean previews stls