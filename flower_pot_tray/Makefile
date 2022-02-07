BASE := flower_pot_tray
PREVIEWS := $(BASE).png
STLS := $(BASE).stl

include ../patterns.mk

all: previews stls

clean:
	rm -f $(PREVIEWS) $(STLS)

previews: $(PREVIEWS)

stls: $(STLS)

.PHONY: clean previews stls