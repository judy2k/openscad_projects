SUBPROJECTS := blobby cable_clip diamond

all:
	@for d in $(SUBPROJECTS); do $(MAKE) -C $${d} all; done

clean:
	@for d in $(SUBPROJECTS); do $(MAKE) -C $${d} clean; done

previews:
	@for d in $(SUBPROJECTS); do $(MAKE) -C $${d} previews; done

stls:
	@for d in $(SUBPROJECTS); do $(MAKE) -C $${d} stls; done


.PHONY: all clean previews stls