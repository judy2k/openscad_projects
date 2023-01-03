BASE := hull_chain
PREVIEWS := $(BASE).png
STLS := $(BASE).stl
PARAMFLAGS := --view axes

include ../patterns.mk

all: previews stls

clean:
	rm -f $(PREVIEWS) $(STLS)

previews: $(PREVIEWS)

stls: $(STLS)

.PHONY: clean previews stls